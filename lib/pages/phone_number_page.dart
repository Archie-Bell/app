import 'package:app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    'Enter your phone number.',
                    style: Styles.whiteTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start, // Align text to the start
                  ),
                ),
              ),
              
              const SizedBox(height: 1), // Space between Text and TextField

              // TextField with dynamic width (based on screen size)
              SizedBox(
                width: screenWidth * 0.71, // TextField takes up 71% of screen width
                child: Styles.customTextField(hintText: "(123) 456-7890"),
              ),
              const SizedBox(height: 10),

              // Continue button with same width as TextField (71% of screen width)
              SizedBox(
                width: screenWidth * 0.71, // Same width as the TextField
                child: OutlinedButton(
                  style: Styles.button,
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed('/u/verification/pending');
                  },
                  child: Text(
                    "Continue",
                    style: Styles.whiteTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
          
              // Info link about why the info is needed
              SizedBox(
                width: screenWidth * 0.71,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        // TODO: Add logic
                      },
                      children: const [
                        TextSpan(
                          text: "Why do we need this information?",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
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
                        text: 'By using our services, you also agree to our \n',
                      ),
                      TextSpan(
                        text: 'Terms of Use',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
