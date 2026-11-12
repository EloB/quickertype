// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Result> results;

    TopLevel({
        required this.results,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    final int age;
    final dynamic name;

    Result({
        required this.age,
        this.name,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        age: json["age"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "age": age,
        "name": name,
    };
}
