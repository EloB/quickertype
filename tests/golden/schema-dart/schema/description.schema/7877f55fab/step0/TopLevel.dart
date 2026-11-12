// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());


///The top-level class.
///Its description has two lines.
class TopLevel {
    
    ///A pretty boolean
    final bool? bar;
    
    ///An enumeration
    final Enum topLevelEnum;
    final double? foo;
    final dynamic objectOrString;
    
    ///Either a number or a string
    final dynamic union;

    TopLevel({
        this.bar,
        required this.topLevelEnum,
        this.foo,
        required this.objectOrString,
        required this.union,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        bar: json["bar"],
        topLevelEnum: enumValues.map[json["enum"]]!,
        foo: json["foo"]?.toDouble(),
        objectOrString: json["object-or-string"],
        union: json["union"],
    );

    Map<String, dynamic> toJson() => {
        "bar": bar,
        "enum": enumValues.reverse[topLevelEnum],
        "foo": foo,
        "object-or-string": objectOrString,
        "union": union,
    };
}

class ObjectOrStringClass {
    
    ///This must not get lost
    final double prop;

    ObjectOrStringClass({
        required this.prop,
    });

    factory ObjectOrStringClass.fromJson(Map<String, dynamic> json) => ObjectOrStringClass(
        prop: json["prop"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "prop": prop,
    };
}


///An enumeration
enum Enum {
    FOO,
    BAR
}

final enumValues = EnumValues({
    "foo": Enum.FOO,
    "bar": Enum.BAR
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
