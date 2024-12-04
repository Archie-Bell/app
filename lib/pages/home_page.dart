import 'dart:async';

import 'package:app/api/mongo_db.dart';
import 'package:app/models/missing_person_model.dart';
import 'package:app/pages/notification_page.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  late Future<List> _dataFuture;

  @override
  void initState() {
    super.initState();

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
    return Scaffold(appBar: AppBar(
      centerTitle: true,
      title: const Text("Archie Bell"),
    ),
    body: SafeArea(
      child: FutureBuilder(
        future: _dataFuture,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            var totalData = snapshot.data.length;
            print("Total Data : $totalData");
            return ListView.builder(
              itemCount: totalData,
              itemBuilder: (context, index) {
                var data = snapshot.data[index];
                return displayCard(DbModel.fromJson(data));
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return const Center(child: Text("No data is available"));
          }
        }
      ),
    ),
    );
  }

  Widget displayCard(DbModel data) {
    return Card(
      // child: Padding(
      //   padding: const EdgeInsets.all(15.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       Text(data.id!.oid.toString()),
      //       Text(data.name.toString()),
      //       Text(data.lastLocationSeen.toString()),
      //       Text(data.lastDateTimeSeen.toString()),
      //       Text(data.additionalInfo.toString()),
      //     ]),
      //   ),
      child: ListTile(
        onTap: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(missingPersonData: data),))
        },
        minTileHeight: 200.0,
        title: Text(data.name.toString()),
        trailing: Image.asset('images/placeholder-img.jpg'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(data.id!.oid.toString()),
            Text(data.lastLocationSeen.toString()),
            Text(data.lastDateTimeSeen.toString()),
            Text(data.additionalInfo.toString()),
          ]),
        ),
    );
  }
}