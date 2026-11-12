// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic disallowed;
    final List<dynamic> empty;
    final String foo;
    final dynamic impossible;

    TopLevel({
        this.disallowed,
        required this.empty,
        required this.foo,
        this.impossible,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        disallowed: json["disallowed"],
        empty: List<dynamic>.from(json["empty"].map((x) => x)),
        foo: json["foo"],
        impossible: json["impossible"],
    );

    Map<String, dynamic> toJson() => {
        "disallowed": disallowed,
        "empty": List<dynamic>.from(empty.map((x) => x)),
        "foo": foo,
        "impossible": impossible,
    };
}
