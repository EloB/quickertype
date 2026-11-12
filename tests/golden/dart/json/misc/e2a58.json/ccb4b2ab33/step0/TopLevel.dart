// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final String date;
    final List<String> stopAndSearch;

    TopLevel({
        required this.date,
        required this.stopAndSearch,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        date: json["date"],
        stopAndSearch: List<String>.from(json["stop-and-search"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "stop-and-search": List<dynamic>.from(stopAndSearch.map((x) => x)),
    };
}
