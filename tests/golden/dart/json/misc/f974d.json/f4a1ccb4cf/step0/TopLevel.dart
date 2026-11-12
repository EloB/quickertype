// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int blockIndex;
    final String hash;
    final int height;
    final int time;
    final List<int> txIndexes;

    TopLevel({
        required this.blockIndex,
        required this.hash,
        required this.height,
        required this.time,
        required this.txIndexes,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        blockIndex: json["block_index"],
        hash: json["hash"],
        height: json["height"],
        time: json["time"],
        txIndexes: List<int>.from(json["txIndexes"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "block_index": blockIndex,
        "hash": hash,
        "height": height,
        "time": time,
        "txIndexes": List<dynamic>.from(txIndexes.map((x) => x)),
    };
}
