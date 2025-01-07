import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app/models/missing_person_model.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final DbModel? missingPersonData;

  const NotificationPage({super.key, this.missingPersonData});

  @override
  Widget build(BuildContext context) {
    if (missingPersonData == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Archie Bell", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: const Center(child: Text("No Data Available")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Archie Bell", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'http://${dotenv.env['YOUR_LOCAL_IP_ADDRESS']}:8001/api/${missingPersonData!.image}',
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
                return Image.asset('images/placeholder-img.jpg', height: 200); // Provide a local fallback image
              },
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            Text(
              missingPersonData!.name.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Last Known Location: ${missingPersonData!.lastLocationSeen}',
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              'Last Seen: ${missingPersonData!.lastDateTimeSeen}',
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              missingPersonData!.additionalInfo.toString(),
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
