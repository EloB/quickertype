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
    final List<List<List<List<double>>>> coordinates;
    final GeometryType type;

    Geometry({
        required this.coordinates,
        required this.type,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<List<List<List<double>>>>.from(json["coordinates"].map((x) => List<List<List<double>>>.from(x.map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x?.toDouble())))))))),
        type: geometryTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))))),
        "type": geometryTypeValues.reverse[type],
    };
}

enum GeometryType {
    MULTI_POLYGON
}

final geometryTypeValues = EnumValues({
    "MultiPolygon": GeometryType.MULTI_POLYGON
});

enum GeometryName {
    GEOM
}

final geometryNameValues = EnumValues({
    "geom": GeometryName.GEOM
});

class FeatureProperties {
    final AddImprov? addImprov;
    final double area;
    final String assetNumb;
    final String? comments;
    final int condition;
    final String? constructi;
    final dynamic createdate;
    final dynamic createuser;
    final dynamic disposalD;
    final String documents;
    final String? drawingNu;
    final String? fileNumbe;
    final String? folderNum;
    final FundingBa? fundingBa;
    final int historicC;
    final String inspection;
    final dynamic inspectors;
    final dynamic lastUpdat;
    final LevelAccu? levelAccu;
    final Material material;
    final int miPrinx;
    final MiSymbolo miSymbolo;
    final int numberLan;
    final String? owner;
    final LevelAccu? positional;
    final String? projectNu;
    final int recId;
    final String? recordCre;
    final double shapeArea;
    final double shapeLeng;
    final Status status;
    final dynamic surveyNum;
    final double toeRl;
    final double topRl;
    final PropertiesType? type;
    final String updateDat;
    final dynamic updatedate;
    final dynamic updateuser;

    FeatureProperties({
        required this.addImprov,
        required this.area,
        required this.assetNumb,
        required this.comments,
        required this.condition,
        required this.constructi,
        required this.createdate,
        required this.createuser,
        required this.disposalD,
        required this.documents,
        required this.drawingNu,
        required this.fileNumbe,
        required this.folderNum,
        required this.fundingBa,
        required this.historicC,
        required this.inspection,
        required this.inspectors,
        required this.lastUpdat,
        required this.levelAccu,
        required this.material,
        required this.miPrinx,
        required this.miSymbolo,
        required this.numberLan,
        required this.owner,
        required this.positional,
        required this.projectNu,
        required this.recId,
        required this.recordCre,
        required this.shapeArea,
        required this.shapeLeng,
        required this.status,
        required this.surveyNum,
        required this.toeRl,
        required this.topRl,
        required this.type,
        required this.updateDat,
        required this.updatedate,
        required this.updateuser,
    });

