import 'package:app/api/firebase_api.dart';
import 'package:app/api/mongo_db.dart';
import 'package:app/firebase_options.dart';
import 'package:app/pages/new_home_page.dart';
import 'package:app/pages/list_page.dart';
import 'package:app/pages/notification_page.dart';
import 'package:app/pages/person_details_page.dart';
import 'package:app/pages/phone_number_page.dart';
import 'package:app/pages/staff_homepage.dart';
import 'package:app/pages/verification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Firebase messaging and notifications
  await FirebaseApi().initialiseNotifications();

  // Connect to MongoDB
  await MongoDB.connect();

  runApp(const ArchieBellApp());
}

// The background task handler
void backgroundTaskHandler() {
  print("Background task triggered by FCM or custom logic");
  FirebaseApi().handleMessages(null); // Example of invoking the FCM handler in the background.
}

// The main app widget
class ArchieBellApp extends StatelessWidget {
  const ArchieBellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        '/home_page': (context) => const HomePage(),
        '/api/notification': (context) => const NotificationPage(),
        '/list': (context) => const ListPage(), 
        '/person_details': (context) => const PersonDetailsPage(person: {},), 

        '/verification_page': (context) => const VerificationPage(),
        '/phone_number_page': (context) => const PhoneNumberPage(),
        '/list_page': (context) => const ListPage(), 
        '/person_details': (context) => const PersonDetailsPage(person: {},), 
        '/staff/home_page': (context) => const StaffHomepage(),
      },
    );
  }
}
