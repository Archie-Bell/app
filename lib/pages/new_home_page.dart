import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    const Column(
                      mainAxisSize: MainAxisSize.min, // Avoids unnecessary expansion
                      crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
                      children: [
                        Text(
                          "ARCHIE",
                          style: TextStyle(
                            fontSize: 56, // Increased font size
                            fontWeight: FontWeight.w900, // Extra bold
                          ),
                        ),
                        SizedBox(height: 0), // Reduced space between ARCHIE and BELL
                        Text(
                          "BELL",
                          style: TextStyle(
                            fontSize: 56, // Increased font size
                            fontWeight: FontWeight.w900, // Extra bold
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20), // Spacing

                    // Language Selection Text (Now Bold & Black)
                    const Text(
                      "Select your language.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold, // Bold
                        color: Colors.black, // Black color
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Dropdown Button for Language Selection (Now Styled)
                    SizedBox(
                      width: 200, // Matches title width
                      child: DropdownButtonFormField<String>(
                        value: selectedLanguage,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, // Strong black outline
                              width: 2, // Thicker border
                            ),
                            borderRadius: BorderRadius.zero, // Sharp corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, // Strong black outline
                              width: 2, // Thicker border
                            ),
                            borderRadius: BorderRadius.zero, // Sharp corners
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10), // Adjust padding
                        ),
                        hint: const Text(
                          "Select an option",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Bold text
                            color: Colors.black, // Black color
                          ),
                        ),
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black), // Black dropdown icon
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
                    width: 200, // Matches title width
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black, width: 2), // Stronger black outline
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Sharp corners
                        ),
                      ),
                      onPressed: () {
                        // Navigate to Staff Login Page
                        Navigator.pushNamed(context, "/staff/home_page");
                      },
                      child: const Text(
                        "Login as Staff",
                        style: TextStyle(
                          color: Colors.black, // Black text
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: 200, // Matches title width
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black, width: 2), // Stronger black outline
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Sharp corners
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/phone_number_page'); // Regular users will be prompted to the phone number verification screen
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.black, // Black text
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20), // Extra space for better layout

                  // Terms of Use and Privacy Policy
                  Column(
                    children: [
                      const Text(
                        "By using our services, you also agree to our",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Open Terms of Use
                        },
                        child: const Text(
                          "Terms of Use",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Open Privacy Policy
                        },
                        child: const Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
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
    );
  }
}
