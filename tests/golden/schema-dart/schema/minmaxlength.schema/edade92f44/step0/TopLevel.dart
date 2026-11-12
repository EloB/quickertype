// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String intersection;
    final dynamic inUnion;
    final String maxlength;
    final String minlength;
    final String minMaxIntersection;
    final String minmaxlength;
    final String minMaxUnion;
    final String union;

    TopLevel({
        required this.intersection,
        required this.inUnion,
        required this.maxlength,
        required this.minlength,
        required this.minMaxIntersection,
        required this.minmaxlength,
        required this.minMaxUnion,
        required this.union,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        intersection: ((x) => x.runes.length >= 4 && x.runes.length <= 5 ? x : throw FormatException("Expected bounded string"))(json["intersection"]),
        inUnion: json["inUnion"],
        maxlength: ((x) => true && x.runes.length <= 5 ? x : throw FormatException("Expected bounded string"))(json["maxlength"]),
        minlength: ((x) => x.runes.length >= 3 && true ? x : throw FormatException("Expected bounded string"))(json["minlength"]),
        minMaxIntersection: ((x) => x.runes.length >= 3 && x.runes.length <= 5 ? x : throw FormatException("Expected bounded string"))(json["minMaxIntersection"]),
        minmaxlength: ((x) => x.runes.length >= 3 && x.runes.length <= 5 ? x : throw FormatException("Expected bounded string"))(json["minmaxlength"]),
        minMaxUnion: json["minMaxUnion"],
        union: ((x) => x.runes.length >= 3 && x.runes.length <= 6 ? x : throw FormatException("Expected bounded string"))(json["union"]),
    );

    Map<String, dynamic> toJson() => {
        "intersection": intersection,
        "inUnion": inUnion,
        "maxlength": maxlength,
        "minlength": minlength,
        "minMaxIntersection": minMaxIntersection,
        "minmaxlength": minmaxlength,
        "minMaxUnion": minMaxUnion,
        "union": union,
    };
}
