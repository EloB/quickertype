// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final IssPosition issPosition;
    final String message;
    final int timestamp;

    TopLevel({
        required this.issPosition,
        required this.message,
        required this.timestamp,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        issPosition: IssPosition.fromJson(json["iss_position"]),
        message: json["message"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "iss_position": issPosition.toJson(),
        "message": message,
        "timestamp": timestamp,
    };
}

class IssPosition {
    final String latitude;
    final String longitude;

    IssPosition({
        required this.latitude,
        required this.longitude,
    });

    factory IssPosition.fromJson(Map<String, dynamic> json) => IssPosition(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
