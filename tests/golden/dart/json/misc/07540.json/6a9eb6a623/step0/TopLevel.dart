// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Cookies cookies;

    TopLevel({
        required this.cookies,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        cookies: Cookies.fromJson(json["cookies"]),
    );

    Map<String, dynamic> toJson() => {
        "cookies": cookies.toJson(),
    };
}

class Cookies {
    Cookies();

    factory Cookies.fromJson(Map<String, dynamic> json) => Cookies(
    );

    Map<String, dynamic> toJson() => {
    };
}
