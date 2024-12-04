import 'package:app/pages/home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  // Initiate instance
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialise notification system
  Future<void> initialiseNotifications() async {

    // Request permissions from user (notifications)
    await _firebaseMessaging.requestPermission();

    // Fetch Firebase Cloud Messaging token for device (unique)
    final fCMToken = await _firebaseMessaging.getToken();

    // DEBUG: print token to log (send to server later)

    /* 
      TO-DO: 
      We need an Apple Developer Account to be able to use the Notification System
      as it will require an APNS token from the Apple Developer website.
    */

    print('Token received: ' + fCMToken.toString());

    // Initialise settings for push notifications
    initialisePushNotifications();
  }

  // Handle received messages
  void handleMessages(RemoteMessage? message) {
    // If message equals to null, do nothing
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  // Initialise foreground/background settings
  Future initialisePushNotifications() async {
    // Handle notifications if application is terminated and opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessages);

    // Attach event listeners whenever the app is opened through notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }
}