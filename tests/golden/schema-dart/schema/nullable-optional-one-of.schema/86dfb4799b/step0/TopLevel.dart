// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String? b;
    final Kind kind;

    TopLevel({
        this.b,
        required this.kind,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        b: json["b"],
        kind: kindValues.map[json["kind"]]!,
    );

    Map<String, dynamic> toJson() => {
        "b": b,
        "kind": kindValues.reverse[kind],
    };
}

enum Kind {
    ONE,
    TWO
}

final kindValues = EnumValues({
    "one": Kind.ONE,
    "two": Kind.TWO
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
