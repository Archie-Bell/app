import 'package:app/api/firebase_api.dart';
import 'package:app/api/mongo_db.dart';
import 'package:app/firebase_options.dart';
import 'package:app/pages/notification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initialiseNotifications();

  await MongoDB.connect();
  runApp(const ArchieBellApp());
}

class ArchieBellApp extends StatelessWidget {
  const ArchieBellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen':(context) => const NotificationPage(),
      },
    );
  }
}
