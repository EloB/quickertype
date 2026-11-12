// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String pattern1;
    final String pattern2;
    final RegExpClass? regExp;
    final String union;

    TopLevel({
        required this.pattern1,
        required this.pattern2,
        this.regExp,
        required this.union,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        pattern1: ((x) => RegExp("a[.]*").hasMatch(x) ? x : throw FormatException("Expected matching string"))(json["pattern1"]),
        pattern2: ((x) => RegExp("b[.]*").hasMatch(x) ? x : throw FormatException("Expected matching string"))(json["pattern2"]),
        regExp: json["RegExp"] == null ? null : RegExpClass.fromJson(json["RegExp"]),
        union: ((x) => RegExp("(b[.]*)|(c[.]*)").hasMatch(x) ? x : throw FormatException("Expected matching string"))(json["union"]),
    );

    Map<String, dynamic> toJson() => {
        "pattern1": pattern1,
        "pattern2": pattern2,
        "RegExp": regExp?.toJson(),
        "union": union,
    };
}

class RegExpClass {
    final String pattern3;

    RegExpClass({
        required this.pattern3,
    });

    factory RegExpClass.fromJson(Map<String, dynamic> json) => RegExpClass(
        pattern3: ((x) => RegExp("d[.]*").hasMatch(x) ? x : throw FormatException("Expected matching string"))(json["pattern3"]),
    );

    Map<String, dynamic> toJson() => {
        "pattern3": pattern3,
    };
}
