// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int foo;
    final bool bar;
    final String quux;

    TopLevel({
        required this.foo,
        required this.bar,
        required this.quux,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        foo: json["foo"],
        bar: json["bar"],
        quux: json["quux"],
    );

    Map<String, dynamic> toJson() => {
        "foo": foo,
        "bar": bar,
        "quux": quux,
    };
}
