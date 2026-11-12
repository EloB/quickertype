// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final int id;
    final String name;
    final String notes;

    TopLevel({
        required this.id,
        required this.name,
        required this.notes,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        id: json["ID"],
        name: json["Name"],
        notes: json["Notes"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Notes": notes,
    };
}
