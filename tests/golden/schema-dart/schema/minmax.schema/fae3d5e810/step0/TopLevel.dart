// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final double free;
    final double intersection;
    final double max;
    final double min;
    final double minmax;
    final double minMaxIntersection;
    final double minMaxUnion;
    final double union;

    TopLevel({
        required this.free,
        required this.intersection,
        required this.max,
        required this.min,
        required this.minmax,
        required this.minMaxIntersection,
        required this.minMaxUnion,
        required this.union,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        free: json["free"]?.toDouble(),
        intersection: ((x) => x >= 4 && x <= 5 ? x : throw FormatException("Expected bounded number"))(json["intersection"]?.toDouble()),
        max: ((x) => true && x <= 5 ? x : throw FormatException("Expected bounded number"))(json["max"]?.toDouble()),
        min: ((x) => x >= 3 && true ? x : throw FormatException("Expected bounded number"))(json["min"]?.toDouble()),
        minmax: ((x) => x >= 3 && x <= 5 ? x : throw FormatException("Expected bounded number"))(json["minmax"]?.toDouble()),
        minMaxIntersection: ((x) => x >= 3 && x <= 5 ? x : throw FormatException("Expected bounded number"))(json["minMaxIntersection"]?.toDouble()),
        minMaxUnion: json["minMaxUnion"]?.toDouble(),
        union: ((x) => x >= 3 && x <= 6 ? x : throw FormatException("Expected bounded number"))(json["union"]?.toDouble()),
    );

    Map<String, dynamic> toJson() => {
        "free": free,
        "intersection": intersection,
        "max": max,
        "min": min,
        "minmax": minmax,
        "minMaxIntersection": minMaxIntersection,
        "minMaxUnion": minMaxUnion,
        "union": union,
    };
}
