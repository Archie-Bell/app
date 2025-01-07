import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Archie Bell"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/placeholder-img.jpg', height: 200),
            const SizedBox(height: 20),
            Text(
              message.data['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Last Known Location: ${message.data['lastLocationSeen']}',
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              'Last Seen: ${message.data['lastDateTimeSeen']}',
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              message.data['additionalInfo'],
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
