// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String literal;
    final int the11;
    final List<Value> values;

    TopLevel({
        required this.literal,
        required this.the11,
        required this.values,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        literal: json["literal"],
        the11: json["#{1+1}"],
        values: List<Value>.from(json["values"].map((x) => valueValues.map[x]!)),
    );

    Map<String, dynamic> toJson() => {
        "literal": literal,
        "#{1+1}": the11,
        "values": List<dynamic>.from(values.map((x) => valueValues.reverse[x])),
    };
}

enum Value {
    C0,
    C1
}

final valueValues = EnumValues({
    "c0\u0001\u001b\u001f": Value.C0,
    "c1\u007f\u0080\u0085\u009f": Value.C1
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
