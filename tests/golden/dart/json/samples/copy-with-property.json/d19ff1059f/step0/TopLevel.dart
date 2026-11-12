// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int copyWith;
    final String name;

    TopLevel({
        required this.copyWith,
        required this.name,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        copyWith: json["copyWith"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "copyWith": copyWith,
        "name": name,
    };
}
