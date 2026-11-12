// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Map<String, int> map;

    TopLevel({
        required this.map,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        map: Map.from(json["map"]).map((k, v) => MapEntry<String, int>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "map": Map.from(map).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
