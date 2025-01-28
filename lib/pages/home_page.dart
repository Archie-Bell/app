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
              child: Center( // This ensures everything stays centered
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Avoids unnecessary expansion
                  children: [
                    // Title: ARCHIE BELL
                    const Text(
                      "ARCHIE\nBELL",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48, // Large title
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20), // Spacing

                    // Language Selection Text
                    const Text(
                      "Select your language.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 10),

                    // Dropdown Button for Language Selection
                    SizedBox(
                      width: 200, // Matches title width
                      child: DropdownButtonFormField<String>(
                        value: selectedLanguage,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: const Text("Select an option"),
                        items: ["English", "Spanish", "French"]
                            .map((lang) => DropdownMenuItem(
                                  value: lang,
                                  child: Text(lang),
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
                      onPressed: () {
                        // Navigate to Staff Login Page
                      },
                      child: const Text("Login as Staff"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: 200, // Matches title width
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigate to Main App
                      },
                      child: const Text("Continue"),
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
