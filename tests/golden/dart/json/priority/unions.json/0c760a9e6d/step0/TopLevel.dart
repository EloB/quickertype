// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<dynamic> x;
    final List<int?> y;
    final List<dynamic> z;

    TopLevel({
        required this.x,
        required this.y,
        required this.z,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        x: List<dynamic>.from(json["x"].map((x) => x)),
        y: List<int?>.from(json["y"].map((x) => x)),
        z: List<dynamic>.from(json["z"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "x": List<dynamic>.from(x.map((x) => x)),
        "y": List<dynamic>.from(y.map((x) => x)),
        "z": List<dynamic>.from(z.map((x) => x)),
    };
}

class ZClass {
    final bool a;

    ZClass({
        required this.a,
    });

    factory ZClass.fromJson(Map<String, dynamic> json) => ZClass(
        a: json["a"],
    );

    Map<String, dynamic> toJson() => {
        "a": a,
    };
}
