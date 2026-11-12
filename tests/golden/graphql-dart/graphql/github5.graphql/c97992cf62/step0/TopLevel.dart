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
    final User viewer;

    Data({
        required this.viewer,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        viewer: User.fromJson(json["viewer"]),
    );

    Map<String, dynamic> toJson() => {
        "viewer": viewer.toJson(),
    };
}

class User {
    final String login;
    final String? name;

    User({
        required this.login,
        this.name,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "login": login,
        "name": name,
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
