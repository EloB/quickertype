// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Args args;
    final String data;
    final Args files;
    final Args form;
    final Headers headers;
    final String origin;
    final String url;

    TopLevel({
        required this.args,
        required this.data,
        required this.files,
        required this.form,
        required this.headers,
        required this.origin,
        required this.url,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        args: Args.fromJson(json["args"]),
        data: json["data"],
        files: Args.fromJson(json["files"]),
        form: Args.fromJson(json["form"]),
        headers: Headers.fromJson(json["headers"]),
        origin: json["origin"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "args": args.toJson(),
        "data": data,
        "files": files.toJson(),
        "form": form.toJson(),
        "headers": headers.toJson(),
        "origin": origin,
        "url": url,
    };
}

class Args {
    Args();

    factory Args.fromJson(Map<String, dynamic> json) => Args(
    );

    Map<String, dynamic> toJson() => {
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
