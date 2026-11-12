// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String code;
    final List<String> columnNames;
    final List<List<dynamic>> data;
    final String description;
    final String displayUrl;
    final Errors errors;
    final String frequency;
    final DateTime fromDate;
    final int id;
    final String name;
    final bool premium;
    final String sourceCode;
    final String sourceName;
    final DateTime toDate;
    final String type;
    final DateTime updatedAt;
    final String urlizeName;

    TopLevel({
        required this.code,
        required this.columnNames,
        required this.data,
        required this.description,
        required this.displayUrl,
        required this.errors,
        required this.frequency,
        required this.fromDate,
        required this.id,
        required this.name,
        required this.premium,
        required this.sourceCode,
        required this.sourceName,
        required this.toDate,
        required this.type,
        required this.updatedAt,
        required this.urlizeName,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        code: json["code"],
        columnNames: List<String>.from(json["column_names"].map((x) => x)),
        data: List<List<dynamic>>.from(json["data"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        description: json["description"],
        displayUrl: json["display_url"],
        errors: Errors.fromJson(json["errors"]),
        frequency: json["frequency"],
        fromDate: DateTime.parse(json["from_date"]),
        id: json["id"],
        name: json["name"],
        premium: json["premium"],
        sourceCode: json["source_code"],
        sourceName: json["source_name"],
        toDate: DateTime.parse(json["to_date"]),
        type: json["type"],
        updatedAt: DateTime.parse(json["updated_at"]),
        urlizeName: json["urlize_name"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "column_names": List<dynamic>.from(columnNames.map((x) => x)),
        "data": List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "description": description,
        "display_url": displayUrl,
        "errors": errors.toJson(),
        "frequency": frequency,
        "from_date": "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "id": id,
        "name": name,
        "premium": premium,
        "source_code": sourceCode,
        "source_name": sourceName,
        "to_date": "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "type": type,
        "updated_at": updatedAt.toIso8601String(),
        "urlize_name": urlizeName,
    };
}

class Errors {
    Errors();

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    );

    Map<String, dynamic> toJson() => {
    };
}
