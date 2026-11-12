// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromMap(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toMap());

class TopLevel {
    final int date;
    final String title;
    final bool validity;

    TopLevel({
        required this.date,
        required this.title,
        required this.validity,
    });

    factory TopLevel.fromMap(Map<String, dynamic> json) => TopLevel(
        date: json["date"],
        title: json["title"],
        validity: json["validity"],
    );

    Map<String, dynamic> toMap() => {
        "date": date,
        "title": title,
        "validity": validity,
    };
}
