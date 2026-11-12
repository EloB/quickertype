// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final DateTime birthday;
    final DateTime lastSeen;
    final String name;

    TopLevel({
        required this.birthday,
        required this.lastSeen,
        required this.name,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        birthday: DateTime.parse(json["birthday"]),
        lastSeen: DateTime.parse(json["lastSeen"]),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "lastSeen": lastSeen.toIso8601String(),
        "name": name,
    };
}
