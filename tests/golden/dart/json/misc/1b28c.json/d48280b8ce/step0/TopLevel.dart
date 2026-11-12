// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<TotalPopulation> totalPopulation;

    TopLevel({
        required this.totalPopulation,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        totalPopulation: List<TotalPopulation>.from(json["total_population"].map((x) => TotalPopulation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_population": List<dynamic>.from(totalPopulation.map((x) => x.toJson())),
    };
}

class TotalPopulation {
    final DateTime date;
    final int population;

    TotalPopulation({
        required this.date,
        required this.population,
    });

    factory TotalPopulation.fromJson(Map<String, dynamic> json) => TotalPopulation(
        date: DateTime.parse(json["date"]),
        population: json["population"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "population": population,
    };
}
