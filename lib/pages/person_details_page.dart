import 'dart:ui'; 

import 'package:app/api/missing_persons_list_api.dart';
import 'package:app/pages/submission_page.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        maxChildSize: 0.7,
        builder: (_, controller) => Stack(
          children: [
            // First BackdropFilter for background blur
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Background blur
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                  child: Container(
                    color: Colors.white.withAlpha(100)
                  ),
                )
              ),
            ),

            // Second BackdropFilter for content container blur
            Positioned(
              top: 150, // Adjust the margin here for the second blur
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0), // Lighter blur effect
                  child: Container(
                    color: Colors.white, // Semi-transparent background color for content
                  ),
                ),
              ),
            ),

            // The scrollable content inside the container with BoxDecoration
            Container(
              decoration: BoxDecoration(
                // color: Colors.white.withAlpha(100),
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                border: Border(
                  top: BorderSide(color: Colors.white, width: 2.0),
                  left: BorderSide(color: Colors.white, width: 2.0),
                  right: BorderSide(color: Colors.white, width: 2.0),
                ),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(70), // Shadow color
                          offset: Offset(0, 2.0), // Horizontal and vertical offset
                          blurRadius: 6.0, // Blur radius
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Last Known Location
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                            text: "Last known location: ",
                            style: TextStyle(fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withAlpha(70), // Shadow color
                                  offset: Offset(0, 2.0), // Horizontal and vertical offset
                                  blurRadius: 6.0, // Blur radius
                                ),
                              ],
                            )),
                        TextSpan(text: "${person.lastLocationSeen}\n", style: TextStyle(
                          shadows: [
                            Shadow(
                              color: Colors.black.withAlpha(70),
                              offset: Offset(0, 2.0), // Horizontal and vertical offset
                              blurRadius: 6.0, // Blur radius
                            )
                          ]
                        )),
                        TextSpan(
                            text: "Last date/time seen: ",
                            style: TextStyle(fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withAlpha(70), // Shadow color
                                  offset: Offset(0, 2.0), // Horizontal and vertical offset
                                  blurRadius: 6.0, // Blur radius
                                ),
                              ],
                            )),
                        TextSpan(text: person.lastDateTimeSeen, style: TextStyle(
                          shadows: [
                            Shadow(
                              color: Colors.black.withAlpha(70),
                              offset: Offset(0, 2.0), // Horizontal and vertical offset
                              blurRadius: 6.0, // Blur radius
                            )
                          ]
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Additional Information
                  Text("Additional Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withAlpha(70), // Shadow color
                            offset: Offset(0, 2.0), // Horizontal and vertical offset
                            blurRadius: 6.0, // Blur radius
                          ),
                        ],
                      )),

                  SizedBox(
                    child: Text(
                      person.additionalInfo,
                      softWrap: true, // Ensures that long text wraps to the next line
                      textAlign: TextAlign.left, // Optional: Align text as needed,
                      style: TextStyle(color: Colors.white,
                          shadows: [
                          Shadow(
                            color: Colors.black.withAlpha(70), // Shadow color
                            offset: Offset(0, 2.0), // Horizontal and vertical offset
                            blurRadius: 6.0, // Blur radius
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
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
                        "https://${dotenv.env['NGROK_ADDRESS']}${person.image}",
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
                    decorationColor: Colors.white,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withAlpha(70), // Shadow color
                        offset: Offset(0, 2.0), // Horizontal and vertical offset
                        blurRadius: 6.0, // Blur radius
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Ensure button placement is consistent regardless of modal height
            Positioned(
              left: 50,
              right: 50,
              bottom: 25,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: Styles.button,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubmissionPage(
                          missingPersonId: person.id,
                          missingPersonName: person.name,
                        ),
                      ),
                    );
                  },
                  child: const Text("Found this person?", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
