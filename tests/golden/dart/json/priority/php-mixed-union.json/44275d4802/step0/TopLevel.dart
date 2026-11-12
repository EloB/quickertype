// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<dynamic> mixed;

    TopLevel({
        required this.mixed,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        mixed: List<dynamic>.from(json["mixed"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "mixed": List<dynamic>.from(mixed.map((x) => x)),
    };
}

class MixedClass {
    final String nested;

    MixedClass({
        required this.nested,
    });

    factory MixedClass.fromJson(Map<String, dynamic> json) => MixedClass(
        nested: json["nested"],
    );

    Map<String, dynamic> toJson() => {
        "nested": nested,
    };
}
