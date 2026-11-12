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
    final bool next;
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
    final int id;
    final int items;
    final String name;
    final int? parent;
    final DateTime updatedAt;
    final String uri;

    Result({
        required this.createdAt,
        required this.id,
        required this.items,
        required this.name,
        required this.parent,
        required this.updatedAt,
        required this.uri,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        items: json["items"],
        name: json["name"],
        parent: (json.containsKey("parent") ? json["parent"] : throw FormatException('Missing required property')),
        updatedAt: DateTime.parse(json["updated_at"]),
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "items": items,
        "name": name,
        "parent": parent,
        "updated_at": updatedAt.toIso8601String(),
        "uri": uri,
    };
}
