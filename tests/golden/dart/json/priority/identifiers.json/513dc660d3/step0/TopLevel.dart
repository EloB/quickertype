// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'top_level.freezed.dart';
part 'top_level.g.dart';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

@freezed
abstract class TopLevel with _$TopLevel {
    const factory TopLevel({
        @JsonKey(name: "bla")
        required TopLevelBla bla,
        @JsonKey(name: "")
        required Empty empty,
        @JsonKey(name: "foo")
        required Foo foo,
        @JsonKey(name: "ThisIsA\ud83d\ude1cTough\"\n\nOne")
        required ThisIsAToughOne thisIsAToughOne,
        @JsonKey(name: "!")
        required int topLevel,
        @JsonKey(name: "Empty")
        required EmptyClass topLevelEmpty,
    }) = _TopLevel;

    factory TopLevel.fromJson(Map<String, dynamic> json) => _$TopLevelFromJson(json);
}

@freezed
abstract class TopLevelBla with _$TopLevelBla {
    const factory TopLevelBla({
        @JsonKey(name: "bar")
        required int bar,
    }) = _TopLevelBla;

    factory TopLevelBla.fromJson(Map<String, dynamic> json) => _$TopLevelBlaFromJson(json);
}

@freezed
abstract class Empty with _$Empty {
    const factory Empty({
        @JsonKey(name: "x")
        required int x,
    }) = _Empty;

    factory Empty.fromJson(Map<String, dynamic> json) => _$EmptyFromJson(json);
}

@freezed
abstract class Foo with _$Foo {
    const factory Foo({
        @JsonKey(name: "bla")
        required FooBla bla,
        @JsonKey(name: "_")
        required int empty,
        @JsonKey(name: "__")
        required int foo,
    }) = _Foo;

    factory Foo.fromJson(Map<String, dynamic> json) => _$FooFromJson(json);
}

@freezed
abstract class FooBla with _$FooBla {
    const factory FooBla() = _FooBla;

    factory FooBla.fromJson(Map<String, dynamic> json) => _$FooBlaFromJson(json);
}

@freezed
abstract class ThisIsAToughOne with _$ThisIsAToughOne {
    const factory ThisIsAToughOne({
        @JsonKey(name: "\n\n\n")
        required int empty,
        @JsonKey(name: "\"")
        required int thisIsAToughOne,
    }) = _ThisIsAToughOne;

    factory ThisIsAToughOne.fromJson(Map<String, dynamic> json) => _$ThisIsAToughOneFromJson(json);
}

@freezed
abstract class EmptyClass with _$EmptyClass {
    const factory EmptyClass({
        @JsonKey(name: "y")
        required int y,
    }) = _EmptyClass;

    factory EmptyClass.fromJson(Map<String, dynamic> json) => _$EmptyClassFromJson(json);
}
