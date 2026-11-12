// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String message;
    final int number;
    final List<Person> people;

    TopLevel({
        required this.message,
        required this.number,
        required this.people,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        message: json["message"],
        number: json["number"],
        people: List<Person>.from(json["people"].map((x) => Person.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "number": number,
        "people": List<dynamic>.from(people.map((x) => x.toJson())),
    };
}

class Person {
    final String craft;
    final String name;

    Person({
        required this.craft,
        required this.name,
    });

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        craft: json["craft"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "craft": craft,
        "name": name,
    };
}
