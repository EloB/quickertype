// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final bool booleanValue;
    final String dateValue;
    final List<dynamic> differentThings;
    final double doubleValue;
    final int intValue;
    final Map<String, int?> mapValue;
    final dynamic nameWithSpaces;
    final dynamic nullValue;
    final Map<String, int?> nullableMapValue;
    final List<PersonElement> people;
    final PurplePerson person;
    final String stringValue;
    final List<List<dynamic>> tuples;
    final String uuidValue;

    TopLevel({
        required this.booleanValue,
        required this.dateValue,
        required this.differentThings,
        required this.doubleValue,
        required this.intValue,
        required this.mapValue,
        required this.nameWithSpaces,
        required this.nullValue,
        required this.nullableMapValue,
        required this.people,
        required this.person,
        required this.stringValue,
        required this.tuples,
        required this.uuidValue,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        booleanValue: json["booleanValue"],
        dateValue: json["dateValue"],
        differentThings: List<dynamic>.from(json["differentThings"].map((x) => x)),
        doubleValue: json["doubleValue"]?.toDouble(),
        intValue: json["intValue"],
        mapValue: Map.from(json["mapValue"]).map((k, v) => MapEntry<String, int?>(k, v)),
        nameWithSpaces: (json.containsKey("name with spaces") ? json["name with spaces"] : throw FormatException('Missing required property')),
        nullValue: (json.containsKey("nullValue") ? json["nullValue"] : throw FormatException('Missing required property')),
        nullableMapValue: Map.from(json["nullableMapValue"]).map((k, v) => MapEntry<String, int?>(k, v)),
        people: List<PersonElement>.from(json["people"].map((x) => PersonElement.fromJson(x))),
        person: PurplePerson.fromJson(json["person"]),
        stringValue: json["stringValue"],
        tuples: List<List<dynamic>>.from(json["tuples"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        uuidValue: json["uuidValue"],
    );

    Map<String, dynamic> toJson() => {
        "booleanValue": booleanValue,
        "dateValue": dateValue,
        "differentThings": List<dynamic>.from(differentThings.map((x) => x)),
        "doubleValue": doubleValue,
        "intValue": intValue,
        "mapValue": Map.from(mapValue).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "name with spaces": nameWithSpaces,
        "nullValue": nullValue,
        "nullableMapValue": Map.from(nullableMapValue).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "people": List<dynamic>.from(people.map((x) => x.toJson())),
        "person": person.toJson(),
        "stringValue": stringValue,
        "tuples": List<dynamic>.from(tuples.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "uuidValue": uuidValue,
    };
}

class DifferentThingClass {
    final String name;

    DifferentThingClass({
        required this.name,
    });

    factory DifferentThingClass.fromJson(Map<String, dynamic> json) => DifferentThingClass(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class PersonElement {
    final dynamic intOrString;
    final String name;
    final bool? optionalValue;

    PersonElement({
        required this.intOrString,
        required this.name,
        this.optionalValue,
    });

    factory PersonElement.fromJson(Map<String, dynamic> json) => PersonElement(
        intOrString: json["intOrString"],
        name: json["name"],
        optionalValue: json["optionalValue"],
    );

    Map<String, dynamic> toJson() => {
        "intOrString": intOrString,
        "name": name,
        "optionalValue": optionalValue,
    };
}

class PurplePerson {
    final int intOrString;
    final String name;

    PurplePerson({
        required this.intOrString,
        required this.name,
    });

    factory PurplePerson.fromJson(Map<String, dynamic> json) => PurplePerson(
        intOrString: json["intOrString"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "intOrString": intOrString,
        "name": name,
    };
}
