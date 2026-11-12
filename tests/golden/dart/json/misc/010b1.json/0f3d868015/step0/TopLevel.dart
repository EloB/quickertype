// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final int age;
    final Country country;
    final int females;
    final int males;
    final int total;
    final int year;

    TopLevel({
        required this.age,
        required this.country,
        required this.females,
        required this.males,
        required this.total,
        required this.year,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        age: json["age"],
        country: countryValues.map[json["country"]]!,
        females: json["females"],
        males: json["males"],
        total: json["total"],
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "age": age,
        "country": countryValues.reverse[country],
        "females": females,
        "males": males,
        "total": total,
        "year": year,
    };
}

enum Country {
    UNITED_STATES
}

final countryValues = EnumValues({
    "United States": Country.UNITED_STATES
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
