
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MissingPersonsListApi {
  static Future<List<MissingPerson>> getData() async {
    final uri = Uri.parse("http://${dotenv.env['YOUR_LOCAL_IP_ADDRESS']}:8000/api/missing-persons");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData.map((item) => MissingPerson.fromJson(item)).toList();
    }
    
    else {
      throw Exception('Unable to fetch data. Ensure backend server is online.');
    }
  }
}

class MissingPerson {
  final String id, name, lastLocationSeen, lastDateTimeSeen, image, additionalInfo;
  final int age;

  MissingPerson({
    required this.id,
    required this.name,
    required this.age,
    required this.lastLocationSeen,
    required this.lastDateTimeSeen,
    required this.image,
    required this.additionalInfo,
  });

  factory MissingPerson.fromJson(Map<String, dynamic> json) => MissingPerson(
    id: json['_id'],
    name: json['name'],
    age: json['age'],
    lastLocationSeen: json['last_location_seen'],
    lastDateTimeSeen: json['last_date_time_seen'],
    image: json["image_url"] ?? "images/placeholder-img.jpg",
    additionalInfo: json["additional_info"] ?? "No description provided."
  );
}