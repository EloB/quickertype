// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final String key;

    TopLevel({
        required this.key,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
    };
}
