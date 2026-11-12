// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Foo> foo;

    TopLevel({
        required this.foo,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        foo: List<Foo>.from(json["foo"].map((x) => Foo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foo": List<dynamic>.from(foo.map((x) => x.toJson())),
    };
}

class Foo {
    final String? bar;

    Foo({
        this.bar,
    });

    factory Foo.fromJson(Map<String, dynamic> json) => Foo(
        bar: json["bar"],
    );

    Map<String, dynamic> toJson() => {
        "bar": bar,
    };
}
