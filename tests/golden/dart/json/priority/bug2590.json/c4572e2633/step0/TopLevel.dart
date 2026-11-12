// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Invoice> invoices;

    TopLevel({
        required this.invoices,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        invoices: List<Invoice>.from(json["invoices"].map((x) => Invoice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "invoices": List<dynamic>.from(invoices.map((x) => x.toJson())),
    };
}

class Invoice {
    final DateTime? createdAt;
    final DateTime? dueDate;
    final String name;

    Invoice({
        required this.createdAt,
        required this.dueDate,
        required this.name,
    });

    factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        createdAt: (json.containsKey("createdAt") ? json["createdAt"] : throw FormatException('Missing required property')) == null ? null : DateTime.parse((json.containsKey("createdAt") ? json["createdAt"] : throw FormatException('Missing required property'))),
        dueDate: (json.containsKey("dueDate") ? json["dueDate"] : throw FormatException('Missing required property')) == null ? null : DateTime.parse((json.containsKey("dueDate") ? json["dueDate"] : throw FormatException('Missing required property'))),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "dueDate": dueDate == null ? null : "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "name": name,
    };
}
