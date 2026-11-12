// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final DateTime? optionalDate;
    final DateTime? optionalDateTime;
    final String? optionalTime;
    final DateTime requiredDate;
    final DateTime requiredDateTime;
    final String requiredTime;

    TopLevel({
        this.optionalDate,
        this.optionalDateTime,
        this.optionalTime,
        required this.requiredDate,
        required this.requiredDateTime,
        required this.requiredTime,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        optionalDate: json["optional-date"] == null ? null : DateTime.parse(json["optional-date"]),
        optionalDateTime: json["optional-date-time"] == null ? null : DateTime.parse(json["optional-date-time"]),
        optionalTime: json["optional-time"],
        requiredDate: DateTime.parse(json["required-date"]),
        requiredDateTime: DateTime.parse(json["required-date-time"]),
        requiredTime: json["required-time"],
    );

    Map<String, dynamic> toJson() => {
        "optional-date": optionalDate == null ? null : "${optionalDate!.year.toString().padLeft(4, '0')}-${optionalDate!.month.toString().padLeft(2, '0')}-${optionalDate!.day.toString().padLeft(2, '0')}",
        "optional-date-time": optionalDateTime?.toIso8601String(),
        "optional-time": optionalTime,
        "required-date": "${requiredDate.year.toString().padLeft(4, '0')}-${requiredDate.month.toString().padLeft(2, '0')}-${requiredDate.day.toString().padLeft(2, '0')}",
        "required-date-time": requiredDateTime.toIso8601String(),
        "required-time": requiredTime,
    };
}
