// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int amount;
    final bool enabled;
    final Kind kind;
    final double ratio;
    final double version;

    TopLevel({
        required this.amount,
        required this.enabled,
        required this.kind,
        required this.ratio,
        required this.version,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        amount: json["amount"],
        enabled: json["enabled"],
        kind: kindValues.map[json["kind"]]!,
        ratio: json["ratio"]?.toDouble(),
        version: json["version"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "enabled": enabled,
        "kind": kindValues.reverse[kind],
        "ratio": ratio,
        "version": version,
    };
}

enum Kind {
    WIDGET
}

final kindValues = EnumValues({
    "widget": Kind.WIDGET
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
