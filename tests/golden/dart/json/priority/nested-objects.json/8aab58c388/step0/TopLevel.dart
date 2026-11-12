// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Map<String, int> a;
    final Map<String, int> b;

    TopLevel({
        required this.a,
        required this.b,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        a: Map.from(json["a"]).map((k, v) => MapEntry<String, int>(k, v)),
        b: Map.from(json["b"]).map((k, v) => MapEntry<String, int>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "a": Map.from(a).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "b": Map.from(b).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
