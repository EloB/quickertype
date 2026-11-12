// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Hints hints;
    final Labels labels;

    TopLevel({
        required this.hints,
        required this.labels,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        hints: Hints.fromJson(json["Hints"]),
        labels: Labels.fromJson(json["Labels"]),
    );

    Map<String, dynamic> toJson() => {
        "Hints": hints.toJson(),
        "Labels": labels.toJson(),
    };
}

class Hints {
    Hints();

    factory Hints.fromJson(Map<String, dynamic> json) => Hints(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Labels {
    final String accountNumber;
    final String title;

    Labels({
        required this.accountNumber,
        required this.title,
    });

    factory Labels.fromJson(Map<String, dynamic> json) => Labels(
        accountNumber: json["AccountNumber"],
        title: json["Title"],
    );

    Map<String, dynamic> toJson() => {
        "AccountNumber": accountNumber,
        "Title": title,
    };
}
