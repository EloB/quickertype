// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());


///A recursive class type
class TopLevel {
    final TopLevel? next;

    TopLevel({
        this.next,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        next: json["next"] == null ? null : TopLevel.fromJson(json["next"]),
    );

    Map<String, dynamic> toJson() => {
        "next": next?.toJson(),
    };
}
