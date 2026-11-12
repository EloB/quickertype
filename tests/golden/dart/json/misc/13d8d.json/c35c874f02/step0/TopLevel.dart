// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final String category;
    final String context;
    final int id;
    final Location location;
    final String locationSubtype;
    final String locationType;
    final String month;
    final OutcomeStatus outcomeStatus;
    final String persistentId;

    TopLevel({
        required this.category,
        required this.context,
        required this.id,
        required this.location,
        required this.locationSubtype,
        required this.locationType,
        required this.month,
        required this.outcomeStatus,
        required this.persistentId,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        category: json["category"],
        context: json["context"],
        id: json["id"],
        location: Location.fromJson(json["location"]),
        locationSubtype: json["location_subtype"],
        locationType: json["location_type"],
        month: json["month"],
        outcomeStatus: OutcomeStatus.fromJson(json["outcome_status"]),
        persistentId: json["persistent_id"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "context": context,
        "id": id,
        "location": location.toJson(),
        "location_subtype": locationSubtype,
        "location_type": locationType,
        "month": month,
        "outcome_status": outcomeStatus.toJson(),
        "persistent_id": persistentId,
    };
}

class Location {
    final String latitude;
    final String longitude;
    final Street street;

    Location({
        required this.latitude,
        required this.longitude,
        required this.street,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
        street: Street.fromJson(json["street"]),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "street": street.toJson(),
    };
}

class Street {
    final int id;
    final String name;

    Street({
        required this.id,
        required this.name,
    });

    factory Street.fromJson(Map<String, dynamic> json) => Street(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class OutcomeStatus {
    final String category;
    final String date;

    OutcomeStatus({
        required this.category,
        required this.date,
    });

    factory OutcomeStatus.fromJson(Map<String, dynamic> json) => OutcomeStatus(
        category: json["category"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "date": date,
    };
}
