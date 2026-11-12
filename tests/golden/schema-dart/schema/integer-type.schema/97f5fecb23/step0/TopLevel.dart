// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int aboveI32Max;
    final int belowI32Min;
    final int i32Range;
    final int largeBounds;
    final int onlyMaximum;
    final int onlyMinimum;
    final int smallNegative;
    final int smallPositive;
    final int unbounded;

    TopLevel({
        required this.aboveI32Max,
        required this.belowI32Min,
        required this.i32Range,
        required this.largeBounds,
        required this.onlyMaximum,
        required this.onlyMinimum,
        required this.smallNegative,
        required this.smallPositive,
        required this.unbounded,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        aboveI32Max: ((x) => x >= 0 && x <= 2147483648 ? x : throw FormatException("Expected bounded number"))(json["above_i32_max"]),
        belowI32Min: ((x) => x >= -2147483649 && x <= 0 ? x : throw FormatException("Expected bounded number"))(json["below_i32_min"]),
        i32Range: ((x) => x >= -2147483648 && x <= 2147483647 ? x : throw FormatException("Expected bounded number"))(json["i32_range"]),
        largeBounds: ((x) => x >= -9007199254740991 && x <= 9007199254740991 ? x : throw FormatException("Expected bounded number"))(json["large_bounds"]),
        onlyMaximum: ((x) => true && x <= 0 ? x : throw FormatException("Expected bounded number"))(json["only_maximum"]),
        onlyMinimum: ((x) => x >= 0 && true ? x : throw FormatException("Expected bounded number"))(json["only_minimum"]),
        smallNegative: ((x) => x >= -100 && x <= 0 ? x : throw FormatException("Expected bounded number"))(json["small_negative"]),
        smallPositive: ((x) => x >= 0 && x <= 100 ? x : throw FormatException("Expected bounded number"))(json["small_positive"]),
        unbounded: json["unbounded"],
    );

    Map<String, dynamic> toJson() => {
        "above_i32_max": aboveI32Max,
        "below_i32_min": belowI32Min,
        "i32_range": i32Range,
        "large_bounds": largeBounds,
        "only_maximum": onlyMaximum,
        "only_minimum": onlyMinimum,
        "small_negative": smallNegative,
        "small_positive": smallPositive,
        "unbounded": unbounded,
    };
}
