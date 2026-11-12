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
    final Location location;
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
        required this.location,
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
        location: Location.fromJson(json["location"]),
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
        "location": location.toJson(),
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

class Location {
    final String administrativeArea;
    final String country;
    final String faxNumber;
    final String locality;
    final String mobileNumber;
    final String phoneNumber;
    final String phoneNumberExtension;
    final String postalCode;
    final dynamic subPremise;
    final String thoroughfare;

    Location({
        required this.administrativeArea,
        required this.country,
        required this.faxNumber,
        required this.locality,
        required this.mobileNumber,
        required this.phoneNumber,
        required this.phoneNumberExtension,
        required this.postalCode,
        required this.subPremise,
        required this.thoroughfare,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        administrativeArea: json["administrative_area"],
        country: json["country"],
        faxNumber: json["fax_number"],
        locality: json["locality"],
        mobileNumber: json["mobile_number"],
        phoneNumber: json["phone_number"],
        phoneNumberExtension: json["phone_number_extension"],
        postalCode: json["postal_code"],
        subPremise: (json.containsKey("sub_premise") ? json["sub_premise"] : throw FormatException('Missing required property')),
        thoroughfare: json["thoroughfare"],
    );

    Map<String, dynamic> toJson() => {
        "administrative_area": administrativeArea,
        "country": country,
        "fax_number": faxNumber,
        "locality": locality,
        "mobile_number": mobileNumber,
        "phone_number": phoneNumber,
        "phone_number_extension": phoneNumberExtension,
        "postal_code": postalCode,
        "sub_premise": subPremise,
        "thoroughfare": thoroughfare,
    };
}
