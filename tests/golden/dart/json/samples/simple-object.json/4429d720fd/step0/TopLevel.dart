// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int date;
    final String title;
    final bool validity;

    TopLevel({
        required this.date,
        required this.title,
        required this.validity,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        date: json["date"],
        title: json["title"],
        validity: json["validity"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "title": title,
        "validity": validity,
    };
}
