// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int count;
    final Facets facets;
    final int limit;
    final String next;
    final int offset;
    final bool previous;
    final List<Result> results;

    TopLevel({
        required this.count,
        required this.facets,
        required this.limit,
        required this.next,
        required this.offset,
        required this.previous,
        required this.results,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        count: json["count"],
        facets: Facets.fromJson(json["facets"]),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "facets": facets.toJson(),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Facets {
    Facets();

    factory Facets.fromJson(Map<String, dynamic> json) => Facets(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Result {
    final String? acronym;
    final String activityConsultCommittees;
    final String activityEuLegislative;
    final String activityExpertGroups;
    final String activityHighLevelGroups;
    final String activityIndustryForums;
    final String activityInterGroups;
    final String? activityOther;
    final String activityRelevantComm;
    final String? beOfficeCountry;
    final double? beOfficeLat;
    final double? beOfficeLon;
    final String? beOfficePhone;
    final String? beOfficePostCode;
    final String? beOfficePostbox;
    final String? beOfficeStreet;
    final String? beOfficeTown;
    final String codeOfConduct;
    final int contactCountry;
    final DateTime createdAt;
    final String entity;
    final String goals;
    final String head;
    final String headOfficeCountry;
    final double? headOfficeLat;
    final double? headOfficeLon;
    final String headOfficePhone;
    final String? headOfficePostCode;
    final String? headOfficePostbox;
    final String headOfficeStreet;
    final String headOfficeTown;
    final String id;
    final String identificationCode;
    final String infoMembers;
    final DateTime lastUpdateDate;
    final String legal;
    final String legalStatus;
    final int mainCategory;
    final String mainCategoryTitle;
    final int members;
    final int? members100;
    final int? members25;
    final int? members50;
    final int? members75;
    final double membersFte;
    final String name;
    final dynamic nativeName;
    final String? networking;
    final int? numberOfNaturalPersons;
    final String? otherCodeOfConduct;
    final DateTime registrationDate;
    final Status status;
    final String structureMembers;
    final int subCategory;
    final String subCategoryTitle;
    final DateTime updatedAt;
    final String uri;
    final String? webSiteUrl;

    Result({
        required this.acronym,
        required this.activityConsultCommittees,
        required this.activityEuLegislative,
        required this.activityExpertGroups,
        required this.activityHighLevelGroups,
        required this.activityIndustryForums,
        required this.activityInterGroups,
        required this.activityOther,
        required this.activityRelevantComm,
        this.beOfficeCountry,
        this.beOfficeLat,
        this.beOfficeLon,
        this.beOfficePhone,
        this.beOfficePostCode,
        this.beOfficePostbox,
        this.beOfficeStreet,
        this.beOfficeTown,
        required this.codeOfConduct,
        required this.contactCountry,
        required this.createdAt,
        required this.entity,
        required this.goals,
        required this.head,
        required this.headOfficeCountry,
        required this.headOfficeLat,
        required this.headOfficeLon,
        required this.headOfficePhone,
        required this.headOfficePostCode,
        required this.headOfficePostbox,
        required this.headOfficeStreet,
        required this.headOfficeTown,
        required this.id,
        required this.identificationCode,
        required this.infoMembers,
        required this.lastUpdateDate,
        required this.legal,
        required this.legalStatus,
        required this.mainCategory,
        required this.mainCategoryTitle,
        required this.members,
        required this.members100,
        required this.members25,
        required this.members50,
        required this.members75,
        required this.membersFte,
        required this.name,
        required this.nativeName,
        required this.networking,
        required this.numberOfNaturalPersons,
        required this.otherCodeOfConduct,
        required this.registrationDate,
        required this.status,
        required this.structureMembers,
        required this.subCategory,
        required this.subCategoryTitle,
        required this.updatedAt,
        required this.uri,
        required this.webSiteUrl,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        acronym: (json.containsKey("acronym") ? json["acronym"] : throw FormatException('Missing required property')),
        activityConsultCommittees: json["activity_consult_committees"],
        activityEuLegislative: json["activity_eu_legislative"],
        activityExpertGroups: json["activity_expert_groups"],
        activityHighLevelGroups: json["activity_high_level_groups"],
        activityIndustryForums: json["activity_industry_forums"],
        activityInterGroups: json["activity_inter_groups"],
        activityOther: (json.containsKey("activity_other") ? json["activity_other"] : throw FormatException('Missing required property')),
        activityRelevantComm: json["activity_relevant_comm"],
        beOfficeCountry: json["be_office_country"],
        beOfficeLat: json["be_office_lat"]?.toDouble(),
        beOfficeLon: json["be_office_lon"]?.toDouble(),
        beOfficePhone: json["be_office_phone"],
        beOfficePostCode: json["be_office_post_code"],
        beOfficePostbox: json["be_office_postbox"],
        beOfficeStreet: json["be_office_street"],
        beOfficeTown: json["be_office_town"],
        codeOfConduct: json["code_of_conduct"],
        contactCountry: json["contact_country"],
        createdAt: DateTime.parse(json["created_at"]),
        entity: json["entity"],
        goals: json["goals"],
        head: json["head"],
        headOfficeCountry: json["head_office_country"],
        headOfficeLat: (json.containsKey("head_office_lat") ? json["head_office_lat"] : throw FormatException('Missing required property'))?.toDouble(),
        headOfficeLon: (json.containsKey("head_office_lon") ? json["head_office_lon"] : throw FormatException('Missing required property'))?.toDouble(),
        headOfficePhone: json["head_office_phone"],
        headOfficePostCode: (json.containsKey("head_office_post_code") ? json["head_office_post_code"] : throw FormatException('Missing required property')),
        headOfficePostbox: (json.containsKey("head_office_postbox") ? json["head_office_postbox"] : throw FormatException('Missing required property')),
        headOfficeStreet: json["head_office_street"],
        headOfficeTown: json["head_office_town"],
        id: json["id"],
        identificationCode: json["identification_code"],
        infoMembers: json["info_members"],
        lastUpdateDate: DateTime.parse(json["last_update_date"]),
        legal: json["legal"],
        legalStatus: json["legal_status"],
        mainCategory: json["main_category"],
        mainCategoryTitle: json["main_category_title"],
        members: json["members"],
        members100: (json.containsKey("members_100") ? json["members_100"] : throw FormatException('Missing required property')),
        members25: (json.containsKey("members_25") ? json["members_25"] : throw FormatException('Missing required property')),
        members50: (json.containsKey("members_50") ? json["members_50"] : throw FormatException('Missing required property')),
        members75: (json.containsKey("members_75") ? json["members_75"] : throw FormatException('Missing required property')),
        membersFte: json["members_fte"]?.toDouble(),
        name: json["name"],
        nativeName: (json.containsKey("native_name") ? json["native_name"] : throw FormatException('Missing required property')),
        networking: (json.containsKey("networking") ? json["networking"] : throw FormatException('Missing required property')),
        numberOfNaturalPersons: (json.containsKey("number_of_natural_persons") ? json["number_of_natural_persons"] : throw FormatException('Missing required property')),
        otherCodeOfConduct: (json.containsKey("other_code_of_conduct") ? json["other_code_of_conduct"] : throw FormatException('Missing required property')),
        registrationDate: DateTime.parse(json["registration_date"]),
        status: statusValues.map[json["status"]]!,
        structureMembers: json["structure_members"],
        subCategory: json["sub_category"],
        subCategoryTitle: json["sub_category_title"],
        updatedAt: DateTime.parse(json["updated_at"]),
        uri: json["uri"],
        webSiteUrl: (json.containsKey("web_site_url") ? json["web_site_url"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "acronym": acronym,
        "activity_consult_committees": activityConsultCommittees,
        "activity_eu_legislative": activityEuLegislative,
        "activity_expert_groups": activityExpertGroups,
        "activity_high_level_groups": activityHighLevelGroups,
        "activity_industry_forums": activityIndustryForums,
        "activity_inter_groups": activityInterGroups,
        "activity_other": activityOther,
        "activity_relevant_comm": activityRelevantComm,
        "be_office_country": beOfficeCountry,
        "be_office_lat": beOfficeLat,
        "be_office_lon": beOfficeLon,
        "be_office_phone": beOfficePhone,
        "be_office_post_code": beOfficePostCode,
        "be_office_postbox": beOfficePostbox,
        "be_office_street": beOfficeStreet,
        "be_office_town": beOfficeTown,
        "code_of_conduct": codeOfConduct,
        "contact_country": contactCountry,
        "created_at": createdAt.toIso8601String(),
        "entity": entity,
        "goals": goals,
        "head": head,
        "head_office_country": headOfficeCountry,
        "head_office_lat": headOfficeLat,
        "head_office_lon": headOfficeLon,
        "head_office_phone": headOfficePhone,
        "head_office_post_code": headOfficePostCode,
        "head_office_postbox": headOfficePostbox,
        "head_office_street": headOfficeStreet,
        "head_office_town": headOfficeTown,
        "id": id,
        "identification_code": identificationCode,
        "info_members": infoMembers,
        "last_update_date": lastUpdateDate.toIso8601String(),
        "legal": legal,
        "legal_status": legalStatus,
        "main_category": mainCategory,
        "main_category_title": mainCategoryTitle,
        "members": members,
        "members_100": members100,
        "members_25": members25,
        "members_50": members50,
        "members_75": members75,
        "members_fte": membersFte,
        "name": name,
        "native_name": nativeName,
        "networking": networking,
        "number_of_natural_persons": numberOfNaturalPersons,
        "other_code_of_conduct": otherCodeOfConduct,
        "registration_date": registrationDate.toIso8601String(),
        "status": statusValues.reverse[status],
        "structure_members": structureMembers,
        "sub_category": subCategory,
        "sub_category_title": subCategoryTitle,
        "updated_at": updatedAt.toIso8601String(),
        "uri": uri,
        "web_site_url": webSiteUrl,
    };
}

enum Status {
    ACTIVE,
    INACTIVE
}

final statusValues = EnumValues({
    "active": Status.ACTIVE,
    "inactive": Status.INACTIVE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
