// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Option> options;

    TopLevel({
        required this.options,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
    };
}

class Option {
    final String? foo;
    final String name;

    Option({
        this.foo,
        required this.name,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        foo: json["foo"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "foo": foo,
        "name": name,
    };
}
