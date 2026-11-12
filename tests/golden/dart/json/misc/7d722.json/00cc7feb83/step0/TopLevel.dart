// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String city;
    final String delay;
    final String iata;
    final String icao;
    final String name;
    final String state;
    final Status status;
    final Weather weather;

    TopLevel({
        required this.city,
        required this.delay,
        required this.iata,
        required this.icao,
        required this.name,
        required this.state,
        required this.status,
        required this.weather,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        city: json["city"],
        delay: json["delay"],
        iata: json["IATA"],
        icao: json["ICAO"],
        name: json["name"],
        state: json["state"],
        status: Status.fromJson(json["status"]),
        weather: Weather.fromJson(json["weather"]),
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "delay": delay,
        "IATA": iata,
        "ICAO": icao,
        "name": name,
        "state": state,
        "status": status.toJson(),
        "weather": weather.toJson(),
    };
}

class Status {
    final String avgDelay;
    final String closureBegin;
    final String closureEnd;
    final String endTime;
    final String maxDelay;
    final String minDelay;
    final String reason;
    final String trend;
    final String type;

    Status({
        required this.avgDelay,
        required this.closureBegin,
        required this.closureEnd,
        required this.endTime,
        required this.maxDelay,
        required this.minDelay,
        required this.reason,
        required this.trend,
        required this.type,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        avgDelay: json["avgDelay"],
        closureBegin: json["closureBegin"],
        closureEnd: json["closureEnd"],
        endTime: json["endTime"],
        maxDelay: json["maxDelay"],
        minDelay: json["minDelay"],
        reason: json["reason"],
        trend: json["trend"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "avgDelay": avgDelay,
        "closureBegin": closureBegin,
        "closureEnd": closureEnd,
        "endTime": endTime,
        "maxDelay": maxDelay,
        "minDelay": minDelay,
        "reason": reason,
        "trend": trend,
        "type": type,
    };
}

class Weather {
    final Meta meta;
    final String temp;
    final double visibility;
    final String weather;
    final String wind;

    Weather({
        required this.meta,
        required this.temp,
        required this.visibility,
        required this.weather,
        required this.wind,
    });

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        meta: Meta.fromJson(json["meta"]),
        temp: json["temp"],
        visibility: json["visibility"]?.toDouble(),
        weather: json["weather"],
        wind: json["wind"],
    );

    Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "temp": temp,
        "visibility": visibility,
        "weather": weather,
        "wind": wind,
    };
}

class Meta {
    final String credit;
    final String updated;
    final String url;

    Meta({
        required this.credit,
        required this.updated,
        required this.url,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        credit: json["credit"],
        updated: json["updated"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "credit": credit,
        "updated": updated,
        "url": url,
    };
}
