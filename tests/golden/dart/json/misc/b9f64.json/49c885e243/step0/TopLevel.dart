// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String userAgent;

    TopLevel({
        required this.userAgent,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        userAgent: json["user-agent"],
    );

    Map<String, dynamic> toJson() => {
        "user-agent": userAgent,
    };
}
