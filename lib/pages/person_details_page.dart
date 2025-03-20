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
            // The scrollable content inside the container with BoxDecoration
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              padding: const EdgeInsets.only(
                top: 250, // Padding at the top for the content
                bottom: 15,
                left: 15,
                right: 15,
              ),
              child: ListView(
                controller: controller,
                children: [
                  const SizedBox(height: 10),

                  // Person's Name and Age
                  Text(
                    "${person.name}, ${person.age}",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                        TextSpan(text: person.lastDateTimeSeen)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Additional Information
                  Text("Additional Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),

                  SizedBox(
                    child: Text(
                      person.additionalInfo,
                      softWrap: true, // Ensures that long text wraps to the next line
                      textAlign: TextAlign.left, // Optional: Align text as needed
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20)),

                  // Live Activity Section
                  const Text("Live Updates",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 270,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: const Text("No Live Updates",
                        style: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 85),
                ],
              ),
            ),

            // Image section: Positioned at the top, outside of the padding scope, but still inside the BoxDecoration
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity, // Make the image fill the width
                    height: 250, // Set the fixed height to 250
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [
                            Colors.black, // Start transparent at the top
                            Colors.transparent, // Gradually fade to transparent at the bottom
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.8, 1.0], // Control the fade range
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn, // This blends the image with the gradient effect
                      child: Image.network(
                        person.image,
                        fit: BoxFit.cover, // Ensure the image covers the entire area
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "images/placeholder-img.jpg",
                            fit: BoxFit.cover, // Ensures the placeholder also covers the area
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Footer section (prototype info)
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
              ),
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
