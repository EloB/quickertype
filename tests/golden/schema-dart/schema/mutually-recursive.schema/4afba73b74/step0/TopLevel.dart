// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class Bar {
    final dynamic foo;

    Bar({
        required this.foo,
    });

    factory Bar.fromJson(Map<String, dynamic> json) => Bar(
        foo: json["foo"],
    );

    Map<String, dynamic> toJson() => {
        "foo": foo,
    };
}

class TopLevel {
    final Bar? bar;

    TopLevel({
        this.bar,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        bar: json["bar"] == null ? null : Bar.fromJson(json["bar"]),
    );

    Map<String, dynamic> toJson() => {
        "bar": bar?.toJson(),
    };
}
