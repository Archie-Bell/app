import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleImageStatePage();
  }
}

class SimpleImageStatePage extends StatelessWidget {
  const SimpleImageStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch and display notifications to screen
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    String? notificationImgUrl = message.notification?.android?.imageUrl;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Archie Bell'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(notificationImgUrl ?? 'images/placeholder-img.jpg', height: 200),

            const SizedBox(height: 20),

            Text(
              message.notification!.title.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            /*

            TO-DO:
            Notifications should be linked to an ID from a database fetching contents of:
            - Missing Person Name
            - Last Location
            - Date & Time Last Seen
            - Additional Info

            It should not use the notification values for display.

            */

            /*

            Omit these values for the time being as implementation is not fully complete.
            
            */

            // const Text(
            //   'Last location seen',
            //   style: TextStyle(fontSize: 15),
            // ),

            // const Text(
            //   'Last seen Date & Time',
            //   style: TextStyle(fontSize: 15),
            // ),

            Text(
              message.notification!.body.toString(),
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}