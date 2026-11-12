// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Enum? topLevelEnum;

    TopLevel({
        required this.topLevelEnum,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        topLevelEnum: (json.containsKey("enum") ? json["enum"] : throw FormatException('Missing required property')) == null ? null : enumValues.map[(json.containsKey("enum") ? json["enum"] : throw FormatException('Missing required property'))]!,
    );

    Map<String, dynamic> toJson() => {
        "enum": enumValues.reverse[topLevelEnum],
    };
}

enum Enum {
    FOO,
    BAR
}

final enumValues = EnumValues({
    "foo": Enum.FOO,
    "bar": Enum.BAR
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
