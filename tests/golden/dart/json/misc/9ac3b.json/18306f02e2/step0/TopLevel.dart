// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int count;
    final Facets facets;
    final int limit;
    final String next;
    final int offset;
    final bool previous;
    final List<Result> results;

    TopLevel({
        required this.count,
        required this.facets,
        required this.limit,
        required this.next,
        required this.offset,
        required this.previous,
        required this.results,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        count: json["count"],
        facets: Facets.fromJson(json["facets"]),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "facets": facets.toJson(),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Facets {
    Facets();

    factory Facets.fromJson(Map<String, dynamic> json) => Facets(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Result {
    final DateTime createdAt;
    final String entity;
    final String firstName;
    final String id;
    final String lastName;
    final String name;
    final String? position;
    final Status status;
    final Title? title;
    final DateTime updatedAt;
    final String uri;

    Result({
        required this.createdAt,
        required this.entity,
        required this.firstName,
        required this.id,
        required this.lastName,
        required this.name,
        required this.position,
        required this.status,
        required this.title,
        required this.updatedAt,
        required this.uri,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        createdAt: DateTime.parse(json["created_at"]),
        entity: json["entity"],
        firstName: json["first_name"],
        id: json["id"],
        lastName: json["last_name"],
        name: json["name"],
        position: (json.containsKey("position") ? json["position"] : throw FormatException('Missing required property')),
        status: statusValues.map[json["status"]]!,
        title: (json.containsKey("title") ? json["title"] : throw FormatException('Missing required property')) == null ? null : titleValues.map[(json.containsKey("title") ? json["title"] : throw FormatException('Missing required property'))]!,
        updatedAt: DateTime.parse(json["updated_at"]),
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "entity": entity,
        "first_name": firstName,
        "id": id,
        "last_name": lastName,
        "name": name,
        "position": position,
        "status": statusValues.reverse[status],
        "title": titleValues.reverse[title],
        "updated_at": updatedAt.toIso8601String(),
        "uri": uri,
    };
}

enum Status {
    INACTIVE,
    ACTIVE
}

final statusValues = EnumValues({
    "inactive": Status.INACTIVE,
    "active": Status.ACTIVE
});

enum Title {
    MR,
    MS
}

final titleValues = EnumValues({
    "Mr": Title.MR,
    "Ms": Title.MS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
