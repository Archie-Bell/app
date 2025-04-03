import 'dart:async';
import 'dart:io';

class WebSocketManager {
  // Map of WebSocket connections keyed by their URL for easy reference
  final Map<String, WebSocket> _sockets = {};
  final Map<String, StreamController<String>> _messageControllers = {};
  final Map<String, Timer> _heartbeatTimers = {}; // To manage heartbeat timers for each connection

  // Stream to listen to all messages
  final StreamController<String> _generalMessageController = StreamController<String>();

  // Heartbeat message to send periodically
  final String heartbeatMessage = '{"type": "ping"}';


  // Interval between heartbeats (e.g., 30 seconds)
  final Duration heartbeatInterval = Duration(seconds: 30);

  // Connect to a WebSocket server
  Future<void> connect(String url) async {
    try {
      // Check if already connected to this URL
      if (_sockets.containsKey(url)) {
        print('Already connected to $url');
        return;
      }

      WebSocket socket = await WebSocket.connect(url);
      _sockets[url] = socket;

      // Create a stream controller to listen to messages for this socket
      StreamController<String> controller = StreamController<String>();
      _messageControllers[url] = controller;

      // Listen for messages from this socket and add them to the stream controller
      socket.listen((message) {
        controller.add(message); // Pass the message to the stream controller
        _generalMessageController.add(message); // Add to the general message stream
      });

      // Start sending heartbeat pings
      _startHeartbeat(url);

      print('Connected to: $url');
    } catch (e) {
      print('Error connecting to $url: $e');
    }
  }

  // Start sending heartbeat messages at regular intervals
  void _startHeartbeat(String url) {
    _heartbeatTimers[url] = Timer.periodic(heartbeatInterval, (timer) {
      // Send heartbeat message only if the socket is still open
      WebSocket? socket = _sockets[url];
      if (socket != null && socket.readyState == WebSocket.open) {
        socket.add(heartbeatMessage);
        print('Heartbeat sent to $url');
      } else {
        print('WebSocket for $url is closed, stopping heartbeat');
        timer.cancel();
        _heartbeatTimers.remove(url);
      }
    });
  }

  // Get the messages from a specific WebSocket connection by its URL
  Stream<String>? getMessages(String url) {
    // Return the stream associated with the given URL
    if (_messageControllers.containsKey(url)) {
      return _messageControllers[url]?.stream;
    }
    return null;
  }

  // General message stream to listen to any incoming WebSocket message
  Stream<String> get generalMessages => _generalMessageController.stream;

  // Close all connections
  void close() {
    // Close each socket connection
    for (var socket in _sockets.values) {
      socket.close();
    }

    // Cancel any active heartbeat timers
    for (var timer in _heartbeatTimers.values) {
      timer.cancel();
    }

    // Close all the message controllers
    for (var controller in _messageControllers.values) {
      controller.close();
    }
  }
}
