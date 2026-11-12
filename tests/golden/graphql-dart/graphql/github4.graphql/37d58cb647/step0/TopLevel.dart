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
    final Repository? repository;

    User({
        required this.login,
        required this.name,
        required this.repository,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
        name: (json.containsKey("name") ? json["name"] : throw FormatException('Missing required property')),
        repository: (json.containsKey("repository") ? json["repository"] : throw FormatException('Missing required property')) == null ? null : Repository.fromJson((json.containsKey("repository") ? json["repository"] : throw FormatException('Missing required property'))),
    );

    Map<String, dynamic> toJson() => {
        "login": login,
        "name": name,
        "repository": repository?.toJson(),
    };
}

class Repository {
    final PullRequestConnection pullRequests;

    Repository({
        required this.pullRequests,
    });

    factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        pullRequests: PullRequestConnection.fromJson(json["pullRequests"]),
    );

    Map<String, dynamic> toJson() => {
        "pullRequests": pullRequests.toJson(),
    };
}

class PullRequestConnection {
    final List<PullRequest?>? nodes;

    PullRequestConnection({
        required this.nodes,
    });

    factory PullRequestConnection.fromJson(Map<String, dynamic> json) => PullRequestConnection(
        nodes: (json.containsKey("nodes") ? json["nodes"] : throw FormatException('Missing required property')) == null ? null : List<PullRequest?>.from((json.containsKey("nodes") ? json["nodes"] : throw FormatException('Missing required property'))!.map((x) => x == null ? null : PullRequest.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nodes": nodes == null ? null : List<dynamic>.from(nodes!.map((x) => x?.toJson())),
    };
}

class PullRequest {
    final PullRequestState state;

    PullRequest({
        required this.state,
    });

    factory PullRequest.fromJson(Map<String, dynamic> json) => PullRequest(
        state: pullRequestStateValues.map[json["state"]]!,
    );

    Map<String, dynamic> toJson() => {
        "state": pullRequestStateValues.reverse[state],
    };
}

enum PullRequestState {
    OPEN,
    CLOSED,
    MERGED
}

final pullRequestStateValues = EnumValues({
    "OPEN": PullRequestState.OPEN,
    "CLOSED": PullRequestState.CLOSED,
    "MERGED": PullRequestState.MERGED
});

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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
