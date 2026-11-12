// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Crs crs;
    final List<Feature> features;
    final int totalFeatures;
    final String type;

    TopLevel({
        required this.crs,
        required this.features,
        required this.totalFeatures,
        required this.type,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        crs: Crs.fromJson(json["crs"]),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        totalFeatures: json["totalFeatures"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "crs": crs.toJson(),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "totalFeatures": totalFeatures,
        "type": type,
    };
}

class Crs {
    final CrsProperties properties;
    final String type;

    Crs({
        required this.properties,
        required this.type,
    });

    factory Crs.fromJson(Map<String, dynamic> json) => Crs(
        properties: CrsProperties.fromJson(json["properties"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "properties": properties.toJson(),
        "type": type,
    };
}

class CrsProperties {
    final String name;

    CrsProperties({
        required this.name,
    });

    factory CrsProperties.fromJson(Map<String, dynamic> json) => CrsProperties(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Feature {
    final Geometry geometry;
    final GeometryName geometryName;
    final String id;
    final FeatureProperties properties;
    final FeatureType type;

    Feature({
        required this.geometry,
        required this.geometryName,
        required this.id,
        required this.properties,
        required this.type,
    });

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        geometry: Geometry.fromJson(json["geometry"]),
        geometryName: geometryNameValues.map[json["geometry_name"]]!,
        id: json["id"],
        properties: FeatureProperties.fromJson(json["properties"]),
        type: featureTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "geometry_name": geometryNameValues.reverse[geometryName],
        "id": id,
        "properties": properties.toJson(),
        "type": featureTypeValues.reverse[type],
    };
}

class Geometry {
    final List<List<double>> coordinates;
    final GeometryType type;

    Geometry({
        required this.coordinates,
        required this.type,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        type: geometryTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "type": geometryTypeValues.reverse[type],
    };
}

enum GeometryType {
    MULTI_POINT
}

final geometryTypeValues = EnumValues({
    "MultiPoint": GeometryType.MULTI_POINT
});

enum GeometryName {
    GEOM
}

final geometryNameValues = EnumValues({
    "geom": GeometryName.GEOM
});

class FeatureProperties {
    final String facebookaccount;
    final String frequencyfinderurl;
    final String name;
    final String siteurl;
    final String streetaddress;
    final String twitteraccount;

    FeatureProperties({
        required this.facebookaccount,
        required this.frequencyfinderurl,
        required this.name,
        required this.siteurl,
        required this.streetaddress,
        required this.twitteraccount,
    });

    factory FeatureProperties.fromJson(Map<String, dynamic> json) => FeatureProperties(
        facebookaccount: json["facebookaccount"],
        frequencyfinderurl: json["frequencyfinderurl"],
        name: json["name"],
        siteurl: json["siteurl"],
        streetaddress: json["streetaddress"],
        twitteraccount: json["twitteraccount"],
    );

    Map<String, dynamic> toJson() => {
        "facebookaccount": facebookaccount,
        "frequencyfinderurl": frequencyfinderurl,
        "name": name,
        "siteurl": siteurl,
        "streetaddress": streetaddress,
        "twitteraccount": twitteraccount,
    };
}

enum FeatureType {
    FEATURE
}

final featureTypeValues = EnumValues({
    "Feature": FeatureType.FEATURE
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
