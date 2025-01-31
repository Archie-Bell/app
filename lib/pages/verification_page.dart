import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13, // Add 13% padding to the left and right based on the screen width
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
              'Verification code has been sent to your SMS.',
              style: TextStyle(
                fontWeight: FontWeight.bold
                ),
              textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 1), // Space between Text and TextField

            // TextField
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number, // Keyboard type is number only
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only digit inputs are allowed
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "123456",
              ),
            ),
            const SizedBox(height: 10),

            // Verify button
            ElevatedButton(
              onPressed: () {}, // TODO: add logic to verify verification code
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // Min width is available horizontal space and min height is 50 px
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Make border corners sharp, not rounded
                ),
              ),
              child: const Text(
                'Verify',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
        
            // Resend verification code
            Align( // Widget that will align text to the left border of the verify button
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  recognizer: TapGestureRecognizer()..onTap = () { // Makes text interactive, so it can be tapped instead of using a button
                    // TODO: Add logic to resend verification code
                  },
                  children: const [
                    TextSpan(
                      text: "Didn't receive it? Send again.",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // "Go Back" button
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(150, 50),
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text('Go Back',
                  style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 20),

            // Bottom text for the "Terms of Use" and "Privacy Policy"
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black
                  ),
                recognizer: TapGestureRecognizer()..onTap = () { // Makes text interactive, so it can be tapped instead of using a button
                  // TODO: Add logic to view terms of use and privacy policy
                },
                children: const [
                  TextSpan(
                    text: 'By using our services, you also agree to our ',
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
