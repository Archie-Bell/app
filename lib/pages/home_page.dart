import 'package:app/api/missing_persons_list_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'person_details_page.dart'; 
import 'package:app/main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch data using the updated API that now returns an ApiResult
    Future<ApiResult<List<MissingPerson>>> missingPersons = MissingPersonsListApi.getData();

    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      body: SafeArea(
        child: Column(
          children: [
            // Greeting
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Good afternoon.",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Live Activity Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Live Activity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(4, (index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black, width: 1),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            index == 0
                                ? "No Current Activity"
                                : "No Current activity",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text(
                            "Will update when there is activity",
                          ),
                          trailing: const Icon(Icons.remove_red_eye, color: Colors.black),
                        ),
                      );
                    }),
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
                    const Text(
                      "Missing Cases",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // FutureBuilder to handle the asynchronous data fetching
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBottomButton("Dashboard"),
                  _buildBottomButton("Debug"), // This is where the Settings button will be, but for now, this is the button used for debugging
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom bottom button builder
  Widget _buildBottomButton(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
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
            // Temporarily route the button to the old home page for debugging purposes
            navigatorKey.currentState?.pushNamed("/d/debug");
          },

          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
