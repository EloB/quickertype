// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<double> bbox;
    final List<Feature> features;
    final Metadata metadata;
    final String type;

    TopLevel({
        required this.bbox,
        required this.features,
        required this.metadata,
        required this.type,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        bbox: List<double>.from(json["bbox"].map((x) => x?.toDouble())),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        metadata: Metadata.fromJson(json["metadata"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "bbox": List<dynamic>.from(bbox.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "metadata": metadata.toJson(),
        "type": type,
    };
}

class Feature {
    final Geometry geometry;
    final String id;
    final Properties properties;
    final FeatureType type;

    Feature({
        required this.geometry,
        required this.id,
        required this.properties,
        required this.type,
    });

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        geometry: Geometry.fromJson(json["geometry"]),
        id: json["id"],
        properties: Properties.fromJson(json["properties"]),
        type: featureTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
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

class Properties {
    final dynamic alert;
    final dynamic cdi;
    final String code;
    final String detail;
    final double? dmin;
    final dynamic felt;
    final int? gap;
    final String ids;
    final double mag;
    final MagType magType;
    final dynamic mmi;
    final String net;
    final int? nst;
    final String place;
    final double rms;
    final int sig;
    final String sources;
    final Status status;
    final int time;
    final String title;
    final int tsunami;
    final PropertiesType type;
    final String types;
    final int tz;
    final int updated;
    final String url;

    Properties({
        required this.alert,
        required this.cdi,
        required this.code,
        required this.detail,
        required this.dmin,
        required this.felt,
        required this.gap,
        required this.ids,
        required this.mag,
        required this.magType,
        required this.mmi,
        required this.net,
        required this.nst,
        required this.place,
        required this.rms,
        required this.sig,
        required this.sources,
        required this.status,
        required this.time,
        required this.title,
        required this.tsunami,
        required this.type,
        required this.types,
        required this.tz,
        required this.updated,
        required this.url,
    });

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        alert: (json.containsKey("alert") ? json["alert"] : throw FormatException('Missing required property')),
        cdi: (json.containsKey("cdi") ? json["cdi"] : throw FormatException('Missing required property')),
        code: json["code"],
        detail: json["detail"],
        dmin: (json.containsKey("dmin") ? json["dmin"] : throw FormatException('Missing required property'))?.toDouble(),
        felt: (json.containsKey("felt") ? json["felt"] : throw FormatException('Missing required property')),
        gap: (json.containsKey("gap") ? json["gap"] : throw FormatException('Missing required property')),
        ids: json["ids"],
        mag: json["mag"]?.toDouble(),
        magType: magTypeValues.map[json["magType"]]!,
        mmi: (json.containsKey("mmi") ? json["mmi"] : throw FormatException('Missing required property')),
        net: json["net"],
        nst: (json.containsKey("nst") ? json["nst"] : throw FormatException('Missing required property')),
        place: json["place"],
        rms: json["rms"]?.toDouble(),
        sig: json["sig"],
        sources: json["sources"],
        status: statusValues.map[json["status"]]!,
        time: json["time"],
        title: json["title"],
        tsunami: json["tsunami"],
        type: propertiesTypeValues.map[json["type"]]!,
        types: json["types"],
        tz: json["tz"],
        updated: json["updated"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "alert": alert,
        "cdi": cdi,
        "code": code,
        "detail": detail,
        "dmin": dmin,
        "felt": felt,
        "gap": gap,
        "ids": ids,
        "mag": mag,
        "magType": magTypeValues.reverse[magType],
        "mmi": mmi,
        "net": net,
        "nst": nst,
        "place": place,
        "rms": rms,
        "sig": sig,
        "sources": sources,
        "status": statusValues.reverse[status],
        "time": time,
        "title": title,
        "tsunami": tsunami,
        "type": propertiesTypeValues.reverse[type],
        "types": types,
        "tz": tz,
        "updated": updated,
        "url": url,
    };
}

enum MagType {
    MD,
    ML,
    MB
}

final magTypeValues = EnumValues({
    "md": MagType.MD,
    "ml": MagType.ML,
    "mb": MagType.MB
});

enum Status {
    AUTOMATIC,
    REVIEWED
}

final statusValues = EnumValues({
    "automatic": Status.AUTOMATIC,
    "reviewed": Status.REVIEWED
});

enum PropertiesType {
    EARTHQUAKE
}

final propertiesTypeValues = EnumValues({
    "earthquake": PropertiesType.EARTHQUAKE
});

enum FeatureType {
    FEATURE
}

final featureTypeValues = EnumValues({
    "Feature": FeatureType.FEATURE
});

class Metadata {
    final String api;
    final int count;
    final int generated;
    final int status;
    final String title;
    final String url;

    Metadata({
        required this.api,
        required this.count,
        required this.generated,
        required this.status,
        required this.title,
        required this.url,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        api: json["api"],
        count: json["count"],
        generated: json["generated"],
        status: json["status"],
        title: json["title"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "api": api,
        "count": count,
        "generated": generated,
        "status": status,
        "title": title,
        "url": url,
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
