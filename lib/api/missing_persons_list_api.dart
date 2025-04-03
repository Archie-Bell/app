import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Logic to define if the API returns requested data or an error
class ApiResult<T> {
  final T? data;
  final String? error;

  ApiResult({this.data, this.error});
}

// Define JSON request, and handle GET requests from backend
class MissingPersonsListApi {
  static Future<ApiResult<List<MissingPerson>>> getData() async {
    try {
      final uri = Uri.parse("http://${dotenv.env['YOUR_LOCAL_IP_ADDRESS']}:8000/api/missing-persons");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<MissingPerson> missingPersons = responseData
            .map((item) => MissingPerson.fromJson(item))
            .toList();
        return ApiResult(data: missingPersons); // Return data if successful
      } else {
        return ApiResult(error: 'Unable to fetch data, server returned: ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) {
        return ApiResult(error: 'Backend is offline, unable to fetch data.');
      } else {
        return ApiResult(error: 'An error occurred: $e');
      }
    }
  }

  static Future<ApiResult<MissingPerson>> postActiveSearchData(String parentId, String imageUrl, String locationFound, String dateTimeFound, String providedInfo) async {
    Map<String, dynamic> request = {
      '_parent_id': parentId,
      'image_url': imageUrl,
      'location_found': locationFound,
      'date_time_found': dateTimeFound,
      'provided_info': providedInfo,
    };

    try {
      final uri = Uri.parse('http://${dotenv.env['YOUR_LOCAL_IP_ADDRESS']}:8000/api/missing-person/submission');
      final response = await http.post(uri, body: request);

      if (response.statusCode == 200) {
        return ApiResult(data: MissingPerson.fromJson(json.decode(response.body)));
      } else {
        return ApiResult(error: 'An error occurred: ${response.statusCode}');
      }
    }

    catch (e) {
      if (e is SocketException) {
        return ApiResult(error: 'Backend is offline, unable to fetch data.');
      } else {
        return ApiResult(error: 'An error occurred: $e');
      }
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