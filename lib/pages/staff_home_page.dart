import 'package:flutter/material.dart';
import 'package:app/theme.dart';

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
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: Styles.appGradient, // Use custom gradient
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Greeting and Settings Icon
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Good morning, User.",
                      style: Styles.whiteTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Navigator.pushNamed(context, "/d/debug");
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
              style: Styles.liveActivityTitleStyle, // Use custom text style
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Styles.liveActivityBorderColor, width: 1), // Custom border color
                  borderRadius: BorderRadius.circular(Styles.liveActivityBorderRadius), // Apply custom corner radius
                ),
                child: cases.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "There are currently no missing cases reported.",
                            textAlign: TextAlign.center,
                            style: Styles.whiteTextStyle,
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(Styles.liveActivityBorderRadius), // Apply custom corner radius
                        child: ListView.builder(
                          itemCount: cases.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0), // Add padding around each element
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Styles.liveActivityBorderColor, width: 1), // Custom border color
                                  borderRadius: BorderRadius.circular(Styles.liveActivityBorderRadius), // Apply custom corner radius
                                ),
                                child: ListTile(
                                  title: Text(
                                    cases[index],
                                    style: Styles.liveActivityCardTitleStyle, // Custom text style
                                  ),
                                  subtitle: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                    style: Styles.liveActivityCardSubtitleStyle, // Custom text style
                                  ),
                                  trailing: const Icon(Icons.remove_red_eye, color: Styles.liveActivityIconColor),
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
            Text(
              "Individual Reports",
              style: Styles.whiteTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Styles.liveActivityBorderColor, width: 1), // Custom border color
                        borderRadius: BorderRadius.circular(Styles.liveActivityBorderRadius), // Apply custom corner radius
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 50, color: Colors.grey[600]),
                          Text(
                            "Person ${index + 1}",
                            style: Styles.whiteTextStyle,
                          ),
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
                style: Styles.button, // Use custom button style
                onPressed: () {}, // TODO: add logic to see more button
                child: Text(
                  "See More",
                  style: Styles.whiteTextStyle,
                ),
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
        child: OutlinedButton(
          style: Styles.button, // Use custom button style
          onPressed: () {},
          child: Text(
            text,
            style: Styles.whiteTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
