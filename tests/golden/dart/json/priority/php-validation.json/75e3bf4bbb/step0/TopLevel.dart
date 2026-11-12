// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final bool boolean;
    final int integer;
    final List<int> integers;
    final double number;
    final String string;

    TopLevel({
        required this.boolean,
        required this.integer,
        required this.integers,
        required this.number,
        required this.string,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        boolean: json["boolean"],
        integer: json["integer"],
        integers: List<int>.from(json["integers"].map((x) => x)),
        number: json["number"]?.toDouble(),
        string: json["string"],
    );

    Map<String, dynamic> toJson() => {
        "boolean": boolean,
        "integer": integer,
        "integers": List<dynamic>.from(integers.map((x) => x)),
        "number": number,
        "string": string,
    };
}
