// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<dynamic> message;
    final int responseTime;
    final Results results;
    final String status;

    TopLevel({
        required this.message,
        required this.responseTime,
        required this.results,
        required this.status,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        message: List<dynamic>.from(json["message"].map((x) => x)),
        responseTime: json["responseTime"],
        results: Results.fromJson(json["Results"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message.map((x) => x)),
        "responseTime": responseTime,
        "Results": results.toJson(),
        "status": status,
    };
}

class Results {
    final List<Series> series;

    Results({
        required this.series,
    });

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        series: List<Series>.from(json["series"].map((x) => Series.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "series": List<dynamic>.from(series.map((x) => x.toJson())),
    };
}

class Series {
    final List<Datum> data;
    final String seriesId;

    Series({
        required this.data,
        required this.seriesId,
    });

    factory Series.fromJson(Map<String, dynamic> json) => Series(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        seriesId: json["seriesID"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "seriesID": seriesId,
    };
}

class Datum {
    final List<Footnote> footnotes;
    final String period;
    final String periodName;
    final String value;
    final String year;

    Datum({
        required this.footnotes,
        required this.period,
        required this.periodName,
        required this.value,
        required this.year,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        footnotes: List<Footnote>.from(json["footnotes"].map((x) => Footnote.fromJson(x))),
        period: json["period"],
        periodName: json["periodName"],
        value: json["value"],
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "footnotes": List<dynamic>.from(footnotes.map((x) => x.toJson())),
        "period": period,
        "periodName": periodName,
        "value": value,
        "year": year,
    };
}

class Footnote {
    final String? code;
    final String? text;

    Footnote({
        this.code,
        this.text,
    });

    factory Footnote.fromJson(Map<String, dynamic> json) => Footnote(
        code: json["code"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "text": text,
    };
}
