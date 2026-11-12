// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String fromUrl;
    final String url;

    TopLevel({
        required this.fromUrl,
        required this.url,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        fromUrl: json["fromURL"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "fromURL": fromUrl,
        "url": url,
    };
}
