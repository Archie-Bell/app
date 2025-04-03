import 'package:app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app/theme.dart';

class PhoneNumberPage extends StatelessWidget {
  const PhoneNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: Styles.appGradient
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1, // 10% padding on left and right
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Phone number input text with dynamic width
              SizedBox(
                width: screenWidth * 0.71,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome to the Archie Bell demo!',
                    style: Styles.whiteTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start, // Align text to the start
                  ),
                ),
              ),

              SizedBox(
                width: screenWidth * 0.71,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Thank you for taking the time to become part of this semester\'s capstone demo. ' 
                    'Please pay attention for instructions during the demo as we showcase not only the application '
                    'but also the web interface.',
                    style: Styles.whiteTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start, // Align text to the start
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Continue button with same width as TextField (71% of screen width)
              SizedBox(
                width: screenWidth * 0.71, // Same width as the TextField
                child: OutlinedButton(
                  style: Styles.button,
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed('/u/verification/pending');
                  },
                  child: Text(
                    "Next",
                    style: Styles.whiteTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              
              const Spacer(),

              // "Go Back" button with dynamic width (50% of screen width)
              SizedBox(
                width: screenWidth * 0.50, // Go Back button takes up 50% of screen width
                child: OutlinedButton(
                  style: Styles.button,
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed('/u/landing');
                  },
                  child: const Text(
                    "Go Back",
                    style: TextStyle(
                      color: Colors.white, // White text
                      fontWeight: FontWeight.bold, // Bold text
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Bottom text for "Terms of Use" and "Privacy Policy"
              Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Styles.whiteTextStyle,
                    recognizer: TapGestureRecognizer()..onTap = () {
                      // TODO: Add logic to view terms of use and privacy policy
                    },
                    children: const [
                      TextSpan(
                        text: 'Application prototype, Capstone 2025.\n',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dotted,
                          decorationColor: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Everything is subject to change.',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dotted,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
