// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<dynamic>? arr;
    final String? topLevelFor;
    final Gve gve;
    final Lvc? lvc;
    final List<OtherArr>? otherArr;

    TopLevel({
        this.arr,
        this.topLevelFor,
        required this.gve,
        this.lvc,
        this.otherArr,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        arr: json["arr"] == null ? null : List<dynamic>.from(json["arr"]!.map((x) => x)),
        topLevelFor: json["for"],
        gve: gveValues.map[json["gve"]]!,
        lvc: json["lvc"] == null ? null : lvcValues.map[json["lvc"]]!,
        otherArr: json["otherArr"] == null ? null : List<OtherArr>.from(json["otherArr"]!.map((x) => otherArrValues.map[x]!)),
    );

    Map<String, dynamic> toJson() => {
        "arr": arr == null ? null : List<dynamic>.from(arr!.map((x) => x)),
        "for": topLevelFor,
        "gve": gveValues.reverse[gve],
        "lvc": lvcValues.reverse[lvc],
        "otherArr": otherArr == null ? null : List<dynamic>.from(otherArr!.map((x) => otherArrValues.reverse[x])),
    };
}

enum OtherArr {
    FOO,
    BAR,
    IF
}

final otherArrValues = EnumValues({
    "foo": OtherArr.FOO,
    "bar": OtherArr.BAR,
    "if": OtherArr.IF
});

enum Gve {
    GOOD,
    NEUTRAL,
    EVIL
}

final gveValues = EnumValues({
    "good": Gve.GOOD,
    "neutral": Gve.NEUTRAL,
    "evil": Gve.EVIL
});

enum Lvc {
    LAWFUL,
    NEUTRAL,
    CHAOTIC
}

final lvcValues = EnumValues({
    "lawful": Lvc.LAWFUL,
    "neutral": Lvc.NEUTRAL,
    "chaotic": Lvc.CHAOTIC
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
