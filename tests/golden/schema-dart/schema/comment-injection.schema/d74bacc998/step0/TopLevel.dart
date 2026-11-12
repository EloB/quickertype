// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());


///Comment delimiters:
///*/
////*
///{-
///-}
///"""
///</summary> & <br>
///}
///}
///}
///}
///}
class TopLevel {
    
    ///Ends with a backslash \
    final String? trailingBackslash;
    
    ///Ends with a quote "
    final String? trailingQuote;
    
    ///Ends with a triple quote """
    final String? trailingTripleQuote;
    
    ///Property delimiters:
    ///*/
    ////*
    ///{-
    ///-}
    ///"""
    ///</summary> & <br>
    ///}
    ///}
    ///}
    ///}
    ///}
    final String value;

    TopLevel({
        this.trailingBackslash,
        this.trailingQuote,
        this.trailingTripleQuote,
        required this.value,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        trailingBackslash: json["trailingBackslash"],
        trailingQuote: json["trailingQuote"],
        trailingTripleQuote: json["trailingTripleQuote"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "trailingBackslash": trailingBackslash,
        "trailingQuote": trailingQuote,
        "trailingTripleQuote": trailingTripleQuote,
        "value": value,
    };
}
