// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String barre;
    final Enum enumerification;
    final String foo;
    final dynamic unionization;

    TopLevel({
        required this.barre,
        required this.enumerification,
        required this.foo,
        required this.unionization,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        barre: json["bar"],
        enumerification: enumValues.map[json["enum"]]!,
        foo: json["foo"],
        unionization: json["union"],
    );

    Map<String, dynamic> toJson() => {
        "bar": barre,
        "enum": enumValues.reverse[enumerification],
        "foo": foo,
        "union": unionization,
    };
}

enum Enum {
    FIRE,
    GRASS,
    BLUE
}

final enumValues = EnumValues({
    "red": Enum.FIRE,
    "green": Enum.GRASS,
    "blue": Enum.BLUE
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
