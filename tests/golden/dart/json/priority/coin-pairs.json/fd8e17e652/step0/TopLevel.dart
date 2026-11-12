// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Map<String, Pair> pairs;
    final int serverTime;

    TopLevel({
        required this.pairs,
        required this.serverTime,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        pairs: Map.from(json["pairs"]).map((k, v) => MapEntry<String, Pair>(k, Pair.fromJson(v))),
        serverTime: json["server_time"],
    );

    Map<String, dynamic> toJson() => {
        "pairs": Map.from(pairs).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "server_time": serverTime,
    };
}

class Pair {
    final int decimalPlaces;
    final double fee;
    final int hidden;
    final int maxAmount;
    final int maxPrice;
    final double minAmount;
    final double minPrice;
    final double minTotal;

    Pair({
        required this.decimalPlaces,
        required this.fee,
        required this.hidden,
        required this.maxAmount,
        required this.maxPrice,
        required this.minAmount,
        required this.minPrice,
        required this.minTotal,
    });

    factory Pair.fromJson(Map<String, dynamic> json) => Pair(
        decimalPlaces: json["decimal_places"],
        fee: json["fee"]?.toDouble(),
        hidden: json["hidden"],
        maxAmount: json["max_amount"],
        maxPrice: json["max_price"],
        minAmount: json["min_amount"]?.toDouble(),
        minPrice: json["min_price"]?.toDouble(),
        minTotal: json["min_total"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "decimal_places": decimalPlaces,
        "fee": fee,
        "hidden": hidden,
        "max_amount": maxAmount,
        "max_price": maxPrice,
        "min_amount": minAmount,
        "min_price": minPrice,
        "min_total": minTotal,
    };
}
