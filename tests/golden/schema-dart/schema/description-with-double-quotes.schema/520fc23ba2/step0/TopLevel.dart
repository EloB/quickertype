// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());


///Cool "stuff"
class TopLevel {
    final bool? foo;

    TopLevel({
        this.foo,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        foo: json["foo"],
    );

    Map<String, dynamic> toJson() => {
        "foo": foo,
    };
}
