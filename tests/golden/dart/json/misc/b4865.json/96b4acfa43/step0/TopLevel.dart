// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final String? computedRegionCbhkFwbd;
    final String? computedRegionNnqa25F4;
    final Fall fall;
    final Geolocation? geolocation;
    final String id;
    final String? mass;
    final String name;
    final Nametype nametype;
    final String recclass;
    final String? reclat;
    final String? reclong;
    final DateTime? year;

    TopLevel({
        this.computedRegionCbhkFwbd,
        this.computedRegionNnqa25F4,
        required this.fall,
        this.geolocation,
        required this.id,
        this.mass,
        required this.name,
        required this.nametype,
        required this.recclass,
        this.reclat,
        this.reclong,
        this.year,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        computedRegionCbhkFwbd: json[":@computed_region_cbhk_fwbd"],
        computedRegionNnqa25F4: json[":@computed_region_nnqa_25f4"],
        fall: fallValues.map[json["fall"]]!,
        geolocation: json["geolocation"] == null ? null : Geolocation.fromJson(json["geolocation"]),
        id: json["id"],
        mass: json["mass"],
        name: json["name"],
        nametype: nametypeValues.map[json["nametype"]]!,
        recclass: json["recclass"],
        reclat: json["reclat"],
        reclong: json["reclong"],
        year: json["year"] == null ? null : DateTime.parse(json["year"]),
    );

    Map<String, dynamic> toJson() => {
        ":@computed_region_cbhk_fwbd": computedRegionCbhkFwbd,
        ":@computed_region_nnqa_25f4": computedRegionNnqa25F4,
        "fall": fallValues.reverse[fall],
        "geolocation": geolocation?.toJson(),
        "id": id,
        "mass": mass,
        "name": name,
        "nametype": nametypeValues.reverse[nametype],
        "recclass": recclass,
        "reclat": reclat,
        "reclong": reclong,
        "year": year?.toIso8601String(),
    };
}

enum Fall {
    FELL,
    FOUND
}

final fallValues = EnumValues({
    "Fell": Fall.FELL,
    "Found": Fall.FOUND
});

class Geolocation {
    final List<double> coordinates;
    final Type type;

    Geolocation({
        required this.coordinates,
        required this.type,
    });

    factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": typeValues.reverse[type],
    };
}

enum Type {
    POINT
}

final typeValues = EnumValues({
    "Point": Type.POINT
});

enum Nametype {
    VALID
}

final nametypeValues = EnumValues({
    "Valid": Nametype.VALID
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
