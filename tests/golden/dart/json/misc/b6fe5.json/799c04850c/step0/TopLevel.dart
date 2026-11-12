// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String group;
    final String movie;
    final String movieImage;
    final String theater;

    TopLevel({
        required this.group,
        required this.movie,
        required this.movieImage,
        required this.theater,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        group: json["group"],
        movie: json["movie"],
        movieImage: json["movie-image"],
        theater: json["theater"],
    );

    Map<String, dynamic> toJson() => {
        "group": group,
        "movie": movie,
        "movie-image": movieImage,
        "theater": theater,
    };
}
