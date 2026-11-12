// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Map<String, Datum> data;
    final Description description;

    TopLevel({
        required this.data,
        required this.description,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        data: Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
        description: Description.fromJson(json["description"]),
    );

    Map<String, dynamic> toJson() => {
        "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "description": description.toJson(),
    };
}

class Datum {
    final String anomaly;
    final String value;

    Datum({
        required this.anomaly,
        required this.value,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        anomaly: json["anomaly"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "anomaly": anomaly,
        "value": value,
    };
}

class Description {
    final String basePeriod;
    final int missing;
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
