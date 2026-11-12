// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Intersection? intersection;

    TopLevel({
        this.intersection,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        intersection: json["intersection"] == null ? null : Intersection.fromJson(json["intersection"]),
    );

    Map<String, dynamic> toJson() => {
        "intersection": intersection?.toJson(),
    };
}

class Intersection {
    final double foo;
    final String? bar;

    Intersection({
        required this.foo,
        this.bar,
    });

    factory Intersection.fromJson(Map<String, dynamic> json) => Intersection(
        foo: json["foo"]?.toDouble(),
        bar: json["bar"],
    );

    Map<String, dynamic> toJson() => {
        "foo": foo,
        "bar": bar,
    };
}
