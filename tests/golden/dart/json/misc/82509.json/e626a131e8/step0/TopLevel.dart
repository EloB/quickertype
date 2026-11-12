// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String origin;

    TopLevel({
        required this.origin,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        origin: json["origin"],
    );

    Map<String, dynamic> toJson() => {
        "origin": origin,
    };
}
