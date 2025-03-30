import 'package:flutter/gestures.dart';
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
                      width: screenWidth * 0.71,
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
                    

                    const SizedBox(height: 5), // Spacing

                    // Language Selection Text (Now Bold & Black)
                    SizedBox(
                      width: screenWidth * 0.71,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select your language.",
                          style: Styles.whiteTextStyle.copyWith(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                    
                    const SizedBox(height: 10),

                    // Dropdown Button for Language Selection (Now Styled)
                    SizedBox(
                      width: screenWidth * 0.71, // Matches title width
                      child: DropdownButtonFormField<String>(
                        value: selectedLanguage,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white, // Strong black outline
                              width: 2, // Thicker border
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)), // Sharp corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white, // Strong black outline
                              width: 2, // Thicker border
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)), // Sharp corners
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 22), // Adjust padding
                        ),
                        hint: Text(
                          "Select an option",
                          textAlign: TextAlign.center,
                          style: Styles.whiteTextStyle.copyWith(
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                        icon: Container( // Modify the drop down icon
                          padding: const EdgeInsets.all(0), // Remove padding around the icon
                          alignment: Alignment.center, // Vertically center icon
                          child: const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: Colors.white,
                          ),
                        ),
                        items: ["English", "Spanish", "French"]
                            .map((lang) => DropdownMenuItem(
                                  value: lang,
                                  child: Text(
                                    lang,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold, // Bold text
                                      color: Colors.black, // Black color
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons at the bottom, centered
            Padding(
              padding: const EdgeInsets.only(bottom: 20), // Adds bottom padding
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: screenWidth * 0.50,
                      child: OutlinedButton(
                        style: Styles.button,
                        onPressed: () {
                          Navigator.pushNamed(context, '/s/home');
                        },
                        child: Text(
                          "Login as Staff",
                          style: Styles.whiteTextStyle.copyWith(
                            fontWeight: FontWeight.bold, // Bold text
                            fontSize: 16,
                          ),
                        ),
                      ),
                    // ),
                  ),

                  const SizedBox(height: 1),

                  SizedBox(
                    width: screenWidth * 0.50, // Makes button width smaller to match wireframe
                    child: OutlinedButton(
                      style: Styles.button,
                      onPressed: () {
                        Navigator.pushNamed(context, '/u/verification/phone'); // Regular users will be prompted to the phone number verification screen
                      },
                      child: Text(
                        "Continue",
                        style: Styles.whiteTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
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
                              text: "By using our services, you also agree to our\n",
                              style: Styles.whiteTextStyle,
                              ),
                            TextSpan(
                              text: "Terms of Use",
                              style: Styles.whiteTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Open Terms of Use
                                },
                            ),
                            TextSpan(
                              text: " and ",
                              style: Styles.whiteTextStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: "Privacy Policy",
                              style: Styles.whiteTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Open Privacy Policy
                                },
                            ),
                            TextSpan(
                              text: '.',
                              style: Styles.whiteTextStyle
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
