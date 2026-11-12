// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic constructor;

    TopLevel({
        this.constructor,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        constructor: json["constructor"],
    );

    Map<String, dynamic> toJson() => {
        "constructor": constructor,
    };
}

class Constructor {
    Constructor();

    factory Constructor.fromJson(Map<String, dynamic> json) => Constructor(
    );

    Map<String, dynamic> toJson() => {
    };
}
