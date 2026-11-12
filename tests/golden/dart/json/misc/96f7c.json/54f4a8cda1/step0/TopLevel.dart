// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<String> git;
    final String githubServicesSha;
    final List<String> hooks;
    final List<String> importer;
    final List<String> pages;
    final bool verifiablePasswordAuthentication;

    TopLevel({
        required this.git,
        required this.githubServicesSha,
        required this.hooks,
        required this.importer,
        required this.pages,
        required this.verifiablePasswordAuthentication,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        git: List<String>.from(json["git"].map((x) => x)),
        githubServicesSha: json["github_services_sha"],
        hooks: List<String>.from(json["hooks"].map((x) => x)),
        importer: List<String>.from(json["importer"].map((x) => x)),
        pages: List<String>.from(json["pages"].map((x) => x)),
        verifiablePasswordAuthentication: json["verifiable_password_authentication"],
    );

    Map<String, dynamic> toJson() => {
        "git": List<dynamic>.from(git.map((x) => x)),
        "github_services_sha": githubServicesSha,
        "hooks": List<dynamic>.from(hooks.map((x) => x)),
        "importer": List<dynamic>.from(importer.map((x) => x)),
        "pages": List<dynamic>.from(pages.map((x) => x)),
        "verifiable_password_authentication": verifiablePasswordAuthentication,
    };
}
