// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final dynamic list;

    TopLevel({
        required this.list,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        list: json["list"],
    );

    Map<String, dynamic> toJson() => {
        "list": list,
    };
}

class UnionListClass {
    final dynamic next;

    UnionListClass({
        required this.next,
    });

    factory UnionListClass.fromJson(Map<String, dynamic> json) => UnionListClass(
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "next": next,
    };
}
