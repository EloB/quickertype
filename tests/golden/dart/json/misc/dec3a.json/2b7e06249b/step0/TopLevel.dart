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
    final String aboutOffice;
    final String applicationProcess;
    final String body;
    final String changed;
    final String created;
    final dynamic deadline;
    final dynamic hiringOffice;
    final HiringOrg hiringOrg;
    final dynamic jobId;
    final String language;
    final Location location;
    final String numPositions;
    final String position;
    final String practiceArea;
    final String qualifications;
    final dynamic relocationExpenses;
    final String salary;
    final String title;
    final String travel;
    final String url;
    final String uuid;
    final String vuuid;

    Result({
        required this.aboutOffice,
        required this.applicationProcess,
        required this.body,
        required this.changed,
        required this.created,
        required this.deadline,
        required this.hiringOffice,
        required this.hiringOrg,
        required this.jobId,
        required this.language,
        required this.location,
        required this.numPositions,
        required this.position,
        required this.practiceArea,
        required this.qualifications,
        required this.relocationExpenses,
        required this.salary,
        required this.title,
        required this.travel,
        required this.url,
        required this.uuid,
        required this.vuuid,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        aboutOffice: json["about_office"],
        applicationProcess: json["application_process"],
        body: json["body"],
        changed: json["changed"],
        created: json["created"],
        deadline: (json.containsKey("deadline") ? json["deadline"] : throw FormatException('Missing required property')),
        hiringOffice: (json.containsKey("hiring_office") ? json["hiring_office"] : throw FormatException('Missing required property')),
        hiringOrg: HiringOrg.fromJson(json["hiring_org"]),
        jobId: (json.containsKey("job_id") ? json["job_id"] : throw FormatException('Missing required property')),
        language: json["language"],
        location: Location.fromJson(json["location"]),
        numPositions: json["num_positions"],
        position: json["position"],
        practiceArea: json["practice_area"],
        qualifications: json["qualifications"],
        relocationExpenses: (json.containsKey("relocation_expenses") ? json["relocation_expenses"] : throw FormatException('Missing required property')),
        salary: json["salary"],
        title: json["title"],
        travel: json["travel"],
        url: json["url"],
        uuid: ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(json["uuid"]),
        vuuid: ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(json["vuuid"]),
    );

    Map<String, dynamic> toJson() => {
        "about_office": aboutOffice,
        "application_process": applicationProcess,
        "body": body,
        "changed": changed,
        "created": created,
        "deadline": deadline,
        "hiring_office": hiringOffice,
        "hiring_org": hiringOrg.toJson(),
        "job_id": jobId,
        "language": language,
        "location": location.toJson(),
        "num_positions": numPositions,
        "position": position,
        "practice_area": practiceArea,
        "qualifications": qualifications,
        "relocation_expenses": relocationExpenses,
        "salary": salary,
        "title": title,
        "travel": travel,
        "url": url,
        "uuid": uuid,
        "vuuid": vuuid,
    };
}

class HiringOrg {
    final String name;
    final String uuid;

    HiringOrg({
        required this.name,
        required this.uuid,
    });

    factory HiringOrg.fromJson(Map<String, dynamic> json) => HiringOrg(
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
