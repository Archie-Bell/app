import 'package:app/api/missing_persons_list_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'person_details_page.dart'; 
import 'package:app/main.dart';
import 'package:app/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch data using the updated API that now returns an ApiResult
    Future<ApiResult<List<MissingPerson>>> missingPersons = MissingPersonsListApi.getData();

    return Scaffold(
      backgroundColor: Colors.transparent, // Light background
      body: Container(
        decoration: BoxDecoration(
            gradient: Styles.appGradient
          ),
      child: SafeArea(
        child: Column(
          children: [
            // Greeting
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Good afternoon.",
                  style: Styles.whiteTextStyle.copyWith(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Live Activity Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Live Activity",
                    style: Styles.liveActivityTitleStyle,
                  ),
                  const SizedBox(height: 8),
                  // Box to wrap the cards
                  Container(
                    padding: const EdgeInsets.all(Styles.liveActivityPadding),  // Use modular padding
                    decoration: BoxDecoration(
                      color: Styles.liveActivityBackgroundColor, // Use modular background color
                      borderRadius: BorderRadius.circular(Styles.liveActivityBorderRadius), // Use modular border radius
                      border: Border.all(color: Styles.liveActivityBorderColor, width: 2), // Use modular border color
                    ),
                    height: Styles.liveActivityHeight,  // Use modular height
                    child: ListView.builder( // Make it scrollable
                      itemCount: 5, // Set itemCount to 5
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.white, width: 1),
                          ),
                          color: Colors.transparent, // Transparent card background
                          child: ListTile(
                            title: Text(
                              index == 0
                                  ? "No Current Activity"
                                  : "No Current activity",
                              style: Styles.liveActivityCardTitleStyle, // Use modular card title style
                            ),
                            subtitle: Text(
                              "Will update when there is activity",
                              style: Styles.liveActivityCardSubtitleStyle, // Use modular card subtitle style
                            ),
                            trailing: Icon(
                              Icons.remove_red_eye_outlined,
                              color: Styles.liveActivityIconColor, // Use modular icon color
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Missing Cases Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Missing Cases",
                      style: Styles.whiteTextStyle.copyWith(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // FutureBuilder to handle the asynchronous data fetching
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FutureBuilder<ApiResult<List<MissingPerson>>>(
                          future: missingPersons,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              if (snapshot.data!.error != null) {
                                // Show error message if API result contains an error
                                return Center(child: Text('Error: ${snapshot.data!.error}'));
                              } else if (snapshot.data!.data!.isEmpty) {
                                // Handle case where there is no data
                                return Center(child: Text('No missing persons available.'));
                              } else {
                                // Display the data when available
                                List<MissingPerson> persons = snapshot.data!.data!;
                                return ListView.builder(
                                  itemCount: persons.length,
                                  itemBuilder: (context, index) {
                                    var person = persons[index]; // Access MissingPerson object directly
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: const BorderSide(color: Colors.black, width: 1),
                                      ),
                                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                      child: ListTile(
                                        leading: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: ClipOval(
                                            child: Image.network(
                                              "http://${dotenv.env['YOUR_LOCAL_IP_ADDRESS']}:8000${person.image}",
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Image.asset("images/placeholder-img.jpg", fit: BoxFit.cover); // Fallback if image loading fails
                                              },
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "${person.name}, ${person.age}", // Access properties directly
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text("Last location: ${person.lastLocationSeen}", // Access properties directly
                                            style: const TextStyle(fontSize: 14)),
                                        trailing: const Icon(Icons.arrow_forward),
                                        onTap: () {
                                          // Ensure usage of showModalBottomSheet instead of Navigator
                                          showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            isScrollControlled: true,
                                            context: context, 
                                            builder: (context) => PersonDetailsPage(person: person));
                                        },
                                      ),
                                    );
                                  },
                                );
                              }
                            } else {
                              // Default case if snapshot doesn't have data or error
                              return Center(child: Text('Unexpected error occurred.'));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                padding: const EdgeInsets.all(Styles.buttonContainerPadding), // Use modular padding
                decoration: BoxDecoration(
                  color: Styles.buttonContainerBackgroundColor, // Use modular background color
                  borderRadius: BorderRadius.circular(Styles.buttonContainerBorderRadius), // Use modular border radius
                  border: Border.all(color: Styles.buttonContainerBorderColor, width: 2), // Use modular border color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // First button
                    _buildBottomButton("Dashboard"),

                    // Spacer between buttons
                    const SizedBox(width: Styles.buttonSpacing), // Use modular button spacing

                    // Second button
                    _buildBottomButton("Debug"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  // Custom bottom button builder
  Widget _buildBottomButton(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          style: ButtonStyle(
            // Background color changes when pressed
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return Styles.buttonPressedBackgroundColor; // Use modular pressed background color
                }
                return Styles.buttonBackgroundColor; // Use modular normal background color
              },
            ),
            // Text color changes when pressed
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return Styles.buttonPressedForegroundColor; // Use modular pressed text color
                }
                return Styles.buttonForegroundColor; // Use modular normal text color
              },
            ),
            // Button shape
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Styles.buttonBorderRadius), // Use modular border radius
              ),
            ),
            // Padding
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: Styles.buttonPaddingVertical), // Use modular vertical padding
            ),
          ),
          onPressed: () {
            // Temporarily route the button to the old home page for debugging purposes
            navigatorKey.currentState?.pushNamed("/d/debug");
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: Styles.buttonFontSize, // Use modular font size
              fontWeight: Styles.buttonFontWeight, // Use modular font weight
            ),
          ),
        ),
      ),
    );
  }
}