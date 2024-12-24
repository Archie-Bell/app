import 'dart:async';
import 'package:app/api/constants.dart';
import 'package:app/api/mongo_db.dart';
import 'package:app/models/missing_person_model.dart';
import 'package:app/pages/notification_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String? notificationId;

  const HomePage({super.key, this.notificationId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  late Future<List> _dataFuture;
  String? notificationId;

  @override
  void initState() {
    super.initState();
    notificationId = widget.notificationId;
    _dataFuture = MongoDB.getData();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
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
        child: FutureBuilder(
          future: _dataFuture,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              var totalData = snapshot.data.length;
              // print("Total Data: $totalData");

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
        title: Text(data.name.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Image.network(
                    'http://${YOUR_LOCAL_IP_ADDRESS}/api/${data.image}', // Use "ipconfig" to determine your IPv4 address when testing this application.
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
