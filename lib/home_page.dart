import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseMessaging.instance.requestPermission();

    return MaterialApp(
      title: 'Archie Bell',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SimpleImageStatePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SimpleImageStatePage extends StatelessWidget {
  const SimpleImageStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archie Bell'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/placeholder-img.jpg', height: 200),

            const SizedBox(height: 20),

            const Text(
              'Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const Text(
              'Last location seen',
              style: TextStyle(fontSize: 15),
            ),

            const Text(
              'Last seen Date & Time',
              style: TextStyle(fontSize: 15),
            ),

            const Text(
              'Additional Info',
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}