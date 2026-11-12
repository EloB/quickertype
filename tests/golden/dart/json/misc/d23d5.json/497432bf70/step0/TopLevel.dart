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
    final String? acronym;
    final DateTime createdAt;
    final String id;
    final String name;
    final DateTime updatedAt;
    final String uri;

    Result({
        required this.acronym,
        required this.createdAt,
        required this.id,
        required this.name,
        required this.updatedAt,
        required this.uri,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        acronym: (json.containsKey("acronym") ? json["acronym"] : throw FormatException('Missing required property')),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        name: json["name"],
        updatedAt: DateTime.parse(json["updated_at"]),
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "acronym": acronym,
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "name": name,
        "updated_at": updatedAt.toIso8601String(),
        "uri": uri,
    };
}
