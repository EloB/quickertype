// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Coordinate>? coordinates;
    final int? count;
    final String? label;
    final List<Coordinate> requiredCoordinates;
    final int requiredCount;
    final String requiredLabel;
    final double? weight;

    TopLevel({
        this.coordinates,
        this.count,
        this.label,
        required this.requiredCoordinates,
        required this.requiredCount,
        required this.requiredLabel,
        this.weight,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        coordinates: json["coordinates"] == null ? null : List<Coordinate>.from(json["coordinates"]!.map((x) => Coordinate.fromJson(x))),
        count: json["count"] == null ? null : ((x) => x >= 1 && x <= 100 ? x : throw FormatException("Expected bounded number"))(json["count"]),
        label: json["label"] == null ? null : ((x) => x.runes.length >= 2 && x.runes.length <= 16 ? x : throw FormatException("Expected bounded string"))(json["label"]),
        requiredCoordinates: List<Coordinate>.from(json["requiredCoordinates"].map((x) => Coordinate.fromJson(x))),
        requiredCount: ((x) => x >= 1 && x <= 100 ? x : throw FormatException("Expected bounded number"))(json["requiredCount"]),
        requiredLabel: ((x) => x.runes.length >= 2 && x.runes.length <= 16 ? x : throw FormatException("Expected bounded string"))(json["requiredLabel"]),
        weight: json["weight"]?.toDouble() == null ? null : ((x) => x >= 0.5 && x <= 99.5 ? x : throw FormatException("Expected bounded number"))(json["weight"]?.toDouble()),
    );

    Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates!.map((x) => x.toJson())),
        "count": count,
        "label": label,
        "requiredCoordinates": List<dynamic>.from(requiredCoordinates.map((x) => x.toJson())),
        "requiredCount": requiredCount,
        "requiredLabel": requiredLabel,
        "weight": weight,
    };
}

class Coordinate {
    final double latitude;
    final double longitude;

    Coordinate({
        required this.latitude,
        required this.longitude,
    });

    factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
