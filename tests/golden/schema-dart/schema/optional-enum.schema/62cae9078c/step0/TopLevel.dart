// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String name;
    final Shortcut? shortcut;

    TopLevel({
        required this.name,
        this.shortcut,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        name: json["name"],
        shortcut: json["shortcut"] == null ? null : shortcutValues.map[json["shortcut"]]!,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "shortcut": shortcutValues.reverse[shortcut],
    };
}

enum Shortcut {
    HIDDEN,
    VISIBLE
}

final shortcutValues = EnumValues({
    "hidden": Shortcut.HIDDEN,
    "visible": Shortcut.VISIBLE
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
