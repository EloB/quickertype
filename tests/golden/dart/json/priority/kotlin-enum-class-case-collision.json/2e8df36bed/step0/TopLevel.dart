// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final Category category;

    TopLevel({
        required this.category,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        category: categoryValues.map[json["category"]]!,
    );

    Map<String, dynamic> toJson() => {
        "category": categoryValues.reverse[category],
    };
}

enum Category {
    EMPTY,
    CATEGORY
}

final categoryValues = EnumValues({
    " ": Category.EMPTY,
    "": Category.CATEGORY
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
