// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => topLevelValues.map[json.decode(str)]!;

String topLevelToJson(TopLevel data) => json.encode(topLevelValues.reverse[data]);

enum TopLevel {
    ONE,
    THREE,
    TWO
}

final topLevelValues = EnumValues({
    "one": TopLevel.ONE,
    "three": TopLevel.THREE,
    "two": TopLevel.TWO
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
