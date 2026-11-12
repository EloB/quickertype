// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic value;

    TopLevel({
        required this.value,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
    };
}
