import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

DbModel dbModelFromJSON(String str) => DbModel.fromJson(json.decode(str));
String dbModelToJson(DbModel data) => json.encode(data.toJson());

class DbModel {
  ObjectId? id;
  String? name;
  String? lastLocationSeen;
  String? lastDateTimeSeen;
  String? additionalInfo;

  DbModel({
    this.id,
    this.name,
    this.lastLocationSeen,
    this.lastDateTimeSeen,
    this.additionalInfo,
  });

  factory DbModel.fromJson(Map<String, dynamic> json) => DbModel(
    id: json["_id"],
    name: json["name"],
    lastLocationSeen: json["lastLocationSeen"],
    lastDateTimeSeen: json["lastDateTimeSeen"],
    additionalInfo: json["additionalInfo"] ?? "No description provided.",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "lastLocationSeen": lastLocationSeen,
    "lastDateTimeSeen": lastDateTimeSeen,
    "additionalInfo": additionalInfo,
  };
}