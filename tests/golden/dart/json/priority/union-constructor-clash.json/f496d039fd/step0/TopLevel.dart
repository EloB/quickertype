// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final BoolInUnion boolInUnion;
    final List<dynamic> union;

    TopLevel({
        required this.boolInUnion,
        required this.union,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        boolInUnion: BoolInUnion.fromJson(json["BoolInUnion"]),
        union: List<dynamic>.from(json["union"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "BoolInUnion": boolInUnion.toJson(),
        "union": List<dynamic>.from(union.map((x) => x)),
    };
}

class BoolInUnion {
    final bool a;

    BoolInUnion({
        required this.a,
    });

    factory BoolInUnion.fromJson(Map<String, dynamic> json) => BoolInUnion(
        a: json["a"],
    );

    Map<String, dynamic> toJson() => {
        "a": a,
    };
}
