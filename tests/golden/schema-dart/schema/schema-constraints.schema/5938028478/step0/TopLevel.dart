// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String minMaxLength;
    final double percent;

    TopLevel({
        required this.minMaxLength,
        required this.percent,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        minMaxLength: ((x) => x.runes.length >= 5 && x.runes.length <= 5 ? x : throw FormatException("Expected bounded string"))(json["minMaxLength"]),
        percent: ((x) => x >= 0 && x <= 1 ? x : throw FormatException("Expected bounded number"))(json["percent"]?.toDouble()),
    );

    Map<String, dynamic> toJson() => {
        "minMaxLength": minMaxLength,
        "percent": percent,
    };
}
