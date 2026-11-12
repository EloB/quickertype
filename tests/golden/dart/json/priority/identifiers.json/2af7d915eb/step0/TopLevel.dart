// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'top_level.g.dart';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

@JsonSerializable()
class TopLevel {
    @JsonKey(name: "bla")
    final TopLevelBla bla;
    @JsonKey(name: "")
    final Empty empty;
    @JsonKey(name: "foo")
    final Foo foo;
    @JsonKey(name: "ThisIsA\ud83d\ude1cTough\"\n\nOne")
    final ThisIsAToughOne thisIsAToughOne;
    @JsonKey(name: "!")
    final int topLevel;
    @JsonKey(name: "Empty")
    final EmptyClass topLevelEmpty;

    TopLevel({
        required this.bla,
        required this.empty,
        required this.foo,
        required this.thisIsAToughOne,
        required this.topLevel,
        required this.topLevelEmpty,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => _$TopLevelFromJson(json);

    Map<String, dynamic> toJson() => _$TopLevelToJson(this);
}

@JsonSerializable()
class TopLevelBla {
    @JsonKey(name: "bar")
    final int bar;

    TopLevelBla({
        required this.bar,
    });

    factory TopLevelBla.fromJson(Map<String, dynamic> json) => _$TopLevelBlaFromJson(json);

    Map<String, dynamic> toJson() => _$TopLevelBlaToJson(this);
}

@JsonSerializable()
class Empty {
    @JsonKey(name: "x")
    final int x;

    Empty({
        required this.x,
    });

    factory Empty.fromJson(Map<String, dynamic> json) => _$EmptyFromJson(json);

    Map<String, dynamic> toJson() => _$EmptyToJson(this);
}

@JsonSerializable()
class Foo {
    @JsonKey(name: "bla")
    final FooBla bla;
    @JsonKey(name: "_")
    final int empty;
    @JsonKey(name: "__")
    final int foo;

    Foo({
        required this.bla,
        required this.empty,
        required this.foo,
    });

    factory Foo.fromJson(Map<String, dynamic> json) => _$FooFromJson(json);

    Map<String, dynamic> toJson() => _$FooToJson(this);
}

@JsonSerializable()
class FooBla {
    FooBla();

    factory FooBla.fromJson(Map<String, dynamic> json) => _$FooBlaFromJson(json);

    Map<String, dynamic> toJson() => _$FooBlaToJson(this);
}

@JsonSerializable()
class ThisIsAToughOne {
    @JsonKey(name: "\n\n\n")
    final int empty;
    @JsonKey(name: "\"")
    final int thisIsAToughOne;

    ThisIsAToughOne({
        required this.empty,
        required this.thisIsAToughOne,
    });

    factory ThisIsAToughOne.fromJson(Map<String, dynamic> json) => _$ThisIsAToughOneFromJson(json);

    Map<String, dynamic> toJson() => _$ThisIsAToughOneToJson(this);
}

@JsonSerializable()
class EmptyClass {
    @JsonKey(name: "y")
    final int y;

    EmptyClass({
        required this.y,
    });

    factory EmptyClass.fromJson(Map<String, dynamic> json) => _$EmptyClassFromJson(json);

    Map<String, dynamic> toJson() => _$EmptyClassToJson(this);
}
