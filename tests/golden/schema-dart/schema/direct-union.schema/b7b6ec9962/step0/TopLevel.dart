// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final ArrayNode? arrayNode;
    final BooleanNode? booleanNode;
    final DoubleNode? doubleNode;
    final IntNode? intNode;
    final LongNode? longNode;
    final NullNode? nullNode;
    final ObjectNode? objectNode;
    final Map<String, Thing> stuff;
    final TextNode? textNode;

    TopLevel({
        this.arrayNode,
        this.booleanNode,
        this.doubleNode,
        this.intNode,
        this.longNode,
        this.nullNode,
        this.objectNode,
        required this.stuff,
        this.textNode,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        arrayNode: json["arrayNode"] == null ? null : ArrayNode.fromJson(json["arrayNode"]),
        booleanNode: json["booleanNode"] == null ? null : BooleanNode.fromJson(json["booleanNode"]),
        doubleNode: json["doubleNode"] == null ? null : DoubleNode.fromJson(json["doubleNode"]),
        intNode: json["intNode"] == null ? null : IntNode.fromJson(json["intNode"]),
        longNode: json["longNode"] == null ? null : LongNode.fromJson(json["longNode"]),
        nullNode: json["nullNode"] == null ? null : NullNode.fromJson(json["nullNode"]),
        objectNode: json["objectNode"] == null ? null : ObjectNode.fromJson(json["objectNode"]),
        stuff: Map.from(json["stuff"]).map((k, v) => MapEntry<String, Thing>(k, Thing.fromJson(v))),
        textNode: json["textNode"] == null ? null : TextNode.fromJson(json["textNode"]),
    );

    Map<String, dynamic> toJson() => {
        "arrayNode": arrayNode?.toJson(),
        "booleanNode": booleanNode?.toJson(),
        "doubleNode": doubleNode?.toJson(),
        "intNode": intNode?.toJson(),
        "longNode": longNode?.toJson(),
        "nullNode": nullNode?.toJson(),
        "objectNode": objectNode?.toJson(),
        "stuff": Map.from(stuff).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "textNode": textNode?.toJson(),
    };
}

class ArrayNode {
    ArrayNode();

    factory ArrayNode.fromJson(Map<String, dynamic> json) => ArrayNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class BooleanNode {
    BooleanNode();

    factory BooleanNode.fromJson(Map<String, dynamic> json) => BooleanNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class DoubleNode {
    DoubleNode();

    factory DoubleNode.fromJson(Map<String, dynamic> json) => DoubleNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class IntNode {
    IntNode();

    factory IntNode.fromJson(Map<String, dynamic> json) => IntNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class LongNode {
    LongNode();

    factory LongNode.fromJson(Map<String, dynamic> json) => LongNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class NullNode {
    NullNode();

    factory NullNode.fromJson(Map<String, dynamic> json) => NullNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ObjectNode {
    ObjectNode();

    factory ObjectNode.fromJson(Map<String, dynamic> json) => ObjectNode(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Thing {
    final dynamic optional;
    final dynamic required;

    Thing({
        this.optional,
        required this.required,
    });

    factory Thing.fromJson(Map<String, dynamic> json) => Thing(
        optional: json["optional"],
        required: (json.containsKey("required") ? json["required"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "optional": optional,
        "required": required,
    };
}

class TextNode {
    TextNode();

    factory TextNode.fromJson(Map<String, dynamic> json) => TextNode(
    );

    Map<String, dynamic> toJson() => {
    };
}
