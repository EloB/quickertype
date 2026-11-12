// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String? myProperty;
    final String? secondProperty;

    TopLevel({
        this.myProperty,
        this.secondProperty,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        myProperty: json["myProperty"],
        secondProperty: json["secondProperty"],
    );

    Map<String, dynamic> toJson() => {
        "myProperty": myProperty,
        "secondProperty": secondProperty,
    };
}
