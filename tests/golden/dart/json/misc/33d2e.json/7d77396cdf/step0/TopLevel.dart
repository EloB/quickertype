// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Laureate> laureates;

    TopLevel({
        required this.laureates,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        laureates: List<Laureate>.from(json["laureates"].map((x) => Laureate.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "laureates": List<dynamic>.from(laureates.map((x) => x.toJson())),
    };
}

class Laureate {
    final dynamic born;
    final String? bornCity;
    final String? bornCountry;
    final String? bornCountryCode;
    final dynamic died;
    final String? diedCity;
    final String? diedCountry;
    final String? diedCountryCode;
    final String? firstname;
    final Gender gender;
    final String id;
    final List<Prize> prizes;
    final String? surname;

    Laureate({
        required this.born,
        this.bornCity,
        this.bornCountry,
        this.bornCountryCode,
        required this.died,
        this.diedCity,
        this.diedCountry,
        this.diedCountryCode,
        this.firstname,
        required this.gender,
        required this.id,
        required this.prizes,
        this.surname,
    });

    factory Laureate.fromJson(Map<String, dynamic> json) => Laureate(
        born: json["born"],
        bornCity: json["bornCity"],
        bornCountry: json["bornCountry"],
        bornCountryCode: json["bornCountryCode"],
        died: json["died"],
        diedCity: json["diedCity"],
        diedCountry: json["diedCountry"],
        diedCountryCode: json["diedCountryCode"],
        firstname: json["firstname"],
        gender: genderValues.map[json["gender"]]!,
        id: json["id"],
        prizes: List<Prize>.from(json["prizes"].map((x) => Prize.fromJson(x))),
        surname: json["surname"],
    );

    Map<String, dynamic> toJson() => {
        "born": born,
        "bornCity": bornCity,
        "bornCountry": bornCountry,
        "bornCountryCode": bornCountryCode,
        "died": died,
        "diedCity": diedCity,
        "diedCountry": diedCountry,
        "diedCountryCode": diedCountryCode,
        "firstname": firstname,
        "gender": genderValues.reverse[gender],
        "id": id,
        "prizes": List<dynamic>.from(prizes.map((x) => x.toJson())),
        "surname": surname,
    };
}

enum BornEnum {
    THE_00000000,
    THE_18980000,
    THE_19430000
}

final bornEnumValues = EnumValues({
    "0000-00-00": BornEnum.THE_00000000,
    "1898-00-00": BornEnum.THE_18980000,
    "1943-00-00": BornEnum.THE_19430000
});

enum Gender {
    MALE,
    FEMALE,
    ORG
}

final genderValues = EnumValues({
    "male": Gender.MALE,
    "female": Gender.FEMALE,
    "org": Gender.ORG
});

class Prize {
    final List<dynamic> affiliations;
    final Category? category;
    final String? motivation;
    final String? overallMotivation;
    final String? share;
    final String? year;

    Prize({
        required this.affiliations,
        this.category,
        this.motivation,
        this.overallMotivation,
        this.share,
        this.year,
    });

    factory Prize.fromJson(Map<String, dynamic> json) => Prize(
        affiliations: List<dynamic>.from(json["affiliations"].map((x) => x)),
        category: json["category"] == null ? null : categoryValues.map[json["category"]]!,
        motivation: json["motivation"],
        overallMotivation: json["overallMotivation"],
        share: json["share"],
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "affiliations": List<dynamic>.from(affiliations.map((x) => x)),
        "category": categoryValues.reverse[category],
        "motivation": motivation,
        "overallMotivation": overallMotivation,
        "share": share,
        "year": year,
    };
}

class AffiliationClass {
    final String? city;
    final String? country;
    final String? name;

    AffiliationClass({
        this.city,
        this.country,
        this.name,
    });

    factory AffiliationClass.fromJson(Map<String, dynamic> json) => AffiliationClass(
        city: json["city"],
        country: json["country"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "name": name,
    };
}

enum Category {
    PHYSICS,
    CHEMISTRY,
    PEACE,
    MEDICINE,
    LITERATURE,
    ECONOMICS
}

final categoryValues = EnumValues({
    "physics": Category.PHYSICS,
    "chemistry": Category.CHEMISTRY,
    "peace": Category.PEACE,
    "medicine": Category.MEDICINE,
    "literature": Category.LITERATURE,
    "economics": Category.ECONOMICS
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
