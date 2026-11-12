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
    final int activeScreens;
    final List<Collection> collections;
    final List<Detail> details;
    final int duration;
    final FavMovie favMovie;
    final int id;
    final List<Image> images;
    final ResultLanguage language;
    final DateTime releaseDate;
    final int stars;
    final List<dynamic>? tags;
    final String title;
    final List<Video> videos;
    final VoteScore voteScore;
    final int watches;

    Result({
        required this.activeScreens,
        required this.collections,
        required this.details,
        required this.duration,
        required this.favMovie,
        required this.id,
        required this.images,
        required this.language,
        required this.releaseDate,
        required this.stars,
        required this.tags,
        required this.title,
        required this.videos,
        required this.voteScore,
        required this.watches,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        activeScreens: json["active_screens"],
        collections: List<Collection>.from(json["collections"].map((x) => Collection.fromJson(x))),
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        duration: json["duration"],
        favMovie: FavMovie.fromJson(json["fav_movie"]),
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        language: resultLanguageValues.map[json["language"]]!,
        releaseDate: DateTime.parse(json["release_date"]),
        stars: json["stars"],
        tags: (json.containsKey("tags") ? json["tags"] : throw FormatException('Missing required property')) == null ? null : List<dynamic>.from((json.containsKey("tags") ? json["tags"] : throw FormatException('Missing required property'))!.map((x) => x)),
        title: json["title"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        voteScore: VoteScore.fromJson(json["vote_score"]),
        watches: json["watches"],
    );

    Map<String, dynamic> toJson() => {
        "active_screens": activeScreens,
        "collections": List<dynamic>.from(collections.map((x) => x.toJson())),
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
        "duration": duration,
        "fav_movie": favMovie.toJson(),
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "language": resultLanguageValues.reverse[language],
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "stars": stars,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "title": title,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "vote_score": voteScore.toJson(),
        "watches": watches,
    };
}

class Collection {
    final int id;
    final List<int> movies;
    final String name;
    final String slug;

    Collection({
        required this.id,
        required this.movies,
        required this.name,
        required this.slug,
    });

    factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["id"],
        movies: List<int>.from(json["movies"].map((x) => x)),
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "movies": List<dynamic>.from(movies.map((x) => x)),
        "name": name,
        "slug": slug,
    };
}

class Detail {
    final String cast;
    final String director;
    final int id;
    final DetailLanguage language;
    final String storyline;
    final String tagline;
    final String title;

    Detail({
        required this.cast,
        required this.director,
        required this.id,
        required this.language,
        required this.storyline,
        required this.tagline,
        required this.title,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        cast: json["cast"],
        director: json["director"],
        id: json["id"],
        language: detailLanguageValues.map[json["language"]]!,
        storyline: json["storyline"],
        tagline: json["tagline"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "cast": cast,
        "director": director,
        "id": id,
        "language": detailLanguageValues.reverse[language],
        "storyline": storyline,
        "tagline": tagline,
        "title": title,
    };
}

enum DetailLanguage {
    EN,
    TH
}

final detailLanguageValues = EnumValues({
    "en": DetailLanguage.EN,
    "th": DetailLanguage.TH
});

class FavMovie {
    final bool follow;
    final bool star;
    final bool watched;

    FavMovie({
        required this.follow,
        required this.star,
        required this.watched,
    });

    factory FavMovie.fromJson(Map<String, dynamic> json) => FavMovie(
        follow: json["follow"],
        star: json["star"],
        watched: json["watched"],
    );

    Map<String, dynamic> toJson() => {
        "follow": follow,
        "star": star,
        "watched": watched,
    };
}

class Image {
    final int favs;
    final int id;
    final String thumbnail;
    final Type type;
    final String url;

    Image({
        required this.favs,
        required this.id,
        required this.thumbnail,
        required this.type,
        required this.url,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        favs: json["favs"],
        id: json["id"],
        thumbnail: json["thumbnail"],
        type: typeValues.map[json["type"]]!,
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "favs": favs,
        "id": id,
        "thumbnail": thumbnail,
        "type": typeValues.reverse[type],
        "url": url,
    };
}

enum Type {
    POSTER,
    BACKDROP
}

final typeValues = EnumValues({
    "Poster": Type.POSTER,
    "Backdrop": Type.BACKDROP
});

enum ResultLanguage {
    EN,
    EMPTY
}

final resultLanguageValues = EnumValues({
    "en": ResultLanguage.EN,
    "-": ResultLanguage.EMPTY
});

class Video {
    final String kind;
    final ResultLanguage language;
    final String source;
    final String url;

    Video({
        required this.kind,
        required this.language,
        required this.source,
        required this.url,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        kind: json["kind"],
        language: resultLanguageValues.map[json["language"]]!,
        source: json["source"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "language": resultLanguageValues.reverse[language],
        "source": source,
        "url": url,
    };
}

class VoteScore {
    final int avg;
    final int score;
    final int total;

    VoteScore({
        required this.avg,
        required this.score,
        required this.total,
    });

    factory VoteScore.fromJson(Map<String, dynamic> json) => VoteScore(
        avg: json["avg"],
        score: json["score"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "avg": avg,
        "score": score,
        "total": total,
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
