// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());


///Nested block comment openers:
///{-
////*
///This text must remain inside the generated documentation comment.
class TopLevel {
    
    ///Nested property block comment openers:
    ///{-
    ////*
    ///This text must remain inside the generated property documentation comment.
    final String value;

    TopLevel({
        required this.value,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
    };
}
