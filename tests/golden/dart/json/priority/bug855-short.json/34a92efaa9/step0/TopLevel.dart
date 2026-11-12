// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

Map<String, TopLevel> topLevelFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, TopLevel>(k, TopLevel.fromJson(v)));

String topLevelToJson(Map<String, TopLevel> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class TopLevel {
    final String channelId;
    final String channelName;
    final String code;
    final int emoticonSet;
    final int id;

    TopLevel({
        required this.channelId,
        required this.channelName,
        required this.code,
        required this.emoticonSet,
        required this.id,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        channelId: json["channel_id"],
        channelName: json["channel_name"],
        code: json["code"],
        emoticonSet: json["emoticon_set"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "channel_id": channelId,
        "channel_name": channelName,
        "code": code,
        "emoticon_set": emoticonSet,
        "id": id,
    };
}
