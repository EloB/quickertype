// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

dynamic topLevelFromJson(String str) => json.decode(str);

String topLevelToJson(dynamic data) => json.encode(data);

class TopLevelClass {
    final dynamic x;

    TopLevelClass({
        this.x,
    });

    factory TopLevelClass.fromJson(Map<String, dynamic> json) => TopLevelClass(
        x: json["x"],
    );

    Map<String, dynamic> toJson() => {
        "x": x,
    };
}

class XClass {
    final dynamic x;

    XClass({
        this.x,
    });

    factory XClass.fromJson(Map<String, dynamic> json) => XClass(
        x: json["x"],
    );

    Map<String, dynamic> toJson() => {
        "x": x,
    };
}
