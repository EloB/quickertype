// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String name;
    final int topLevelCopyWith;

    TopLevel({
        required this.name,
        required this.topLevelCopyWith,
    });

    TopLevel copyWith({
        String? name,
        int? topLevelCopyWith,
    }) => 
        TopLevel(
            name: name ?? this.name,
            topLevelCopyWith: topLevelCopyWith ?? this.topLevelCopyWith,
        );

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        name: json["name"],
        topLevelCopyWith: json["copyWith"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "copyWith": topLevelCopyWith,
    };
}
