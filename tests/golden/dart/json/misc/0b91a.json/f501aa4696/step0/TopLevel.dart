// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Metadata metadata;
    final List<Result> results;

    TopLevel({
        required this.metadata,
        required this.results,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        metadata: Metadata.fromJson(json["metadata"]),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Metadata {
    final double executionTime;
    final ResponseInfo responseInfo;
    final Resultset resultset;

    Metadata({
        required this.executionTime,
        required this.responseInfo,
        required this.resultset,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        executionTime: json["executionTime"]?.toDouble(),
        responseInfo: ResponseInfo.fromJson(json["responseInfo"]),
        resultset: Resultset.fromJson(json["resultset"]),
    );

    Map<String, dynamic> toJson() => {
        "executionTime": executionTime,
        "responseInfo": responseInfo.toJson(),
        "resultset": resultset.toJson(),
    };
}

class ResponseInfo {
    final String developerMessage;
    final int status;

    ResponseInfo({
        required this.developerMessage,
        required this.status,
    });

    factory ResponseInfo.fromJson(Map<String, dynamic> json) => ResponseInfo(
        developerMessage: json["developerMessage"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "developerMessage": developerMessage,
        "status": status,
    };
}

class Resultset {
    final int count;
    final int page;
    final int pagesize;

    Resultset({
        required this.count,
        required this.page,
        required this.pagesize,
    });

    factory Resultset.fromJson(Map<String, dynamic> json) => Resultset(
        count: json["count"],
        page: json["page"],
        pagesize: json["pagesize"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "page": page,
        "pagesize": pagesize,
    };
}

class Result {
    final List<dynamic> attachment;
    final String body;
    final String changed;
    final List<Component> component;
    final String created;
    final String date;
    final List<dynamic> image;
    final dynamic number;
    final dynamic teaser;
    final String title;
    final List<dynamic> topic;
    final String url;
    final String uuid;
    final String vuuid;

    Result({
        required this.attachment,
        required this.body,
        required this.changed,
        required this.component,
        required this.created,
        required this.date,
        required this.image,
        required this.number,
        required this.teaser,
        required this.title,
        required this.topic,
        required this.url,
        required this.uuid,
        required this.vuuid,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        attachment: List<dynamic>.from(json["attachment"].map((x) => x)),
        body: json["body"],
        changed: json["changed"],
        component: List<Component>.from(json["component"].map((x) => Component.fromJson(x))),
        created: json["created"],
        date: json["date"],
        image: List<dynamic>.from(json["image"].map((x) => x)),
        number: (json.containsKey("number") ? json["number"] : throw FormatException('Missing required property')),
        teaser: (json.containsKey("teaser") ? json["teaser"] : throw FormatException('Missing required property')),
        title: json["title"],
        topic: List<dynamic>.from(json["topic"].map((x) => x)),
        url: json["url"],
        uuid: ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(json["uuid"]),
        vuuid: ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(json["vuuid"]),
    );

    Map<String, dynamic> toJson() => {
        "attachment": List<dynamic>.from(attachment.map((x) => x)),
        "body": body,
        "changed": changed,
        "component": List<dynamic>.from(component.map((x) => x.toJson())),
        "created": created,
        "date": date,
        "image": List<dynamic>.from(image.map((x) => x)),
        "number": number,
        "teaser": teaser,
        "title": title,
        "topic": List<dynamic>.from(topic.map((x) => x)),
        "url": url,
        "uuid": uuid,
        "vuuid": vuuid,
    };
}

class Component {
    final String name;
    final String uuid;

    Component({
        required this.name,
        required this.uuid,
    });

    factory Component.fromJson(Map<String, dynamic> json) => Component(
        name: json["name"],
        uuid: ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(json["uuid"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "uuid": uuid,
    };
}
