// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int item;

    TopLevel({
        required this.item,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        item: json["item"],
    );

    Map<String, dynamic> toJson() => {
        "item": item,
    };
}
