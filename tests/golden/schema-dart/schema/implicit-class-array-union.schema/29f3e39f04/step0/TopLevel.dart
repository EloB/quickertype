// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic foo;

    TopLevel({
        required this.foo,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        foo: (json.containsKey("foo") ? json["foo"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "foo": foo,
    };
}

class FooClass {
    final int bar;

    FooClass({
        required this.bar,
    });

    factory FooClass.fromJson(Map<String, dynamic> json) => FooClass(
        bar: json["bar"],
    );

    Map<String, dynamic> toJson() => {
        "bar": bar,
    };
}
