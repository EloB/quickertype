// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int anEasyOne;
    final bool isMnistLetter;
    final String jsonString;
    final bool prettyEasyToo;
    final String shouldKnowThatIdIsAnInitialism;
    final bool spacesAreSeparatorsToo;
    final bool zsrHhDemo3Delmatnr;

    TopLevel({
        required this.anEasyOne,
        required this.isMnistLetter,
        required this.jsonString,
        required this.prettyEasyToo,
        required this.shouldKnowThatIdIsAnInitialism,
        required this.spacesAreSeparatorsToo,
        required this.zsrHhDemo3Delmatnr,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        anEasyOne: json["anEasyOne"],
        isMnistLetter: json["isMNISTLetter"],
        jsonString: json["JSONString"],
        prettyEasyToo: json["PrettyEasyToo"],
        shouldKnowThatIdIsAnInitialism: json["should_know_that_id_is_an_initialism"],
        spacesAreSeparatorsToo: json["   spaces are separators  too  "],
        zsrHhDemo3Delmatnr: json["ZSR_HH_DEMO3_DELMATNR"],
    );

    Map<String, dynamic> toJson() => {
        "anEasyOne": anEasyOne,
        "isMNISTLetter": isMnistLetter,
        "JSONString": jsonString,
        "PrettyEasyToo": prettyEasyToo,
        "should_know_that_id_is_an_initialism": shouldKnowThatIdIsAnInitialism,
        "   spaces are separators  too  ": spacesAreSeparatorsToo,
        "ZSR_HH_DEMO3_DELMATNR": zsrHhDemo3Delmatnr,
    };
}
