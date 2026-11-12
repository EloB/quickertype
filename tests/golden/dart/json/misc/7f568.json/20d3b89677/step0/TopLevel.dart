// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final int comments;
    final String commentsUrl;
    final String commitsUrl;
    final DateTime createdAt;
    final String? description;
    final Map<String, FileValue> files;
    final String forksUrl;
    final String gitPullUrl;
    final String gitPushUrl;
    final String htmlUrl;
    final String id;
    final bool public;
    final bool truncated;
    final DateTime updatedAt;
    final String url;
    final dynamic user;

    TopLevel({
        required this.comments,
        required this.commentsUrl,
        required this.commitsUrl,
        required this.createdAt,
        required this.description,
        required this.files,
        required this.forksUrl,
        required this.gitPullUrl,
        required this.gitPushUrl,
        required this.htmlUrl,
        required this.id,
        required this.public,
        required this.truncated,
        required this.updatedAt,
        required this.url,
        required this.user,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        comments: json["comments"],
        commentsUrl: json["comments_url"],
        commitsUrl: json["commits_url"],
        createdAt: DateTime.parse(json["created_at"]),
        description: (json.containsKey("description") ? json["description"] : throw FormatException('Missing required property')),
        files: Map.from(json["files"]).map((k, v) => MapEntry<String, FileValue>(k, FileValue.fromJson(v))),
        forksUrl: json["forks_url"],
        gitPullUrl: json["git_pull_url"],
        gitPushUrl: json["git_push_url"],
        htmlUrl: json["html_url"],
        id: json["id"],
        public: json["public"],
        truncated: json["truncated"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        user: (json.containsKey("user") ? json["user"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "comments": comments,
        "comments_url": commentsUrl,
        "commits_url": commitsUrl,
        "created_at": createdAt.toIso8601String(),
        "description": description,
        "files": Map.from(files).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "forks_url": forksUrl,
        "git_pull_url": gitPullUrl,
        "git_push_url": gitPushUrl,
        "html_url": htmlUrl,
        "id": id,
        "public": public,
        "truncated": truncated,
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
        "user": user,
    };
}

class FileValue {
    final String filename;
    final Language? language;
    final String rawUrl;
    final int size;
    final Type type;

    FileValue({
        required this.filename,
        required this.language,
        required this.rawUrl,
        required this.size,
        required this.type,
    });

    factory FileValue.fromJson(Map<String, dynamic> json) => FileValue(
        filename: json["filename"],
        language: (json.containsKey("language") ? json["language"] : throw FormatException('Missing required property')) == null ? null : languageValues.map[(json.containsKey("language") ? json["language"] : throw FormatException('Missing required property'))]!,
        rawUrl: json["raw_url"],
        size: json["size"],
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "filename": filename,
        "language": languageValues.reverse[language],
        "raw_url": rawUrl,
        "size": size,
        "type": typeValues.reverse[type],
    };
}

enum Language {
    MARKDOWN
}

final languageValues = EnumValues({
    "Markdown": Language.MARKDOWN
});

enum Type {
    TEXT_PLAIN
}

final typeValues = EnumValues({
    "text/plain": Type.TEXT_PLAIN
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
