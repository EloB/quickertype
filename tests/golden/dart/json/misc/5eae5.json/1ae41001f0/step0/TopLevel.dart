// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final DateTime date;
    final int id;
    final String sponsor;
    final String title;

    TopLevel({
        required this.date,
        required this.id,
        required this.sponsor,
        required this.title,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        date: DateTime.parse(json["Date"]),
        id: json["ID"],
        sponsor: json["Sponsor"],
        title: json["Title"],
    );

    Map<String, dynamic> toJson() => {
        "Date": date.toIso8601String(),
        "ID": id,
        "Sponsor": sponsor,
        "Title": title,
    };
}
