// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final String label;
    final double score;

    TopLevel({
        required this.label,
        required this.score,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        label: json["label"],
        score: json["score"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "score": score,
    };
}
