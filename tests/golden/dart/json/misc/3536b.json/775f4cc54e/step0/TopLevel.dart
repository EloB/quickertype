// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final String id;
    final List<Identifier> identifiers;
    final List<Keyword> keywords;
    final List<Link> links;
    final String name;
    final List<dynamic> otherNames;
    final String supersededBy;
    final List<Text> text;

    TopLevel({
        required this.id,
        required this.identifiers,
        required this.keywords,
        required this.links,
        required this.name,
        required this.otherNames,
        required this.supersededBy,
        required this.text,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        id: json["id"],
        identifiers: List<Identifier>.from(json["identifiers"].map((x) => Identifier.fromJson(x))),
        keywords: List<Keyword>.from(json["keywords"].map((x) => keywordValues.map[x]!)),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        name: json["name"],
        otherNames: List<dynamic>.from(json["other_names"].map((x) => x)),
        supersededBy: json["superseded_by"],
        text: List<Text>.from(json["text"].map((x) => Text.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "identifiers": List<dynamic>.from(identifiers.map((x) => x.toJson())),
        "keywords": List<dynamic>.from(keywords.map((x) => keywordValues.reverse[x])),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "name": name,
        "other_names": List<dynamic>.from(otherNames.map((x) => x)),
        "superseded_by": supersededBy,
        "text": List<dynamic>.from(text.map((x) => x.toJson())),
    };
}

class Identifier {
    final String identifier;
    final Scheme scheme;

    Identifier({
        required this.identifier,
        required this.scheme,
    });

    factory Identifier.fromJson(Map<String, dynamic> json) => Identifier(
        identifier: json["identifier"],
        scheme: schemeValues.map[json["scheme"]]!,
    );

    Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "scheme": schemeValues.reverse[scheme],
    };
}

enum Scheme {
    SPDX,
    DEP5,
    TROVE
}

final schemeValues = EnumValues({
    "SPDX": Scheme.SPDX,
    "DEP5": Scheme.DEP5,
    "Trove": Scheme.TROVE
});

enum Keyword {
    DISCOURAGED,
    OBSOLETE,
    OSI_APPROVED
}

final keywordValues = EnumValues({
    "discouraged": Keyword.DISCOURAGED,
    "obsolete": Keyword.OBSOLETE,
    "osi-approved": Keyword.OSI_APPROVED
});

class Link {
    final String note;
    final String url;

    Link({
        required this.note,
        required this.url,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        note: json["note"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "note": note,
        "url": url,
    };
}

class Text {
    final String mediaType;
    final String title;
    final String url;

    Text({
        required this.mediaType,
        required this.title,
        required this.url,
    });

    factory Text.fromJson(Map<String, dynamic> json) => Text(
        mediaType: json["media_type"],
        title: json["title"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "media_type": mediaType,
        "title": title,
        "url": url,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
