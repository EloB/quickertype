// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Map<String, dynamic>? union;

    TopLevel({
        this.union,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        union: json["union"] == null ? null : Map.from(json["union"]!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "union": union == null ? null : Map.from(union!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}

class UnionClass {
    final int? quux;

    UnionClass({
        this.quux,
    });

    factory UnionClass.fromJson(Map<String, dynamic> json) => UnionClass(
        quux: json["quux"],
    );

    Map<String, dynamic> toJson() => {
        "quux": quux,
    };
}
