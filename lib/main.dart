import 'package:app/api/firebase_api.dart';
import 'package:app/api/missing_persons_list_api.dart';
import 'package:app/firebase_options.dart';
import 'package:app/pages/staff_home_page.dart';
import 'package:app/pages/debug_page.dart';
import 'package:app/pages/landing_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/debug_details_page.dart';
import 'package:app/pages/phone_number_page.dart';
import 'package:app/pages/verification_page.dart';
import 'package:app/pages/person_details_page.dart';
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
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xFF3D4DEE),
                Color(0xFF293486),
                Color(0xFFA0A5C0),
                Color(0xFFD9D9D9),
              ],
              center: Alignment.topLeft,
              radius: 2.25,
              stops: [0.1, 0.55, 0.9, 1.0]
            )
          ),
          child: const LandingPage(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        '/d/debug': (context) => const DebugPage(),
        '/u/landing': (context) => const LandingPage(),
        '/d/api/notification': (context) => const DebugDetailsPage(),
        '/u/verification/pending': (context) => const VerificationPage(),
        '/u/verification/phone': (context) => const PhoneNumberPage(),
        '/u/home': (context) => const HomePage(), 
        '/u/person/details': (context) => PersonDetailsPage(person: ModalRoute.of(context)!.settings.arguments as MissingPerson), 
        '/s/home': (context) => const StaffHomepage(),
      },
    );
  }
}