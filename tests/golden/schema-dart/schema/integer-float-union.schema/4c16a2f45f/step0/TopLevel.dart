// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic number;

    TopLevel({
        required this.number,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
    };
}
