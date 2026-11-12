// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());


///Postman collection
class TopLevel {
    final List<TopLevel>? item;
    final String? name;
    final List<Response>? response;

    TopLevel({
        this.item,
        this.name,
        this.response,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        item: json["item"] == null ? null : List<TopLevel>.from(json["item"]!.map((x) => TopLevel.fromJson(x))),
        name: json["name"],
        response: json["response"] == null ? null : List<Response>.from(json["response"]!.map((x) => Response.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "item": item == null ? null : List<dynamic>.from(item!.map((x) => x.toJson())),
        "name": name,
        "response": response == null ? null : List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class Response {
    final String? body;

    Response({
        this.body,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "body": body,
    };
}
