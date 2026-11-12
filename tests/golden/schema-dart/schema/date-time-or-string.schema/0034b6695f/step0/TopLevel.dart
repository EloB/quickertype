// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic bar;
    final String foo;

    TopLevel({
        required this.bar,
        required this.foo,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        bar: json["bar"],
        foo: json["foo"],
    );

    Map<String, dynamic> toJson() => {
        "bar": bar,
        "foo": foo,
    };
}

enum BarEnum {
    QUUX
}

final barEnumValues = EnumValues({
    "quux": BarEnum.QUUX
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
