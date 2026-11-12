// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Callsign callsign;
    final Priority priority;

    TopLevel({
        required this.callsign,
        required this.priority,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        callsign: callsignValues.map[json["callsign"]]!,
        priority: priorityValues.map[json["priority"]]!,
    );

    Map<String, dynamic> toJson() => {
        "callsign": callsignValues.reverse[callsign],
        "priority": priorityValues.reverse[priority],
    };
}

enum Callsign {
    ALPHA,
    BRAVO,
    CHARLIE,
    DELTA,
    ECHO,
    FOXTROT,
    GOLF,
    HOTEL,
    INDIA,
    JULIETT,
    KILO,
    LIMA,
    MIKE,
    NOVEMBER,
    OSCAR,
    PAPA,
    QUEBEC,
    ROMEO,
    SIERRA,
    TANGO
}

final callsignValues = EnumValues({
    "alpha": Callsign.ALPHA,
    "bravo": Callsign.BRAVO,
    "charlie": Callsign.CHARLIE,
    "delta": Callsign.DELTA,
    "echo": Callsign.ECHO,
    "foxtrot": Callsign.FOXTROT,
    "golf": Callsign.GOLF,
    "hotel": Callsign.HOTEL,
    "india": Callsign.INDIA,
    "juliett": Callsign.JULIETT,
    "kilo": Callsign.KILO,
    "lima": Callsign.LIMA,
    "mike": Callsign.MIKE,
    "november": Callsign.NOVEMBER,
    "oscar": Callsign.OSCAR,
    "papa": Callsign.PAPA,
    "quebec": Callsign.QUEBEC,
    "romeo": Callsign.ROMEO,
    "sierra": Callsign.SIERRA,
    "tango": Callsign.TANGO
});

enum Priority {
    LOW,
    MEDIUM,
    HIGH
}

final priorityValues = EnumValues({
    "low": Priority.LOW,
    "medium": Priority.MEDIUM,
    "high": Priority.HIGH
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
