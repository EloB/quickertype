// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<int> maxOnly;
    final List<double> minAndMax;
    final List<String> minOnly;
    final List<String> plain;
    final List<dynamic> unionItems;

    TopLevel({
        required this.maxOnly,
        required this.minAndMax,
        required this.minOnly,
        required this.plain,
        required this.unionItems,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        maxOnly: (() { final x = List<int>.from(json["maxOnly"].map((x) => x)); if (x.length > 3) throw FormatException('Invalid array length'); return x; })(),
        minAndMax: (() { final x = List<double>.from(json["minAndMax"].map((x) => x?.toDouble())); if (x.length < 1 || x.length > 4) throw FormatException('Invalid array length'); return x; })(),
        minOnly: (() { final x = List<String>.from(json["minOnly"].map((x) => x)); if (x.length < 2) throw FormatException('Invalid array length'); return x; })(),
        plain: List<String>.from(json["plain"].map((x) => x)),
        unionItems: (() { final x = List<dynamic>.from(json["unionItems"].map((x) => x)); if (x.length < 2) throw FormatException('Invalid array length'); return x; })(),
    );

    Map<String, dynamic> toJson() => {
        "maxOnly": List<dynamic>.from(maxOnly.map((x) => x)),
        "minAndMax": List<dynamic>.from(minAndMax.map((x) => x)),
        "minOnly": List<dynamic>.from(minOnly.map((x) => x)),
        "plain": List<dynamic>.from(plain.map((x) => x)),
        "unionItems": List<dynamic>.from(unionItems.map((x) => x)),
    };
}
