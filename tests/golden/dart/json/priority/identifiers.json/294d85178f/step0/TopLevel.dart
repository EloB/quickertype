// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final TopLevelBla bla;
    final Empty empty;
    final Foo foo;
    final ThisIsAToughOne thisIsAToughOne;
    final int topLevel;
    final EmptyClass topLevelEmpty;

    TopLevel({
        required this.bla,
        required this.empty,
        required this.foo,
        required this.thisIsAToughOne,
        required this.topLevel,
        required this.topLevelEmpty,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        bla: TopLevelBla.fromJson(json["bla"]),
        empty: Empty.fromJson(json[""]),
        foo: Foo.fromJson(json["foo"]),
        thisIsAToughOne: ThisIsAToughOne.fromJson(json["ThisIsA\ud83d\ude1cTough\"\n\nOne"]),
        topLevel: json["!"],
        topLevelEmpty: EmptyClass.fromJson(json["Empty"]),
    );

    Map<String, dynamic> toJson() => {
        "bla": bla.toJson(),
        "": empty.toJson(),
        "foo": foo.toJson(),
        "ThisIsA\ud83d\ude1cTough\"\n\nOne": thisIsAToughOne.toJson(),
        "!": topLevel,
        "Empty": topLevelEmpty.toJson(),
    };
}

class TopLevelBla {
    final int bar;

    TopLevelBla({
        required this.bar,
    });

    factory TopLevelBla.fromJson(Map<String, dynamic> json) => TopLevelBla(
        bar: json["bar"],
    );

    Map<String, dynamic> toJson() => {
        "bar": bar,
    };
}

class Empty {
    final int x;

    Empty({
        required this.x,
    });

    factory Empty.fromJson(Map<String, dynamic> json) => Empty(
        x: json["x"],
    );

    Map<String, dynamic> toJson() => {
        "x": x,
    };
}

class Foo {
    final FooBla bla;
    final int empty;
    final int foo;

    Foo({
        required this.bla,
        required this.empty,
        required this.foo,
    });

    factory Foo.fromJson(Map<String, dynamic> json) => Foo(
        bla: FooBla.fromJson(json["bla"]),
        empty: json["_"],
        foo: json["__"],
    );

    Map<String, dynamic> toJson() => {
        "bla": bla.toJson(),
        "_": empty,
        "__": foo,
    };
}

class FooBla {
    FooBla();

    factory FooBla.fromJson(Map<String, dynamic> json) => FooBla(
    );

    Map<String, dynamic> toJson() => {
    };
}

class ThisIsAToughOne {
    final int empty;
    final int thisIsAToughOne;

    ThisIsAToughOne({
        required this.empty,
        required this.thisIsAToughOne,
    });

    factory ThisIsAToughOne.fromJson(Map<String, dynamic> json) => ThisIsAToughOne(
        empty: json["\n\n\n"],
        thisIsAToughOne: json["\""],
    );

    Map<String, dynamic> toJson() => {
        "\n\n\n": empty,
        "\"": thisIsAToughOne,
    };
}

class EmptyClass {
    final int y;

    EmptyClass({
        required this.y,
    });

    factory EmptyClass.fromJson(Map<String, dynamic> json) => EmptyClass(
        y: json["y"],
    );

    Map<String, dynamic> toJson() => {
        "y": y,
    };
}
