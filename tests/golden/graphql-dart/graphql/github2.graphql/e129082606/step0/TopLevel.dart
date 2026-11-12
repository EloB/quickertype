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
    final RepositoryConnection repositories;

    User({
        required this.login,
        required this.repositories,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
        repositories: RepositoryConnection.fromJson(json["repositories"]),
    );

    Map<String, dynamic> toJson() => {
        "login": login,
        "repositories": repositories.toJson(),
    };
}

class RepositoryConnection {
    final int totalCount;
    final List<Repository?>? nodes;

    RepositoryConnection({
        required this.totalCount,
        required this.nodes,
    });

    factory RepositoryConnection.fromJson(Map<String, dynamic> json) => RepositoryConnection(
        totalCount: json["totalCount"],
        nodes: (json.containsKey("nodes") ? json["nodes"] : throw FormatException('Missing required property')) == null ? null : List<Repository?>.from((json.containsKey("nodes") ? json["nodes"] : throw FormatException('Missing required property'))!.map((x) => x == null ? null : Repository.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "nodes": nodes == null ? null : List<dynamic>.from(nodes!.map((x) => x?.toJson())),
    };
}

class Repository {
    final String name;

    Repository({
        required this.name,
    });

    factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
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
