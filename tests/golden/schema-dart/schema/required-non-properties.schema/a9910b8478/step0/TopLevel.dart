// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int foo;
    final dynamic bar;

    TopLevel({
        required this.foo,
        required this.bar,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        foo: json["foo"],
        bar: (json.containsKey("bar") ? json["bar"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "foo": foo,
        "bar": bar,
    };
}
