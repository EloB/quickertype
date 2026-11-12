// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Pc pc;
    final Pc ps3;
    final Pc ps4;
    final Pc xbox;
    final Pc xone;

    TopLevel({
        required this.pc,
        required this.ps3,
        required this.ps4,
        required this.xbox,
        required this.xone,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        pc: Pc.fromJson(json["pc"]),
        ps3: Pc.fromJson(json["ps3"]),
        ps4: Pc.fromJson(json["ps4"]),
        xbox: Pc.fromJson(json["xbox"]),
        xone: Pc.fromJson(json["xone"]),
    );

    Map<String, dynamic> toJson() => {
        "pc": pc.toJson(),
        "ps3": ps3.toJson(),
        "ps4": ps4.toJson(),
        "xbox": xbox.toJson(),
        "xone": xone.toJson(),
    };
}

class Pc {
    final int count;
    final String label;
    final int peak24;

    Pc({
        required this.count,
        required this.label,
        required this.peak24,
    });

    factory Pc.fromJson(Map<String, dynamic> json) => Pc(
        count: json["count"],
        label: json["label"],
        peak24: json["peak24"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "label": label,
        "peak24": peak24,
    };
}
