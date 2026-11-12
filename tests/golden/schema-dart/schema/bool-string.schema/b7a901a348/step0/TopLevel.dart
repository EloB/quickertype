// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<String?>? arrNullable;
    final List<String>? arrOne;
    final String? nullable;
    final String one;
    final String? optional;
    final dynamic unionWithBool;
    final dynamic unionWithBoolAndEnum;

    TopLevel({
        this.arrNullable,
        this.arrOne,
        required this.nullable,
        required this.one,
        this.optional,
        required this.unionWithBool,
        required this.unionWithBoolAndEnum,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        arrNullable: json["arrNullable"] == null ? null : List<String?>.from(json["arrNullable"]!.map((x) => x)),
        arrOne: json["arrOne"] == null ? null : List<String>.from(json["arrOne"]!.map((x) => x)),
        nullable: (json.containsKey("nullable") ? json["nullable"] : throw FormatException('Missing required property')),
        one: json["one"],
        optional: json["optional"],
        unionWithBool: json["unionWithBool"],
        unionWithBoolAndEnum: json["unionWithBoolAndEnum"],
    );

    Map<String, dynamic> toJson() => {
        "arrNullable": arrNullable == null ? null : List<dynamic>.from(arrNullable!.map((x) => x)),
        "arrOne": arrOne == null ? null : List<dynamic>.from(arrOne!.map((x) => x)),
        "nullable": nullable,
        "one": one,
        "optional": optional,
        "unionWithBool": unionWithBool,
        "unionWithBoolAndEnum": unionWithBoolAndEnum,
    };
}
