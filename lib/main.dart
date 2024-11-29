import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:archie_bell/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}
