// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final int directorateId;
    final int id;
    final String name;

    TopLevel({
        required this.directorateId,
        required this.id,
        required this.name,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        directorateId: json["DirectorateID"],
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "DirectorateID": directorateId,
        "Id": id,
        "Name": name,
    };
}
