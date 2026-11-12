// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final bool bar;
    final dynamic foo;

    TopLevel({
        required this.bar,
        this.foo,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        bar: json["bar"],
        foo: json["foo"],
    );

    Map<String, dynamic> toJson() => {
        "bar": bar,
        "foo": foo,
    };
}
