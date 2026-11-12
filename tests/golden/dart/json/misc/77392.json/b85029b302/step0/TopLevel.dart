// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final String designation;
    final DateTime discoveryDate;
    final String? hMag;
    final String iDeg;
    final String moidAu;
    final OrbitClass orbitClass;
    final String? periodYr;
    final Pha pha;
    final String qAu1;
    final String? qAu2;

    TopLevel({
        required this.designation,
        required this.discoveryDate,
        this.hMag,
        required this.iDeg,
        required this.moidAu,
        required this.orbitClass,
        this.periodYr,
        required this.pha,
        required this.qAu1,
        this.qAu2,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        designation: json["designation"],
        discoveryDate: DateTime.parse(json["discovery_date"]),
        hMag: json["h_mag"],
        iDeg: json["i_deg"],
        moidAu: json["moid_au"],
        orbitClass: orbitClassValues.map[json["orbit_class"]]!,
        periodYr: json["period_yr"],
        pha: phaValues.map[json["pha"]]!,
        qAu1: json["q_au_1"],
        qAu2: json["q_au_2"],
    );

    Map<String, dynamic> toJson() => {
        "designation": designation,
        "discovery_date": discoveryDate.toIso8601String(),
        "h_mag": hMag,
        "i_deg": iDeg,
        "moid_au": moidAu,
        "orbit_class": orbitClassValues.reverse[orbitClass],
        "period_yr": periodYr,
        "pha": phaValues.reverse[pha],
        "q_au_1": qAu1,
        "q_au_2": qAu2,
    };
}

enum OrbitClass {
    APOLLO,
    AMOR,
    ATEN,
    COMET,
    JUPITER_FAMILY_COMET,
    HALLEY_TYPE_COMET,
    PARABOLIC_COMET,
    ORBIT_CLASS_JUPITER_FAMILY_COMET,
    ENCKE_TYPE_COMET
}

final orbitClassValues = EnumValues({
    "Apollo": OrbitClass.APOLLO,
    "Amor": OrbitClass.AMOR,
    "Aten": OrbitClass.ATEN,
    "Comet": OrbitClass.COMET,
    "Jupiter-family Comet": OrbitClass.JUPITER_FAMILY_COMET,
    "Halley-type Comet*": OrbitClass.HALLEY_TYPE_COMET,
    "Parabolic Comet": OrbitClass.PARABOLIC_COMET,
    "Jupiter-family Comet*": OrbitClass.ORBIT_CLASS_JUPITER_FAMILY_COMET,
    "Encke-type Comet": OrbitClass.ENCKE_TYPE_COMET
});

enum Pha {
    Y,
    N,
    N_A
}

final phaValues = EnumValues({
    "Y": Pha.Y,
    "N": Pha.N,
    "n/a": Pha.N_A
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
