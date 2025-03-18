import 'package:flutter/material.dart';

class PersonDetailsPage extends StatelessWidget {
  final Map<String, String> person;

  const PersonDetailsPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Pull-down bar (Back Button)
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: Colors.grey[300],
                child: const Icon(Icons.keyboard_arrow_down, size: 30),
              ),
            ),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 10),

                    // Person's Name and Age
                    Text(
                      "${person['name']}, ${person['age']}",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),

                    // Last Known Location
                    Text("Last known location: ${person['lastLocation']}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),

                    const SizedBox(height: 10),

                    // Live Activity Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey[300],
                      child: const Text(
                        "Live Activity",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: const Text("No Live Activity", style: TextStyle(color: Colors.grey)),
                    ),

                    const SizedBox(height: 10),

                    // Missing Cases Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey[300],
                      child: const Text(
                        "Missing Cases",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: const Text("No Missing Cases", style: TextStyle(color: Colors.grey)),
                    ),

                    const SizedBox(height: 20),

                    // Volunteer Button
                    ElevatedButton(
                      onPressed: () {
                        // Action for volunteering (to be implemented)
                      },
                      child: const Text("Volunteer"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
