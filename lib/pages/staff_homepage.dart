import 'package:flutter/material.dart';

class StaffHomepage extends StatelessWidget {
  const StaffHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for Cases
    List<String> recentCases = [
      "Jane Doe, 12:34 PM, Today",
      ]; // Empty list simulates no recent cases
    List<String> liveActivity = [
      "Jane Doe, 12:34 PM, Today",
      "John Smith, 11:45 AM, Today",
      "Alice Johnson, 10:20 AM, Today",
      "Bob Brown, 09:00 AM, Today",
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            // Greeting and Settings Icon
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Good morning, User.",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.pushNamed(context, "/legacy_home_page");
                    }, // TODO: Route temporarily to debug
                  ),
                ],
              ),
            ),

            // Main Content with Equal Height Sections
            Expanded(
              child: Column(
                children: [
                  // Recent Cases
                  _buildCasesContainer("Recent Cases", recentCases),

                  const SizedBox(height: 8),
                  // Live Activity
                  _buildCasesContainer("Live Activity", liveActivity),

                  // Individual Reports
                  _buildIndividualReportsContainer(),
                ],
              ),
            ),

            // Bottom Navigation (Fixed)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBottomButton("Dashboard"),
                  _buildBottomButton("Chat"),
                  _buildBottomButton("Cases"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCasesContainer(String title, List<String> cases) {
  return Expanded(
    flex: 3, // Ensures equal height across sections
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: cases.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "There are currently no missing cases reported.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ListView.builder(
                        itemCount: cases.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0), // Add padding around each element
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                              child: ListTile(
                                title: Text(
                                  cases[index],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: const Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                ),
                                trailing: const Icon(Icons.remove_red_eye),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    ),
  );
}

  /// Individual reports container
  Widget _buildIndividualReportsContainer() {
    return Expanded(
      flex: 3, // Ensures equal height across sections
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              "Individual Reports",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 50, color: Colors.grey[600]),
                          Text("Person ${index + 1}"),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {}, // TODO: add logic to see more button
                child: const Text("See More"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom navigation button
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
