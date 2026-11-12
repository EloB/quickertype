// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final double? foo;

    TopLevel({
        required this.foo,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        foo: (json.containsKey("foo") ? json["foo"] : throw FormatException('Missing required property'))?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "foo": foo,
    };
}
