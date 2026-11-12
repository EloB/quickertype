// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Map<String, String> data;
    final Description description;

    TopLevel({
        required this.data,
        required this.description,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        data: Map.from(json["data"]).map((k, v) => MapEntry<String, String>(k, v)),
        description: Description.fromJson(json["description"]),
    );

    Map<String, dynamic> toJson() => {
        "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "description": description.toJson(),
    };
}

class Description {
    final String basePeriod;
    final String missing;
    final String title;
    final String units;

    Description({
        required this.basePeriod,
        required this.missing,
        required this.title,
        required this.units,
    });

    factory Description.fromJson(Map<String, dynamic> json) => Description(
        basePeriod: json["base_period"],
        missing: json["missing"],
        title: json["title"],
        units: json["units"],
    );

    Map<String, dynamic> toJson() => {
        "base_period": basePeriod,
        "missing": missing,
        "title": title,
        "units": units,
    };
}
