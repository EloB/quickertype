// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());


///An object with a scalar default
class TopLevel {
    final int id;

    TopLevel({
        required this.id,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
