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

enum GeometryName {
    GEOM
}

final geometryNameValues = EnumValues({
    "geom": GeometryName.GEOM
});

class FeatureProperties {
    final String division;
    final double fax;
    final FireBanR? fireBanR;
    final double latitude;
    final String localGovt;
    final double longitude;
    final String? no;
    final double phone;
    final int postcode;
    final String psa;
    final Region region;
    final String station;
    final String street;
    final String suburb;
    final PropertiesType? type;

    FeatureProperties({
        required this.division,
        required this.fax,
        required this.fireBanR,
        required this.latitude,
        required this.localGovt,
        required this.longitude,
        required this.no,
        required this.phone,
        required this.postcode,
        required this.psa,
        required this.region,
        required this.station,
        required this.street,
        required this.suburb,
        required this.type,
    });

    factory FeatureProperties.fromJson(Map<String, dynamic> json) => FeatureProperties(
        division: json["division"],
        fax: json["fax"]?.toDouble(),
        fireBanR: (json.containsKey("fire_ban_r") ? json["fire_ban_r"] : throw FormatException('Missing required property')) == null ? null : fireBanRValues.map[(json.containsKey("fire_ban_r") ? json["fire_ban_r"] : throw FormatException('Missing required property'))]!,
        latitude: json["latitude"]?.toDouble(),
        localGovt: json["local_govt"],
        longitude: json["longitude"]?.toDouble(),
        no: (json.containsKey("no") ? json["no"] : throw FormatException('Missing required property')),
        phone: json["phone"]?.toDouble(),
        postcode: json["postcode"],
        psa: json["psa"],
        region: regionValues.map[json["region"]]!,
        station: json["station"],
        street: json["street"],
        suburb: json["suburb"],
        type: (json.containsKey("type") ? json["type"] : throw FormatException('Missing required property')) == null ? null : propertiesTypeValues.map[(json.containsKey("type") ? json["type"] : throw FormatException('Missing required property'))]!,
    );

    Map<String, dynamic> toJson() => {
        "division": division,
        "fax": fax,
        "fire_ban_r": fireBanRValues.reverse[fireBanR],
        "latitude": latitude,
        "local_govt": localGovt,
        "longitude": longitude,
        "no": no,
        "phone": phone,
        "postcode": postcode,
        "psa": psa,
        "region": regionValues.reverse[region],
        "station": station,
        "street": street,
        "suburb": suburb,
        "type": propertiesTypeValues.reverse[type],
    };
}

enum FireBanR {
    NORTH_CENTRAL,
    CENTRAL,
    SOUTH_WEST,
    WIMMERA,
    NORTHERN_COUNTRY,
    EAST_GIPPSLAND,
    NORTH_EAST,
    MALLEE,
    WEST_SOUTH_GIPPSLAND,
    BALLARAT
}

final fireBanRValues = EnumValues({
    "North Central": FireBanR.NORTH_CENTRAL,
    "Central": FireBanR.CENTRAL,
    "South West": FireBanR.SOUTH_WEST,
    "Wimmera": FireBanR.WIMMERA,
    "Northern Country": FireBanR.NORTHERN_COUNTRY,
    "East Gippsland": FireBanR.EAST_GIPPSLAND,
    "North East": FireBanR.NORTH_EAST,
    "Mallee": FireBanR.MALLEE,
    "West &South Gippsland": FireBanR.WEST_SOUTH_GIPPSLAND,
    "Ballarat": FireBanR.BALLARAT
});

enum Region {
    EASTERN,
    NORTHERN_METRO,
    WESTERN,
    SOUTHERN_METRO
}

final regionValues = EnumValues({
    "Eastern": Region.EASTERN,
    "Northern Metro": Region.NORTHERN_METRO,
    "Western": Region.WESTERN,
    "Southern Metro": Region.SOUTHERN_METRO
});

enum PropertiesType {
    STREET,
    AVENUE,
    ROAD,
    HIGHWAY,
    BOULEVARD,
    COURT,
    WAY,
    DRIVE,
    SOUTH,
    HILL,
    LANE,
    CLOSE,
    PARADE,
    TYPE_ROAD,
    PLACE,
    RD
}

final propertiesTypeValues = EnumValues({
    "STREET": PropertiesType.STREET,
    "AVENUE": PropertiesType.AVENUE,
    "ROAD": PropertiesType.ROAD,
    "HIGHWAY": PropertiesType.HIGHWAY,
    "BOULEVARD": PropertiesType.BOULEVARD,
    "COURT": PropertiesType.COURT,
    "WAY": PropertiesType.WAY,
    "DRIVE": PropertiesType.DRIVE,
    "SOUTH": PropertiesType.SOUTH,
    "HILL": PropertiesType.HILL,
    "LANE": PropertiesType.LANE,
    "CLOSE": PropertiesType.CLOSE,
    "PARADE": PropertiesType.PARADE,
    "Road": PropertiesType.TYPE_ROAD,
    "PLACE": PropertiesType.PLACE,
    "RD": PropertiesType.RD
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
