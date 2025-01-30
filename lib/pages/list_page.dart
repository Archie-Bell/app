import 'package:flutter/material.dart';
import 'person_details_page.dart'; 

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of missing persons (this will be replaced with database data later)
    List<Map<String, String>> missingPersons = [
      {'name': 'Person 1', 'age': '70', 'lastLocation': 'Moose Jaw, SK'},
      {'name': 'Person 2', 'age': '50', 'lastLocation': 'Regina, SK'},
    ];

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

                    // Scrollable List of Missing Persons
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          itemCount: missingPersons.length,
                          itemBuilder: (context, index) {
                            var person = missingPersons[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: const BorderSide(color: Colors.black, width: 1),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              child: ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                title: Text(
                                  "${person['name']}, ${person['age']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text("Last location: ${person['lastLocation']}",
                                    style: const TextStyle(fontSize: 14)),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () {
                                  // Navigate to PersonDetailsPage with person's data
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PersonDetailsPage(person: person),
                                    ),
                                  );
                                },
                              ),
                            );
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
                  _buildBottomButton("Settings"),
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
          onPressed: () {},
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
