// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String details;
    final List<Rate> rates;
    final dynamic version;

    TopLevel({
        required this.details,
        required this.rates,
        required this.version,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        details: json["details"],
        rates: List<Rate>.from(json["rates"].map((x) => Rate.fromJson(x))),
        version: (json.containsKey("version") ? json["version"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "details": details,
        "rates": List<dynamic>.from(rates.map((x) => x.toJson())),
        "version": version,
    };
}

class Rate {
    final String code;
    final String countryCode;
    final String name;
    final List<Period> periods;

    Rate({
        required this.code,
        required this.countryCode,
        required this.name,
        required this.periods,
    });

    factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        code: json["code"],
        countryCode: json["country_code"],
        name: json["name"],
        periods: List<Period>.from(json["periods"].map((x) => Period.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "country_code": countryCode,
        "name": name,
        "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
    };
}

class Period {
    final dynamic effectiveFrom;
    final Rates rates;

    Period({
        required this.effectiveFrom,
        required this.rates,
    });

    factory Period.fromJson(Map<String, dynamic> json) => Period(
        effectiveFrom: json["effective_from"],
        rates: Rates.fromJson(json["rates"]),
    );

    Map<String, dynamic> toJson() => {
        "effective_from": effectiveFrom,
        "rates": rates.toJson(),
    };
}

enum EffectiveFromEnum {
    THE_00000101
}

final effectiveFromEnumValues = EnumValues({
    "0000-01-01": EffectiveFromEnum.THE_00000101
});

class Rates {
    final double? parking;
    final double? reduced;
    final double? reduced1;
    final double? reduced2;
    final double standard;
    final double? superReduced;

    Rates({
        this.parking,
        this.reduced,
        this.reduced1,
        this.reduced2,
        required this.standard,
        this.superReduced,
    });

    factory Rates.fromJson(Map<String, dynamic> json) => Rates(
        parking: json["parking"]?.toDouble(),
        reduced: json["reduced"]?.toDouble(),
        reduced1: json["reduced1"]?.toDouble(),
        reduced2: json["reduced2"]?.toDouble(),
        standard: json["standard"]?.toDouble(),
        superReduced: json["super_reduced"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "parking": parking,
        "reduced": reduced,
        "reduced1": reduced1,
        "reduced2": reduced2,
        "standard": standard,
        "super_reduced": superReduced,
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
