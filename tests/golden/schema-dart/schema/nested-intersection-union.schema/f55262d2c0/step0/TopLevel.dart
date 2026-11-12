// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Item> input;

    TopLevel({
        required this.input,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        input: List<Item>.from(json["input"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "input": List<dynamic>.from(input.map((x) => x.toJson())),
    };
}

class Item {
    final String? content;
    final String? id;
    final String? output;
    final String? summary;

    Item({
        this.content,
        this.id,
        this.output,
        this.summary,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        content: json["content"],
        id: json["id"],
        output: json["output"],
        summary: json["summary"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "id": id,
        "output": output,
        "summary": summary,
    };
}
