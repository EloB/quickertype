// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Meta meta;
    final List<Object> objects;

    TopLevel({
        required this.meta,
        required this.objects,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        meta: Meta.fromJson(json["meta"]),
        objects: List<Object>.from(json["objects"].map((x) => Object.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "objects": List<dynamic>.from(objects.map((x) => x.toJson())),
    };
}

class Meta {
    final int limit;
    final int offset;
    final int totalCount;

    Meta({
        required this.limit,
        required this.offset,
        required this.totalCount,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        limit: json["limit"],
        offset: json["offset"],
        totalCount: json["total_count"],
    );

    Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "total_count": totalCount,
    };
}

class Object {
    final Party? caucus;
    final List<int> congressNumbers;
    final bool current;
    final String description;
    final dynamic district;
    final DateTime enddate;
    final Extra extra;
    final int id;
    final String? leadershipTitle;
    final Party party;
    final Person person;
    final String phone;
    final RoleType roleType;
    final RoleTypeLabel roleTypeLabel;
    final SenatorClass senatorClass;
    final SenatorClassLabel senatorClassLabel;
    final SenatorRank senatorRank;
    final SenatorRankLabel senatorRankLabel;
    final DateTime startdate;
    final String state;
    final Title title;
    final RoleTypeLabel titleLong;
    final String website;

    Object({
        required this.caucus,
        required this.congressNumbers,
        required this.current,
        required this.description,
        required this.district,
        required this.enddate,
        required this.extra,
        required this.id,
        required this.leadershipTitle,
        required this.party,
        required this.person,
        required this.phone,
        required this.roleType,
        required this.roleTypeLabel,
        required this.senatorClass,
        required this.senatorClassLabel,
        required this.senatorRank,
        required this.senatorRankLabel,
        required this.startdate,
        required this.state,
        required this.title,
        required this.titleLong,
        required this.website,
    });

    factory Object.fromJson(Map<String, dynamic> json) => Object(
        caucus: (json.containsKey("caucus") ? json["caucus"] : throw FormatException('Missing required property')) == null ? null : partyValues.map[(json.containsKey("caucus") ? json["caucus"] : throw FormatException('Missing required property'))]!,
        congressNumbers: List<int>.from(json["congress_numbers"].map((x) => x)),
        current: json["current"],
        description: json["description"],
        district: (json.containsKey("district") ? json["district"] : throw FormatException('Missing required property')),
        enddate: DateTime.parse(json["enddate"]),
        extra: Extra.fromJson(json["extra"]),
        id: json["id"],
        leadershipTitle: (json.containsKey("leadership_title") ? json["leadership_title"] : throw FormatException('Missing required property')),
        party: partyValues.map[json["party"]]!,
        person: Person.fromJson(json["person"]),
        phone: json["phone"],
        roleType: roleTypeValues.map[json["role_type"]]!,
        roleTypeLabel: roleTypeLabelValues.map[json["role_type_label"]]!,
        senatorClass: senatorClassValues.map[json["senator_class"]]!,
        senatorClassLabel: senatorClassLabelValues.map[json["senator_class_label"]]!,
        senatorRank: senatorRankValues.map[json["senator_rank"]]!,
        senatorRankLabel: senatorRankLabelValues.map[json["senator_rank_label"]]!,
        startdate: DateTime.parse(json["startdate"]),
        state: json["state"],
        title: titleValues.map[json["title"]]!,
        titleLong: roleTypeLabelValues.map[json["title_long"]]!,
        website: json["website"],
    );

    Map<String, dynamic> toJson() => {
        "caucus": partyValues.reverse[caucus],
        "congress_numbers": List<dynamic>.from(congressNumbers.map((x) => x)),
        "current": current,
        "description": description,
        "district": district,
        "enddate": "${enddate.year.toString().padLeft(4, '0')}-${enddate.month.toString().padLeft(2, '0')}-${enddate.day.toString().padLeft(2, '0')}",
        "extra": extra.toJson(),
        "id": id,
        "leadership_title": leadershipTitle,
        "party": partyValues.reverse[party],
        "person": person.toJson(),
        "phone": phone,
        "role_type": roleTypeValues.reverse[roleType],
        "role_type_label": roleTypeLabelValues.reverse[roleTypeLabel],
        "senator_class": senatorClassValues.reverse[senatorClass],
        "senator_class_label": senatorClassLabelValues.reverse[senatorClassLabel],
        "senator_rank": senatorRankValues.reverse[senatorRank],
        "senator_rank_label": senatorRankLabelValues.reverse[senatorRankLabel],
        "startdate": "${startdate.year.toString().padLeft(4, '0')}-${startdate.month.toString().padLeft(2, '0')}-${startdate.day.toString().padLeft(2, '0')}",
        "state": state,
        "title": titleValues.reverse[title],
        "title_long": roleTypeLabelValues.reverse[titleLong],
        "website": website,
    };
}

enum Party {
    REPUBLICAN,
    DEMOCRAT,
    INDEPENDENT
}

final partyValues = EnumValues({
    "Republican": Party.REPUBLICAN,
    "Democrat": Party.DEMOCRAT,
    "Independent": Party.INDEPENDENT
});

class Extra {
    final String address;
    final String contactForm;
    final String? fax;
    final String office;
    final String? rssUrl;

    Extra({
        required this.address,
        required this.contactForm,
        this.fax,
        required this.office,
        this.rssUrl,
    });

    factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        address: json["address"],
        contactForm: json["contact_form"],
        fax: json["fax"],
        office: json["office"],
        rssUrl: json["rss_url"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "contact_form": contactForm,
        "fax": fax,
        "office": office,
        "rss_url": rssUrl,
    };
}

class Person {
    final String bioguideid;
    final DateTime birthday;
    final int cspanid;
    final String firstname;
    final Gender gender;
    final GenderLabel genderLabel;
    final int id;
    final String lastname;
    final String link;
    final String middlename;
    final String name;
    final Namemod namemod;
    final String nickname;
    final String osid;
    final String pvsid;
    final String sortname;
    final String? twitterid;
    final String? youtubeid;

    Person({
        required this.bioguideid,
        required this.birthday,
        required this.cspanid,
        required this.firstname,
        required this.gender,
        required this.genderLabel,
        required this.id,
        required this.lastname,
        required this.link,
        required this.middlename,
        required this.name,
        required this.namemod,
        required this.nickname,
        required this.osid,
        required this.pvsid,
        required this.sortname,
        required this.twitterid,
        required this.youtubeid,
    });

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        bioguideid: json["bioguideid"],
        birthday: DateTime.parse(json["birthday"]),
        cspanid: json["cspanid"],
        firstname: json["firstname"],
        gender: genderValues.map[json["gender"]]!,
        genderLabel: genderLabelValues.map[json["gender_label"]]!,
        id: json["id"],
        lastname: json["lastname"],
        link: json["link"],
        middlename: json["middlename"],
        name: json["name"],
        namemod: namemodValues.map[json["namemod"]]!,
        nickname: json["nickname"],
        osid: json["osid"],
        pvsid: json["pvsid"],
        sortname: json["sortname"],
        twitterid: (json.containsKey("twitterid") ? json["twitterid"] : throw FormatException('Missing required property')),
        youtubeid: (json.containsKey("youtubeid") ? json["youtubeid"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "bioguideid": bioguideid,
        "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "cspanid": cspanid,
        "firstname": firstname,
        "gender": genderValues.reverse[gender],
        "gender_label": genderLabelValues.reverse[genderLabel],
        "id": id,
        "lastname": lastname,
        "link": link,
        "middlename": middlename,
        "name": name,
        "namemod": namemodValues.reverse[namemod],
        "nickname": nickname,
        "osid": osid,
        "pvsid": pvsid,
        "sortname": sortname,
        "twitterid": twitterid,
        "youtubeid": youtubeid,
    };
}

enum Gender {
    MALE,
    FEMALE
}

final genderValues = EnumValues({
    "male": Gender.MALE,
    "female": Gender.FEMALE
});

enum GenderLabel {
    MALE,
    FEMALE
}

final genderLabelValues = EnumValues({
    "Male": GenderLabel.MALE,
    "Female": GenderLabel.FEMALE
});

enum Namemod {
    EMPTY,
    III,
    JR
}

final namemodValues = EnumValues({
    "": Namemod.EMPTY,
    "III": Namemod.III,
    "Jr.": Namemod.JR
});

enum RoleType {
    SENATOR
}

final roleTypeValues = EnumValues({
    "senator": RoleType.SENATOR
});

enum RoleTypeLabel {
    SENATOR
}

final roleTypeLabelValues = EnumValues({
    "Senator": RoleTypeLabel.SENATOR
});

enum SenatorClass {
    CLASS2,
    CLASS1,
    CLASS3
}

final senatorClassValues = EnumValues({
    "class2": SenatorClass.CLASS2,
    "class1": SenatorClass.CLASS1,
    "class3": SenatorClass.CLASS3
});

enum SenatorClassLabel {
    CLASS_2,
    CLASS_1,
    CLASS_3
}

final senatorClassLabelValues = EnumValues({
    "Class 2": SenatorClassLabel.CLASS_2,
    "Class 1": SenatorClassLabel.CLASS_1,
    "Class 3": SenatorClassLabel.CLASS_3
});

enum SenatorRank {
    SENIOR,
    JUNIOR
}

final senatorRankValues = EnumValues({
    "senior": SenatorRank.SENIOR,
    "junior": SenatorRank.JUNIOR
});

enum SenatorRankLabel {
    SENIOR,
    JUNIOR
}

final senatorRankLabelValues = EnumValues({
    "Senior": SenatorRankLabel.SENIOR,
    "Junior": SenatorRankLabel.JUNIOR
});

enum Title {
    SEN
}

final titleValues = EnumValues({
    "Sen.": Title.SEN
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
