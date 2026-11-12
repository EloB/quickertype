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
    final String id;
    final String personId;
    final String representativeId;
    final Status status;
    final DateTime updatedAt;

    Result({
        required this.createdAt,
        required this.id,
        required this.personId,
        required this.representativeId,
        required this.status,
        required this.updatedAt,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        personId: json["person_id"],
        representativeId: json["representative_id"],
        status: statusValues.map[json["status"]]!,
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "person_id": personId,
        "representative_id": representativeId,
        "status": statusValues.reverse[status],
        "updated_at": updatedAt.toIso8601String(),
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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
