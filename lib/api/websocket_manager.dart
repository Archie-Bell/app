import 'dart:async';
import 'dart:io';

class WebSocketManager {
  // Map of WebSocket connections keyed by their URL for easy reference
  final Map<String, WebSocket> _sockets = {};
  final Map<String, StreamController<String>> _messageControllers = {};

  // Stream to listen to all messages
  final StreamController<String> _generalMessageController = StreamController<String>();

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

      print('Connected to: $url');
    } catch (e) {
      print('Error connecting to $url: $e');
    }
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

    // Close all the message controllers
    for (var controller in _messageControllers.values) {
      controller.close();
    }
  }
}
