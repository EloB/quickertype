// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final bool booleanValue;
    final double doubleValue;
    final int intValue;
    final String stringValue;
    final String uuidValue;
    final List<String> uuidValues;

    TopLevel({
        required this.booleanValue,
        required this.doubleValue,
        required this.intValue,
        required this.stringValue,
        required this.uuidValue,
        required this.uuidValues,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        booleanValue: json["booleanValue"],
        doubleValue: json["doubleValue"]?.toDouble(),
        intValue: json["intValue"],
        stringValue: json["stringValue"],
        uuidValue: ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(json["uuidValue"]),
        uuidValues: List<String>.from(json["uuidValues"].map((x) => ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(x))),
    );

    Map<String, dynamic> toJson() => {
        "booleanValue": booleanValue,
        "doubleValue": doubleValue,
        "intValue": intValue,
        "stringValue": stringValue,
        "uuidValue": uuidValue,
        "uuidValues": List<dynamic>.from(uuidValues.map((x) => x)),
    };
}
