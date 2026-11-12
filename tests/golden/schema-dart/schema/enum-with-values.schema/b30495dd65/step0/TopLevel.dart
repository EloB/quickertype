// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Weekdays weekdays;

    TopLevel({
        required this.weekdays,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        weekdays: weekdaysValues.map[json["weekdays"]]!,
    );

    Map<String, dynamic> toJson() => {
        "weekdays": weekdaysValues.reverse[weekdays],
    };
}

enum Weekdays {
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SUNDAY
}

final weekdaysValues = EnumValues({
    "Monday": Weekdays.MONDAY,
    "Tuesday": Weekdays.TUESDAY,
    "Wednesday": Weekdays.WEDNESDAY,
    "Thursday": Weekdays.THURSDAY,
    "Friday": Weekdays.FRIDAY,
    "Saturday": Weekdays.SATURDAY,
    "Sunday": Weekdays.SUNDAY
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
