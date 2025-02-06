import 'package:app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notification system
  Future<void> initialiseNotifications() async {
    // Request permissions from user (notifications)
    await _firebaseMessaging.requestPermission();

    // Fetch Firebase Cloud Messaging token for the device (unique)
    final fCMToken = await _firebaseMessaging.getToken();
    print(fCMToken);

    // Send the token to the server
    if (fCMToken != null) {
      sendTokenToServer(fCMToken);
    }

    // Listen for token refresh events
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);

    // Initialize settings for push notifications
    initialisePushNotifications();
  }

  // Handle received messages
  void handleMessages(RemoteMessage? message) {
    if (message == null) return;

    // Add a delay to allow the navigation context to initialize properly
    Future.delayed(const Duration(milliseconds: 500), () {
      if (navigatorKey.currentState != null) {
        // Navigate to the HomePage with the 'id' argument
        navigatorKey.currentState?.pushNamed('/home_page');
      }
    });
  }

  // Initialize foreground/background settings
  Future initialisePushNotifications() async {
    // Handle notifications when the app is terminated and opened from a notification
    FirebaseMessaging.instance.getInitialMessage().then(handleMessages);

    // Attach event listeners whenever the app is opened through a notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }

  Future<void> sendTokenToServer(String token) async {
    try {
      String deviceId = 'device_${DateTime.now().millisecondsSinceEpoch}';
      Map<String, dynamic> deviceToken = {
        'token': token,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance.collection('fcmTokens').doc(deviceId).set(deviceToken);
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }
}
