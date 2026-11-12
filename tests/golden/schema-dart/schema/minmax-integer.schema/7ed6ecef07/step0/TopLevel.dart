// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int free;
    final int intersection;
    final int max;
    final int min;
    final int minmax;
    final int minMaxIntersection;
    final int minMaxUnion;
    final int union;

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
        free: json["free"],
        intersection: ((x) => x >= 4 && x <= 5 ? x : throw FormatException("Expected bounded number"))(json["intersection"]),
        max: ((x) => true && x <= 5 ? x : throw FormatException("Expected bounded number"))(json["max"]),
        min: ((x) => x >= 3 && true ? x : throw FormatException("Expected bounded number"))(json["min"]),
        minmax: ((x) => x >= 3 && x <= 5 ? x : throw FormatException("Expected bounded number"))(json["minmax"]),
        minMaxIntersection: ((x) => x >= 3 && x <= 5 ? x : throw FormatException("Expected bounded number"))(json["minMaxIntersection"]),
        minMaxUnion: json["minMaxUnion"],
        union: ((x) => x >= 3 && x <= 6 ? x : throw FormatException("Expected bounded number"))(json["union"]),
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
