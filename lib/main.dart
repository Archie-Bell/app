import 'package:app/api/firebase_api.dart';
import 'package:app/api/mongo_db.dart';
import 'package:app/firebase_options.dart';
import 'package:app/pages/new_home_page.dart';
import 'package:app/pages/list_page.dart';
import 'package:app/pages/notification_page.dart';
import 'package:app/pages/person_details_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
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

  // Initialize WorkManager
  Workmanager().initialize(callbackDispatcher);

  // Register the background task (the task will run in the background)
  Workmanager().registerOneOffTask(
    'firebase_background_task', // A unique task name
    'simple_task', // A unique task tag for identification
    initialDelay: const Duration(seconds: 30), // Optional delay
    constraints: Constraints(
      networkType: NetworkType.connected, // Ensure network is available
      requiresCharging: false, // Don't require charging
      requiresBatteryNotLow: true, // Require battery not to be low
      requiresDeviceIdle: false, // Don't require device to be idle
    ),
    backoffPolicy: BackoffPolicy.exponential,
    backoffPolicyDelay: const Duration(minutes: 5),
  );

  runApp(const ArchieBellApp());
}

// This function is called when the background task is triggered
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    backgroundTaskHandler();
    return Future.value(true);  // Return true when the background task is complete
  });
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
        '/home': (context) => const HomePage(),
        '/api/notification': (context) => const NotificationPage(),
                '/list': (context) => const ListPage(), 
                                 '/person_details': (context) => const PersonDetailsPage(person: {},), 

      },
    );
  }
}
