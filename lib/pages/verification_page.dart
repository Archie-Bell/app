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
                    'Verification code has been sent to your SMS.',
                    style: Styles.whiteTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 1), // Space between Text and TextField

              // TextField with dynamic width (based on screen size)
              SizedBox(
                width: screenWidth * 0.71, // TextField takes up 75% of screen width
                child: Styles.customTextField(hintText: "123456"),
              ),
              const SizedBox(height: 10),

              // Verify button with same width as TextField (75% of screen width)
              SizedBox(
                width: screenWidth * 0.71, // Same width as the TextField
                child: OutlinedButton(
                  style: Styles.button,
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed("/u/home");
                  },
                  child: Text(
                    "Verify",
                    style: Styles.whiteTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Resend verification code with dynamic alignment
              SizedBox(
                width: screenWidth * 0.71,
                  child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: Styles.whiteTextStyle,
                      recognizer: TapGestureRecognizer()..onTap = () {
                        // TODO: Add logic to resend verification code
                      },
                      children: const [
                        TextSpan(
                          text: "Didn't receive it? Send again.",
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
                        text: 'By using our services, you also agree to our\n',
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
