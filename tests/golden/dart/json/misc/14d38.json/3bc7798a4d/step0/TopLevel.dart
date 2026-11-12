// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Headers headers;

    TopLevel({
        required this.headers,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        headers: Headers.fromJson(json["headers"]),
    );

    Map<String, dynamic> toJson() => {
        "headers": headers.toJson(),
    };
}

class Headers {
    final String acceptEncoding;
    final String connection;
    final String host;
    final String userAgent;

    Headers({
        required this.acceptEncoding,
        required this.connection,
        required this.host,
        required this.userAgent,
    });

    factory Headers.fromJson(Map<String, dynamic> json) => Headers(
        acceptEncoding: json["Accept-Encoding"],
        connection: json["Connection"],
        host: json["Host"],
        userAgent: json["User-Agent"],
    );

    Map<String, dynamic> toJson() => {
        "Accept-Encoding": acceptEncoding,
        "Connection": connection,
        "Host": host,
        "User-Agent": userAgent,
    };
}
