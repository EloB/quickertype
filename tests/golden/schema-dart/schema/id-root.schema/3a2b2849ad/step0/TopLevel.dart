// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int bar;

    TopLevel({
        required this.bar,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        bar: json["bar"],
    );

    Map<String, dynamic> toJson() => {
        "bar": bar,
    };
}
