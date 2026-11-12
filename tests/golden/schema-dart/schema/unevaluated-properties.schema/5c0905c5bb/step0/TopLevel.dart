// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Config? config;

    TopLevel({
        this.config,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        config: json["config"] == null ? null : Config.fromJson(json["config"]),
    );

    Map<String, dynamic> toJson() => {
        "config": config?.toJson(),
    };
}

class Config {
    final dynamic closed;
    final String? name;
    final Map<String, List<Item>>? settings;

    Config({
        this.closed,
        this.name,
        this.settings,
    });

    factory Config.fromJson(Map<String, dynamic> json) => Config(
        closed: json["closed"],
        name: json["name"],
        settings: json["settings"] == null ? null : Map.from(json["settings"]!).map((k, v) => MapEntry<String, List<Item>>(k, List<Item>.from(v.map((x) => Item.fromJson(x))))),
    );

    Map<String, dynamic> toJson() => {
        "closed": closed,
        "name": name,
        "settings": settings == null ? null : Map.from(settings!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
    };
}

class ClosedClass {
    ClosedClass();

    factory ClosedClass.fromJson(Map<String, dynamic> json) => ClosedClass(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Item {
    final String key;
    final String value;

    Item({
        required this.key,
        required this.value,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
    };
}
