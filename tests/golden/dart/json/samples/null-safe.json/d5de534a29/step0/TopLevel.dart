// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Item> item;

    TopLevel({
        required this.item,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "item": List<dynamic>.from(item.map((x) => x.toJson())),
    };
}

class Item {
    final Address? address;
    final DateTime? createdAt;
    final String name;
    final int? sex;

    Item({
        this.address,
        this.createdAt,
        required this.name,
        required this.sex,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        name: json["name"],
        sex: (json.containsKey("sex") ? json["sex"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "name": name,
        "sex": sex,
    };
}

class Address {
    final String city;
    final String country;
    final String street;

    Address({
        required this.city,
        required this.country,
        required this.street,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        country: json["country"],
        street: json["street"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "street": street,
    };
}
