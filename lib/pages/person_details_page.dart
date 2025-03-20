import 'package:app/api/missing_persons_list_api.dart';
import 'package:flutter/material.dart';

class PersonDetailsPage extends StatelessWidget {
  final MissingPerson person;

  const PersonDetailsPage({super.key, required this.person});

  // Widget to handle taps outside the DraggableScrollableSheet range
  Widget makeDismissible(
          {required BuildContext context, required Widget child}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(), // Kills the widget instance
        child: GestureDetector(onTap: () {}, child: child),
      );

  // Widget for the details structure
  @override
  Widget build(BuildContext context) {
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, controller) => Stack(
          children: [
            // The scrollable content
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              padding: const EdgeInsets.all(15),
              child: ListView(
                controller: controller,
                children: [
                  // Main content
                  const SizedBox(height: 10),
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  // Person's Name and Age
                  Text(
                    "${person.name}, ${person.age}",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),

                  // Last Known Location
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            text: "Last known location: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "${person.lastLocationSeen}\n"),
                        TextSpan(
                            text: "Last date/time seen: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "${person.lastDateTimeSeen}\n")
                      ])),

                  Text("Additional Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),

                  Text(person.additionalInfo),

                  Padding(padding: EdgeInsets.only(bottom: 20)),

                  // Live Activity Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey[300],
                    child: const Text(
                      "Live Activity",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: const Text("No Live Activity",
                        style: TextStyle(color: Colors.grey)),
                  ),

                  const SizedBox(height: 10),

                  // Missing Cases Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey[300],
                    child: const Text(
                      "Missing Cases",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: const Text("No Missing Cases",
                        style: TextStyle(color: Colors.grey)),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Archie Bell prototype, Capstone 2025.\n"
                  "Everything is subject to change.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dotted,
                  ),
                ),
              )
            ),

            // Ensure button placement is consistent regardless of modal height
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    // Action for volunteering (to be implemented)
                  },
                  child: const Text("Found this person?"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
