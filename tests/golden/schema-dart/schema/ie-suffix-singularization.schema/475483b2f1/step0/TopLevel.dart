// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Cookie> cookies;

    TopLevel({
        required this.cookies,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        cookies: List<Cookie>.from(json["cookies"].map((x) => Cookie.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cookies": List<dynamic>.from(cookies.map((x) => x.toJson())),
    };
}

class Cookie {
    final String name;
    final String value;

    Cookie({
        required this.name,
        required this.value,
    });

    factory Cookie.fromJson(Map<String, dynamic> json) => Cookie(
        name: json["name"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
    };
}
