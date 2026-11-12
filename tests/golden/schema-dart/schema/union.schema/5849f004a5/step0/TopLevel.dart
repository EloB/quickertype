// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final int? one;
    final bool two;
    final double? three;

    TopLevel({
        this.one,
        required this.two,
        this.three,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        one: json["one"],
        two: json["two"],
        three: json["three"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "one": one,
        "two": two,
        "three": three,
    };
}
