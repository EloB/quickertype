// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic foo;
    final Map<String, dynamic> values;

    TopLevel({
        required this.foo,
        required this.values,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        foo: (json.containsKey("foo") ? json["foo"] : throw FormatException('Missing required property')),
        values: Map.from(json["values"]).map((k, v) => MapEntry<String, dynamic>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "foo": foo,
        "values": Map.from(values).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
