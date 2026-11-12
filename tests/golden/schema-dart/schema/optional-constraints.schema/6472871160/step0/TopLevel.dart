// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final double? optDouble;
    final int? optInt;
    final String? optPattern;
    final String? optString;
    final int reqZeroMin;

    TopLevel({
        this.optDouble,
        this.optInt,
        this.optPattern,
        this.optString,
        required this.reqZeroMin,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        optDouble: json["optDouble"]?.toDouble() == null ? null : ((x) => x >= 0.5 && x <= 99.5 ? x : throw FormatException("Expected bounded number"))(json["optDouble"]?.toDouble()),
        optInt: json["optInt"] == null ? null : ((x) => x >= 0 && x <= 100 ? x : throw FormatException("Expected bounded number"))(json["optInt"]),
        optPattern: json["optPattern"] == null ? null : ((x) => RegExp("^[a-z]+\u0024").hasMatch(x) ? x : throw FormatException("Expected matching string"))(json["optPattern"]),
        optString: json["optString"] == null ? null : ((x) => x.runes.length >= 3 && x.runes.length <= 10 ? x : throw FormatException("Expected bounded string"))(json["optString"]),
        reqZeroMin: ((x) => x >= 0 && x <= 100 ? x : throw FormatException("Expected bounded number"))(json["reqZeroMin"]),
    );

    Map<String, dynamic> toJson() => {
        "optDouble": optDouble,
        "optInt": optInt,
        "optPattern": optPattern,
        "optString": optString,
        "reqZeroMin": reqZeroMin,
    };
}
