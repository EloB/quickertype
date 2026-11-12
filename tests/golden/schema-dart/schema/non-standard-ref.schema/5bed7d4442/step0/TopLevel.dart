// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int bar;
    final int foo;
    final bool quux;

    TopLevel({
        required this.bar,
        required this.foo,
        required this.quux,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        bar: json["bar"],
        foo: json["foo"],
        quux: json["quux"],
    );

    Map<String, dynamic> toJson() => {
        "bar": bar,
        "foo": foo,
        "quux": quux,
    };
}
