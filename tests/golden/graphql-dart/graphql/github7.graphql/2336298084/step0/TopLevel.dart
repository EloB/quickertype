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
    final Connection starredRepositories;
    final RepositoryConnection repositories;

    User({
        required this.login,
        required this.starredRepositories,
        required this.repositories,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
        starredRepositories: Connection.fromJson(json["starredRepositories"]),
        repositories: RepositoryConnection.fromJson(json["repositories"]),
    );

    Map<String, dynamic> toJson() => {
        "login": login,
        "starredRepositories": starredRepositories.toJson(),
        "repositories": repositories.toJson(),
    };
}

class RepositoryConnection {
    final List<RepositoryEdge?>? edges;

    RepositoryConnection({
        required this.edges,
    });

    factory RepositoryConnection.fromJson(Map<String, dynamic> json) => RepositoryConnection(
        edges: (json.containsKey("edges") ? json["edges"] : throw FormatException('Missing required property')) == null ? null : List<RepositoryEdge?>.from((json.containsKey("edges") ? json["edges"] : throw FormatException('Missing required property'))!.map((x) => x == null ? null : RepositoryEdge.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "edges": edges == null ? null : List<dynamic>.from(edges!.map((x) => x?.toJson())),
    };
}

class RepositoryEdge {
    final Repository? node;

    RepositoryEdge({
        required this.node,
    });

    factory RepositoryEdge.fromJson(Map<String, dynamic> json) => RepositoryEdge(
        node: (json.containsKey("node") ? json["node"] : throw FormatException('Missing required property')) == null ? null : Repository.fromJson((json.containsKey("node") ? json["node"] : throw FormatException('Missing required property'))),
    );

    Map<String, dynamic> toJson() => {
        "node": node?.toJson(),
    };
}

class Repository {
    final String name;
    final Connection stargazers;
    final Connection forks;
    final Connection watchers;
    final Connection issues;

    Repository({
        required this.name,
        required this.stargazers,
        required this.forks,
        required this.watchers,
        required this.issues,
    });

    factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        name: json["name"],
        stargazers: Connection.fromJson(json["stargazers"]),
        forks: Connection.fromJson(json["forks"]),
        watchers: Connection.fromJson(json["watchers"]),
        issues: Connection.fromJson(json["issues"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "stargazers": stargazers.toJson(),
        "forks": forks.toJson(),
        "watchers": watchers.toJson(),
        "issues": issues.toJson(),
    };
}

class Connection {
    final int totalCount;

    Connection({
        required this.totalCount,
    });

    factory Connection.fromJson(Map<String, dynamic> json) => Connection(
        totalCount: json["totalCount"],
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
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
