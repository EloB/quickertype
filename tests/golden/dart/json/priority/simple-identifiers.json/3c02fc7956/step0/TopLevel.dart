// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String empty;
    final String purpleX;
    final String topLevel;
    final String topLevelContinue;
    final String topLevelNull;
    final String topLevelX;
    final String undefined;
    final String x;
    final String xY;

    TopLevel({
        required this.empty,
        required this.purpleX,
        required this.topLevel,
        required this.topLevelContinue,
        required this.topLevelNull,
        required this.topLevelX,
        required this.undefined,
        required this.x,
        required this.xY,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        empty: json[""],
        purpleX: json["x'"],
        topLevel: json["{}"],
        topLevelContinue: json["continue"],
        topLevelNull: json["null"],
        topLevelX: json["x\""],
        undefined: json["undefined"],
        x: json["x"],
        xY: json["x y"],
    );

    Map<String, dynamic> toJson() => {
        "": empty,
        "x'": purpleX,
        "{}": topLevel,
        "continue": topLevelContinue,
        "null": topLevelNull,
        "x\"": topLevelX,
        "undefined": undefined,
        "x": x,
        "x y": xY,
    };
}
