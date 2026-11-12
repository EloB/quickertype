// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Bar> bar;
    final List<Bar> foo;

    TopLevel({
        required this.bar,
        required this.foo,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        bar: List<Bar>.from(json["bar"].map((x) => Bar.fromJson(x))),
        foo: List<Bar>.from(json["foo"].map((x) => Bar.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "bar": List<dynamic>.from(bar.map((x) => x.toJson())),
        "foo": List<dynamic>.from(foo.map((x) => x.toJson())),
    };
}

class Bar {
    final X x;

    Bar({
        required this.x,
    });

    factory Bar.fromJson(Map<String, dynamic> json) => Bar(
        x: xValues.map[json["x"]]!,
    );

    Map<String, dynamic> toJson() => {
        "x": xValues.reverse[x],
    };
}

enum X {
    THREE,
    ONE,
    TWO
}

final xValues = EnumValues({
    "three": X.THREE,
    "one": X.ONE,
    "two": X.TWO
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
