import 'package:app/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app/main.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

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

              // Verification code text with dynamic alignment
              SizedBox(
                width: screenWidth * 0.71,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Thank you! \u{2764}\u{FE0F}',
                    style: Styles.whiteTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: screenWidth * 0.71,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your participation truly means a lot to us.',
                    style: Styles.whiteTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start, // Align text to the start
                  ),
                ),
              ),
              
              const SizedBox(height: 10), // Space between Text and TextField

              // Verify button with same width as TextField (75% of screen width)
              SizedBox(
                width: screenWidth * 0.71, // Same width as the TextField
                child: OutlinedButton(
                  style: Styles.button,
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed("/u/home");
                  },
                  child: Text(
                    "Let's go",
                    style: Styles.whiteTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Spacer(),

              // "Go Back" button with dynamic width (90% of screen width)
              SizedBox(
                width: screenWidth * 0.50, // Go Back button takes up 90% of screen width
                child: OutlinedButton(
                  style: Styles.button,
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed('/u/verification/phone');
                  },
                  child: Text(
                    "Go Back",
                    style: Styles.whiteTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

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
