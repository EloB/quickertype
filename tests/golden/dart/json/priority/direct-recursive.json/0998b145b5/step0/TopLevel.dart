// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final TopLevel? also;
    final bool bar;
    final int foo;
    final double moo;
    final String quux;

    TopLevel({
        this.also,
        required this.bar,
        required this.foo,
        required this.moo,
        required this.quux,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        also: json["also"] == null ? null : TopLevel.fromJson(json["also"]),
        bar: json["bar"],
        foo: json["foo"],
        moo: json["moo"]?.toDouble(),
        quux: json["quux"],
    );

    Map<String, dynamic> toJson() => {
        "also": also?.toJson(),
        "bar": bar,
        "foo": foo,
        "moo": moo,
        "quux": quux,
    };
}
