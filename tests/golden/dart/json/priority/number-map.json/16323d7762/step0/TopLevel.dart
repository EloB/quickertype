// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Map<String, double> foo;

    TopLevel({
        required this.foo,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        foo: Map.from(json["foo"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "foo": Map.from(foo).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
