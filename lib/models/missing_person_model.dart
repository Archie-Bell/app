import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

DbModel dbModelFromJSON(String str) => DbModel.fromJson(json.decode(str));
String dbModelToJson(DbModel data) => json.encode(data.toJson());

class DbModel {
  ObjectId? id;
  String? name;
  int? age;
  String? lastLocationSeen;
  String? lastDateTimeSeen;
  String? additionalInfo;
  String? image;

  DbModel({
    this.id,
    this.name,
    this.age,
    this.lastLocationSeen,
    this.lastDateTimeSeen,
    this.additionalInfo,
    this.image,
  });

  factory DbModel.fromJson(Map<String, dynamic> json) => DbModel(
    id: json["_id"],
    name: json["name"],
    age: json["age"],
    lastLocationSeen: json["last_location_seen"],
    lastDateTimeSeen: json["last_date_time_seen"],
    additionalInfo: (json["additional_info"] == null || json["additional_info"].toString().trim().isEmpty) 
        ? "No description provided."
        : json["additional_info"],
    image: json["image"] ?? "images/placeholder-img.jpg",
  );


  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "age": age,
    "lastLocationSeen": lastLocationSeen,
    "lastDateTimeSeen": lastDateTimeSeen,
    "additionalInfo": additionalInfo,
    "image": image,
  };
}