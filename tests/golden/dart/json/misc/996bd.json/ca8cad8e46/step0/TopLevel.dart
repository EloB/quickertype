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
    final String? supersededBy;
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
        supersededBy: (json.containsKey("superseded_by") ? json["superseded_by"] : throw FormatException('Missing required property')),
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
    DEP5,
    SPDX,
    TROVE
}

final schemeValues = EnumValues({
    "DEP5": Scheme.DEP5,
    "SPDX": Scheme.SPDX,
    "Trove": Scheme.TROVE
});

enum Keyword {
    OSI_APPROVED,
    POPULAR,
    COPYLEFT,
    INTERNATIONAL
}

final keywordValues = EnumValues({
    "osi-approved": Keyword.OSI_APPROVED,
    "popular": Keyword.POPULAR,
    "copyleft": Keyword.COPYLEFT,
    "international": Keyword.INTERNATIONAL
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
    final MediaType mediaType;
    final Title title;
    final String url;

    Text({
        required this.mediaType,
        required this.title,
        required this.url,
    });

    factory Text.fromJson(Map<String, dynamic> json) => Text(
        mediaType: mediaTypeValues.map[json["media_type"]]!,
        title: titleValues.map[json["title"]]!,
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "media_type": mediaTypeValues.reverse[mediaType],
        "title": titleValues.reverse[title],
        "url": url,
    };
}

enum MediaType {
    TEXT_PLAIN,
    TEXT_HTML
}

final mediaTypeValues = EnumValues({
    "text/plain": MediaType.TEXT_PLAIN,
    "text/html": MediaType.TEXT_HTML
});

enum Title {
    PLAIN_TEXT,
    HTML
}

final titleValues = EnumValues({
    "Plain Text": Title.PLAIN_TEXT,
    "HTML": Title.HTML
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
