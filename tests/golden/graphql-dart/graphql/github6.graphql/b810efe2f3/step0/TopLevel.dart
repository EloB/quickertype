// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Data? data;
    final List<Error>? errors;

    TopLevel({
        required this.data,
        this.errors,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        data: (json.containsKey("data") ? json["data"] : throw FormatException('Missing required property')) == null ? null : Data.fromJson((json.containsKey("data") ? json["data"] : throw FormatException('Missing required property'))),
        errors: json["errors"] == null ? null : List<Error>.from(json["errors"]!.map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "errors": errors == null ? null : List<dynamic>.from(errors!.map((x) => x.toJson())),
    };
}

class Data {
    final UniformResourceLocatable? resource;

    Data({
        required this.resource,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        resource: (json.containsKey("resource") ? json["resource"] : throw FormatException('Missing required property')) == null ? null : UniformResourceLocatable.fromJson((json.containsKey("resource") ? json["resource"] : throw FormatException('Missing required property'))),
    );

    Map<String, dynamic> toJson() => {
        "resource": resource?.toJson(),
    };
}

class UniformResourceLocatable {
    final String url;
    final String? login;

    UniformResourceLocatable({
        required this.url,
        this.login,
    });

    factory UniformResourceLocatable.fromJson(Map<String, dynamic> json) => UniformResourceLocatable(
        url: json["url"],
        login: json["login"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "login": login,
    };
}

class Error {
    final String message;

    Error({
        required this.message,
    });

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
