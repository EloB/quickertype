// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic next;
    final String value;

    TopLevel({
        this.next,
        required this.value,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        next: json["next"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "next": next,
        "value": value,
    };
}

class Node {
    final dynamic next;
    final String value;

    Node({
        this.next,
        required this.value,
    });

    factory Node.fromJson(Map<String, dynamic> json) => Node(
        next: json["next"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "next": next,
        "value": value,
    };
}
