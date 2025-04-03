import 'package:flutter/material.dart';
import 'package:app/theme.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    // Get the screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            gradient: Styles.appGradient,
          ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Proper spacing
          children: [
            // Centered Content (Title + Language Selection)
            Expanded(
              child: Center( // Ensures everything is centered
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Avoids unnecessary expansion
                  children: [
                    // Title: ARCHIE BELL (Larger & Bolder)
                    SizedBox(
                      width: screenWidth * 0.51,
                      child: Column(
                      mainAxisSize: MainAxisSize.min, // Avoids unnecessary expansion
                      crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
                      children: [
                        Text(
                          "ARCHIE",
                          style: Styles.appName
                        ),
                        SizedBox(height: 0), // Reduced space between ARCHIE and BELL
                        Text(
                          "BELL",
                          style: Styles.appName
                        ),
                      ],
                    ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons at the bottom, centered
            Padding(
              padding: const EdgeInsets.only(bottom: 40), // Adds bottom padding
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: screenWidth * 0.40, // Makes button width smaller to match wireframe
                    child: OutlinedButton(
                      style: Styles.button,
                      onPressed: () {
                        Navigator.pushNamed(context, '/u/verification/phone'); // Regular users will be prompted to the phone number verification screen
                      },
                      child: Text(
                        "Begin Demo",
                        style: Styles.whiteTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10), // Extra space for better layout

                  // Terms of Use and Privacy Policy
                  Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          children: [
                            TextSpan(
                              text: "Application prototype, Capstone 2025.\n",
                              style: Styles.whiteTextStyle.copyWith(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dotted,
                              ),
                            ),

                            TextSpan(
                              text: "Everything is subject to change.",
                              style: Styles.whiteTextStyle.copyWith(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dotted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
