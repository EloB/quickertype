// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Health health;

    TopLevel({
        required this.health,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        health: healthValues.map[json["health"]]!,
    );

    Map<String, dynamic> toJson() => {
        "health": healthValues.reverse[health],
    };
}

enum Health {
    OK,
    ERROR
}

final healthValues = EnumValues({
    "ok": Health.OK,
    "error": Health.ERROR
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
