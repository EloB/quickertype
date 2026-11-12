// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final double value;

    TopLevel({
        required this.value,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        value: ((x) => x >= 0.1 && x <= 0.9 ? x : throw FormatException("Expected bounded number"))(json["value"]?.toDouble()),
    );

    Map<String, dynamic> toJson() => {
        "value": value,
    };
}
