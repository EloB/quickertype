// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Prize> prizes;

    TopLevel({
        required this.prizes,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        prizes: List<Prize>.from(json["prizes"].map((x) => Prize.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "prizes": List<dynamic>.from(prizes.map((x) => x.toJson())),
    };
}

class Prize {
    final Category category;
    final List<Laureate> laureates;
    final String? overallMotivation;
    final String year;

    Prize({
        required this.category,
        required this.laureates,
        this.overallMotivation,
        required this.year,
    });

    factory Prize.fromJson(Map<String, dynamic> json) => Prize(
        category: categoryValues.map[json["category"]]!,
        laureates: List<Laureate>.from(json["laureates"].map((x) => Laureate.fromJson(x))),
        overallMotivation: json["overallMotivation"],
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "category": categoryValues.reverse[category],
        "laureates": List<dynamic>.from(laureates.map((x) => x.toJson())),
        "overallMotivation": overallMotivation,
        "year": year,
    };
}

enum Category {
    PHYSICS,
    CHEMISTRY,
    MEDICINE,
    LITERATURE,
    PEACE,
    ECONOMICS
}

final categoryValues = EnumValues({
    "physics": Category.PHYSICS,
    "chemistry": Category.CHEMISTRY,
    "medicine": Category.MEDICINE,
    "literature": Category.LITERATURE,
    "peace": Category.PEACE,
    "economics": Category.ECONOMICS
});

class Laureate {
    final String firstname;
    final String id;
    final String? motivation;
    final String share;
    final String surname;

    Laureate({
        required this.firstname,
        required this.id,
        this.motivation,
        required this.share,
        required this.surname,
    });

    factory Laureate.fromJson(Map<String, dynamic> json) => Laureate(
        firstname: json["firstname"],
        id: json["id"],
        motivation: json["motivation"],
        share: json["share"],
        surname: json["surname"],
    );

    Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "id": id,
        "motivation": motivation,
        "share": share,
        "surname": surname,
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
