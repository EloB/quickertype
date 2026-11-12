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
    final Repository? repository;

    Data({
        required this.repository,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        repository: (json.containsKey("repository") ? json["repository"] : throw FormatException('Missing required property')) == null ? null : Repository.fromJson((json.containsKey("repository") ? json["repository"] : throw FormatException('Missing required property'))),
    );

    Map<String, dynamic> toJson() => {
        "repository": repository?.toJson(),
    };
}

class Repository {
    final String nameWithOwner;
    final IssueOrPullRequest? n303;
    final IssueOrPullRequest? n307;

    Repository({
        required this.nameWithOwner,
        required this.n303,
        required this.n307,
    });

    factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        nameWithOwner: json["nameWithOwner"],
        n303: (json.containsKey("n303") ? json["n303"] : throw FormatException('Missing required property')) == null ? null : IssueOrPullRequest.fromJson((json.containsKey("n303") ? json["n303"] : throw FormatException('Missing required property'))),
        n307: (json.containsKey("n307") ? json["n307"] : throw FormatException('Missing required property')) == null ? null : IssueOrPullRequest.fromJson((json.containsKey("n307") ? json["n307"] : throw FormatException('Missing required property'))),
    );

    Map<String, dynamic> toJson() => {
        "nameWithOwner": nameWithOwner,
        "n303": n303?.toJson(),
        "n307": n307?.toJson(),
    };
}

class IssueOrPullRequest {
    final String? title;
    final IssueState? state;
    final bool? merged;

    IssueOrPullRequest({
        this.title,
        this.state,
        this.merged,
    });

    factory IssueOrPullRequest.fromJson(Map<String, dynamic> json) => IssueOrPullRequest(
        title: json["title"],
        state: json["state"] == null ? null : issueStateValues.map[json["state"]]!,
        merged: json["merged"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "state": issueStateValues.reverse[state],
        "merged": merged,
    };
}

enum IssueState {
    OPEN,
    CLOSED
}

final issueStateValues = EnumValues({
    "OPEN": IssueState.OPEN,
    "CLOSED": IssueState.CLOSED
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
