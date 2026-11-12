// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic foo;

    TopLevel({
        required this.foo,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        foo: json["foo"],
    );

    Map<String, dynamic> toJson() => {
        "foo": foo,
    };
}

enum FooEnum {
    A,
    B,
    C
}

final fooEnumValues = EnumValues({
    "a": FooEnum.A,
    "b": FooEnum.B,
    "c": FooEnum.C
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
