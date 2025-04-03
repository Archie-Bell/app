import 'package:flutter/material.dart';
import 'package:app/api/missing_persons_list_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'person_details_page.dart';
import 'package:app/main.dart';
import 'package:app/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch data using the updated API that now returns an ApiResult
    Future<ApiResult<List<MissingPerson>>> missingPersons = MissingPersonsListApi.getData();

    // Get the current time and date to determine greeting and today's date
    String greeting = _getGreeting();
    String formattedDate = _getFormattedDate();
    String formattedDay = _getFormattedDay();

    return Scaffold(
      backgroundColor: Colors.transparent, // Light background
      body: Container(
        decoration: BoxDecoration(
            gradient: Styles.appGradient
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 150),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    greeting,
                    style: Styles.whiteTextStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$formattedDay is $formattedDate.',
                    style: Styles.whiteTextStyle.copyWith(
                        fontSize: 12),
                  ),
                ),
              ),
              
              // Missing Cases Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Currently active searches:",
                        style: Styles.whiteTextStyle.copyWith(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Stack(
                          children: [
                            // The border is placed in the background
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24), // Make sure border radius is the same here
                                  border: Border.all(color: Colors.white, width: 1),
                                ),
                              ),
                            ),
                            // FutureBuilder with cards displayed inside
                            Padding(
                              padding: const EdgeInsets.all(5.0), // Padding for spacing around the container
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20), // Add rounded corners to the container
                                  // border: Border.all(color: Colors.white, width: 1), // Optional: Add border
                                ),
                                child: ClipRRect( // This ensures that the content inside the container is also clipped to the rounded corners
                                  borderRadius: BorderRadius.circular(22), // Same radius as container
                                  child: FutureBuilder<ApiResult<List<MissingPerson>>>(
                                    future: missingPersons,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
                                      } else if (snapshot.hasData) {
                                        if (snapshot.data!.error != null) {
                                          return Center(child: Text('Error: ${snapshot.data!.error}', style: const TextStyle(color: Colors.white)));
                                        } else if (snapshot.data!.data!.isEmpty) {
                                          return Center(child: Text('No missing persons available.', style: const TextStyle(color: Colors.white)));
                                        } else {
                                          List<MissingPerson> persons = snapshot.data!.data!;
                                          return ListView.builder(
                                            itemCount: persons.length,
                                            itemBuilder: (context, index) {
                                              var person = persons[index];
                                              return Card(
                                                elevation: 0,
                                                color: Colors.white.withAlpha(100),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                  side: const BorderSide(color: Colors.white, width: 2),
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
                                                    "${person.name}, ${person.age}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    "Last location: ${person.lastLocationSeen}",
                                                    style: const TextStyle(fontSize: 14, color: Colors.white),
                                                  ),
                                                  trailing: Icon(Icons.arrow_forward, color: Colors.white),
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      backgroundColor: Colors.transparent,
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) => PersonDetailsPage(person: person),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      } else {
                                        return Center(child: Text('Unexpected error occurred.', style: const TextStyle(color: Colors.white),));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 150),

              // Bottom Navigation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Container(
                  padding: const EdgeInsets.all(Styles.buttonContainerPadding),
                  decoration: BoxDecoration(
                    color: Styles.buttonContainerBackgroundColor,
                    borderRadius: BorderRadius.circular(Styles.buttonContainerBorderRadius),
                    border: Border.all(color: Styles.buttonContainerBorderColor, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // First button
                      _buildBottomButton("Dashboard"),

                      // Spacer between buttons
                      const SizedBox(width: Styles.buttonSpacing),

                      // Second button
                      _buildBottomButton("Debug"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get the appropriate greeting based on the time of day
  String _getGreeting() {
    final hour = DateTime.now().hour;
    
    if (hour >= 5 && hour < 12) {
      return "Good morning.";
    } else if (hour >= 12 && hour < 18) {
      return "Good afternoon.";
    } else {
      return "Good evening.";
    }
  }

  String _getFormattedDay() {
    final hour = DateTime.now().hour;
    
    if (hour >= 5 && hour < 18) {
      return "Today";
    } else {
      return "Tonight";
    }
  }

  // Function to get the current date formatted
  String _getFormattedDate() {
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM dd, yyyy'); // You can adjust this format as needed
    return formatter.format(now); // Formats the date
  }

  // Custom bottom button builder
  Widget _buildBottomButton(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return Styles.buttonPressedBackgroundColor;
                }
                return Styles.buttonBackgroundColor;
              },
            ),
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return Styles.buttonPressedForegroundColor;
                }
                return Styles.buttonForegroundColor;
              },
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Styles.buttonBorderRadius),
              ),
            ),
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: Styles.buttonPaddingVertical),
            ),
          ),
          onPressed: () {
            navigatorKey.currentState?.pushNamed("/d/debug");
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: Styles.buttonFontSize,
              fontWeight: Styles.buttonFontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
