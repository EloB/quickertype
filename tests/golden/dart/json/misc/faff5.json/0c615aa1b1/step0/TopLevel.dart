// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Response response;

    TopLevel({
        required this.response,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "response": response.toJson(),
    };
}

class Response {
    final int playerCount;
    final int result;

    Response({
        required this.playerCount,
        required this.result,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        playerCount: json["player_count"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "player_count": playerCount,
        "result": result,
    };
}
