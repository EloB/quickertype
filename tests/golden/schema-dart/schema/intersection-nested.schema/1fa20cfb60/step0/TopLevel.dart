// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final double? intersection;

    TopLevel({
        this.intersection,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        intersection: json["intersection"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "intersection": intersection,
    };
}
