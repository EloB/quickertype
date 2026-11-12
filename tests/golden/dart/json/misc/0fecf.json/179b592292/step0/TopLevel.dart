// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<String> countries;

    TopLevel({
        required this.countries,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        countries: List<String>.from(json["countries"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x)),
    };
}
