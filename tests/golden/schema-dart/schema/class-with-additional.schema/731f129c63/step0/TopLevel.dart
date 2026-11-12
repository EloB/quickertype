// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Map<String, dynamic>? map;

    TopLevel({
        this.map,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        map: json["map"] == null ? null : Map.from(json["map"]!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "map": map == null ? null : Map.from(map!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
