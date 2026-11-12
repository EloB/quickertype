// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<dynamic> topLevelFromJson(String str) => List<dynamic>.from(json.decode(str).map((x) => x));

String topLevelToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

class TopLevelElement {
    final Adminregion adminregion;
    final String capitalCity;
    final String id;
    final Adminregion incomeLevel;
    final String iso2Code;
    final String latitude;
    final Adminregion lendingType;
    final String longitude;
    final String name;
    final Adminregion region;

    TopLevelElement({
        required this.adminregion,
        required this.capitalCity,
        required this.id,
        required this.incomeLevel,
        required this.iso2Code,
        required this.latitude,
        required this.lendingType,
        required this.longitude,
        required this.name,
        required this.region,
    });

    factory TopLevelElement.fromJson(Map<String, dynamic> json) => TopLevelElement(
        adminregion: Adminregion.fromJson(json["adminregion"]),
        capitalCity: json["capitalCity"],
        id: json["id"],
        incomeLevel: Adminregion.fromJson(json["incomeLevel"]),
        iso2Code: json["iso2Code"],
        latitude: json["latitude"],
        lendingType: Adminregion.fromJson(json["lendingType"]),
        longitude: json["longitude"],
        name: json["name"],
        region: Adminregion.fromJson(json["region"]),
    );

    Map<String, dynamic> toJson() => {
        "adminregion": adminregion.toJson(),
        "capitalCity": capitalCity,
        "id": id,
        "incomeLevel": incomeLevel.toJson(),
        "iso2Code": iso2Code,
        "latitude": latitude,
        "lendingType": lendingType.toJson(),
        "longitude": longitude,
        "name": name,
        "region": region.toJson(),
    };
}

class Adminregion {
    final Id id;
    final Value value;

    Adminregion({
        required this.id,
        required this.value,
    });

    factory Adminregion.fromJson(Map<String, dynamic> json) => Adminregion(
        id: idValues.map[json["id"]]!,
        value: valueValues.map[json["value"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "value": valueValues.reverse[value],
    };
}

enum Id {
    EMPTY,
    SAS,
    SSA,
    ECA,
    LAC,
    EAP,
    MNA,
    HIC,
    LIC,
    NA,
    LMC,
    UMC,
    LNX,
    IDX,
    IBD,
    IDB,
    LCN,
    SSF,
    ECS,
    MEA,
    EAS,
    NAC
}

final idValues = EnumValues({
    "": Id.EMPTY,
    "SAS": Id.SAS,
    "SSA": Id.SSA,
    "ECA": Id.ECA,
    "LAC": Id.LAC,
    "EAP": Id.EAP,
    "MNA": Id.MNA,
    "HIC": Id.HIC,
    "LIC": Id.LIC,
    "NA": Id.NA,
    "LMC": Id.LMC,
    "UMC": Id.UMC,
    "LNX": Id.LNX,
    "IDX": Id.IDX,
    "IBD": Id.IBD,
    "IDB": Id.IDB,
    "LCN": Id.LCN,
    "SSF": Id.SSF,
    "ECS": Id.ECS,
    "MEA": Id.MEA,
    "EAS": Id.EAS,
    "NAC": Id.NAC
});

enum Value {
    EMPTY,
    SOUTH_ASIA,
    SUB_SAHARAN_AFRICA_EXCLUDING_HIGH_INCOME,
    EUROPE_CENTRAL_ASIA_EXCLUDING_HIGH_INCOME,
    LATIN_AMERICA_CARIBBEAN_EXCLUDING_HIGH_INCOME,
    EAST_ASIA_PACIFIC_EXCLUDING_HIGH_INCOME,
    MIDDLE_EAST_NORTH_AFRICA_EXCLUDING_HIGH_INCOME,
    HIGH_INCOME,
    LOW_INCOME,
    AGGREGATES,
    LOWER_MIDDLE_INCOME,
    UPPER_MIDDLE_INCOME,
    NOT_CLASSIFIED,
    IDA,
    IBRD,
    BLEND,
    LATIN_AMERICA_CARIBBEAN,
    SUB_SAHARAN_AFRICA,
    EUROPE_CENTRAL_ASIA,
    MIDDLE_EAST_NORTH_AFRICA,
    EAST_ASIA_PACIFIC,
    NORTH_AMERICA
}

final valueValues = EnumValues({
    "": Value.EMPTY,
    "South Asia": Value.SOUTH_ASIA,
    "Sub-Saharan Africa (excluding high income)": Value.SUB_SAHARAN_AFRICA_EXCLUDING_HIGH_INCOME,
    "Europe & Central Asia (excluding high income)": Value.EUROPE_CENTRAL_ASIA_EXCLUDING_HIGH_INCOME,
    "Latin America & Caribbean (excluding high income)": Value.LATIN_AMERICA_CARIBBEAN_EXCLUDING_HIGH_INCOME,
    "East Asia & Pacific (excluding high income)": Value.EAST_ASIA_PACIFIC_EXCLUDING_HIGH_INCOME,
    "Middle East & North Africa (excluding high income)": Value.MIDDLE_EAST_NORTH_AFRICA_EXCLUDING_HIGH_INCOME,
    "High income": Value.HIGH_INCOME,
    "Low income": Value.LOW_INCOME,
    "Aggregates": Value.AGGREGATES,
    "Lower middle income": Value.LOWER_MIDDLE_INCOME,
    "Upper middle income": Value.UPPER_MIDDLE_INCOME,
    "Not classified": Value.NOT_CLASSIFIED,
    "IDA": Value.IDA,
    "IBRD": Value.IBRD,
    "Blend": Value.BLEND,
    "Latin America & Caribbean ": Value.LATIN_AMERICA_CARIBBEAN,
    "Sub-Saharan Africa ": Value.SUB_SAHARAN_AFRICA,
    "Europe & Central Asia": Value.EUROPE_CENTRAL_ASIA,
    "Middle East & North Africa": Value.MIDDLE_EAST_NORTH_AFRICA,
    "East Asia & Pacific": Value.EAST_ASIA_PACIFIC,
    "North America": Value.NORTH_AMERICA
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
