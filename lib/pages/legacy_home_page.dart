import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app/api/mongo_db.dart';
import 'package:app/models/missing_person_model.dart';
import 'package:app/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:app/main.dart';

/*

To ensure efficient migration to the new interface, 
keeping the old code is necessary until everything is moved over before finally deleting.

*/

class LegacyHomePage extends StatefulWidget {
  final String? notificationId;

  const LegacyHomePage({super.key, this.notificationId});

  @override
  State<LegacyHomePage> createState() => _LegacyHomePageState();
}

class _LegacyHomePageState extends State<LegacyHomePage> {
  late Timer _timer;
  late Future<List> _dataFuture;
  String? notificationId;

  @override
  void initState() {
    super.initState();
    notificationId = widget.notificationId;
    _dataFuture = MongoDB.getData();

    // Make duration for 60 instead of 5 for debugging purposes
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        _dataFuture = MongoDB.getData();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Archie Bell", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers the column's content vertically
          children: [
            OutlinedButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/verification_page');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(250, 40),
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text("View Verification Page", style: TextStyle(color: Colors.black)),
            ),
            OutlinedButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/phone_number_page');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(250, 40),
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text("View Phone Number Page", style: TextStyle(color: Colors.black)),
            ),
            OutlinedButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/new_home_page');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(250, 40),
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text("View New Home Page", style: TextStyle(color: Colors.black)),
            ),
            OutlinedButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/list_page');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(250, 40),
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text("View List Page", style: TextStyle(color: Colors.black)),
            ),
            Expanded(  // Ensures the FutureBuilder takes the remaining space
              child: FutureBuilder(
                future: _dataFuture,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    // var totalData = snapshot.data.length;

                    // Filter the data if notificationId is provided
                    List filteredData = snapshot.data;
                    if (notificationId != null) {
                      filteredData = snapshot.data.where((data) {
                        return DbModel.fromJson(data).id == notificationId;
                      }).toList();
                    }

                    return ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        var data = filteredData[index];
                        return displayCard(DbModel.fromJson(data));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    return const Center(child: Text("No data available"));
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget displayCard(DbModel data) {
    return Card(
      child: ListTile(
        onTap: () {
          // Navigate to the notification page with the missing person data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationPage(missingPersonData: data),
            ),
          );
        },
        minTileHeight: 200.0,
        title: Text("${data.name.toString()}, ${data.age.toString()}", style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Image.network(
                    'http://${dotenv.env['YOUR_LOCAL_IP_ADDRESS']}:8001/api/${data.image}', // Use "ipconfig" to determine your IPv4 address when testing this application.
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return const Text('Failed to load image');
                    },
                  ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(data.id!.oid.toString()),
            Text(data.lastLocationSeen.toString()),
            Text(data.lastDateTimeSeen.toString()),
            Text(data.additionalInfo.toString()),
          ],
        ),
      ),
    );
  }
}
