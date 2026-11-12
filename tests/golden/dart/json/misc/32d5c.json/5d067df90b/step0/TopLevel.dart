// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final DateTime? birthDate;
    final bool birthDateIsProtected;
    final int genderTypeId;
    final String notes;
    final String parliamentaryName;
    final int personId;
    final String photoUrl;
    final String preferredName;

    TopLevel({
        required this.birthDate,
        required this.birthDateIsProtected,
        required this.genderTypeId,
        required this.notes,
        required this.parliamentaryName,
        required this.personId,
        required this.photoUrl,
        required this.preferredName,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        birthDate: (json.containsKey("BirthDate") ? json["BirthDate"] : throw FormatException('Missing required property')) == null ? null : DateTime.parse((json.containsKey("BirthDate") ? json["BirthDate"] : throw FormatException('Missing required property'))),
        birthDateIsProtected: json["BirthDateIsProtected"],
        genderTypeId: json["GenderTypeID"],
        notes: json["Notes"],
        parliamentaryName: json["ParliamentaryName"],
        personId: json["PersonID"],
        photoUrl: json["PhotoURL"],
        preferredName: json["PreferredName"],
    );

    Map<String, dynamic> toJson() => {
        "BirthDate": birthDate?.toIso8601String(),
        "BirthDateIsProtected": birthDateIsProtected,
        "GenderTypeID": genderTypeId,
        "Notes": notes,
        "ParliamentaryName": parliamentaryName,
        "PersonID": personId,
        "PhotoURL": photoUrl,
        "PreferredName": preferredName,
    };
}
