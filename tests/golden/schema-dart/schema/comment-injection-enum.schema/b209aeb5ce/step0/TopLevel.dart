// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    
    ///Comment delimiters:
    ///*/
    ///{-
    ///-}
    ///"""
    ///}
    ///}
    final Kind kind;

    TopLevel({
        required this.kind,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        kind: kindValues.map[json["kind"]]!,
    );

    Map<String, dynamic> toJson() => {
        "kind": kindValues.reverse[kind],
    };
}


///Comment delimiters:
///*/
///{-
///-}
///"""
///}
///}
enum Kind {
    OK
}

final kindValues = EnumValues({
    "ok": Kind.OK
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
