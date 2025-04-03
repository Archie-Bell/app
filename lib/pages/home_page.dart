import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app/api/websocket_manager.dart';
import 'package:app/api/missing_persons_list_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'person_details_page.dart';
import 'package:app/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebSocketManager _webSocketManager; // WebSocket manager to listen for updates
  List<MissingPerson> _missingPersons = []; // To hold missing persons list

  @override
  void initState() {
    super.initState();
    _webSocketManager = WebSocketManager();

    // Connect to the WebSocket servers for updates
    _webSocketManager.connect(
      'ws://${dotenv.env['YOUR_LOCAL_IP_ADDRESS']}:8000/ws/active-search-updates/',
    );

    _webSocketManager.connect(
      'ws://${dotenv.env['YOUR_LOCAL_IP_ADDRESS']}:8000/ws/submission-updates/',
    );

    // Listen for all messages from the WebSocket Manager
    _webSocketManager.generalMessages.listen((message) {
      _handleMessage(message);
    });

    // Fetch the initial list of missing persons
    _fetchMissingPersons();
  }

  @override
  void dispose() {
    super.dispose();
    _webSocketManager.close(); // Close WebSocket when leaving the page
  }

  // Function to fetch the initial list of missing persons
  Future<void> _fetchMissingPersons() async {
    ApiResult<List<MissingPerson>> result = await MissingPersonsListApi.getData();
    if (result.data != null) {
      setState(() {
        _missingPersons = result.data!;
      });
    }
  }

  // Function to handle incoming WebSocket messages
  void _handleMessage(String message) {
    print('================ TRIGGERED');
    try {
      var data = jsonDecode(message);
      print('HP: Received message: $data');

      if (data['type'] == 'update' && data['message'] != null) {
        // Update the missing persons list when an update is received
        print('Submission update received: ${data['message']}');
        setState(() {
          _fetchMissingPersons();
        });
      }

      if (data['type'] == 'active_search_update' && data['message'] != null) {
        // Handle transaction updates if necessary
        print('Active search update received: ${data['message']}');
        setState(() {
          _fetchMissingPersons();
        });
      }
    } catch (e) {
      print('Error decoding message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                  color: Colors.black.withAlpha(50),
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
                                ),
                                child: ClipRRect( // This ensures that the content inside the container is also clipped to the rounded corners
                                  borderRadius: BorderRadius.circular(22), // Same radius as container
                                  child: ListView.builder(
                                    itemCount: _missingPersons.length,
                                    itemBuilder: (context, index) {
                                      var person = _missingPersons[index];
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
}