    factory FeatureProperties.fromJson(Map<String, dynamic> json) => FeatureProperties(
        addImprov: (json.containsKey("add_improv") ? json["add_improv"] : throw FormatException('Missing required property')) == null ? null : addImprovValues.map[(json.containsKey("add_improv") ? json["add_improv"] : throw FormatException('Missing required property'))]!,
        area: json["area_"]?.toDouble(),
        assetNumb: json["asset_numb"],
        comments: (json.containsKey("comments") ? json["comments"] : throw FormatException('Missing required property')),
        condition: json["condition"],
        constructi: (json.containsKey("constructi") ? json["constructi"] : throw FormatException('Missing required property')),
        createdate: (json.containsKey("createdate") ? json["createdate"] : throw FormatException('Missing required property')),
        createuser: (json.containsKey("createuser") ? json["createuser"] : throw FormatException('Missing required property')),
        disposalD: (json.containsKey("disposal_d") ? json["disposal_d"] : throw FormatException('Missing required property')),
        documents: json["documents"],
        drawingNu: (json.containsKey("drawing_nu") ? json["drawing_nu"] : throw FormatException('Missing required property')),
        fileNumbe: (json.containsKey("file_numbe") ? json["file_numbe"] : throw FormatException('Missing required property')),
        folderNum: (json.containsKey("folder_num") ? json["folder_num"] : throw FormatException('Missing required property')),
        fundingBa: (json.containsKey("funding_ba") ? json["funding_ba"] : throw FormatException('Missing required property')) == null ? null : fundingBaValues.map[(json.containsKey("funding_ba") ? json["funding_ba"] : throw FormatException('Missing required property'))]!,
        historicC: json["historic_c"],
        inspection: json["inspection"],
        inspectors: (json.containsKey("inspectors") ? json["inspectors"] : throw FormatException('Missing required property')),
        lastUpdat: (json.containsKey("last_updat") ? json["last_updat"] : throw FormatException('Missing required property')),
        levelAccu: (json.containsKey("level_accu") ? json["level_accu"] : throw FormatException('Missing required property')) == null ? null : levelAccuValues.map[(json.containsKey("level_accu") ? json["level_accu"] : throw FormatException('Missing required property'))]!,
        material: materialValues.map[json["material"]]!,
        miPrinx: json["mi_prinx"],
        miSymbolo: miSymboloValues.map[json["mi_symbolo"]]!,
        numberLan: json["number_lan"],
        owner: (json.containsKey("owner") ? json["owner"] : throw FormatException('Missing required property')),
        positional: (json.containsKey("positional") ? json["positional"] : throw FormatException('Missing required property')) == null ? null : levelAccuValues.map[(json.containsKey("positional") ? json["positional"] : throw FormatException('Missing required property'))]!,
        projectNu: (json.containsKey("project_nu") ? json["project_nu"] : throw FormatException('Missing required property')),
        recId: json["rec_id"],
        recordCre: (json.containsKey("record_cre") ? json["record_cre"] : throw FormatException('Missing required property')),
        shapeArea: json["shape_area"]?.toDouble(),
        shapeLeng: json["shape_leng"]?.toDouble(),
        status: statusValues.map[json["status"]]!,
        surveyNum: (json.containsKey("survey_num") ? json["survey_num"] : throw FormatException('Missing required property')),
        toeRl: json["toe_rl"]?.toDouble(),
        topRl: json["top_rl"]?.toDouble(),
        type: (json.containsKey("type") ? json["type"] : throw FormatException('Missing required property')) == null ? null : propertiesTypeValues.map[(json.containsKey("type") ? json["type"] : throw FormatException('Missing required property'))]!,
        updateDat: json["update_dat"],
        updatedate: (json.containsKey("updatedate") ? json["updatedate"] : throw FormatException('Missing required property')),
        updateuser: (json.containsKey("updateuser") ? json["updateuser"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "add_improv": addImprovValues.reverse[addImprov],
        "area_": area,
        "asset_numb": assetNumb,
        "comments": comments,
        "condition": condition,
        "constructi": constructi,
        "createdate": createdate,
        "createuser": createuser,
        "disposal_d": disposalD,
        "documents": documents,
        "drawing_nu": drawingNu,
        "file_numbe": fileNumbe,
        "folder_num": folderNum,
        "funding_ba": fundingBaValues.reverse[fundingBa],
        "historic_c": historicC,
        "inspection": inspection,
        "inspectors": inspectors,
        "last_updat": lastUpdat,
        "level_accu": levelAccuValues.reverse[levelAccu],
        "material": materialValues.reverse[material],
        "mi_prinx": miPrinx,
        "mi_symbolo": miSymboloValues.reverse[miSymbolo],
        "number_lan": numberLan,
        "owner": owner,
        "positional": levelAccuValues.reverse[positional],
        "project_nu": projectNu,
        "rec_id": recId,
        "record_cre": recordCre,
        "shape_area": shapeArea,
        "shape_leng": shapeLeng,
        "status": statusValues.reverse[status],
        "survey_num": surveyNum,
        "toe_rl": toeRl,
        "top_rl": topRl,
        "type": propertiesTypeValues.reverse[type],
        "update_dat": updateDat,
        "updatedate": updatedate,
        "updateuser": updateuser,
    };
}

enum AddImprov {
    F,
    ADD_IMPROV_F,
    T
}

final addImprovValues = EnumValues({
    "f": AddImprov.F,
    "F": AddImprov.ADD_IMPROV_F,
    "t": AddImprov.T
});

enum FundingBa {
    NON_GCCC,
    CAPEX,
    INITIAL,
    CONTRIBUTE
}

final fundingBaValues = EnumValues({
    "Non GCCC": FundingBa.NON_GCCC,
    "Capex": FundingBa.CAPEX,
    "Initial": FundingBa.INITIAL,
    "Contribute": FundingBa.CONTRIBUTE
});

enum LevelAccu {
    GPS_CORRECTED_10_M,
    APPROX,
    GPS_C_ORRECTED_10_M
}

final levelAccuValues = EnumValues({
    "GPS Corrected 1.0M": LevelAccu.GPS_CORRECTED_10_M,
    "APPROX": LevelAccu.APPROX,
    "GPS COrrected 1.0M": LevelAccu.GPS_C_ORRECTED_10_M
});

enum Material {
    GRAVEL,
    CONCRETE,
    BITUMEN,
    INTERLOCK_CONC_BLOCK,
    OTHER,
    EARTH
}

final materialValues = EnumValues({
    "Gravel": Material.GRAVEL,
    "Concrete": Material.CONCRETE,
    "Bitumen": Material.BITUMEN,
    "Interlock Conc Block": Material.INTERLOCK_CONC_BLOCK,
    "Other": Material.OTHER,
    "Earth": Material.EARTH
});

enum MiSymbolo {
    PEN_2265535_BRUSH_1016777215
}

final miSymboloValues = EnumValues({
    "Pen (2, 2, 65535) Brush (1, 0, 16777215)": MiSymbolo.PEN_2265535_BRUSH_1016777215
});

enum Status {
    CURRENT
}

final statusValues = EnumValues({
    "CURRENT": Status.CURRENT
});

enum PropertiesType {
    BOAT_RAMP
}

final propertiesTypeValues = EnumValues({
    "Boat Ramp": PropertiesType.BOAT_RAMP
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
