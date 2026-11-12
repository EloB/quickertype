// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<dynamic> open;
    final List<dynamic> tuple;

    TopLevel({
        required this.open,
        required this.tuple,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        open: List<dynamic>.from(json["open"].map((x) => x)),
        tuple: List<dynamic>.from(json["tuple"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "open": List<dynamic>.from(open.map((x) => x)),
        "tuple": List<dynamic>.from(tuple.map((x) => x)),
    };
}
