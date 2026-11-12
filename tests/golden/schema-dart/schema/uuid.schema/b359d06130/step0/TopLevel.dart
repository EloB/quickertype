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
    final dynamic unionWithEnum;

    TopLevel({
        this.arrNullable,
        this.arrOne,
        required this.nullable,
        required this.one,
        this.optional,
        required this.unionWithEnum,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        arrNullable: json["arrNullable"] == null ? null : List<String?>.from(json["arrNullable"]!.map((x) => x == null ? null : ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(x))),
        arrOne: json["arrOne"] == null ? null : List<String>.from(json["arrOne"]!.map((x) => ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(x))),
        nullable: (json.containsKey("nullable") ? json["nullable"] : throw FormatException('Missing required property')) == null ? null : ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))((json.containsKey("nullable") ? json["nullable"] : throw FormatException('Missing required property'))),
        one: ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(json["one"]),
        optional: json["optional"] == null ? null : ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(json["optional"]),
        unionWithEnum: json["unionWithEnum"],
    );

    Map<String, dynamic> toJson() => {
        "arrNullable": arrNullable == null ? null : List<dynamic>.from(arrNullable!.map((x) => x)),
        "arrOne": arrOne == null ? null : List<dynamic>.from(arrOne!.map((x) => x)),
        "nullable": nullable,
        "one": one,
        "optional": optional,
        "unionWithEnum": unionWithEnum,
    };
}

enum UnionWithEnumEnum {
    FOO
}

final unionWithEnumEnumValues = EnumValues({
    "foo": UnionWithEnumEnum.FOO
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
