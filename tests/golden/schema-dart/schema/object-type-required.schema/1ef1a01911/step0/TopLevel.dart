// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Empty empty;
    final String foo;
    final String? bar;

    TopLevel({
        required this.empty,
        required this.foo,
        this.bar,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        empty: Empty.fromJson(json["empty"]),
        foo: json["foo"],
        bar: json["bar"],
    );

    Map<String, dynamic> toJson() => {
        "empty": empty.toJson(),
        "foo": foo,
        "bar": bar,
    };
}

class Empty {
    Empty();

    factory Empty.fromJson(Map<String, dynamic> json) => Empty(
    );

    Map<String, dynamic> toJson() => {
    };
}
