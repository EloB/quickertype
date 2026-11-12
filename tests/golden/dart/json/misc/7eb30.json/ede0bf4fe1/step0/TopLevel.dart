// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int count;
    final String next;
    final dynamic previous;
    final List<Result> results;

    TopLevel({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        count: json["count"],
        next: json["next"],
        previous: (json.containsKey("previous") ? json["previous"] : throw FormatException('Missing required property')),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    final String code;
    final String english;
    final bool fav;
    final Group group;
    final Location location;
    final int minScreens;
    final int numViews;
    final String showtimes;
    final int stars;
    final Tel tel;
    final String thai;
    final int todayScreens;
    final String url;
    final String website;

    Result({
        required this.code,
        required this.english,
        required this.fav,
        required this.group,
        required this.location,
        required this.minScreens,
        required this.numViews,
        required this.showtimes,
        required this.stars,
        required this.tel,
        required this.thai,
        required this.todayScreens,
        required this.url,
        required this.website,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        english: json["english"],
        fav: json["fav"],
        group: Group.fromJson(json["group"]),
        location: locationValues.map[json["location"]]!,
        minScreens: json["min_screens"],
        numViews: json["num_views"],
        showtimes: json["showtimes"],
        stars: json["stars"],
        tel: telValues.map[json["tel"]]!,
        thai: json["thai"],
        todayScreens: json["today_screens"],
        url: json["url"],
        website: json["website"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "english": english,
        "fav": fav,
        "group": group.toJson(),
        "location": locationValues.reverse[location],
        "min_screens": minScreens,
        "num_views": numViews,
        "showtimes": showtimes,
        "stars": stars,
        "tel": telValues.reverse[tel],
        "thai": thai,
        "today_screens": todayScreens,
        "url": url,
        "website": website,
    };
}

class Group {
    final Code code;
    final English english;
    final Thai thai;
    final String website;

    Group({
        required this.code,
        required this.english,
        required this.thai,
        required this.website,
    });

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        code: codeValues.map[json["code"]]!,
        english: englishValues.map[json["english"]]!,
        thai: thaiValues.map[json["thai"]]!,
        website: json["website"],
    );

    Map<String, dynamic> toJson() => {
        "code": codeValues.reverse[code],
        "english": englishValues.reverse[english],
        "thai": thaiValues.reverse[thai],
        "website": website,
    };
}

enum Code {
    SF
}

final codeValues = EnumValues({
    "sf": Code.SF
});

enum English {
    SF
}

final englishValues = EnumValues({
    "SF": English.SF
});

enum Thai {
    EMPTY
}

final thaiValues = EnumValues({
    "เอสเอฟ": Thai.EMPTY
});

enum Location {
    EMPTY,
    THE_5_TH_FL_EMPORIUM
}

final locationValues = EnumValues({
    "": Location.EMPTY,
    "5th Fl. Emporium": Location.THE_5_TH_FL_EMPORIUM
});

enum Tel {
    EMPTY,
    THE_022688899
}

final telValues = EnumValues({
    "": Tel.EMPTY,
    "02-268-8899": Tel.THE_022688899
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
