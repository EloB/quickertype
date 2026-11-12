// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int data;
    final TopLevel? next;

    TopLevel({
        required this.data,
        required this.next,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        data: json["data"],
        next: (json.containsKey("next") ? json["next"] : throw FormatException('Missing required property')) == null ? null : TopLevel.fromJson((json.containsKey("next") ? json["next"] : throw FormatException('Missing required property'))),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "next": next?.toJson(),
    };
}
