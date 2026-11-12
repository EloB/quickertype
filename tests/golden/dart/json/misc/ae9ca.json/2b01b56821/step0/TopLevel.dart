// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Feature> features;
    final String name;
    final String type;

    TopLevel({
        required this.features,
        required this.name,
        required this.type,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        name: json["name"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "name": name,
        "type": type,
    };
}

class Feature {
    final Geometry geometry;
    final Properties properties;
    final FeatureType type;

    Feature({
        required this.geometry,
        required this.properties,
        required this.type,
    });

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
        type: featureTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
        "type": featureTypeValues.reverse[type],
    };
}

class Geometry {
    final List<double> coordinates;
    final GeometryType type;

    Geometry({
        required this.coordinates,
        required this.type,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: geometryTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": geometryTypeValues.reverse[type],
    };
}

enum GeometryType {
    POINT
}

final geometryTypeValues = EnumValues({
    "Point": GeometryType.POINT
});

class Properties {
    final String area;
    final String centralAssetId;
    final String featureLocation;
    final String lat;
    final String long;
    final MaintainingAuthority maintainingAuthority;
    final String number;
    final Class propertiesClass;
    final String siteName;
    final Ward ward;

    Properties({
        required this.area,
        required this.centralAssetId,
        required this.featureLocation,
        required this.lat,
        required this.long,
        required this.maintainingAuthority,
        required this.number,
        required this.propertiesClass,
        required this.siteName,
        required this.ward,
    });

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        area: json["Area"],
        centralAssetId: json["Central Asset ID"],
        featureLocation: json["Feature Location"],
        lat: json["lat"],
        long: json["long"],
        maintainingAuthority: maintainingAuthorityValues.map[json["Maintaining Authority"]]!,
        number: json["Number"],
        propertiesClass: classValues.map[json["Class"]]!,
        siteName: json["Site Name"],
        ward: wardValues.map[json["Ward"]]!,
    );

    Map<String, dynamic> toJson() => {
        "Area": area,
        "Central Asset ID": centralAssetId,
        "Feature Location": featureLocation,
        "lat": lat,
        "long": long,
        "Maintaining Authority": maintainingAuthorityValues.reverse[maintainingAuthority],
        "Number": number,
        "Class": classValues.reverse[propertiesClass],
        "Site Name": siteName,
        "Ward": wardValues.reverse[ward],
    };
}

enum MaintainingAuthority {
    CITY_OF_BALLARAT
}

final maintainingAuthorityValues = EnumValues({
    "City of Ballarat": MaintainingAuthority.CITY_OF_BALLARAT
});

enum Class {
    NO_CODE_ALLOCATED,
    OS_DISTRICT,
    OS_NEIGHBOURHOOD,
    OS_REGIONAL
}

final classValues = EnumValues({
    "No Code Allocated": Class.NO_CODE_ALLOCATED,
    "OS-District": Class.OS_DISTRICT,
    "OS-Neighbourhood": Class.OS_NEIGHBOURHOOD,
    "OS-Regional": Class.OS_REGIONAL
});

enum Ward {
    SOUTH,
    NORTH,
    CENTRAL
}

final wardValues = EnumValues({
    "South": Ward.SOUTH,
    "North": Ward.NORTH,
    "Central": Ward.CENTRAL
});

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
