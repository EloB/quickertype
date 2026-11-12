// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String exact;
    final String maximum;
    final String minimum;

    TopLevel({
        required this.exact,
        required this.maximum,
        required this.minimum,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        exact: ((x) => RegExp("^[^!]+\u0024").hasMatch(x) ? x : throw FormatException("Expected matching string"))(((x) => x.runes.length >= 2 && x.runes.length <= 2 ? x : throw FormatException("Expected bounded string"))(json["exact"])),
        maximum: ((x) => true && x.runes.length <= 1 ? x : throw FormatException("Expected bounded string"))(json["maximum"]),
        minimum: ((x) => x.runes.length >= 2 && true ? x : throw FormatException("Expected bounded string"))(json["minimum"]),
    );

    Map<String, dynamic> toJson() => {
        "exact": exact,
        "maximum": maximum,
        "minimum": minimum,
    };
}
