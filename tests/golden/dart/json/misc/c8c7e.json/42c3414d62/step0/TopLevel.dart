// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<dynamic> topLevelFromJson(String str) => List<dynamic>.from(json.decode(str).map((x) => x));

String topLevelToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

class TopLevelElement {
    final Country country;
    final String date;
    final String decimal;
    final Country indicator;
    final String value;

    TopLevelElement({
        required this.country,
        required this.date,
        required this.decimal,
        required this.indicator,
        required this.value,
    });

    factory TopLevelElement.fromJson(Map<String, dynamic> json) => TopLevelElement(
        country: Country.fromJson(json["country"]),
        date: json["date"],
        decimal: json["decimal"],
        indicator: Country.fromJson(json["indicator"]),
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "country": country.toJson(),
        "date": date,
        "decimal": decimal,
        "indicator": indicator.toJson(),
        "value": value,
    };
}

class Country {
    final Id id;
    final Value value;

    Country({
        required this.id,
        required this.value,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: idValues.map[json["id"]]!,
        value: valueValues.map[json["value"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "value": valueValues.reverse[value],
    };
}

enum Id {
    IN,
    NY_GDP_MKTP_CD
}

final idValues = EnumValues({
    "IN": Id.IN,
    "NY.GDP.MKTP.CD": Id.NY_GDP_MKTP_CD
});

enum Value {
    INDIA,
    GDP_CURRENT_US
}

final valueValues = EnumValues({
    "India": Value.INDIA,
    "GDP (current US\u0024)": Value.GDP_CURRENT_US
});

class PurpleTopLevel {
    final int page;
    final int pages;
    final String perPage;
    final int total;

    PurpleTopLevel({
        required this.page,
        required this.pages,
        required this.perPage,
        required this.total,
    });

    factory PurpleTopLevel.fromJson(Map<String, dynamic> json) => PurpleTopLevel(
        page: json["page"],
        pages: json["pages"],
        perPage: json["per_page"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "pages": pages,
        "per_page": perPage,
        "total": total,
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
