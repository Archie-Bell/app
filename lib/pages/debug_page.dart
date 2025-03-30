import 'dart:async';
import 'package:app/api/missing_persons_list_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app/pages/debug_details_page.dart';
import 'package:flutter/material.dart';
import 'package:app/main.dart';
import 'package:app/theme.dart';

class DebugPage extends StatefulWidget {
  final String? notificationId;

  const DebugPage({super.key, this.notificationId});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  late Timer _timer;
  late Future<ApiResult<List<MissingPerson>>> _dataFuture;
  String? notificationId;

  @override
  void initState() {
    super.initState();
    notificationId = widget.notificationId;
    _dataFuture = MissingPersonsListApi.getData();
    print(MissingPersonsListApi.getData());

    // Make duration for 60 instead of 5 for debugging purposes
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        _dataFuture = MissingPersonsListApi.getData();
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
      body: Container(
        decoration: BoxDecoration(
            gradient: Styles.appGradient,
          ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/u/verification/pending');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(250, 40),
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text("View Verification Pending Page", 
              style: Styles.whiteTextStyle,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/u/verification/phone');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(250, 40),
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text("View Phone Verification Page", style: Styles.whiteTextStyle,),
            ),
            OutlinedButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/u/landing');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(250, 40),
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text("View Landing Page", style: Styles.whiteTextStyle,),
            ),
            OutlinedButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/u/home');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(250, 40),
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text("View Home Page", style: Styles.whiteTextStyle,),
            ),
            OutlinedButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/s/home');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(250, 40),
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text("View Staff Home Page", style: Styles.whiteTextStyle,),
            ),
            Expanded(  // Ensures the FutureBuilder takes the remaining space
              child: FutureBuilder<ApiResult<List<MissingPerson>>>(
                future: _dataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.error != null) {
                      return Center(child: Text("Error: ${snapshot.data!.error}"));
                    } else {
                      List<MissingPerson> dataList = snapshot.data!.data!;

                      // Filter data if notificationId is provided
                      List<MissingPerson> filteredData = notificationId != null 
                        ? dataList.where((data) {
                            return data.id == notificationId;
                          }).toList()
                        : dataList;

                      return ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          var data = filteredData[index];
                          return displayCard(data);
                        },
                      );
                    }
                  } else {
                    return const Center(child: Text("No data available"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget displayCard(MissingPerson data) {
    return Card(
      child: ListTile(
        onTap: () {
          // Navigate to the notification page with the missing person data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DebugDetailsPage(missingPersonData: data),
            ),
          );
        },
        minTileHeight: 200.0,
        title: Text("${data.name.toString()}, ${data.age.toString()}", style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Image.network(
                    'http://${dotenv.env['YOUR_LOCAL_IP_ADDRESS']}:8000${data.image}', // Use "ipconfig" to determine your IPv4 address when testing this application.
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
                      return Image.asset('images/placeholder-img.jpg');
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
