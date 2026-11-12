// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final int dummy;
    final Obj1 obj1;
    final Obj2 obj2;
    final Obj3 obj3;
    final Obj4 obj4;
    final Obj5 obj5;
    final Obj6 obj6;

    TopLevel({
        required this.dummy,
        required this.obj1,
        required this.obj2,
        required this.obj3,
        required this.obj4,
        required this.obj5,
        required this.obj6,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        dummy: json["dummy"],
        obj1: Obj1.fromJson(json["obj1"]),
        obj2: Obj2.fromJson(json["obj2"]),
        obj3: Obj3.fromJson(json["obj3"]),
        obj4: Obj4.fromJson(json["obj4"]),
        obj5: Obj5.fromJson(json["obj5"]),
        obj6: Obj6.fromJson(json["obj6"]),
    );

    Map<String, dynamic> toJson() => {
        "dummy": dummy,
        "obj1": obj1.toJson(),
        "obj2": obj2.toJson(),
        "obj3": obj3.toJson(),
        "obj4": obj4.toJson(),
        "obj5": obj5.toJson(),
        "obj6": obj6.toJson(),
    };
}

class Obj1 {
    final Alignas alignas;
    final Alignof alignof;
    final And and;
    final AndEq andEq;
    final Any any;
    final Array array;
    final ArrayNode arrayNode;
    final Asm asm;
    final Associatedtype associatedtype;
    final Associativity associativity;
    final Atomic atomic;
    final AtomicCancel atomicCancel;
    final AtomicCommit atomicCommit;
    final AtomicNoexcept atomicNoexcept;
    final Auto auto;
    final Base base;
    final Bitand bitand;
    final Bitor bitor;
    final Boolean boolean;
    final BooleanNode booleanNode;
    final Bycopy bycopy;
    final Byref byref;
    final Byte byte;
    final Calendar calendar;
    final Chan chan;
    final Char char;
    final Char16T char16T;
    final Char32T char32T;
    final Checked checked;
    final Clone clone;
    final CoAwait coAwait;
    final CoReturn coReturn;
    final CoYield coYield;
    final Codable codable;
    final CodingKey codingKey;
    final CodingKeys codingKeys;
    final Compl compl;
    final Complex complex;
    final Concept concept;
    final Console console;
    final ConstCast constCast;
    final Constexpr constexpr;
    final Constructor constructor;
    final Convenience convenience;
    final Convert convert;
    final Converter converter;
    final int dummy;
    final Empty empty;
    final Obj1Bool fluffyBool;
    final Imaginery imaginery;
    final Abstract obj1Abstract;
    final AnyClass obj1Any;
    final As obj1As;
    final Assert obj1Assert;
    final Async obj1Async;
    final Await obj1Await;
    final Bool obj1Bool;
    final Break obj1Break;
    final Case obj1Case;
    final Catch obj1Catch;
    final Class obj1Class;
    final Const obj1Const;
    final Continue obj1Continue;
    final BoolClass purpleBool;
    final ClassClass purpleClass;

    Obj1({
        required this.alignas,
        required this.alignof,
        required this.and,
        required this.andEq,
        required this.any,
        required this.array,
        required this.arrayNode,
        required this.asm,
        required this.associatedtype,
        required this.associativity,
        required this.atomic,
        required this.atomicCancel,
        required this.atomicCommit,
        required this.atomicNoexcept,
        required this.auto,
        required this.base,
        required this.bitand,
        required this.bitor,
        required this.boolean,
        required this.booleanNode,
        required this.bycopy,
        required this.byref,
        required this.byte,
        required this.calendar,
        required this.chan,
        required this.char,
        required this.char16T,
        required this.char32T,
        required this.checked,
        required this.clone,
        required this.coAwait,
        required this.coReturn,
        required this.coYield,
        required this.codable,
        required this.codingKey,
        required this.codingKeys,
        required this.compl,
        required this.complex,
        required this.concept,
        required this.console,
        required this.constCast,
        required this.constexpr,
        required this.constructor,
        required this.convenience,
        required this.convert,
        required this.converter,
        required this.dummy,
        required this.empty,
        required this.fluffyBool,
        required this.imaginery,
        required this.obj1Abstract,
        required this.obj1Any,
        required this.obj1As,
        required this.obj1Assert,
        required this.obj1Async,
        required this.obj1Await,
        required this.obj1Bool,
        required this.obj1Break,
        required this.obj1Case,
        required this.obj1Catch,
        required this.obj1Class,
        required this.obj1Const,
        required this.obj1Continue,
        required this.purpleBool,
        required this.purpleClass,
    });

    factory Obj1.fromJson(Map<String, dynamic> json) => Obj1(
        alignas: Alignas.fromJson(json["alignas"]),
        alignof: Alignof.fromJson(json["alignof"]),
        and: And.fromJson(json["and"]),
        andEq: AndEq.fromJson(json["and_eq"]),
        any: Any.fromJson(json["Any"]),
        array: Array.fromJson(json["array"]),
        arrayNode: ArrayNode.fromJson(json["ArrayNode"]),
        asm: Asm.fromJson(json["asm"]),
        associatedtype: Associatedtype.fromJson(json["associatedtype"]),
        associativity: Associativity.fromJson(json["associativity"]),
        atomic: Atomic.fromJson(json["atomic"]),
        atomicCancel: AtomicCancel.fromJson(json["atomic_cancel"]),
        atomicCommit: AtomicCommit.fromJson(json["atomic_commit"]),
        atomicNoexcept: AtomicNoexcept.fromJson(json["atomic_noexcept"]),
        auto: Auto.fromJson(json["auto"]),
        base: Base.fromJson(json["base"]),
        bitand: Bitand.fromJson(json["bitand"]),
        bitor: Bitor.fromJson(json["bitor"]),
        boolean: Boolean.fromJson(json["boolean"]),
        booleanNode: BooleanNode.fromJson(json["BooleanNode"]),
        bycopy: Bycopy.fromJson(json["bycopy"]),
        byref: Byref.fromJson(json["byref"]),
        byte: Byte.fromJson(json["byte"]),
        calendar: Calendar.fromJson(json["Calendar"]),
        chan: Chan.fromJson(json["chan"]),
        char: Char.fromJson(json["char"]),
        char16T: Char16T.fromJson(json["char16_t"]),
        char32T: Char32T.fromJson(json["char32_t"]),
        checked: Checked.fromJson(json["checked"]),
        clone: Clone.fromJson(json["clone"]),
        coAwait: CoAwait.fromJson(json["co_await"]),
        coReturn: CoReturn.fromJson(json["co_return"]),
        coYield: CoYield.fromJson(json["co_yield"]),
        codable: Codable.fromJson(json["Codable"]),
        codingKey: CodingKey.fromJson(json["CodingKey"]),
        codingKeys: CodingKeys.fromJson(json["CodingKeys"]),
        compl: Compl.fromJson(json["compl"]),
        complex: Complex.fromJson(json["_Complex"]),
        concept: Concept.fromJson(json["concept"]),
        console: Console.fromJson(json["console"]),
        constCast: ConstCast.fromJson(json["const_cast"]),
        constexpr: Constexpr.fromJson(json["constexpr"]),
        constructor: Constructor.fromJson(json["constructor"]),
        convenience: Convenience.fromJson(json["convenience"]),
        convert: Convert.fromJson(json["convert"]),
        converter: Converter.fromJson(json["converter"]),
        dummy: json["dummy"],
        empty: Empty.fromJson(json["_"]),
        fluffyBool: Obj1Bool.fromJson(json["bool"]),
        imaginery: Imaginery.fromJson(json["_Imaginery"]),
        obj1Abstract: Abstract.fromJson(json["abstract"]),
        obj1Any: AnyClass.fromJson(json["any"]),
        obj1As: As.fromJson(json["as"]),
        obj1Assert: Assert.fromJson(json["assert"]),
        obj1Async: Async.fromJson(json["async"]),
        obj1Await: Await.fromJson(json["await"]),
        obj1Bool: Bool.fromJson(json["BOOL"]),
        obj1Break: Break.fromJson(json["break"]),
        obj1Case: Case.fromJson(json["case"]),
        obj1Catch: Catch.fromJson(json["catch"]),
        obj1Class: Class.fromJson(json["Class"]),
        obj1Const: Const.fromJson(json["const"]),
        obj1Continue: Continue.fromJson(json["continue"]),
        purpleBool: BoolClass.fromJson(json["_Bool"]),
        purpleClass: ClassClass.fromJson(json["class"]),
    );

    Map<String, dynamic> toJson() => {
        "alignas": alignas.toJson(),
        "alignof": alignof.toJson(),
        "and": and.toJson(),
        "and_eq": andEq.toJson(),
        "Any": any.toJson(),
        "array": array.toJson(),
        "ArrayNode": arrayNode.toJson(),
        "asm": asm.toJson(),
        "associatedtype": associatedtype.toJson(),
        "associativity": associativity.toJson(),
        "atomic": atomic.toJson(),
        "atomic_cancel": atomicCancel.toJson(),
        "atomic_commit": atomicCommit.toJson(),
        "atomic_noexcept": atomicNoexcept.toJson(),
        "auto": auto.toJson(),
        "base": base.toJson(),
        "bitand": bitand.toJson(),
        "bitor": bitor.toJson(),
        "boolean": boolean.toJson(),
        "BooleanNode": booleanNode.toJson(),
        "bycopy": bycopy.toJson(),
        "byref": byref.toJson(),
        "byte": byte.toJson(),
        "Calendar": calendar.toJson(),
        "chan": chan.toJson(),
        "char": char.toJson(),
        "char16_t": char16T.toJson(),
        "char32_t": char32T.toJson(),
        "checked": checked.toJson(),
        "clone": clone.toJson(),
        "co_await": coAwait.toJson(),
        "co_return": coReturn.toJson(),
        "co_yield": coYield.toJson(),
        "Codable": codable.toJson(),
        "CodingKey": codingKey.toJson(),
        "CodingKeys": codingKeys.toJson(),
        "compl": compl.toJson(),
        "_Complex": complex.toJson(),
        "concept": concept.toJson(),
        "console": console.toJson(),
        "const_cast": constCast.toJson(),
        "constexpr": constexpr.toJson(),
        "constructor": constructor.toJson(),
        "convenience": convenience.toJson(),
        "convert": convert.toJson(),
        "converter": converter.toJson(),
        "dummy": dummy,
        "_": empty.toJson(),
        "bool": fluffyBool.toJson(),
        "_Imaginery": imaginery.toJson(),
        "abstract": obj1Abstract.toJson(),
        "any": obj1Any.toJson(),
        "as": obj1As.toJson(),
        "assert": obj1Assert.toJson(),
        "async": obj1Async.toJson(),
        "await": obj1Await.toJson(),
        "BOOL": obj1Bool.toJson(),
        "break": obj1Break.toJson(),
        "case": obj1Case.toJson(),
        "catch": obj1Catch.toJson(),
        "Class": obj1Class.toJson(),
        "const": obj1Const.toJson(),
        "continue": obj1Continue.toJson(),
        "_Bool": purpleBool.toJson(),
        "class": purpleClass.toJson(),
    };
}

class Alignas {
    final int alignas;

    Alignas({
        required this.alignas,
    });

    factory Alignas.fromJson(Map<String, dynamic> json) => Alignas(
        alignas: json["alignas"],
    );

    Map<String, dynamic> toJson() => {
        "alignas": alignas,
    };
}

class Alignof {
    final int alignof;

    Alignof({
        required this.alignof,
    });

    factory Alignof.fromJson(Map<String, dynamic> json) => Alignof(
        alignof: json["alignof"],
    );

    Map<String, dynamic> toJson() => {
        "alignof": alignof,
    };
}

class And {
    final int and;

    And({
        required this.and,
    });

    factory And.fromJson(Map<String, dynamic> json) => And(
        and: json["and"],
    );

    Map<String, dynamic> toJson() => {
        "and": and,
    };
}

class AndEq {
    final int andEq;

    AndEq({
        required this.andEq,
    });

    factory AndEq.fromJson(Map<String, dynamic> json) => AndEq(
        andEq: json["and_eq"],
    );

    Map<String, dynamic> toJson() => {
        "and_eq": andEq,
    };
}

class Any {
    final int any;

    Any({
        required this.any,
    });

    factory Any.fromJson(Map<String, dynamic> json) => Any(
        any: json["Any"],
    );

    Map<String, dynamic> toJson() => {
        "Any": any,
    };
}

class Array {
    final int array;

    Array({
        required this.array,
    });

    factory Array.fromJson(Map<String, dynamic> json) => Array(
        array: json["array"],
    );

    Map<String, dynamic> toJson() => {
        "array": array,
    };
}

class ArrayNode {
    final int arrayNode;

    ArrayNode({
        required this.arrayNode,
    });

    factory ArrayNode.fromJson(Map<String, dynamic> json) => ArrayNode(
        arrayNode: json["ArrayNode"],
    );

    Map<String, dynamic> toJson() => {
        "ArrayNode": arrayNode,
    };
}

class Asm {
    final int asm;

    Asm({
        required this.asm,
    });

    factory Asm.fromJson(Map<String, dynamic> json) => Asm(
        asm: json["asm"],
    );

    Map<String, dynamic> toJson() => {
        "asm": asm,
    };
}

class Associatedtype {
    final int associatedtype;

    Associatedtype({
        required this.associatedtype,
    });

    factory Associatedtype.fromJson(Map<String, dynamic> json) => Associatedtype(
        associatedtype: json["associatedtype"],
    );

    Map<String, dynamic> toJson() => {
        "associatedtype": associatedtype,
    };
}

class Associativity {
    final int associativity;

    Associativity({
        required this.associativity,
    });

    factory Associativity.fromJson(Map<String, dynamic> json) => Associativity(
        associativity: json["associativity"],
    );

    Map<String, dynamic> toJson() => {
        "associativity": associativity,
    };
}

class Atomic {
    final int atomic;

    Atomic({
        required this.atomic,
    });

    factory Atomic.fromJson(Map<String, dynamic> json) => Atomic(
        atomic: json["atomic"],
    );

    Map<String, dynamic> toJson() => {
        "atomic": atomic,
    };
}

class AtomicCancel {
    final int atomicCancel;

    AtomicCancel({
        required this.atomicCancel,
    });

    factory AtomicCancel.fromJson(Map<String, dynamic> json) => AtomicCancel(
        atomicCancel: json["atomic_cancel"],
    );

    Map<String, dynamic> toJson() => {
        "atomic_cancel": atomicCancel,
    };
}

class AtomicCommit {
    final int atomicCommit;

    AtomicCommit({
        required this.atomicCommit,
    });

    factory AtomicCommit.fromJson(Map<String, dynamic> json) => AtomicCommit(
        atomicCommit: json["atomic_commit"],
    );

    Map<String, dynamic> toJson() => {
        "atomic_commit": atomicCommit,
    };
}

class AtomicNoexcept {
    final int atomicNoexcept;

    AtomicNoexcept({
        required this.atomicNoexcept,
    });

    factory AtomicNoexcept.fromJson(Map<String, dynamic> json) => AtomicNoexcept(
        atomicNoexcept: json["atomic_noexcept"],
    );

    Map<String, dynamic> toJson() => {
        "atomic_noexcept": atomicNoexcept,
    };
}

class Auto {
    final int auto;

    Auto({
        required this.auto,
    });

    factory Auto.fromJson(Map<String, dynamic> json) => Auto(
        auto: json["auto"],
    );

    Map<String, dynamic> toJson() => {
        "auto": auto,
    };
}

class Base {
    final int base;

    Base({
        required this.base,
    });

    factory Base.fromJson(Map<String, dynamic> json) => Base(
        base: json["base"],
    );

    Map<String, dynamic> toJson() => {
        "base": base,
    };
}

class Bitand {
    final int bitand;

    Bitand({
        required this.bitand,
    });

    factory Bitand.fromJson(Map<String, dynamic> json) => Bitand(
        bitand: json["bitand"],
    );

    Map<String, dynamic> toJson() => {
        "bitand": bitand,
    };
}

class Bitor {
    final int bitor;

    Bitor({
        required this.bitor,
    });

    factory Bitor.fromJson(Map<String, dynamic> json) => Bitor(
        bitor: json["bitor"],
    );

    Map<String, dynamic> toJson() => {
        "bitor": bitor,
    };
}

class Boolean {
    final int boolean;

    Boolean({
        required this.boolean,
    });

    factory Boolean.fromJson(Map<String, dynamic> json) => Boolean(
        boolean: json["boolean"],
    );

    Map<String, dynamic> toJson() => {
        "boolean": boolean,
    };
}

class BooleanNode {
    final int booleanNode;

    BooleanNode({
        required this.booleanNode,
    });

    factory BooleanNode.fromJson(Map<String, dynamic> json) => BooleanNode(
        booleanNode: json["BooleanNode"],
    );

    Map<String, dynamic> toJson() => {
        "BooleanNode": booleanNode,
    };
}

class Bycopy {
    final int bycopy;

    Bycopy({
        required this.bycopy,
    });

    factory Bycopy.fromJson(Map<String, dynamic> json) => Bycopy(
        bycopy: json["bycopy"],
    );

    Map<String, dynamic> toJson() => {
        "bycopy": bycopy,
    };
}

class Byref {
    final int byref;

    Byref({
        required this.byref,
    });

    factory Byref.fromJson(Map<String, dynamic> json) => Byref(
        byref: json["byref"],
    );

    Map<String, dynamic> toJson() => {
        "byref": byref,
    };
}

class Byte {
    final int byte;

    Byte({
        required this.byte,
    });

    factory Byte.fromJson(Map<String, dynamic> json) => Byte(
        byte: json["byte"],
    );

    Map<String, dynamic> toJson() => {
        "byte": byte,
    };
}

class Calendar {
    final int calendar;

    Calendar({
        required this.calendar,
    });

    factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
        calendar: json["Calendar"],
    );

    Map<String, dynamic> toJson() => {
        "Calendar": calendar,
    };
}

class Chan {
    final int chan;

    Chan({
        required this.chan,
    });

    factory Chan.fromJson(Map<String, dynamic> json) => Chan(
        chan: json["chan"],
    );

    Map<String, dynamic> toJson() => {
        "chan": chan,
    };
}

class Char {
    final int char;

    Char({
        required this.char,
    });

    factory Char.fromJson(Map<String, dynamic> json) => Char(
        char: json["char"],
    );

    Map<String, dynamic> toJson() => {
        "char": char,
    };
}

class Char16T {
    final int char16T;

    Char16T({
        required this.char16T,
    });

    factory Char16T.fromJson(Map<String, dynamic> json) => Char16T(
        char16T: json["char16_t"],
    );

    Map<String, dynamic> toJson() => {
        "char16_t": char16T,
    };
}

class Char32T {
    final int char32T;

    Char32T({
        required this.char32T,
    });

    factory Char32T.fromJson(Map<String, dynamic> json) => Char32T(
        char32T: json["char32_t"],
    );

    Map<String, dynamic> toJson() => {
        "char32_t": char32T,
    };
}

class Checked {
    final int checked;

    Checked({
        required this.checked,
    });

    factory Checked.fromJson(Map<String, dynamic> json) => Checked(
        checked: json["checked"],
    );

    Map<String, dynamic> toJson() => {
        "checked": checked,
    };
}

class Clone {
    final int clone;

    Clone({
        required this.clone,
    });

    factory Clone.fromJson(Map<String, dynamic> json) => Clone(
        clone: json["clone"],
    );

    Map<String, dynamic> toJson() => {
        "clone": clone,
    };
}

class CoAwait {
    final int coAwait;

    CoAwait({
        required this.coAwait,
    });

    factory CoAwait.fromJson(Map<String, dynamic> json) => CoAwait(
        coAwait: json["co_await"],
    );

    Map<String, dynamic> toJson() => {
        "co_await": coAwait,
    };
}

class CoReturn {
    final int coReturn;

    CoReturn({
        required this.coReturn,
    });

    factory CoReturn.fromJson(Map<String, dynamic> json) => CoReturn(
        coReturn: json["co_return"],
    );

    Map<String, dynamic> toJson() => {
        "co_return": coReturn,
    };
}

class CoYield {
    final int coYield;

    CoYield({
        required this.coYield,
    });

    factory CoYield.fromJson(Map<String, dynamic> json) => CoYield(
        coYield: json["co_yield"],
    );

    Map<String, dynamic> toJson() => {
        "co_yield": coYield,
    };
}

class Codable {
    final int codable;

    Codable({
        required this.codable,
    });

    factory Codable.fromJson(Map<String, dynamic> json) => Codable(
        codable: json["Codable"],
    );

    Map<String, dynamic> toJson() => {
        "Codable": codable,
    };
}

class CodingKey {
    final int codingKey;

    CodingKey({
        required this.codingKey,
    });

    factory CodingKey.fromJson(Map<String, dynamic> json) => CodingKey(
        codingKey: json["CodingKey"],
    );

    Map<String, dynamic> toJson() => {
        "CodingKey": codingKey,
    };
}

class CodingKeys {
    final int codingKeys;

    CodingKeys({
        required this.codingKeys,
    });

    factory CodingKeys.fromJson(Map<String, dynamic> json) => CodingKeys(
        codingKeys: json["CodingKeys"],
    );

    Map<String, dynamic> toJson() => {
        "CodingKeys": codingKeys,
    };
}

class Compl {
    final int compl;

    Compl({
        required this.compl,
    });

    factory Compl.fromJson(Map<String, dynamic> json) => Compl(
        compl: json["compl"],
    );

    Map<String, dynamic> toJson() => {
        "compl": compl,
    };
}

class Complex {
    final int complex;

    Complex({
        required this.complex,
    });

    factory Complex.fromJson(Map<String, dynamic> json) => Complex(
        complex: json["_Complex"],
    );

    Map<String, dynamic> toJson() => {
        "_Complex": complex,
    };
}

class Concept {
    final int concept;

    Concept({
        required this.concept,
    });

    factory Concept.fromJson(Map<String, dynamic> json) => Concept(
        concept: json["concept"],
    );

    Map<String, dynamic> toJson() => {
        "concept": concept,
    };
}

class Console {
    final int console;

    Console({
        required this.console,
    });

    factory Console.fromJson(Map<String, dynamic> json) => Console(
        console: json["console"],
    );

    Map<String, dynamic> toJson() => {
        "console": console,
    };
}

class ConstCast {
    final int constCast;

    ConstCast({
        required this.constCast,
    });

    factory ConstCast.fromJson(Map<String, dynamic> json) => ConstCast(
        constCast: json["const_cast"],
    );

    Map<String, dynamic> toJson() => {
        "const_cast": constCast,
    };
}

class Constexpr {
    final int constexpr;

    Constexpr({
        required this.constexpr,
    });

    factory Constexpr.fromJson(Map<String, dynamic> json) => Constexpr(
        constexpr: json["constexpr"],
    );

    Map<String, dynamic> toJson() => {
        "constexpr": constexpr,
    };
}

class Constructor {
    final int constructor;

    Constructor({
        required this.constructor,
    });

    factory Constructor.fromJson(Map<String, dynamic> json) => Constructor(
        constructor: json["constructor"],
    );

    Map<String, dynamic> toJson() => {
        "constructor": constructor,
    };
}

class Convenience {
    final int convenience;

    Convenience({
        required this.convenience,
    });

    factory Convenience.fromJson(Map<String, dynamic> json) => Convenience(
        convenience: json["convenience"],
    );

    Map<String, dynamic> toJson() => {
        "convenience": convenience,
    };
}

class Convert {
    final int convert;

    Convert({
        required this.convert,
    });

    factory Convert.fromJson(Map<String, dynamic> json) => Convert(
        convert: json["convert"],
    );

    Map<String, dynamic> toJson() => {
        "convert": convert,
    };
}

class Converter {
    final int converter;

    Converter({
        required this.converter,
    });

    factory Converter.fromJson(Map<String, dynamic> json) => Converter(
        converter: json["converter"],
    );

    Map<String, dynamic> toJson() => {
        "converter": converter,
    };
}

class Empty {
    final int empty;

    Empty({
        required this.empty,
    });

    factory Empty.fromJson(Map<String, dynamic> json) => Empty(
        empty: json["_"],
    );

    Map<String, dynamic> toJson() => {
        "_": empty,
    };
}

class Obj1Bool {
    final int boolBool;

    Obj1Bool({
        required this.boolBool,
    });

    factory Obj1Bool.fromJson(Map<String, dynamic> json) => Obj1Bool(
        boolBool: json["bool"],
    );

    Map<String, dynamic> toJson() => {
        "bool": boolBool,
    };
}

class Imaginery {
    final int imaginery;

    Imaginery({
        required this.imaginery,
    });

    factory Imaginery.fromJson(Map<String, dynamic> json) => Imaginery(
        imaginery: json["_Imaginery"],
    );

    Map<String, dynamic> toJson() => {
        "_Imaginery": imaginery,
    };
}

class Abstract {
    final int abstractAbstract;

    Abstract({
        required this.abstractAbstract,
    });

    factory Abstract.fromJson(Map<String, dynamic> json) => Abstract(
        abstractAbstract: json["abstract"],
    );

    Map<String, dynamic> toJson() => {
        "abstract": abstractAbstract,
    };
}

class AnyClass {
    final int any;

    AnyClass({
        required this.any,
    });

    factory AnyClass.fromJson(Map<String, dynamic> json) => AnyClass(
        any: json["any"],
    );

    Map<String, dynamic> toJson() => {
        "any": any,
    };
}

class As {
    final int asAs;

    As({
        required this.asAs,
    });

    factory As.fromJson(Map<String, dynamic> json) => As(
        asAs: json["as"],
    );

    Map<String, dynamic> toJson() => {
        "as": asAs,
    };
}

class Assert {
    final int assertAssert;

    Assert({
        required this.assertAssert,
    });

    factory Assert.fromJson(Map<String, dynamic> json) => Assert(
        assertAssert: json["assert"],
    );

    Map<String, dynamic> toJson() => {
        "assert": assertAssert,
    };
}

class Async {
    final int asyncAsync;

    Async({
        required this.asyncAsync,
    });

    factory Async.fromJson(Map<String, dynamic> json) => Async(
        asyncAsync: json["async"],
    );

    Map<String, dynamic> toJson() => {
        "async": asyncAsync,
    };
}

class Await {
    final int awaitAwait;

    Await({
        required this.awaitAwait,
    });

    factory Await.fromJson(Map<String, dynamic> json) => Await(
        awaitAwait: json["await"],
    );

    Map<String, dynamic> toJson() => {
        "await": awaitAwait,
    };
}

class Bool {
    final int boolBool;

    Bool({
        required this.boolBool,
    });

    factory Bool.fromJson(Map<String, dynamic> json) => Bool(
        boolBool: json["BOOL"],
    );

    Map<String, dynamic> toJson() => {
        "BOOL": boolBool,
    };
}

class Break {
    final int breakBreak;

    Break({
        required this.breakBreak,
    });

    factory Break.fromJson(Map<String, dynamic> json) => Break(
        breakBreak: json["break"],
    );

    Map<String, dynamic> toJson() => {
        "break": breakBreak,
    };
}

class Case {
    final int caseCase;

    Case({
        required this.caseCase,
    });

    factory Case.fromJson(Map<String, dynamic> json) => Case(
        caseCase: json["case"],
    );

    Map<String, dynamic> toJson() => {
        "case": caseCase,
    };
}

class Catch {
    final int catchCatch;

    Catch({
        required this.catchCatch,
    });

    factory Catch.fromJson(Map<String, dynamic> json) => Catch(
        catchCatch: json["catch"],
    );

    Map<String, dynamic> toJson() => {
        "catch": catchCatch,
    };
}

class Class {
    final int classClass;

    Class({
        required this.classClass,
    });

    factory Class.fromJson(Map<String, dynamic> json) => Class(
        classClass: json["Class"],
    );

    Map<String, dynamic> toJson() => {
        "Class": classClass,
    };
}

class Const {
    final int constConst;

    Const({
        required this.constConst,
    });

    factory Const.fromJson(Map<String, dynamic> json) => Const(
        constConst: json["const"],
    );

    Map<String, dynamic> toJson() => {
        "const": constConst,
    };
}

class Continue {
    final int continueContinue;

    Continue({
        required this.continueContinue,
    });

    factory Continue.fromJson(Map<String, dynamic> json) => Continue(
        continueContinue: json["continue"],
    );

    Map<String, dynamic> toJson() => {
        "continue": continueContinue,
    };
}

class BoolClass {
    final int boolBool;

    BoolClass({
        required this.boolBool,
    });

    factory BoolClass.fromJson(Map<String, dynamic> json) => BoolClass(
        boolBool: json["_Bool"],
    );

    Map<String, dynamic> toJson() => {
        "_Bool": boolBool,
    };
}

class ClassClass {
    final int classClass;

    ClassClass({
        required this.classClass,
    });

    factory ClassClass.fromJson(Map<String, dynamic> json) => ClassClass(
        classClass: json["class"],
    );

    Map<String, dynamic> toJson() => {
        "class": classClass,
    };
}

class Obj2 {
    final CultureInfo cultureInfo;
    final Date date;
    final DateFormatter dateFormatter;
    final DateOnly dateOnly;
    final DateOnlyConverter dateOnlyConverter;
    final DateParseHandling dateParseHandling;
    final DateTimeClass dateTime;
    final DateTimeStyles dateTimeStyles;
    final Debugger debugger;
    final Decimal decimal;
    final Declare declare;
    final Decltype decltype;
    final DecodeString decodeString;
    final Decoder decoder;
    final DecodingError decodingError;
    final Def def;
    final Defer defer;
    final Deinit deinit;
    final Del del;
    final Delegate delegate;
    final Delete delete;
    final DeserializationFeature deserializationFeature;
    final Dict dict;
    final Dictionary dictionary;
    final DidSet didSet;
    final DoubleNode doubleNode;
    final int dummy;
    final DynamicCast dynamicCast;
    final Elif elif;
    final EncodeQuickType encodeQuickType;
    final Encoder encoder;
    final EnumValuesClass enumValues;
    final EqualityContract equalityContract;
    final Equatable equatable;
    final Event event;
    final Except except;
    final Exception exception;
    final Explicit explicit;
    final Exposing exposing;
    final Extension extension;
    final Extern extern;
    final Fallthrough fallthrough;
    final Fileprivate fileprivate;
    final Fixed fixed;
    final Float float;
    final Foreach foreach;
    final FormatExceptionClass formatException;
    final Friend friend;
    final From from;
    final FromDict fromDict;
    final Func func;
    final Default obj2Default;
    final Do obj2Do;
    final Double obj2Double;
    final Dynamic obj2Dynamic;
    final Else obj2Else;
    final Enum obj2Enum;
    final Export obj2Export;
    final Extends obj2Extends;
    final False obj2False;
    final Final obj2Final;
    final Finally obj2Finally;
    final For obj2For;
    final FromJson obj2FromJson;
    final FalseClass purpleFalse;

    Obj2({
        required this.cultureInfo,
        required this.date,
        required this.dateFormatter,
        required this.dateOnly,
        required this.dateOnlyConverter,
        required this.dateParseHandling,
        required this.dateTime,
        required this.dateTimeStyles,
        required this.debugger,
        required this.decimal,
        required this.declare,
        required this.decltype,
        required this.decodeString,
        required this.decoder,
        required this.decodingError,
        required this.def,
        required this.defer,
        required this.deinit,
        required this.del,
        required this.delegate,
        required this.delete,
        required this.deserializationFeature,
        required this.dict,
        required this.dictionary,
        required this.didSet,
        required this.doubleNode,
        required this.dummy,
        required this.dynamicCast,
        required this.elif,
        required this.encodeQuickType,
        required this.encoder,
        required this.enumValues,
        required this.equalityContract,
        required this.equatable,
        required this.event,
        required this.except,
        required this.exception,
        required this.explicit,
        required this.exposing,
        required this.extension,
        required this.extern,
        required this.fallthrough,
        required this.fileprivate,
        required this.fixed,
        required this.float,
        required this.foreach,
        required this.formatException,
        required this.friend,
        required this.from,
        required this.fromDict,
        required this.func,
        required this.obj2Default,
        required this.obj2Do,
        required this.obj2Double,
        required this.obj2Dynamic,
        required this.obj2Else,
        required this.obj2Enum,
        required this.obj2Export,
        required this.obj2Extends,
        required this.obj2False,
        required this.obj2Final,
        required this.obj2Finally,
        required this.obj2For,
        required this.obj2FromJson,
        required this.purpleFalse,
    });

    factory Obj2.fromJson(Map<String, dynamic> json) => Obj2(
        cultureInfo: CultureInfo.fromJson(json["CultureInfo"]),
        date: Date.fromJson(json["date"]),
        dateFormatter: DateFormatter.fromJson(json["DateFormatter"]),
        dateOnly: DateOnly.fromJson(json["DateOnly"]),
        dateOnlyConverter: DateOnlyConverter.fromJson(json["DateOnlyConverter"]),
        dateParseHandling: DateParseHandling.fromJson(json["date_parse_handling"]),
        dateTime: DateTimeClass.fromJson(json["DateTime"]),
        dateTimeStyles: DateTimeStyles.fromJson(json["DateTimeStyles"]),
        debugger: Debugger.fromJson(json["debugger"]),
        decimal: Decimal.fromJson(json["decimal"]),
        declare: Declare.fromJson(json["declare"]),
        decltype: Decltype.fromJson(json["decltype"]),
        decodeString: DecodeString.fromJson(json["decode_string"]),
        decoder: Decoder.fromJson(json["Decoder"]),
        decodingError: DecodingError.fromJson(json["DecodingError"]),
        def: Def.fromJson(json["def"]),
        defer: Defer.fromJson(json["defer"]),
        deinit: Deinit.fromJson(json["deinit"]),
        del: Del.fromJson(json["del"]),
        delegate: Delegate.fromJson(json["delegate"]),
        delete: Delete.fromJson(json["delete"]),
        deserializationFeature: DeserializationFeature.fromJson(json["DeserializationFeature"]),
        dict: Dict.fromJson(json["dict"]),
        dictionary: Dictionary.fromJson(json["dictionary"]),
        didSet: DidSet.fromJson(json["didSet"]),
        doubleNode: DoubleNode.fromJson(json["DoubleNode"]),
        dummy: json["dummy"],
        dynamicCast: DynamicCast.fromJson(json["dynamic_cast"]),
        elif: Elif.fromJson(json["elif"]),
        encodeQuickType: EncodeQuickType.fromJson(json["encode_quick_type"]),
        encoder: Encoder.fromJson(json["Encoder"]),
        enumValues: EnumValuesClass.fromJson(json["EnumValues"]),
        equalityContract: EqualityContract.fromJson(json["equalityContract"]),
        equatable: Equatable.fromJson(json["Equatable"]),
        event: Event.fromJson(json["event"]),
        except: Except.fromJson(json["except"]),
        exception: Exception.fromJson(json["exception"]),
        explicit: Explicit.fromJson(json["explicit"]),
        exposing: Exposing.fromJson(json["exposing"]),
        extension: Extension.fromJson(json["extension"]),
        extern: Extern.fromJson(json["extern"]),
        fallthrough: Fallthrough.fromJson(json["fallthrough"]),
        fileprivate: Fileprivate.fromJson(json["fileprivate"]),
        fixed: Fixed.fromJson(json["fixed"]),
        float: Float.fromJson(json["float"]),
        foreach: Foreach.fromJson(json["foreach"]),
        formatException: FormatExceptionClass.fromJson(json["FormatException"]),
        friend: Friend.fromJson(json["friend"]),
        from: From.fromJson(json["from"]),
        fromDict: FromDict.fromJson(json["from_dict"]),
        func: Func.fromJson(json["func"]),
        obj2Default: Default.fromJson(json["default"]),
        obj2Do: Do.fromJson(json["do"]),
        obj2Double: Double.fromJson(json["double"]),
        obj2Dynamic: Dynamic.fromJson(json["dynamic"]),
        obj2Else: Else.fromJson(json["else"]),
        obj2Enum: Enum.fromJson(json["enum"]),
        obj2Export: Export.fromJson(json["export"]),
        obj2Extends: Extends.fromJson(json["extends"]),
        obj2False: False.fromJson(json["False"]),
        obj2Final: Final.fromJson(json["final"]),
        obj2Finally: Finally.fromJson(json["finally"]),
        obj2For: For.fromJson(json["for"]),
        obj2FromJson: FromJson.fromJson(json["from_json"]),
        purpleFalse: FalseClass.fromJson(json["false"]),
    );

    Map<String, dynamic> toJson() => {
        "CultureInfo": cultureInfo.toJson(),
        "date": date.toJson(),
        "DateFormatter": dateFormatter.toJson(),
        "DateOnly": dateOnly.toJson(),
        "DateOnlyConverter": dateOnlyConverter.toJson(),
        "date_parse_handling": dateParseHandling.toJson(),
        "DateTime": dateTime.toJson(),
        "DateTimeStyles": dateTimeStyles.toJson(),
        "debugger": debugger.toJson(),
        "decimal": decimal.toJson(),
        "declare": declare.toJson(),
        "decltype": decltype.toJson(),
        "decode_string": decodeString.toJson(),
        "Decoder": decoder.toJson(),
        "DecodingError": decodingError.toJson(),
        "def": def.toJson(),
        "defer": defer.toJson(),
        "deinit": deinit.toJson(),
        "del": del.toJson(),
        "delegate": delegate.toJson(),
        "delete": delete.toJson(),
        "DeserializationFeature": deserializationFeature.toJson(),
        "dict": dict.toJson(),
        "dictionary": dictionary.toJson(),
        "didSet": didSet.toJson(),
        "DoubleNode": doubleNode.toJson(),
        "dummy": dummy,
        "dynamic_cast": dynamicCast.toJson(),
        "elif": elif.toJson(),
        "encode_quick_type": encodeQuickType.toJson(),
        "Encoder": encoder.toJson(),
        "EnumValues": enumValues.toJson(),
        "equalityContract": equalityContract.toJson(),
        "Equatable": equatable.toJson(),
        "event": event.toJson(),
        "except": except.toJson(),
        "exception": exception.toJson(),
        "explicit": explicit.toJson(),
        "exposing": exposing.toJson(),
        "extension": extension.toJson(),
        "extern": extern.toJson(),
        "fallthrough": fallthrough.toJson(),
        "fileprivate": fileprivate.toJson(),
        "fixed": fixed.toJson(),
        "float": float.toJson(),
        "foreach": foreach.toJson(),
        "FormatException": formatException.toJson(),
        "friend": friend.toJson(),
        "from": from.toJson(),
        "from_dict": fromDict.toJson(),
        "func": func.toJson(),
        "default": obj2Default.toJson(),
        "do": obj2Do.toJson(),
        "double": obj2Double.toJson(),
        "dynamic": obj2Dynamic.toJson(),
        "else": obj2Else.toJson(),
        "enum": obj2Enum.toJson(),
        "export": obj2Export.toJson(),
        "extends": obj2Extends.toJson(),
        "False": obj2False.toJson(),
        "final": obj2Final.toJson(),
        "finally": obj2Finally.toJson(),
        "for": obj2For.toJson(),
        "from_json": obj2FromJson.toJson(),
        "false": purpleFalse.toJson(),
    };
}

class CultureInfo {
    final int cultureInfo;

    CultureInfo({
        required this.cultureInfo,
    });

    factory CultureInfo.fromJson(Map<String, dynamic> json) => CultureInfo(
        cultureInfo: json["CultureInfo"],
    );

    Map<String, dynamic> toJson() => {
        "CultureInfo": cultureInfo,
    };
}

class Date {
    final int date;

    Date({
        required this.date,
    });

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
    };
}

class DateFormatter {
    final int dateFormatter;

    DateFormatter({
        required this.dateFormatter,
    });

    factory DateFormatter.fromJson(Map<String, dynamic> json) => DateFormatter(
        dateFormatter: json["DateFormatter"],
    );

    Map<String, dynamic> toJson() => {
        "DateFormatter": dateFormatter,
    };
}

class DateOnly {
    final int dateOnly;

    DateOnly({
        required this.dateOnly,
    });

    factory DateOnly.fromJson(Map<String, dynamic> json) => DateOnly(
        dateOnly: json["DateOnly"],
    );

    Map<String, dynamic> toJson() => {
        "DateOnly": dateOnly,
    };
}

class DateOnlyConverter {
    final int dateOnlyConverter;

    DateOnlyConverter({
        required this.dateOnlyConverter,
    });

    factory DateOnlyConverter.fromJson(Map<String, dynamic> json) => DateOnlyConverter(
        dateOnlyConverter: json["DateOnlyConverter"],
    );

    Map<String, dynamic> toJson() => {
        "DateOnlyConverter": dateOnlyConverter,
    };
}

class DateParseHandling {
    final int dateParseHandling;

    DateParseHandling({
        required this.dateParseHandling,
    });

    factory DateParseHandling.fromJson(Map<String, dynamic> json) => DateParseHandling(
        dateParseHandling: json["date_parse_handling"],
    );

    Map<String, dynamic> toJson() => {
        "date_parse_handling": dateParseHandling,
    };
}

class DateTimeClass {
    final DateTime dateTime;

    DateTimeClass({
        required this.dateTime,
    });

    factory DateTimeClass.fromJson(Map<String, dynamic> json) => DateTimeClass(
        dateTime: DateTime.parse(json["DateTime"]),
    );

    Map<String, dynamic> toJson() => {
        "DateTime": dateTime.toIso8601String(),
    };
}

class DateTimeStyles {
    final int dateTimeStyles;

    DateTimeStyles({
        required this.dateTimeStyles,
    });

    factory DateTimeStyles.fromJson(Map<String, dynamic> json) => DateTimeStyles(
        dateTimeStyles: json["DateTimeStyles"],
    );

    Map<String, dynamic> toJson() => {
        "DateTimeStyles": dateTimeStyles,
    };
}

class Debugger {
    final int debugger;

    Debugger({
        required this.debugger,
    });

    factory Debugger.fromJson(Map<String, dynamic> json) => Debugger(
        debugger: json["debugger"],
    );

    Map<String, dynamic> toJson() => {
        "debugger": debugger,
    };
}

class Decimal {
    final int decimal;

    Decimal({
        required this.decimal,
    });

    factory Decimal.fromJson(Map<String, dynamic> json) => Decimal(
        decimal: json["decimal"],
    );

    Map<String, dynamic> toJson() => {
        "decimal": decimal,
    };
}

class Declare {
    final int declare;

    Declare({
        required this.declare,
    });

    factory Declare.fromJson(Map<String, dynamic> json) => Declare(
        declare: json["declare"],
    );

    Map<String, dynamic> toJson() => {
        "declare": declare,
    };
}

class Decltype {
    final int decltype;

    Decltype({
        required this.decltype,
    });

    factory Decltype.fromJson(Map<String, dynamic> json) => Decltype(
        decltype: json["decltype"],
    );

    Map<String, dynamic> toJson() => {
        "decltype": decltype,
    };
}

class DecodeString {
    final int decodeString;

    DecodeString({
        required this.decodeString,
    });

    factory DecodeString.fromJson(Map<String, dynamic> json) => DecodeString(
        decodeString: json["decode_string"],
    );

    Map<String, dynamic> toJson() => {
        "decode_string": decodeString,
    };
}

class Decoder {
    final int decoder;

    Decoder({
        required this.decoder,
    });

    factory Decoder.fromJson(Map<String, dynamic> json) => Decoder(
        decoder: json["Decoder"],
    );

    Map<String, dynamic> toJson() => {
        "Decoder": decoder,
    };
}

class DecodingError {
    final int decodingError;

    DecodingError({
        required this.decodingError,
    });

    factory DecodingError.fromJson(Map<String, dynamic> json) => DecodingError(
        decodingError: json["DecodingError"],
    );

    Map<String, dynamic> toJson() => {
        "DecodingError": decodingError,
    };
}

class Def {
    final int def;

    Def({
        required this.def,
    });

    factory Def.fromJson(Map<String, dynamic> json) => Def(
        def: json["def"],
    );

    Map<String, dynamic> toJson() => {
        "def": def,
    };
}

class Defer {
    final int defer;

    Defer({
        required this.defer,
    });

    factory Defer.fromJson(Map<String, dynamic> json) => Defer(
        defer: json["defer"],
    );

    Map<String, dynamic> toJson() => {
        "defer": defer,
    };
}

class Deinit {
    final int deinit;

    Deinit({
        required this.deinit,
    });

    factory Deinit.fromJson(Map<String, dynamic> json) => Deinit(
        deinit: json["deinit"],
    );

    Map<String, dynamic> toJson() => {
        "deinit": deinit,
    };
}

class Del {
    final int del;

    Del({
        required this.del,
    });

    factory Del.fromJson(Map<String, dynamic> json) => Del(
        del: json["del"],
    );

    Map<String, dynamic> toJson() => {
        "del": del,
    };
}

class Delegate {
    final int delegate;

    Delegate({
        required this.delegate,
    });

    factory Delegate.fromJson(Map<String, dynamic> json) => Delegate(
        delegate: json["delegate"],
    );

    Map<String, dynamic> toJson() => {
        "delegate": delegate,
    };
}

class Delete {
    final int delete;

    Delete({
        required this.delete,
    });

    factory Delete.fromJson(Map<String, dynamic> json) => Delete(
        delete: json["delete"],
    );

    Map<String, dynamic> toJson() => {
        "delete": delete,
    };
}

class DeserializationFeature {
    final int deserializationFeature;

    DeserializationFeature({
        required this.deserializationFeature,
    });

    factory DeserializationFeature.fromJson(Map<String, dynamic> json) => DeserializationFeature(
        deserializationFeature: json["DeserializationFeature"],
    );

    Map<String, dynamic> toJson() => {
        "DeserializationFeature": deserializationFeature,
    };
}

class Dict {
    final int dict;

    Dict({
        required this.dict,
    });

    factory Dict.fromJson(Map<String, dynamic> json) => Dict(
        dict: json["dict"],
    );

    Map<String, dynamic> toJson() => {
        "dict": dict,
    };
}

class Dictionary {
    final int dictionary;

    Dictionary({
        required this.dictionary,
    });

    factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
        dictionary: json["dictionary"],
    );

    Map<String, dynamic> toJson() => {
        "dictionary": dictionary,
    };
}

class DidSet {
    final int didSet;

    DidSet({
        required this.didSet,
    });

    factory DidSet.fromJson(Map<String, dynamic> json) => DidSet(
        didSet: json["didSet"],
    );

    Map<String, dynamic> toJson() => {
        "didSet": didSet,
    };
}

class DoubleNode {
    final int doubleNode;

    DoubleNode({
        required this.doubleNode,
    });

    factory DoubleNode.fromJson(Map<String, dynamic> json) => DoubleNode(
        doubleNode: json["DoubleNode"],
    );

    Map<String, dynamic> toJson() => {
        "DoubleNode": doubleNode,
    };
}

class DynamicCast {
    final int dynamicCast;

    DynamicCast({
        required this.dynamicCast,
    });

    factory DynamicCast.fromJson(Map<String, dynamic> json) => DynamicCast(
        dynamicCast: json["dynamic_cast"],
    );

    Map<String, dynamic> toJson() => {
        "dynamic_cast": dynamicCast,
    };
}

class Elif {
    final int elif;

    Elif({
        required this.elif,
    });

    factory Elif.fromJson(Map<String, dynamic> json) => Elif(
        elif: json["elif"],
    );

    Map<String, dynamic> toJson() => {
        "elif": elif,
    };
}

class EncodeQuickType {
    final int encodeQuickType;

    EncodeQuickType({
        required this.encodeQuickType,
    });

    factory EncodeQuickType.fromJson(Map<String, dynamic> json) => EncodeQuickType(
        encodeQuickType: json["encode_quick_type"],
    );

    Map<String, dynamic> toJson() => {
        "encode_quick_type": encodeQuickType,
    };
}

class Encoder {
    final int encoder;

    Encoder({
        required this.encoder,
    });

    factory Encoder.fromJson(Map<String, dynamic> json) => Encoder(
        encoder: json["Encoder"],
    );

    Map<String, dynamic> toJson() => {
        "Encoder": encoder,
    };
}

class EnumValuesClass {
    final List<EnumValue> enumValues;

    EnumValuesClass({
        required this.enumValues,
    });

    factory EnumValuesClass.fromJson(Map<String, dynamic> json) => EnumValuesClass(
        enumValues: List<EnumValue>.from(json["EnumValues"].map((x) => enumValueValues.map[x]!)),
    );

    Map<String, dynamic> toJson() => {
        "EnumValues": List<dynamic>.from(enumValues.map((x) => enumValueValues.reverse[x])),
    };
}

enum EnumValue {
    READY,
    DONE
}

final enumValueValues = EnumValues({
    "ready": EnumValue.READY,
    "done": EnumValue.DONE
});

class EqualityContract {
    final int equalityContract;

    EqualityContract({
        required this.equalityContract,
    });

    factory EqualityContract.fromJson(Map<String, dynamic> json) => EqualityContract(
        equalityContract: json["equalityContract"],
    );

    Map<String, dynamic> toJson() => {
        "equalityContract": equalityContract,
    };
}

class Equatable {
    final int equatable;

    Equatable({
        required this.equatable,
    });

    factory Equatable.fromJson(Map<String, dynamic> json) => Equatable(
        equatable: json["Equatable"],
    );

    Map<String, dynamic> toJson() => {
        "Equatable": equatable,
    };
}

class Event {
    final int event;

    Event({
        required this.event,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        event: json["event"],
    );

    Map<String, dynamic> toJson() => {
        "event": event,
    };
}

class Except {
    final int except;

    Except({
        required this.except,
    });

    factory Except.fromJson(Map<String, dynamic> json) => Except(
        except: json["except"],
    );

    Map<String, dynamic> toJson() => {
        "except": except,
    };
}

class Exception {
    final int exception;

    Exception({
        required this.exception,
    });

    factory Exception.fromJson(Map<String, dynamic> json) => Exception(
        exception: json["exception"],
    );

    Map<String, dynamic> toJson() => {
        "exception": exception,
    };
}

class Explicit {
    final int explicit;

    Explicit({
        required this.explicit,
    });

    factory Explicit.fromJson(Map<String, dynamic> json) => Explicit(
        explicit: json["explicit"],
    );

    Map<String, dynamic> toJson() => {
        "explicit": explicit,
    };
}

class Exposing {
    final int exposing;

    Exposing({
        required this.exposing,
    });

    factory Exposing.fromJson(Map<String, dynamic> json) => Exposing(
        exposing: json["exposing"],
    );

    Map<String, dynamic> toJson() => {
        "exposing": exposing,
    };
}

class Extension {
    final int extension;

    Extension({
        required this.extension,
    });

    factory Extension.fromJson(Map<String, dynamic> json) => Extension(
        extension: json["extension"],
    );

    Map<String, dynamic> toJson() => {
        "extension": extension,
    };
}

class Extern {
    final int extern;

    Extern({
        required this.extern,
    });

    factory Extern.fromJson(Map<String, dynamic> json) => Extern(
        extern: json["extern"],
    );

    Map<String, dynamic> toJson() => {
        "extern": extern,
    };
}

class Fallthrough {
    final int fallthrough;

    Fallthrough({
        required this.fallthrough,
    });

    factory Fallthrough.fromJson(Map<String, dynamic> json) => Fallthrough(
        fallthrough: json["fallthrough"],
    );

    Map<String, dynamic> toJson() => {
        "fallthrough": fallthrough,
    };
}

class Fileprivate {
    final int fileprivate;

    Fileprivate({
        required this.fileprivate,
    });

    factory Fileprivate.fromJson(Map<String, dynamic> json) => Fileprivate(
        fileprivate: json["fileprivate"],
    );

    Map<String, dynamic> toJson() => {
        "fileprivate": fileprivate,
    };
}

class Fixed {
    final int fixed;

    Fixed({
        required this.fixed,
    });

    factory Fixed.fromJson(Map<String, dynamic> json) => Fixed(
        fixed: json["fixed"],
    );

    Map<String, dynamic> toJson() => {
        "fixed": fixed,
    };
}

class Float {
    final int float;

    Float({
        required this.float,
    });

    factory Float.fromJson(Map<String, dynamic> json) => Float(
        float: json["float"],
    );

    Map<String, dynamic> toJson() => {
        "float": float,
    };
}

class Foreach {
    final int foreach;

    Foreach({
        required this.foreach,
    });

    factory Foreach.fromJson(Map<String, dynamic> json) => Foreach(
        foreach: json["foreach"],
    );

    Map<String, dynamic> toJson() => {
        "foreach": foreach,
    };
}

class FormatExceptionClass {
    final int formatException;

    FormatExceptionClass({
        required this.formatException,
    });

    factory FormatExceptionClass.fromJson(Map<String, dynamic> json) => FormatExceptionClass(
        formatException: json["FormatException"],
    );

    Map<String, dynamic> toJson() => {
        "FormatException": formatException,
    };
}

class Friend {
    final int friend;

    Friend({
        required this.friend,
    });

    factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        friend: json["friend"],
    );

    Map<String, dynamic> toJson() => {
        "friend": friend,
    };
}

class From {
    final int from;

    From({
        required this.from,
    });

    factory From.fromJson(Map<String, dynamic> json) => From(
        from: json["from"],
    );

    Map<String, dynamic> toJson() => {
        "from": from,
    };
}

class FromDict {
    final int fromDict;

    FromDict({
        required this.fromDict,
    });

    factory FromDict.fromJson(Map<String, dynamic> json) => FromDict(
        fromDict: json["from_dict"],
    );

    Map<String, dynamic> toJson() => {
        "from_dict": fromDict,
    };
}

class Func {
    final int func;

    Func({
        required this.func,
    });

    factory Func.fromJson(Map<String, dynamic> json) => Func(
        func: json["func"],
    );

    Map<String, dynamic> toJson() => {
        "func": func,
    };
}

class Default {
    final int defaultDefault;

    Default({
        required this.defaultDefault,
    });

    factory Default.fromJson(Map<String, dynamic> json) => Default(
        defaultDefault: json["default"],
    );

    Map<String, dynamic> toJson() => {
        "default": defaultDefault,
    };
}

class Do {
    final int doDo;

    Do({
        required this.doDo,
    });

    factory Do.fromJson(Map<String, dynamic> json) => Do(
        doDo: json["do"],
    );

    Map<String, dynamic> toJson() => {
        "do": doDo,
    };
}

class Double {
    final int doubleDouble;

    Double({
        required this.doubleDouble,
    });

    factory Double.fromJson(Map<String, dynamic> json) => Double(
        doubleDouble: json["double"],
    );

    Map<String, dynamic> toJson() => {
        "double": doubleDouble,
    };
}

class Dynamic {
    final int dynamicDynamic;

    Dynamic({
        required this.dynamicDynamic,
    });

    factory Dynamic.fromJson(Map<String, dynamic> json) => Dynamic(
        dynamicDynamic: json["dynamic"],
    );

    Map<String, dynamic> toJson() => {
        "dynamic": dynamicDynamic,
    };
}

class Else {
    final int elseElse;

    Else({
        required this.elseElse,
    });

    factory Else.fromJson(Map<String, dynamic> json) => Else(
        elseElse: json["else"],
    );

    Map<String, dynamic> toJson() => {
        "else": elseElse,
    };
}

class Enum {
    final int enumEnum;

    Enum({
        required this.enumEnum,
    });

    factory Enum.fromJson(Map<String, dynamic> json) => Enum(
        enumEnum: json["enum"],
    );

    Map<String, dynamic> toJson() => {
        "enum": enumEnum,
    };
}

class Export {
    final int exportExport;

    Export({
        required this.exportExport,
    });

    factory Export.fromJson(Map<String, dynamic> json) => Export(
        exportExport: json["export"],
    );

    Map<String, dynamic> toJson() => {
        "export": exportExport,
    };
}

class Extends {
    final int extendsExtends;

    Extends({
        required this.extendsExtends,
    });

    factory Extends.fromJson(Map<String, dynamic> json) => Extends(
        extendsExtends: json["extends"],
    );

    Map<String, dynamic> toJson() => {
        "extends": extendsExtends,
    };
}

class False {
    final int falseFalse;

    False({
        required this.falseFalse,
    });

    factory False.fromJson(Map<String, dynamic> json) => False(
        falseFalse: json["False"],
    );

    Map<String, dynamic> toJson() => {
        "False": falseFalse,
    };
}

class Final {
    final int finalFinal;

    Final({
        required this.finalFinal,
    });

    factory Final.fromJson(Map<String, dynamic> json) => Final(
        finalFinal: json["final"],
    );

    Map<String, dynamic> toJson() => {
        "final": finalFinal,
    };
}

class Finally {
    final int finallyFinally;

    Finally({
        required this.finallyFinally,
    });

    factory Finally.fromJson(Map<String, dynamic> json) => Finally(
        finallyFinally: json["finally"],
    );

    Map<String, dynamic> toJson() => {
        "finally": finallyFinally,
    };
}

class For {
    final int forFor;

    For({
        required this.forFor,
    });

    factory For.fromJson(Map<String, dynamic> json) => For(
        forFor: json["for"],
    );

    Map<String, dynamic> toJson() => {
        "for": forFor,
    };
}

class FromJson {
    final int fromJsonFromJson;

    FromJson({
        required this.fromJsonFromJson,
    });

    factory FromJson.fromJson(Map<String, dynamic> json) => FromJson(
        fromJsonFromJson: json["from_json"],
    );

    Map<String, dynamic> toJson() => {
        "from_json": fromJsonFromJson,
    };
}

class FalseClass {
    final int falseFalse;

    FalseClass({
        required this.falseFalse,
    });

    factory FalseClass.fromJson(Map<String, dynamic> json) => FalseClass(
        falseFalse: json["false"],
    );

    Map<String, dynamic> toJson() => {
        "false": falseFalse,
    };
}

class Obj3 {
    final int dummy;
    final FunctionClass function;
    final Global global;
    final Go go;
    final Goto goto;
    final Guard guard;
    final HasOwnProperty hasOwnProperty;
    final Hashable hashable;
    final Hasher hasher;
    final Id id;
    final Imp imp;
    final Implicit implicit;
    final Indirect indirect;
    final Infix infix;
    final Init init;
    final Inline inline;
    final Inout inout;
    final Instanceof instanceof;
    final IntNode intNode;
    final Internal internal;
    final IsoDateTimeOffsetConverter isoDateTimeOffsetConverter;
    final Iterable iterable;
    final Jdec jdec;
    final Jenc jenc;
    final Jpipe jpipe;
    final Json json;
    final JsonAny jsonAny;
    final JsonCodingKey jsonCodingKey;
    final JsonConverter jsonConverter;
    final JsonDecoder jsonDecoder;
    final JsonEncoder jsonEncoder;
    final JsonException jsonException;
    final JsonGenerator jsonGenerator;
    final JsonNode jsonNode;
    final JsonNull jsonNull;
    final JsonParser jsonParser;
    final JsonReader jsonReader;
    final JsonSerializer jsonSerializer;
    final JsonToken jsonToken;
    final JsonTokenType jsonTokenType;
    final JsonWriter jsonWriter;
    final Lambda lambda;
    final Lazy lazy;
    final Left left;
    final Let let;
    final ListClass list;
    final LocalDate localDate;
    final Locale locale;
    final Lock lock;
    final Long long;
    final LongNode longNode;
    final MapClass map;
    final MapEntryClass mapEntry;
    final MarshalJson marshalJson;
    final MetadataPropertyHandling metadataPropertyHandling;
    final Module module;
    final Get obj3Get;
    final HashCode obj3HashCode;
    final If obj3If;
    final Implements obj3Implements;
    final Import obj3Import;
    final In obj3In;
    final Int obj3Int;
    final Interface obj3Interface;
    final Is obj3Is;

    Obj3({
        required this.dummy,
        required this.function,
        required this.global,
        required this.go,
        required this.goto,
        required this.guard,
        required this.hasOwnProperty,
        required this.hashable,
        required this.hasher,
        required this.id,
        required this.imp,
        required this.implicit,
        required this.indirect,
        required this.infix,
        required this.init,
        required this.inline,
        required this.inout,
        required this.instanceof,
        required this.intNode,
        required this.internal,
        required this.isoDateTimeOffsetConverter,
        required this.iterable,
        required this.jdec,
        required this.jenc,
        required this.jpipe,
        required this.json,
        required this.jsonAny,
        required this.jsonCodingKey,
        required this.jsonConverter,
        required this.jsonDecoder,
        required this.jsonEncoder,
        required this.jsonException,
        required this.jsonGenerator,
        required this.jsonNode,
        required this.jsonNull,
        required this.jsonParser,
        required this.jsonReader,
        required this.jsonSerializer,
        required this.jsonToken,
        required this.jsonTokenType,
        required this.jsonWriter,
        required this.lambda,
        required this.lazy,
        required this.left,
        required this.let,
        required this.list,
        required this.localDate,
        required this.locale,
        required this.lock,
        required this.long,
        required this.longNode,
        required this.map,
        required this.mapEntry,
        required this.marshalJson,
        required this.metadataPropertyHandling,
        required this.module,
        required this.obj3Get,
        required this.obj3HashCode,
        required this.obj3If,
        required this.obj3Implements,
        required this.obj3Import,
        required this.obj3In,
        required this.obj3Int,
        required this.obj3Interface,
        required this.obj3Is,
    });

    factory Obj3.fromJson(Map<String, dynamic> json) => Obj3(
        dummy: json["dummy"],
        function: FunctionClass.fromJson(json["function"]),
        global: Global.fromJson(json["global"]),
        go: Go.fromJson(json["go"]),
        goto: Goto.fromJson(json["goto"]),
        guard: Guard.fromJson(json["guard"]),
        hasOwnProperty: HasOwnProperty.fromJson(json["hasOwnProperty"]),
        hashable: Hashable.fromJson(json["Hashable"]),
        hasher: Hasher.fromJson(json["Hasher"]),
        id: Id.fromJson(json["id"]),
        imp: Imp.fromJson(json["IMP"]),
        implicit: Implicit.fromJson(json["implicit"]),
        indirect: Indirect.fromJson(json["indirect"]),
        infix: Infix.fromJson(json["infix"]),
        init: Init.fromJson(json["init"]),
        inline: Inline.fromJson(json["inline"]),
        inout: Inout.fromJson(json["inout"]),
        instanceof: Instanceof.fromJson(json["instanceof"]),
        intNode: IntNode.fromJson(json["IntNode"]),
        internal: Internal.fromJson(json["internal"]),
        isoDateTimeOffsetConverter: IsoDateTimeOffsetConverter.fromJson(json["IsoDateTimeOffsetConverter"]),
        iterable: Iterable.fromJson(json["iterable"]),
        jdec: Jdec.fromJson(json["jdec"]),
        jenc: Jenc.fromJson(json["jenc"]),
        jpipe: Jpipe.fromJson(json["jpipe"]),
        json: Json.fromJson(json["json"]),
        jsonAny: JsonAny.fromJson(json["JSONAny"]),
        jsonCodingKey: JsonCodingKey.fromJson(json["JSONCodingKey"]),
        jsonConverter: JsonConverter.fromJson(json["json_converter"]),
        jsonDecoder: JsonDecoder.fromJson(json["JSONDecoder"]),
        jsonEncoder: JsonEncoder.fromJson(json["JSONEncoder"]),
        jsonException: JsonException.fromJson(json["JsonException"]),
        jsonGenerator: JsonGenerator.fromJson(json["JsonGenerator"]),
        jsonNode: JsonNode.fromJson(json["JsonNode"]),
        jsonNull: JsonNull.fromJson(json["JSONNull"]),
        jsonParser: JsonParser.fromJson(json["JsonParser"]),
        jsonReader: JsonReader.fromJson(json["JsonReader"]),
        jsonSerializer: JsonSerializer.fromJson(json["json_serializer"]),
        jsonToken: JsonToken.fromJson(json["json_token"]),
        jsonTokenType: JsonTokenType.fromJson(json["JsonTokenType"]),
        jsonWriter: JsonWriter.fromJson(json["json_writer"]),
        lambda: Lambda.fromJson(json["lambda"]),
        lazy: Lazy.fromJson(json["lazy"]),
        left: Left.fromJson(json["left"]),
        let: Let.fromJson(json["let"]),
        list: ListClass.fromJson(json["list"]),
        localDate: LocalDate.fromJson(json["LocalDate"]),
        locale: Locale.fromJson(json["Locale"]),
        lock: Lock.fromJson(json["lock"]),
        long: Long.fromJson(json["long"]),
        longNode: LongNode.fromJson(json["LongNode"]),
        map: MapClass.fromJson(json["map"]),
        mapEntry: MapEntryClass.fromJson(json["MapEntry"]),
        marshalJson: MarshalJson.fromJson(json["MarshalJSON"]),
        metadataPropertyHandling: MetadataPropertyHandling.fromJson(json["metadata_property_handling"]),
        module: Module.fromJson(json["module"]),
        obj3Get: Get.fromJson(json["get"]),
        obj3HashCode: HashCode.fromJson(json["hashCode"]),
        obj3If: If.fromJson(json["if"]),
        obj3Implements: Implements.fromJson(json["implements"]),
        obj3Import: Import.fromJson(json["import"]),
        obj3In: In.fromJson(json["in"]),
        obj3Int: Int.fromJson(json["int"]),
        obj3Interface: Interface.fromJson(json["interface"]),
        obj3Is: Is.fromJson(json["is"]),
    );

    Map<String, dynamic> toJson() => {
        "dummy": dummy,
        "function": function.toJson(),
        "global": global.toJson(),
        "go": go.toJson(),
        "goto": goto.toJson(),
        "guard": guard.toJson(),
        "hasOwnProperty": hasOwnProperty.toJson(),
        "Hashable": hashable.toJson(),
        "Hasher": hasher.toJson(),
        "id": id.toJson(),
        "IMP": imp.toJson(),
        "implicit": implicit.toJson(),
        "indirect": indirect.toJson(),
        "infix": infix.toJson(),
        "init": init.toJson(),
        "inline": inline.toJson(),
        "inout": inout.toJson(),
        "instanceof": instanceof.toJson(),
        "IntNode": intNode.toJson(),
        "internal": internal.toJson(),
        "IsoDateTimeOffsetConverter": isoDateTimeOffsetConverter.toJson(),
        "iterable": iterable.toJson(),
        "jdec": jdec.toJson(),
        "jenc": jenc.toJson(),
        "jpipe": jpipe.toJson(),
        "json": json.toJson(),
        "JSONAny": jsonAny.toJson(),
        "JSONCodingKey": jsonCodingKey.toJson(),
        "json_converter": jsonConverter.toJson(),
        "JSONDecoder": jsonDecoder.toJson(),
        "JSONEncoder": jsonEncoder.toJson(),
        "JsonException": jsonException.toJson(),
        "JsonGenerator": jsonGenerator.toJson(),
        "JsonNode": jsonNode.toJson(),
        "JSONNull": jsonNull.toJson(),
        "JsonParser": jsonParser.toJson(),
        "JsonReader": jsonReader.toJson(),
        "json_serializer": jsonSerializer.toJson(),
        "json_token": jsonToken.toJson(),
        "JsonTokenType": jsonTokenType.toJson(),
        "json_writer": jsonWriter.toJson(),
        "lambda": lambda.toJson(),
        "lazy": lazy.toJson(),
        "left": left.toJson(),
        "let": let.toJson(),
        "list": list.toJson(),
        "LocalDate": localDate.toJson(),
        "Locale": locale.toJson(),
        "lock": lock.toJson(),
        "long": long.toJson(),
        "LongNode": longNode.toJson(),
        "map": map.toJson(),
        "MapEntry": mapEntry.toJson(),
        "MarshalJSON": marshalJson.toJson(),
        "metadata_property_handling": metadataPropertyHandling.toJson(),
        "module": module.toJson(),
        "get": obj3Get.toJson(),
        "hashCode": obj3HashCode.toJson(),
        "if": obj3If.toJson(),
        "implements": obj3Implements.toJson(),
        "import": obj3Import.toJson(),
        "in": obj3In.toJson(),
        "int": obj3Int.toJson(),
        "interface": obj3Interface.toJson(),
        "is": obj3Is.toJson(),
    };
}

class FunctionClass {
    final int function;

    FunctionClass({
        required this.function,
    });

    factory FunctionClass.fromJson(Map<String, dynamic> json) => FunctionClass(
        function: json["function"],
    );

    Map<String, dynamic> toJson() => {
        "function": function,
    };
}

class Global {
    final int global;

    Global({
        required this.global,
    });

    factory Global.fromJson(Map<String, dynamic> json) => Global(
        global: json["global"],
    );

    Map<String, dynamic> toJson() => {
        "global": global,
    };
}

class Go {
    final int go;

    Go({
        required this.go,
    });

    factory Go.fromJson(Map<String, dynamic> json) => Go(
        go: json["go"],
    );

    Map<String, dynamic> toJson() => {
        "go": go,
    };
}

class Goto {
    final int goto;

    Goto({
        required this.goto,
    });

    factory Goto.fromJson(Map<String, dynamic> json) => Goto(
        goto: json["goto"],
    );

    Map<String, dynamic> toJson() => {
        "goto": goto,
    };
}

class Guard {
    final int guard;

    Guard({
        required this.guard,
    });

    factory Guard.fromJson(Map<String, dynamic> json) => Guard(
        guard: json["guard"],
    );

    Map<String, dynamic> toJson() => {
        "guard": guard,
    };
}

class HasOwnProperty {
    final int hasOwnProperty;

    HasOwnProperty({
        required this.hasOwnProperty,
    });

    factory HasOwnProperty.fromJson(Map<String, dynamic> json) => HasOwnProperty(
        hasOwnProperty: json["hasOwnProperty"],
    );

    Map<String, dynamic> toJson() => {
        "hasOwnProperty": hasOwnProperty,
    };
}

class Hashable {
    final int hashable;

    Hashable({
        required this.hashable,
    });

    factory Hashable.fromJson(Map<String, dynamic> json) => Hashable(
        hashable: json["Hashable"],
    );

    Map<String, dynamic> toJson() => {
        "Hashable": hashable,
    };
}

class Hasher {
    final int hasher;

    Hasher({
        required this.hasher,
    });

    factory Hasher.fromJson(Map<String, dynamic> json) => Hasher(
        hasher: json["Hasher"],
    );

    Map<String, dynamic> toJson() => {
        "Hasher": hasher,
    };
}

class Id {
    final int id;

    Id({
        required this.id,
    });

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

class Imp {
    final int imp;

    Imp({
        required this.imp,
    });

    factory Imp.fromJson(Map<String, dynamic> json) => Imp(
        imp: json["IMP"],
    );

    Map<String, dynamic> toJson() => {
        "IMP": imp,
    };
}

class Implicit {
    final int implicit;

    Implicit({
        required this.implicit,
    });

    factory Implicit.fromJson(Map<String, dynamic> json) => Implicit(
        implicit: json["implicit"],
    );

    Map<String, dynamic> toJson() => {
        "implicit": implicit,
    };
}

class Indirect {
    final int indirect;

    Indirect({
        required this.indirect,
    });

    factory Indirect.fromJson(Map<String, dynamic> json) => Indirect(
        indirect: json["indirect"],
    );

    Map<String, dynamic> toJson() => {
        "indirect": indirect,
    };
}

class Infix {
    final int infix;

    Infix({
        required this.infix,
    });

    factory Infix.fromJson(Map<String, dynamic> json) => Infix(
        infix: json["infix"],
    );

    Map<String, dynamic> toJson() => {
        "infix": infix,
    };
}

class Init {
    final int init;

    Init({
        required this.init,
    });

    factory Init.fromJson(Map<String, dynamic> json) => Init(
        init: json["init"],
    );

    Map<String, dynamic> toJson() => {
        "init": init,
    };
}

class Inline {
    final int inline;

    Inline({
        required this.inline,
    });

    factory Inline.fromJson(Map<String, dynamic> json) => Inline(
        inline: json["inline"],
    );

    Map<String, dynamic> toJson() => {
        "inline": inline,
    };
}

class Inout {
    final int inout;

    Inout({
        required this.inout,
    });

    factory Inout.fromJson(Map<String, dynamic> json) => Inout(
        inout: json["inout"],
    );

    Map<String, dynamic> toJson() => {
        "inout": inout,
    };
}

class Instanceof {
    final int instanceof;

    Instanceof({
        required this.instanceof,
    });

    factory Instanceof.fromJson(Map<String, dynamic> json) => Instanceof(
        instanceof: json["instanceof"],
    );

    Map<String, dynamic> toJson() => {
        "instanceof": instanceof,
    };
}

class IntNode {
    final int intNode;

    IntNode({
        required this.intNode,
    });

    factory IntNode.fromJson(Map<String, dynamic> json) => IntNode(
        intNode: json["IntNode"],
    );

    Map<String, dynamic> toJson() => {
        "IntNode": intNode,
    };
}

class Internal {
    final int internal;

    Internal({
        required this.internal,
    });

    factory Internal.fromJson(Map<String, dynamic> json) => Internal(
        internal: json["internal"],
    );

    Map<String, dynamic> toJson() => {
        "internal": internal,
    };
}

class IsoDateTimeOffsetConverter {
    final int isoDateTimeOffsetConverter;

    IsoDateTimeOffsetConverter({
        required this.isoDateTimeOffsetConverter,
    });

    factory IsoDateTimeOffsetConverter.fromJson(Map<String, dynamic> json) => IsoDateTimeOffsetConverter(
        isoDateTimeOffsetConverter: json["IsoDateTimeOffsetConverter"],
    );

    Map<String, dynamic> toJson() => {
        "IsoDateTimeOffsetConverter": isoDateTimeOffsetConverter,
    };
}

class Iterable {
    final int iterable;

    Iterable({
        required this.iterable,
    });

    factory Iterable.fromJson(Map<String, dynamic> json) => Iterable(
        iterable: json["iterable"],
    );

    Map<String, dynamic> toJson() => {
        "iterable": iterable,
    };
}

class Jdec {
    final int jdec;

    Jdec({
        required this.jdec,
    });

    factory Jdec.fromJson(Map<String, dynamic> json) => Jdec(
        jdec: json["jdec"],
    );

    Map<String, dynamic> toJson() => {
        "jdec": jdec,
    };
}

class Jenc {
    final int jenc;

    Jenc({
        required this.jenc,
    });

    factory Jenc.fromJson(Map<String, dynamic> json) => Jenc(
        jenc: json["jenc"],
    );

    Map<String, dynamic> toJson() => {
        "jenc": jenc,
    };
}

class Jpipe {
    final int jpipe;

    Jpipe({
        required this.jpipe,
    });

    factory Jpipe.fromJson(Map<String, dynamic> json) => Jpipe(
        jpipe: json["jpipe"],
    );

    Map<String, dynamic> toJson() => {
        "jpipe": jpipe,
    };
}

class Json {
    final int json;

    Json({
        required this.json,
    });

    factory Json.fromJson(Map<String, dynamic> json) => Json(
        json: json["json"],
    );

    Map<String, dynamic> toJson() => {
        "json": json,
    };
}

class JsonAny {
    final dynamic jsonAny;

    JsonAny({
        required this.jsonAny,
    });

    factory JsonAny.fromJson(Map<String, dynamic> json) => JsonAny(
        jsonAny: (json.containsKey("JSONAny") ? json["JSONAny"] : throw FormatException('Missing required property')),
    );

    Map<String, dynamic> toJson() => {
        "JSONAny": jsonAny,
    };
}

class JsonCodingKey {
    final int jsonCodingKey;

    JsonCodingKey({
        required this.jsonCodingKey,
    });

    factory JsonCodingKey.fromJson(Map<String, dynamic> json) => JsonCodingKey(
        jsonCodingKey: json["JSONCodingKey"],
    );

    Map<String, dynamic> toJson() => {
        "JSONCodingKey": jsonCodingKey,
    };
}

class JsonConverter {
    final int jsonConverter;

    JsonConverter({
        required this.jsonConverter,
    });

    factory JsonConverter.fromJson(Map<String, dynamic> json) => JsonConverter(
        jsonConverter: json["json_converter"],
    );

    Map<String, dynamic> toJson() => {
        "json_converter": jsonConverter,
    };
}

class JsonDecoder {
    final int jsonDecoder;

    JsonDecoder({
        required this.jsonDecoder,
    });

    factory JsonDecoder.fromJson(Map<String, dynamic> json) => JsonDecoder(
        jsonDecoder: json["JSONDecoder"],
    );

    Map<String, dynamic> toJson() => {
        "JSONDecoder": jsonDecoder,
    };
}

class JsonEncoder {
    final int jsonEncoder;

    JsonEncoder({
        required this.jsonEncoder,
    });

    factory JsonEncoder.fromJson(Map<String, dynamic> json) => JsonEncoder(
        jsonEncoder: json["JSONEncoder"],
    );

    Map<String, dynamic> toJson() => {
        "JSONEncoder": jsonEncoder,
    };
}

class JsonException {
    final int jsonException;

    JsonException({
        required this.jsonException,
    });

    factory JsonException.fromJson(Map<String, dynamic> json) => JsonException(
        jsonException: json["JsonException"],
    );

    Map<String, dynamic> toJson() => {
        "JsonException": jsonException,
    };
}

class JsonGenerator {
    final int jsonGenerator;

    JsonGenerator({
        required this.jsonGenerator,
    });

    factory JsonGenerator.fromJson(Map<String, dynamic> json) => JsonGenerator(
        jsonGenerator: json["JsonGenerator"],
    );

    Map<String, dynamic> toJson() => {
        "JsonGenerator": jsonGenerator,
    };
}

class JsonNode {
    final int jsonNode;

    JsonNode({
        required this.jsonNode,
    });

    factory JsonNode.fromJson(Map<String, dynamic> json) => JsonNode(
        jsonNode: json["JsonNode"],
    );

    Map<String, dynamic> toJson() => {
        "JsonNode": jsonNode,
    };
}

class JsonNull {
    final int jsonNull;

    JsonNull({
        required this.jsonNull,
    });

    factory JsonNull.fromJson(Map<String, dynamic> json) => JsonNull(
        jsonNull: json["JSONNull"],
    );

    Map<String, dynamic> toJson() => {
        "JSONNull": jsonNull,
    };
}

class JsonParser {
    final int jsonParser;

    JsonParser({
        required this.jsonParser,
    });

    factory JsonParser.fromJson(Map<String, dynamic> json) => JsonParser(
        jsonParser: json["JsonParser"],
    );

    Map<String, dynamic> toJson() => {
        "JsonParser": jsonParser,
    };
}

class JsonReader {
    final int jsonReader;

    JsonReader({
        required this.jsonReader,
    });

    factory JsonReader.fromJson(Map<String, dynamic> json) => JsonReader(
        jsonReader: json["JsonReader"],
    );

    Map<String, dynamic> toJson() => {
        "JsonReader": jsonReader,
    };
}

class JsonSerializer {
    final int jsonSerializer;

    JsonSerializer({
        required this.jsonSerializer,
    });

    factory JsonSerializer.fromJson(Map<String, dynamic> json) => JsonSerializer(
        jsonSerializer: json["json_serializer"],
    );

    Map<String, dynamic> toJson() => {
        "json_serializer": jsonSerializer,
    };
}

class JsonToken {
    final int jsonToken;

    JsonToken({
        required this.jsonToken,
    });

    factory JsonToken.fromJson(Map<String, dynamic> json) => JsonToken(
        jsonToken: json["json_token"],
    );

    Map<String, dynamic> toJson() => {
        "json_token": jsonToken,
    };
}

class JsonTokenType {
    final int jsonTokenType;

    JsonTokenType({
        required this.jsonTokenType,
    });

    factory JsonTokenType.fromJson(Map<String, dynamic> json) => JsonTokenType(
        jsonTokenType: json["JsonTokenType"],
    );

    Map<String, dynamic> toJson() => {
        "JsonTokenType": jsonTokenType,
    };
}

class JsonWriter {
    final int jsonWriter;

    JsonWriter({
        required this.jsonWriter,
    });

    factory JsonWriter.fromJson(Map<String, dynamic> json) => JsonWriter(
        jsonWriter: json["json_writer"],
    );

    Map<String, dynamic> toJson() => {
        "json_writer": jsonWriter,
    };
}

class Lambda {
    final int lambda;

    Lambda({
        required this.lambda,
    });

    factory Lambda.fromJson(Map<String, dynamic> json) => Lambda(
        lambda: json["lambda"],
    );

    Map<String, dynamic> toJson() => {
        "lambda": lambda,
    };
}

class Lazy {
    final int lazy;

    Lazy({
        required this.lazy,
    });

    factory Lazy.fromJson(Map<String, dynamic> json) => Lazy(
        lazy: json["lazy"],
    );

    Map<String, dynamic> toJson() => {
        "lazy": lazy,
    };
}

class Left {
    final int left;

    Left({
        required this.left,
    });

    factory Left.fromJson(Map<String, dynamic> json) => Left(
        left: json["left"],
    );

    Map<String, dynamic> toJson() => {
        "left": left,
    };
}

class Let {
    final int let;

    Let({
        required this.let,
    });

    factory Let.fromJson(Map<String, dynamic> json) => Let(
        let: json["let"],
    );

    Map<String, dynamic> toJson() => {
        "let": let,
    };
}

class ListClass {
    final int list;

    ListClass({
        required this.list,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        list: json["list"],
    );

    Map<String, dynamic> toJson() => {
        "list": list,
    };
}

class LocalDate {
    final int localDate;

    LocalDate({
        required this.localDate,
    });

    factory LocalDate.fromJson(Map<String, dynamic> json) => LocalDate(
        localDate: json["LocalDate"],
    );

    Map<String, dynamic> toJson() => {
        "LocalDate": localDate,
    };
}

class Locale {
    final int locale;

    Locale({
        required this.locale,
    });

    factory Locale.fromJson(Map<String, dynamic> json) => Locale(
        locale: json["Locale"],
    );

    Map<String, dynamic> toJson() => {
        "Locale": locale,
    };
}

class Lock {
    final int lock;

    Lock({
        required this.lock,
    });

    factory Lock.fromJson(Map<String, dynamic> json) => Lock(
        lock: json["lock"],
    );

    Map<String, dynamic> toJson() => {
        "lock": lock,
    };
}

class Long {
    final int long;

    Long({
        required this.long,
    });

    factory Long.fromJson(Map<String, dynamic> json) => Long(
        long: json["long"],
    );

    Map<String, dynamic> toJson() => {
        "long": long,
    };
}

class LongNode {
    final int longNode;

    LongNode({
        required this.longNode,
    });

    factory LongNode.fromJson(Map<String, dynamic> json) => LongNode(
        longNode: json["LongNode"],
    );

    Map<String, dynamic> toJson() => {
        "LongNode": longNode,
    };
}

class MapClass {
    final int map;

    MapClass({
        required this.map,
    });

    factory MapClass.fromJson(Map<String, dynamic> json) => MapClass(
        map: json["map"],
    );

    Map<String, dynamic> toJson() => {
        "map": map,
    };
}

class MapEntryClass {
    final int mapEntry;

    MapEntryClass({
        required this.mapEntry,
    });

    factory MapEntryClass.fromJson(Map<String, dynamic> json) => MapEntryClass(
        mapEntry: json["MapEntry"],
    );

    Map<String, dynamic> toJson() => {
        "MapEntry": mapEntry,
    };
}

class MarshalJson {
    final int marshalJson;

    MarshalJson({
        required this.marshalJson,
    });

    factory MarshalJson.fromJson(Map<String, dynamic> json) => MarshalJson(
        marshalJson: json["MarshalJSON"],
    );

    Map<String, dynamic> toJson() => {
        "MarshalJSON": marshalJson,
    };
}

class MetadataPropertyHandling {
    final int metadataPropertyHandling;

    MetadataPropertyHandling({
        required this.metadataPropertyHandling,
    });

    factory MetadataPropertyHandling.fromJson(Map<String, dynamic> json) => MetadataPropertyHandling(
        metadataPropertyHandling: json["metadata_property_handling"],
    );

    Map<String, dynamic> toJson() => {
        "metadata_property_handling": metadataPropertyHandling,
    };
}

class Module {
    final int module;

    Module({
        required this.module,
    });

    factory Module.fromJson(Map<String, dynamic> json) => Module(
        module: json["module"],
    );

    Map<String, dynamic> toJson() => {
        "module": module,
    };
}

class Get {
    final int getGet;

    Get({
        required this.getGet,
    });

    factory Get.fromJson(Map<String, dynamic> json) => Get(
        getGet: json["get"],
    );

    Map<String, dynamic> toJson() => {
        "get": getGet,
    };
}

class HashCode {
    final int hashCodeHashCode;

    HashCode({
        required this.hashCodeHashCode,
    });

    factory HashCode.fromJson(Map<String, dynamic> json) => HashCode(
        hashCodeHashCode: json["hashCode"],
    );

    Map<String, dynamic> toJson() => {
        "hashCode": hashCodeHashCode,
    };
}

class If {
    final int ifIf;

    If({
        required this.ifIf,
    });

    factory If.fromJson(Map<String, dynamic> json) => If(
        ifIf: json["if"],
    );

    Map<String, dynamic> toJson() => {
        "if": ifIf,
    };
}

class Implements {
    final int implementsImplements;

    Implements({
        required this.implementsImplements,
    });

    factory Implements.fromJson(Map<String, dynamic> json) => Implements(
        implementsImplements: json["implements"],
    );

    Map<String, dynamic> toJson() => {
        "implements": implementsImplements,
    };
}

class Import {
    final int importImport;

    Import({
        required this.importImport,
    });

    factory Import.fromJson(Map<String, dynamic> json) => Import(
        importImport: json["import"],
    );

    Map<String, dynamic> toJson() => {
        "import": importImport,
    };
}

class In {
    final int inIn;

    In({
        required this.inIn,
    });

    factory In.fromJson(Map<String, dynamic> json) => In(
        inIn: json["in"],
    );

    Map<String, dynamic> toJson() => {
        "in": inIn,
    };
}

class Int {
    final int intInt;

    Int({
        required this.intInt,
    });

    factory Int.fromJson(Map<String, dynamic> json) => Int(
        intInt: json["int"],
    );

    Map<String, dynamic> toJson() => {
        "int": intInt,
    };
}

class Interface {
    final int interfaceInterface;

    Interface({
        required this.interfaceInterface,
    });

    factory Interface.fromJson(Map<String, dynamic> json) => Interface(
        interfaceInterface: json["interface"],
    );

    Map<String, dynamic> toJson() => {
        "interface": interfaceInterface,
    };
}

class Is {
    final int isIs;

    Is({
        required this.isIs,
    });

    factory Is.fromJson(Map<String, dynamic> json) => Is(
        isIs: json["is"],
    );

    Map<String, dynamic> toJson() => {
        "is": isIs,
    };
}

class Obj4 {
    final int dummy;
    final Mutable mutable;
    final Mutating mutating;
    final Namespace namespace;
    final Native native;
    final Newtonsoft newtonsoft;
    final Nil nil;
    final No no;
    final Noexcept noexcept;
    final Nonatomic nonatomic;
    final None none;
    final Nonlocal nonlocal;
    final Nonmutating nonmutating;
    final Not not;
    final NotEq notEq;
    final NsError nsError;
    final NsObject nsObject;
    final NsString nsString;
    final NullNode nullNode;
    final Nullptr nullptr;
    final Number number;
    final New obj4New;
    final NoSuchMethod obj4NoSuchMethod;
    final NoneClass obj4None;
    final Null obj4Null;
    final Operator obj4Operator;
    final ProtocolClass obj4Protocol;
    final Object object;
    final ObjectMapper objectMapper;
    final ObjectNode objectNode;
    final ObjectReader objectReader;
    final ObjectWriter objectWriter;
    final Of of;
    final OffsetDateTime offsetDateTime;
    final OffsetTime offsetTime;
    final Oneway oneway;
    final Open open;
    final Optional optional;
    final Or or;
    final OrEq orEq;
    final Out out;
    final Override override;
    final Package package;
    final Params params;
    final Pass pass;
    final Port port;
    final Postfix postfix;
    final Precedence precedence;
    final Prefix prefix;
    final Print print;
    final PrintMembers printMembers;
    final Printf printf;
    final Private private;
    final Protected protected;
    final Protocol protocol;
    final Public public;
    final NullClass purpleNull;
    final Quicktype quicktype;
    final Raise raise;
    final Range range;
    final Readonly readonly;
    final Ref ref;
    final RegExpClass regExp;
    final Register register;
    final ReinterpretCast reinterpretCast;

    Obj4({
        required this.dummy,
        required this.mutable,
        required this.mutating,
        required this.namespace,
        required this.native,
        required this.newtonsoft,
        required this.nil,
        required this.no,
        required this.noexcept,
        required this.nonatomic,
        required this.none,
        required this.nonlocal,
        required this.nonmutating,
        required this.not,
        required this.notEq,
        required this.nsError,
        required this.nsObject,
        required this.nsString,
        required this.nullNode,
        required this.nullptr,
        required this.number,
        required this.obj4New,
        required this.obj4NoSuchMethod,
        required this.obj4None,
        required this.obj4Null,
        required this.obj4Operator,
        required this.obj4Protocol,
        required this.object,
        required this.objectMapper,
        required this.objectNode,
        required this.objectReader,
        required this.objectWriter,
        required this.of,
        required this.offsetDateTime,
        required this.offsetTime,
        required this.oneway,
        required this.open,
        required this.optional,
        required this.or,
        required this.orEq,
        required this.out,
        required this.override,
        required this.package,
        required this.params,
        required this.pass,
        required this.port,
        required this.postfix,
        required this.precedence,
        required this.prefix,
        required this.print,
        required this.printMembers,
        required this.printf,
        required this.private,
        required this.protected,
        required this.protocol,
        required this.public,
        required this.purpleNull,
        required this.quicktype,
        required this.raise,
        required this.range,
        required this.readonly,
        required this.ref,
        required this.regExp,
        required this.register,
        required this.reinterpretCast,
    });

    factory Obj4.fromJson(Map<String, dynamic> json) => Obj4(
        dummy: json["dummy"],
        mutable: Mutable.fromJson(json["mutable"]),
        mutating: Mutating.fromJson(json["mutating"]),
        namespace: Namespace.fromJson(json["namespace"]),
        native: Native.fromJson(json["native"]),
        newtonsoft: Newtonsoft.fromJson(json["newtonsoft"]),
        nil: Nil.fromJson(json["nil"]),
        no: No.fromJson(json["NO"]),
        noexcept: Noexcept.fromJson(json["noexcept"]),
        nonatomic: Nonatomic.fromJson(json["nonatomic"]),
        none: None.fromJson(json["None"]),
        nonlocal: Nonlocal.fromJson(json["nonlocal"]),
        nonmutating: Nonmutating.fromJson(json["nonmutating"]),
        not: Not.fromJson(json["not"]),
        notEq: NotEq.fromJson(json["not_eq"]),
        nsError: NsError.fromJson(json["NSError"]),
        nsObject: NsObject.fromJson(json["NSObject"]),
        nsString: NsString.fromJson(json["NSString"]),
        nullNode: NullNode.fromJson(json["NullNode"]),
        nullptr: Nullptr.fromJson(json["nullptr"]),
        number: Number.fromJson(json["number"]),
        obj4New: New.fromJson(json["new"]),
        obj4NoSuchMethod: NoSuchMethod.fromJson(json["noSuchMethod"]),
        obj4None: NoneClass.fromJson(json["none"]),
        obj4Null: Null.fromJson(json["NULL"]),
        obj4Operator: Operator.fromJson(json["operator"]),
        obj4Protocol: ProtocolClass.fromJson(json["protocol"]),
        object: Object.fromJson(json["object"]),
        objectMapper: ObjectMapper.fromJson(json["ObjectMapper"]),
        objectNode: ObjectNode.fromJson(json["ObjectNode"]),
        objectReader: ObjectReader.fromJson(json["ObjectReader"]),
        objectWriter: ObjectWriter.fromJson(json["ObjectWriter"]),
        of: Of.fromJson(json["of"]),
        offsetDateTime: OffsetDateTime.fromJson(json["OffsetDateTime"]),
        offsetTime: OffsetTime.fromJson(json["OffsetTime"]),
        oneway: Oneway.fromJson(json["oneway"]),
        open: Open.fromJson(json["open"]),
        optional: Optional.fromJson(json["optional"]),
        or: Or.fromJson(json["or"]),
        orEq: OrEq.fromJson(json["or_eq"]),
        out: Out.fromJson(json["out"]),
        override: Override.fromJson(json["override"]),
        package: Package.fromJson(json["package"]),
        params: Params.fromJson(json["params"]),
        pass: Pass.fromJson(json["pass"]),
        port: Port.fromJson(json["port"]),
        postfix: Postfix.fromJson(json["postfix"]),
        precedence: Precedence.fromJson(json["precedence"]),
        prefix: Prefix.fromJson(json["prefix"]),
        print: Print.fromJson(json["print"]),
        printMembers: PrintMembers.fromJson(json["printMembers"]),
        printf: Printf.fromJson(json["printf"]),
        private: Private.fromJson(json["private"]),
        protected: Protected.fromJson(json["protected"]),
        protocol: Protocol.fromJson(json["Protocol"]),
        public: Public.fromJson(json["public"]),
        purpleNull: NullClass.fromJson(json["null"]),
        quicktype: Quicktype.fromJson(json["quicktype"]),
        raise: Raise.fromJson(json["raise"]),
        range: Range.fromJson(json["range"]),
        readonly: Readonly.fromJson(json["readonly"]),
        ref: Ref.fromJson(json["ref"]),
        regExp: RegExpClass.fromJson(json["RegExp"]),
        register: Register.fromJson(json["register"]),
        reinterpretCast: ReinterpretCast.fromJson(json["reinterpret_cast"]),
    );

    Map<String, dynamic> toJson() => {
        "dummy": dummy,
        "mutable": mutable.toJson(),
        "mutating": mutating.toJson(),
        "namespace": namespace.toJson(),
        "native": native.toJson(),
        "newtonsoft": newtonsoft.toJson(),
        "nil": nil.toJson(),
        "NO": no.toJson(),
        "noexcept": noexcept.toJson(),
        "nonatomic": nonatomic.toJson(),
        "None": none.toJson(),
        "nonlocal": nonlocal.toJson(),
        "nonmutating": nonmutating.toJson(),
        "not": not.toJson(),
        "not_eq": notEq.toJson(),
        "NSError": nsError.toJson(),
        "NSObject": nsObject.toJson(),
        "NSString": nsString.toJson(),
        "NullNode": nullNode.toJson(),
        "nullptr": nullptr.toJson(),
        "number": number.toJson(),
        "new": obj4New.toJson(),
        "noSuchMethod": obj4NoSuchMethod.toJson(),
        "none": obj4None.toJson(),
        "NULL": obj4Null.toJson(),
        "operator": obj4Operator.toJson(),
        "protocol": obj4Protocol.toJson(),
        "object": object.toJson(),
        "ObjectMapper": objectMapper.toJson(),
        "ObjectNode": objectNode.toJson(),
        "ObjectReader": objectReader.toJson(),
        "ObjectWriter": objectWriter.toJson(),
        "of": of.toJson(),
        "OffsetDateTime": offsetDateTime.toJson(),
        "OffsetTime": offsetTime.toJson(),
        "oneway": oneway.toJson(),
        "open": open.toJson(),
        "optional": optional.toJson(),
        "or": or.toJson(),
        "or_eq": orEq.toJson(),
        "out": out.toJson(),
        "override": override.toJson(),
        "package": package.toJson(),
        "params": params.toJson(),
        "pass": pass.toJson(),
        "port": port.toJson(),
        "postfix": postfix.toJson(),
        "precedence": precedence.toJson(),
        "prefix": prefix.toJson(),
        "print": print.toJson(),
        "printMembers": printMembers.toJson(),
        "printf": printf.toJson(),
        "private": private.toJson(),
        "protected": protected.toJson(),
        "Protocol": protocol.toJson(),
        "public": public.toJson(),
        "null": purpleNull.toJson(),
        "quicktype": quicktype.toJson(),
        "raise": raise.toJson(),
        "range": range.toJson(),
        "readonly": readonly.toJson(),
        "ref": ref.toJson(),
        "RegExp": regExp.toJson(),
        "register": register.toJson(),
        "reinterpret_cast": reinterpretCast.toJson(),
    };
}

class Mutable {
    final int mutable;

    Mutable({
        required this.mutable,
    });

    factory Mutable.fromJson(Map<String, dynamic> json) => Mutable(
        mutable: json["mutable"],
    );

    Map<String, dynamic> toJson() => {
        "mutable": mutable,
    };
}

class Mutating {
    final int mutating;

    Mutating({
        required this.mutating,
    });

    factory Mutating.fromJson(Map<String, dynamic> json) => Mutating(
        mutating: json["mutating"],
    );

    Map<String, dynamic> toJson() => {
        "mutating": mutating,
    };
}

class Namespace {
    final int namespace;

    Namespace({
        required this.namespace,
    });

    factory Namespace.fromJson(Map<String, dynamic> json) => Namespace(
        namespace: json["namespace"],
    );

    Map<String, dynamic> toJson() => {
        "namespace": namespace,
    };
}

class Native {
    final int native;

    Native({
        required this.native,
    });

    factory Native.fromJson(Map<String, dynamic> json) => Native(
        native: json["native"],
    );

    Map<String, dynamic> toJson() => {
        "native": native,
    };
}

class Newtonsoft {
    final int newtonsoft;

    Newtonsoft({
        required this.newtonsoft,
    });

    factory Newtonsoft.fromJson(Map<String, dynamic> json) => Newtonsoft(
        newtonsoft: json["newtonsoft"],
    );

    Map<String, dynamic> toJson() => {
        "newtonsoft": newtonsoft,
    };
}

class Nil {
    final int nil;

    Nil({
        required this.nil,
    });

    factory Nil.fromJson(Map<String, dynamic> json) => Nil(
        nil: json["nil"],
    );

    Map<String, dynamic> toJson() => {
        "nil": nil,
    };
}

class No {
    final int no;

    No({
        required this.no,
    });

    factory No.fromJson(Map<String, dynamic> json) => No(
        no: json["NO"],
    );

    Map<String, dynamic> toJson() => {
        "NO": no,
    };
}

class Noexcept {
    final int noexcept;

    Noexcept({
        required this.noexcept,
    });

    factory Noexcept.fromJson(Map<String, dynamic> json) => Noexcept(
        noexcept: json["noexcept"],
    );

    Map<String, dynamic> toJson() => {
        "noexcept": noexcept,
    };
}

class Nonatomic {
    final int nonatomic;

    Nonatomic({
        required this.nonatomic,
    });

    factory Nonatomic.fromJson(Map<String, dynamic> json) => Nonatomic(
        nonatomic: json["nonatomic"],
    );

    Map<String, dynamic> toJson() => {
        "nonatomic": nonatomic,
    };
}

class None {
    final int none;

    None({
        required this.none,
    });

    factory None.fromJson(Map<String, dynamic> json) => None(
        none: json["None"],
    );

    Map<String, dynamic> toJson() => {
        "None": none,
    };
}

class Nonlocal {
    final int nonlocal;

    Nonlocal({
        required this.nonlocal,
    });

    factory Nonlocal.fromJson(Map<String, dynamic> json) => Nonlocal(
        nonlocal: json["nonlocal"],
    );

    Map<String, dynamic> toJson() => {
        "nonlocal": nonlocal,
    };
}

class Nonmutating {
    final int nonmutating;

    Nonmutating({
        required this.nonmutating,
    });

    factory Nonmutating.fromJson(Map<String, dynamic> json) => Nonmutating(
        nonmutating: json["nonmutating"],
    );

    Map<String, dynamic> toJson() => {
        "nonmutating": nonmutating,
    };
}

class Not {
    final int not;

    Not({
        required this.not,
    });

    factory Not.fromJson(Map<String, dynamic> json) => Not(
        not: json["not"],
    );

    Map<String, dynamic> toJson() => {
        "not": not,
    };
}

class NotEq {
    final int notEq;

    NotEq({
        required this.notEq,
    });

    factory NotEq.fromJson(Map<String, dynamic> json) => NotEq(
        notEq: json["not_eq"],
    );

    Map<String, dynamic> toJson() => {
        "not_eq": notEq,
    };
}

class NsError {
    final int nsError;

    NsError({
        required this.nsError,
    });

    factory NsError.fromJson(Map<String, dynamic> json) => NsError(
        nsError: json["NSError"],
    );

    Map<String, dynamic> toJson() => {
        "NSError": nsError,
    };
}

class NsObject {
    final int nsObject;

    NsObject({
        required this.nsObject,
    });

    factory NsObject.fromJson(Map<String, dynamic> json) => NsObject(
        nsObject: json["NSObject"],
    );

    Map<String, dynamic> toJson() => {
        "NSObject": nsObject,
    };
}

class NsString {
    final int nsString;

    NsString({
        required this.nsString,
    });

    factory NsString.fromJson(Map<String, dynamic> json) => NsString(
        nsString: json["NSString"],
    );

    Map<String, dynamic> toJson() => {
        "NSString": nsString,
    };
}

class NullNode {
    final int nullNode;

    NullNode({
        required this.nullNode,
    });

    factory NullNode.fromJson(Map<String, dynamic> json) => NullNode(
        nullNode: json["NullNode"],
    );

    Map<String, dynamic> toJson() => {
        "NullNode": nullNode,
    };
}

class Nullptr {
    final int nullptr;

    Nullptr({
        required this.nullptr,
    });

    factory Nullptr.fromJson(Map<String, dynamic> json) => Nullptr(
        nullptr: json["nullptr"],
    );

    Map<String, dynamic> toJson() => {
        "nullptr": nullptr,
    };
}

class Number {
    final int number;

    Number({
        required this.number,
    });

    factory Number.fromJson(Map<String, dynamic> json) => Number(
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
    };
}

class New {
    final int newNew;

    New({
        required this.newNew,
    });

    factory New.fromJson(Map<String, dynamic> json) => New(
        newNew: json["new"],
    );

    Map<String, dynamic> toJson() => {
        "new": newNew,
    };
}

class NoSuchMethod {
    final int noSuchMethodNoSuchMethod;

    NoSuchMethod({
        required this.noSuchMethodNoSuchMethod,
    });

    factory NoSuchMethod.fromJson(Map<String, dynamic> json) => NoSuchMethod(
        noSuchMethodNoSuchMethod: json["noSuchMethod"],
    );

    Map<String, dynamic> toJson() => {
        "noSuchMethod": noSuchMethodNoSuchMethod,
    };
}

class NoneClass {
    final int none;

    NoneClass({
        required this.none,
    });

    factory NoneClass.fromJson(Map<String, dynamic> json) => NoneClass(
        none: json["none"],
    );

    Map<String, dynamic> toJson() => {
        "none": none,
    };
}

class Null {
    final int nullNull;

    Null({
        required this.nullNull,
    });

    factory Null.fromJson(Map<String, dynamic> json) => Null(
        nullNull: json["NULL"],
    );

    Map<String, dynamic> toJson() => {
        "NULL": nullNull,
    };
}

class Operator {
    final int operatorOperator;

    Operator({
        required this.operatorOperator,
    });

    factory Operator.fromJson(Map<String, dynamic> json) => Operator(
        operatorOperator: json["operator"],
    );

    Map<String, dynamic> toJson() => {
        "operator": operatorOperator,
    };
}

class ProtocolClass {
    final int protocol;

    ProtocolClass({
        required this.protocol,
    });

    factory ProtocolClass.fromJson(Map<String, dynamic> json) => ProtocolClass(
        protocol: json["protocol"],
    );

    Map<String, dynamic> toJson() => {
        "protocol": protocol,
    };
}

class Object {
    final int object;

    Object({
        required this.object,
    });

    factory Object.fromJson(Map<String, dynamic> json) => Object(
        object: json["object"],
    );

    Map<String, dynamic> toJson() => {
        "object": object,
    };
}

class ObjectMapper {
    final int objectMapper;

    ObjectMapper({
        required this.objectMapper,
    });

    factory ObjectMapper.fromJson(Map<String, dynamic> json) => ObjectMapper(
        objectMapper: json["ObjectMapper"],
    );

    Map<String, dynamic> toJson() => {
        "ObjectMapper": objectMapper,
    };
}

class ObjectNode {
    final int objectNode;

    ObjectNode({
        required this.objectNode,
    });

    factory ObjectNode.fromJson(Map<String, dynamic> json) => ObjectNode(
        objectNode: json["ObjectNode"],
    );

    Map<String, dynamic> toJson() => {
        "ObjectNode": objectNode,
    };
}

class ObjectReader {
    final int objectReader;

    ObjectReader({
        required this.objectReader,
    });

    factory ObjectReader.fromJson(Map<String, dynamic> json) => ObjectReader(
        objectReader: json["ObjectReader"],
    );

    Map<String, dynamic> toJson() => {
        "ObjectReader": objectReader,
    };
}

class ObjectWriter {
    final int objectWriter;

    ObjectWriter({
        required this.objectWriter,
    });

    factory ObjectWriter.fromJson(Map<String, dynamic> json) => ObjectWriter(
        objectWriter: json["ObjectWriter"],
    );

    Map<String, dynamic> toJson() => {
        "ObjectWriter": objectWriter,
    };
}

class Of {
    final int of;

    Of({
        required this.of,
    });

    factory Of.fromJson(Map<String, dynamic> json) => Of(
        of: json["of"],
    );

    Map<String, dynamic> toJson() => {
        "of": of,
    };
}

class OffsetDateTime {
    final int offsetDateTime;

    OffsetDateTime({
        required this.offsetDateTime,
    });

    factory OffsetDateTime.fromJson(Map<String, dynamic> json) => OffsetDateTime(
        offsetDateTime: json["OffsetDateTime"],
    );

    Map<String, dynamic> toJson() => {
        "OffsetDateTime": offsetDateTime,
    };
}

class OffsetTime {
    final int offsetTime;

    OffsetTime({
        required this.offsetTime,
    });

    factory OffsetTime.fromJson(Map<String, dynamic> json) => OffsetTime(
        offsetTime: json["OffsetTime"],
    );

    Map<String, dynamic> toJson() => {
        "OffsetTime": offsetTime,
    };
}

class Oneway {
    final int oneway;

    Oneway({
        required this.oneway,
    });

    factory Oneway.fromJson(Map<String, dynamic> json) => Oneway(
        oneway: json["oneway"],
    );

    Map<String, dynamic> toJson() => {
        "oneway": oneway,
    };
}

class Open {
    final int open;

    Open({
        required this.open,
    });

    factory Open.fromJson(Map<String, dynamic> json) => Open(
        open: json["open"],
    );

    Map<String, dynamic> toJson() => {
        "open": open,
    };
}

class Optional {
    final int optional;

    Optional({
        required this.optional,
    });

    factory Optional.fromJson(Map<String, dynamic> json) => Optional(
        optional: json["optional"],
    );

    Map<String, dynamic> toJson() => {
        "optional": optional,
    };
}

class Or {
    final int or;

    Or({
        required this.or,
    });

    factory Or.fromJson(Map<String, dynamic> json) => Or(
        or: json["or"],
    );

    Map<String, dynamic> toJson() => {
        "or": or,
    };
}

class OrEq {
    final int orEq;

    OrEq({
        required this.orEq,
    });

    factory OrEq.fromJson(Map<String, dynamic> json) => OrEq(
        orEq: json["or_eq"],
    );

    Map<String, dynamic> toJson() => {
        "or_eq": orEq,
    };
}

class Out {
    final int out;

    Out({
        required this.out,
    });

    factory Out.fromJson(Map<String, dynamic> json) => Out(
        out: json["out"],
    );

    Map<String, dynamic> toJson() => {
        "out": out,
    };
}

class Override {
    final int override;

    Override({
        required this.override,
    });

    factory Override.fromJson(Map<String, dynamic> json) => Override(
        override: json["override"],
    );

    Map<String, dynamic> toJson() => {
        "override": override,
    };
}

class Package {
    final int package;

    Package({
        required this.package,
    });

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        package: json["package"],
    );

    Map<String, dynamic> toJson() => {
        "package": package,
    };
}

class Params {
    final int params;

    Params({
        required this.params,
    });

    factory Params.fromJson(Map<String, dynamic> json) => Params(
        params: json["params"],
    );

    Map<String, dynamic> toJson() => {
        "params": params,
    };
}

class Pass {
    final int pass;

    Pass({
        required this.pass,
    });

    factory Pass.fromJson(Map<String, dynamic> json) => Pass(
        pass: json["pass"],
    );

    Map<String, dynamic> toJson() => {
        "pass": pass,
    };
}

class Port {
    final int port;

    Port({
        required this.port,
    });

    factory Port.fromJson(Map<String, dynamic> json) => Port(
        port: json["port"],
    );

    Map<String, dynamic> toJson() => {
        "port": port,
    };
}

class Postfix {
    final int postfix;

    Postfix({
        required this.postfix,
    });

    factory Postfix.fromJson(Map<String, dynamic> json) => Postfix(
        postfix: json["postfix"],
    );

    Map<String, dynamic> toJson() => {
        "postfix": postfix,
    };
}

class Precedence {
    final int precedence;

    Precedence({
        required this.precedence,
    });

    factory Precedence.fromJson(Map<String, dynamic> json) => Precedence(
        precedence: json["precedence"],
    );

    Map<String, dynamic> toJson() => {
        "precedence": precedence,
    };
}

class Prefix {
    final int prefix;

    Prefix({
        required this.prefix,
    });

    factory Prefix.fromJson(Map<String, dynamic> json) => Prefix(
        prefix: json["prefix"],
    );

    Map<String, dynamic> toJson() => {
        "prefix": prefix,
    };
}

class Print {
    final int print;

    Print({
        required this.print,
    });

    factory Print.fromJson(Map<String, dynamic> json) => Print(
        print: json["print"],
    );

    Map<String, dynamic> toJson() => {
        "print": print,
    };
}

class PrintMembers {
    final int printMembers;

    PrintMembers({
        required this.printMembers,
    });

    factory PrintMembers.fromJson(Map<String, dynamic> json) => PrintMembers(
        printMembers: json["printMembers"],
    );

    Map<String, dynamic> toJson() => {
        "printMembers": printMembers,
    };
}

class Printf {
    final int printf;

    Printf({
        required this.printf,
    });

    factory Printf.fromJson(Map<String, dynamic> json) => Printf(
        printf: json["printf"],
    );

    Map<String, dynamic> toJson() => {
        "printf": printf,
    };
}

class Private {
    final int private;

    Private({
        required this.private,
    });

    factory Private.fromJson(Map<String, dynamic> json) => Private(
        private: json["private"],
    );

    Map<String, dynamic> toJson() => {
        "private": private,
    };
}

class Protected {
    final int protected;

    Protected({
        required this.protected,
    });

    factory Protected.fromJson(Map<String, dynamic> json) => Protected(
        protected: json["protected"],
    );

    Map<String, dynamic> toJson() => {
        "protected": protected,
    };
}

class Protocol {
    final int protocol;

    Protocol({
        required this.protocol,
    });

    factory Protocol.fromJson(Map<String, dynamic> json) => Protocol(
        protocol: json["Protocol"],
    );

    Map<String, dynamic> toJson() => {
        "Protocol": protocol,
    };
}

class Public {
    final int public;

    Public({
        required this.public,
    });

    factory Public.fromJson(Map<String, dynamic> json) => Public(
        public: json["public"],
    );

    Map<String, dynamic> toJson() => {
        "public": public,
    };
}

class NullClass {
    final int nullNull;

    NullClass({
        required this.nullNull,
    });

    factory NullClass.fromJson(Map<String, dynamic> json) => NullClass(
        nullNull: json["null"],
    );

    Map<String, dynamic> toJson() => {
        "null": nullNull,
    };
}

class Quicktype {
    final int quicktype;

    Quicktype({
        required this.quicktype,
    });

    factory Quicktype.fromJson(Map<String, dynamic> json) => Quicktype(
        quicktype: json["quicktype"],
    );

    Map<String, dynamic> toJson() => {
        "quicktype": quicktype,
    };
}

class Raise {
    final int raise;

    Raise({
        required this.raise,
    });

    factory Raise.fromJson(Map<String, dynamic> json) => Raise(
        raise: json["raise"],
    );

    Map<String, dynamic> toJson() => {
        "raise": raise,
    };
}

class Range {
    final int range;

    Range({
        required this.range,
    });

    factory Range.fromJson(Map<String, dynamic> json) => Range(
        range: json["range"],
    );

    Map<String, dynamic> toJson() => {
        "range": range,
    };
}

class Readonly {
    final int readonly;

    Readonly({
        required this.readonly,
    });

    factory Readonly.fromJson(Map<String, dynamic> json) => Readonly(
        readonly: json["readonly"],
    );

    Map<String, dynamic> toJson() => {
        "readonly": readonly,
    };
}

class Ref {
    final int ref;

    Ref({
        required this.ref,
    });

    factory Ref.fromJson(Map<String, dynamic> json) => Ref(
        ref: json["ref"],
    );

    Map<String, dynamic> toJson() => {
        "ref": ref,
    };
}

class RegExpClass {
    final String regExp;

    RegExpClass({
        required this.regExp,
    });

    factory RegExpClass.fromJson(Map<String, dynamic> json) => RegExpClass(
        regExp: ((String x) => RegExp(r'^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$').hasMatch(x) ? x : throw FormatException('Invalid UUID'))(json["RegExp"]),
    );

    Map<String, dynamic> toJson() => {
        "RegExp": regExp,
    };
}

class Register {
    final int register;

    Register({
        required this.register,
    });

    factory Register.fromJson(Map<String, dynamic> json) => Register(
        register: json["register"],
    );

    Map<String, dynamic> toJson() => {
        "register": register,
    };
}

class ReinterpretCast {
    final int reinterpretCast;

    ReinterpretCast({
        required this.reinterpretCast,
    });

    factory ReinterpretCast.fromJson(Map<String, dynamic> json) => ReinterpretCast(
        reinterpretCast: json["reinterpret_cast"],
    );

    Map<String, dynamic> toJson() => {
        "reinterpret_cast": reinterpretCast,
    };
}

class Obj5 {
    final int dummy;
    final KSerializer kSerializer;
    final Return obj5Return;
    final RuntimeType obj5RuntimeType;
    final SelfClass obj5Self;
    final Set obj5Set;
    final Static obj5Static;
    final Super obj5Super;
    final Switch obj5Switch;
    final This obj5This;
    final Throw obj5Throw;
    final ToJson obj5ToJson;
    final ToString obj5ToString;
    final True obj5True;
    final PrimitiveKind primitiveKind;
    final TrueClass purpleTrue;
    final Repeat repeat;
    final Require require;
    final Required required;
    final Requires requires;
    final Restrict restrict;
    final Retain retain;
    final Rethrows rethrows;
    final Right right;
    final S s;
    final Sbyte sbyte;
    final Sealed sealed;
    final Sel sel;
    final Select select;
    final Self self;
    final Sendable sendable;
    final SerialDescriptor serialDescriptor;
    final SerialName serialName;
    final Serializable serializable;
    final SerializationFeature serializationFeature;
    final Serialize serialize;
    final SerializerProvider serializerProvider;
    final Short short;
    final Signed signed;
    final SimpleModule simpleModule;
    final Sizeof sizeof;
    final Stackalloc stackalloc;
    final Standards standards;
    final StaticAssert staticAssert;
    final StaticCast staticCast;
    final StdDeserializer stdDeserializer;
    final StdSerializer stdSerializer;
    final Strictfp strictfp;
    final StringClass string;
    final Struct struct;
    final Subscript subscript;
    final Symbol symbol;
    final Synchronized synchronized;
    final System system;
    final Template template;
    final TextNode textNode;
    final Then then;
    final ThreadLocal threadLocal;
    final Throws throws;
    final TimeOnly timeOnly;
    final TimeOnlyConverter timeOnlyConverter;
    final TimeZone timeZone;
    final ToDict toDict;
    final TopLevelClass topLevel;
    final Transient transient;

    Obj5({
        required this.dummy,
        required this.kSerializer,
        required this.obj5Return,
        required this.obj5RuntimeType,
        required this.obj5Self,
        required this.obj5Set,
        required this.obj5Static,
        required this.obj5Super,
        required this.obj5Switch,
        required this.obj5This,
        required this.obj5Throw,
        required this.obj5ToJson,
        required this.obj5ToString,
        required this.obj5True,
        required this.primitiveKind,
        required this.purpleTrue,
        required this.repeat,
        required this.require,
        required this.required,
        required this.requires,
        required this.restrict,
        required this.retain,
        required this.rethrows,
        required this.right,
        required this.s,
        required this.sbyte,
        required this.sealed,
        required this.sel,
        required this.select,
        required this.self,
        required this.sendable,
        required this.serialDescriptor,
        required this.serialName,
        required this.serializable,
        required this.serializationFeature,
        required this.serialize,
        required this.serializerProvider,
        required this.short,
        required this.signed,
        required this.simpleModule,
        required this.sizeof,
        required this.stackalloc,
        required this.standards,
        required this.staticAssert,
        required this.staticCast,
        required this.stdDeserializer,
        required this.stdSerializer,
        required this.strictfp,
        required this.string,
        required this.struct,
        required this.subscript,
        required this.symbol,
        required this.synchronized,
        required this.system,
        required this.template,
        required this.textNode,
        required this.then,
        required this.threadLocal,
        required this.throws,
        required this.timeOnly,
        required this.timeOnlyConverter,
        required this.timeZone,
        required this.toDict,
        required this.topLevel,
        required this.transient,
    });

    factory Obj5.fromJson(Map<String, dynamic> json) => Obj5(
        dummy: json["dummy"],
        kSerializer: KSerializer.fromJson(json["KSerializer"]),
        obj5Return: Return.fromJson(json["return"]),
        obj5RuntimeType: RuntimeType.fromJson(json["runtimeType"]),
        obj5Self: SelfClass.fromJson(json["self"]),
        obj5Set: Set.fromJson(json["set"]),
        obj5Static: Static.fromJson(json["static"]),
        obj5Super: Super.fromJson(json["super"]),
        obj5Switch: Switch.fromJson(json["switch"]),
        obj5This: This.fromJson(json["this"]),
        obj5Throw: Throw.fromJson(json["throw"]),
        obj5ToJson: ToJson.fromJson(json["to_json"]),
        obj5ToString: ToString.fromJson(json["toString"]),
        obj5True: True.fromJson(json["True"]),
        primitiveKind: PrimitiveKind.fromJson(json["PrimitiveKind"]),
        purpleTrue: TrueClass.fromJson(json["true"]),
        repeat: Repeat.fromJson(json["repeat"]),
        require: Require.fromJson(json["require"]),
        required: Required.fromJson(json["required"]),
        requires: Requires.fromJson(json["requires"]),
        restrict: Restrict.fromJson(json["restrict"]),
        retain: Retain.fromJson(json["retain"]),
        rethrows: Rethrows.fromJson(json["rethrows"]),
        right: Right.fromJson(json["right"]),
        s: S.fromJson(json["s"]),
        sbyte: Sbyte.fromJson(json["sbyte"]),
        sealed: Sealed.fromJson(json["sealed"]),
        sel: Sel.fromJson(json["SEL"]),
        select: Select.fromJson(json["select"]),
        self: Self.fromJson(json["Self"]),
        sendable: Sendable.fromJson(json["Sendable"]),
        serialDescriptor: SerialDescriptor.fromJson(json["SerialDescriptor"]),
        serialName: SerialName.fromJson(json["SerialName"]),
        serializable: Serializable.fromJson(json["Serializable"]),
        serializationFeature: SerializationFeature.fromJson(json["SerializationFeature"]),
        serialize: Serialize.fromJson(json["serialize"]),
        serializerProvider: SerializerProvider.fromJson(json["SerializerProvider"]),
        short: Short.fromJson(json["short"]),
        signed: Signed.fromJson(json["signed"]),
        simpleModule: SimpleModule.fromJson(json["SimpleModule"]),
        sizeof: Sizeof.fromJson(json["sizeof"]),
        stackalloc: Stackalloc.fromJson(json["stackalloc"]),
        standards: Standards.fromJson(json["Standards"]),
        staticAssert: StaticAssert.fromJson(json["static_assert"]),
        staticCast: StaticCast.fromJson(json["static_cast"]),
        stdDeserializer: StdDeserializer.fromJson(json["StdDeserializer"]),
        stdSerializer: StdSerializer.fromJson(json["StdSerializer"]),
        strictfp: Strictfp.fromJson(json["strictfp"]),
        string: StringClass.fromJson(json["string"]),
        struct: Struct.fromJson(json["struct"]),
        subscript: Subscript.fromJson(json["subscript"]),
        symbol: Symbol.fromJson(json["symbol"]),
        synchronized: Synchronized.fromJson(json["synchronized"]),
        system: System.fromJson(json["system"]),
        template: Template.fromJson(json["template"]),
        textNode: TextNode.fromJson(json["TextNode"]),
        then: Then.fromJson(json["then"]),
        threadLocal: ThreadLocal.fromJson(json["thread_local"]),
        throws: Throws.fromJson(json["throws"]),
        timeOnly: TimeOnly.fromJson(json["TimeOnly"]),
        timeOnlyConverter: TimeOnlyConverter.fromJson(json["TimeOnlyConverter"]),
        timeZone: TimeZone.fromJson(json["TimeZone"]),
        toDict: ToDict.fromJson(json["to_dict"]),
        topLevel: TopLevelClass.fromJson(json["top_level"]),
        transient: Transient.fromJson(json["transient"]),
    );

    Map<String, dynamic> toJson() => {
        "dummy": dummy,
        "KSerializer": kSerializer.toJson(),
        "return": obj5Return.toJson(),
        "runtimeType": obj5RuntimeType.toJson(),
        "self": obj5Self.toJson(),
        "set": obj5Set.toJson(),
        "static": obj5Static.toJson(),
        "super": obj5Super.toJson(),
        "switch": obj5Switch.toJson(),
        "this": obj5This.toJson(),
        "throw": obj5Throw.toJson(),
        "to_json": obj5ToJson.toJson(),
        "toString": obj5ToString.toJson(),
        "True": obj5True.toJson(),
        "PrimitiveKind": primitiveKind.toJson(),
        "true": purpleTrue.toJson(),
        "repeat": repeat.toJson(),
        "require": require.toJson(),
        "required": required.toJson(),
        "requires": requires.toJson(),
        "restrict": restrict.toJson(),
        "retain": retain.toJson(),
        "rethrows": rethrows.toJson(),
        "right": right.toJson(),
        "s": s.toJson(),
        "sbyte": sbyte.toJson(),
        "sealed": sealed.toJson(),
        "SEL": sel.toJson(),
        "select": select.toJson(),
        "Self": self.toJson(),
        "Sendable": sendable.toJson(),
        "SerialDescriptor": serialDescriptor.toJson(),
        "SerialName": serialName.toJson(),
        "Serializable": serializable.toJson(),
        "SerializationFeature": serializationFeature.toJson(),
        "serialize": serialize.toJson(),
        "SerializerProvider": serializerProvider.toJson(),
        "short": short.toJson(),
        "signed": signed.toJson(),
        "SimpleModule": simpleModule.toJson(),
        "sizeof": sizeof.toJson(),
        "stackalloc": stackalloc.toJson(),
        "Standards": standards.toJson(),
        "static_assert": staticAssert.toJson(),
        "static_cast": staticCast.toJson(),
        "StdDeserializer": stdDeserializer.toJson(),
        "StdSerializer": stdSerializer.toJson(),
        "strictfp": strictfp.toJson(),
        "string": string.toJson(),
        "struct": struct.toJson(),
        "subscript": subscript.toJson(),
        "symbol": symbol.toJson(),
        "synchronized": synchronized.toJson(),
        "system": system.toJson(),
        "template": template.toJson(),
        "TextNode": textNode.toJson(),
        "then": then.toJson(),
        "thread_local": threadLocal.toJson(),
        "throws": throws.toJson(),
        "TimeOnly": timeOnly.toJson(),
        "TimeOnlyConverter": timeOnlyConverter.toJson(),
        "TimeZone": timeZone.toJson(),
        "to_dict": toDict.toJson(),
        "top_level": topLevel.toJson(),
        "transient": transient.toJson(),
    };
}

class KSerializer {
    final int kSerializer;

    KSerializer({
        required this.kSerializer,
    });

    factory KSerializer.fromJson(Map<String, dynamic> json) => KSerializer(
        kSerializer: json["KSerializer"],
    );

    Map<String, dynamic> toJson() => {
        "KSerializer": kSerializer,
    };
}

class Return {
    final int returnReturn;

    Return({
        required this.returnReturn,
    });

    factory Return.fromJson(Map<String, dynamic> json) => Return(
        returnReturn: json["return"],
    );

    Map<String, dynamic> toJson() => {
        "return": returnReturn,
    };
}

class RuntimeType {
    final int runtimeTypeRuntimeType;

    RuntimeType({
        required this.runtimeTypeRuntimeType,
    });

    factory RuntimeType.fromJson(Map<String, dynamic> json) => RuntimeType(
        runtimeTypeRuntimeType: json["runtimeType"],
    );

    Map<String, dynamic> toJson() => {
        "runtimeType": runtimeTypeRuntimeType,
    };
}

class SelfClass {
    final int self;

    SelfClass({
        required this.self,
    });

    factory SelfClass.fromJson(Map<String, dynamic> json) => SelfClass(
        self: json["self"],
    );

    Map<String, dynamic> toJson() => {
        "self": self,
    };
}

class Set {
    final int setSet;

    Set({
        required this.setSet,
    });

    factory Set.fromJson(Map<String, dynamic> json) => Set(
        setSet: json["set"],
    );

    Map<String, dynamic> toJson() => {
        "set": setSet,
    };
}

class Static {
    final int staticStatic;

    Static({
        required this.staticStatic,
    });

    factory Static.fromJson(Map<String, dynamic> json) => Static(
        staticStatic: json["static"],
    );

    Map<String, dynamic> toJson() => {
        "static": staticStatic,
    };
}

class Super {
    final int superSuper;

    Super({
        required this.superSuper,
    });

    factory Super.fromJson(Map<String, dynamic> json) => Super(
        superSuper: json["super"],
    );

    Map<String, dynamic> toJson() => {
        "super": superSuper,
    };
}

class Switch {
    final int switchSwitch;

    Switch({
        required this.switchSwitch,
    });

    factory Switch.fromJson(Map<String, dynamic> json) => Switch(
        switchSwitch: json["switch"],
    );

    Map<String, dynamic> toJson() => {
        "switch": switchSwitch,
    };
}

class This {
    final int thisThis;

    This({
        required this.thisThis,
    });

    factory This.fromJson(Map<String, dynamic> json) => This(
        thisThis: json["this"],
    );

    Map<String, dynamic> toJson() => {
        "this": thisThis,
    };
}

class Throw {
    final int throwThrow;

    Throw({
        required this.throwThrow,
    });

    factory Throw.fromJson(Map<String, dynamic> json) => Throw(
        throwThrow: json["throw"],
    );

    Map<String, dynamic> toJson() => {
        "throw": throwThrow,
    };
}

class ToJson {
    final int toJsonToJson;

    ToJson({
        required this.toJsonToJson,
    });

    factory ToJson.fromJson(Map<String, dynamic> json) => ToJson(
        toJsonToJson: json["to_json"],
    );

    Map<String, dynamic> toJson() => {
        "to_json": toJsonToJson,
    };
}

class ToString {
    final int toStringToString;

    ToString({
        required this.toStringToString,
    });

    factory ToString.fromJson(Map<String, dynamic> json) => ToString(
        toStringToString: json["toString"],
    );

    Map<String, dynamic> toJson() => {
        "toString": toStringToString,
    };
}

class True {
    final int trueTrue;

    True({
        required this.trueTrue,
    });

    factory True.fromJson(Map<String, dynamic> json) => True(
        trueTrue: json["True"],
    );

    Map<String, dynamic> toJson() => {
        "True": trueTrue,
    };
}

class PrimitiveKind {
    final int primitiveKind;

    PrimitiveKind({
        required this.primitiveKind,
    });

    factory PrimitiveKind.fromJson(Map<String, dynamic> json) => PrimitiveKind(
        primitiveKind: json["PrimitiveKind"],
    );

    Map<String, dynamic> toJson() => {
        "PrimitiveKind": primitiveKind,
    };
}

class TrueClass {
    final int trueTrue;

    TrueClass({
        required this.trueTrue,
    });

    factory TrueClass.fromJson(Map<String, dynamic> json) => TrueClass(
        trueTrue: json["true"],
    );

    Map<String, dynamic> toJson() => {
        "true": trueTrue,
    };
}

class Repeat {
    final int repeat;

    Repeat({
        required this.repeat,
    });

    factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
        repeat: json["repeat"],
    );

    Map<String, dynamic> toJson() => {
        "repeat": repeat,
    };
}

class Require {
    final int require;

    Require({
        required this.require,
    });

    factory Require.fromJson(Map<String, dynamic> json) => Require(
        require: json["require"],
    );

    Map<String, dynamic> toJson() => {
        "require": require,
    };
}

class Required {
    final int required;

    Required({
        required this.required,
    });

    factory Required.fromJson(Map<String, dynamic> json) => Required(
        required: json["required"],
    );

    Map<String, dynamic> toJson() => {
        "required": required,
    };
}

class Requires {
    final int requires;

    Requires({
        required this.requires,
    });

    factory Requires.fromJson(Map<String, dynamic> json) => Requires(
        requires: json["requires"],
    );

    Map<String, dynamic> toJson() => {
        "requires": requires,
    };
}

class Restrict {
    final int restrict;

    Restrict({
        required this.restrict,
    });

    factory Restrict.fromJson(Map<String, dynamic> json) => Restrict(
        restrict: json["restrict"],
    );

    Map<String, dynamic> toJson() => {
        "restrict": restrict,
    };
}

class Retain {
    final int retain;

    Retain({
        required this.retain,
    });

    factory Retain.fromJson(Map<String, dynamic> json) => Retain(
        retain: json["retain"],
    );

    Map<String, dynamic> toJson() => {
        "retain": retain,
    };
}

class Rethrows {
    final int rethrows;

    Rethrows({
        required this.rethrows,
    });

    factory Rethrows.fromJson(Map<String, dynamic> json) => Rethrows(
        rethrows: json["rethrows"],
    );

    Map<String, dynamic> toJson() => {
        "rethrows": rethrows,
    };
}

class Right {
    final int right;

    Right({
        required this.right,
    });

    factory Right.fromJson(Map<String, dynamic> json) => Right(
        right: json["right"],
    );

    Map<String, dynamic> toJson() => {
        "right": right,
    };
}

class S {
    final int s;

    S({
        required this.s,
    });

    factory S.fromJson(Map<String, dynamic> json) => S(
        s: json["s"],
    );

    Map<String, dynamic> toJson() => {
        "s": s,
    };
}

class Sbyte {
    final int sbyte;

    Sbyte({
        required this.sbyte,
    });

    factory Sbyte.fromJson(Map<String, dynamic> json) => Sbyte(
        sbyte: json["sbyte"],
    );

    Map<String, dynamic> toJson() => {
        "sbyte": sbyte,
    };
}

class Sealed {
    final int sealed;

    Sealed({
        required this.sealed,
    });

    factory Sealed.fromJson(Map<String, dynamic> json) => Sealed(
        sealed: json["sealed"],
    );

    Map<String, dynamic> toJson() => {
        "sealed": sealed,
    };
}

class Sel {
    final int sel;

    Sel({
        required this.sel,
    });

    factory Sel.fromJson(Map<String, dynamic> json) => Sel(
        sel: json["SEL"],
    );

    Map<String, dynamic> toJson() => {
        "SEL": sel,
    };
}

class Select {
    final int select;

    Select({
        required this.select,
    });

    factory Select.fromJson(Map<String, dynamic> json) => Select(
        select: json["select"],
    );

    Map<String, dynamic> toJson() => {
        "select": select,
    };
}

class Self {
    final int self;

    Self({
        required this.self,
    });

    factory Self.fromJson(Map<String, dynamic> json) => Self(
        self: json["Self"],
    );

    Map<String, dynamic> toJson() => {
        "Self": self,
    };
}

class Sendable {
    final int sendable;

    Sendable({
        required this.sendable,
    });

    factory Sendable.fromJson(Map<String, dynamic> json) => Sendable(
        sendable: json["Sendable"],
    );

    Map<String, dynamic> toJson() => {
        "Sendable": sendable,
    };
}

class SerialDescriptor {
    final int serialDescriptor;

    SerialDescriptor({
        required this.serialDescriptor,
    });

    factory SerialDescriptor.fromJson(Map<String, dynamic> json) => SerialDescriptor(
        serialDescriptor: json["SerialDescriptor"],
    );

    Map<String, dynamic> toJson() => {
        "SerialDescriptor": serialDescriptor,
    };
}

class SerialName {
    final int serialName;

    SerialName({
        required this.serialName,
    });

    factory SerialName.fromJson(Map<String, dynamic> json) => SerialName(
        serialName: json["SerialName"],
    );

    Map<String, dynamic> toJson() => {
        "SerialName": serialName,
    };
}

class Serializable {
    final int serializable;

    Serializable({
        required this.serializable,
    });

    factory Serializable.fromJson(Map<String, dynamic> json) => Serializable(
        serializable: json["Serializable"],
    );

    Map<String, dynamic> toJson() => {
        "Serializable": serializable,
    };
}

class SerializationFeature {
    final int serializationFeature;

    SerializationFeature({
        required this.serializationFeature,
    });

    factory SerializationFeature.fromJson(Map<String, dynamic> json) => SerializationFeature(
        serializationFeature: json["SerializationFeature"],
    );

    Map<String, dynamic> toJson() => {
        "SerializationFeature": serializationFeature,
    };
}

class Serialize {
    final int serialize;

    Serialize({
        required this.serialize,
    });

    factory Serialize.fromJson(Map<String, dynamic> json) => Serialize(
        serialize: json["serialize"],
    );

    Map<String, dynamic> toJson() => {
        "serialize": serialize,
    };
}

class SerializerProvider {
    final int serializerProvider;

    SerializerProvider({
        required this.serializerProvider,
    });

    factory SerializerProvider.fromJson(Map<String, dynamic> json) => SerializerProvider(
        serializerProvider: json["SerializerProvider"],
    );

    Map<String, dynamic> toJson() => {
        "SerializerProvider": serializerProvider,
    };
}

class Short {
    final int short;

    Short({
        required this.short,
    });

    factory Short.fromJson(Map<String, dynamic> json) => Short(
        short: json["short"],
    );

    Map<String, dynamic> toJson() => {
        "short": short,
    };
}

class Signed {
    final int signed;

    Signed({
        required this.signed,
    });

    factory Signed.fromJson(Map<String, dynamic> json) => Signed(
        signed: json["signed"],
    );

    Map<String, dynamic> toJson() => {
        "signed": signed,
    };
}

class SimpleModule {
    final int simpleModule;

    SimpleModule({
        required this.simpleModule,
    });

    factory SimpleModule.fromJson(Map<String, dynamic> json) => SimpleModule(
        simpleModule: json["SimpleModule"],
    );

    Map<String, dynamic> toJson() => {
        "SimpleModule": simpleModule,
    };
}

class Sizeof {
    final int sizeof;

    Sizeof({
        required this.sizeof,
    });

    factory Sizeof.fromJson(Map<String, dynamic> json) => Sizeof(
        sizeof: json["sizeof"],
    );

    Map<String, dynamic> toJson() => {
        "sizeof": sizeof,
    };
}

class Stackalloc {
    final int stackalloc;

    Stackalloc({
        required this.stackalloc,
    });

    factory Stackalloc.fromJson(Map<String, dynamic> json) => Stackalloc(
        stackalloc: json["stackalloc"],
    );

    Map<String, dynamic> toJson() => {
        "stackalloc": stackalloc,
    };
}

class Standards {
    final int standards;

    Standards({
        required this.standards,
    });

    factory Standards.fromJson(Map<String, dynamic> json) => Standards(
        standards: json["Standards"],
    );

    Map<String, dynamic> toJson() => {
        "Standards": standards,
    };
}

class StaticAssert {
    final int staticAssert;

    StaticAssert({
        required this.staticAssert,
    });

    factory StaticAssert.fromJson(Map<String, dynamic> json) => StaticAssert(
        staticAssert: json["static_assert"],
    );

    Map<String, dynamic> toJson() => {
        "static_assert": staticAssert,
    };
}

class StaticCast {
    final int staticCast;

    StaticCast({
        required this.staticCast,
    });

    factory StaticCast.fromJson(Map<String, dynamic> json) => StaticCast(
        staticCast: json["static_cast"],
    );

    Map<String, dynamic> toJson() => {
        "static_cast": staticCast,
    };
}

class StdDeserializer {
    final int stdDeserializer;

    StdDeserializer({
        required this.stdDeserializer,
    });

    factory StdDeserializer.fromJson(Map<String, dynamic> json) => StdDeserializer(
        stdDeserializer: json["StdDeserializer"],
    );

    Map<String, dynamic> toJson() => {
        "StdDeserializer": stdDeserializer,
    };
}

class StdSerializer {
    final int stdSerializer;

    StdSerializer({
        required this.stdSerializer,
    });

    factory StdSerializer.fromJson(Map<String, dynamic> json) => StdSerializer(
        stdSerializer: json["StdSerializer"],
    );

    Map<String, dynamic> toJson() => {
        "StdSerializer": stdSerializer,
    };
}

class Strictfp {
    final int strictfp;

    Strictfp({
        required this.strictfp,
    });

    factory Strictfp.fromJson(Map<String, dynamic> json) => Strictfp(
        strictfp: json["strictfp"],
    );

    Map<String, dynamic> toJson() => {
        "strictfp": strictfp,
    };
}

class StringClass {
    final int string;

    StringClass({
        required this.string,
    });

    factory StringClass.fromJson(Map<String, dynamic> json) => StringClass(
        string: json["string"],
    );

    Map<String, dynamic> toJson() => {
        "string": string,
    };
}

class Struct {
    final int struct;

    Struct({
        required this.struct,
    });

    factory Struct.fromJson(Map<String, dynamic> json) => Struct(
        struct: json["struct"],
    );

    Map<String, dynamic> toJson() => {
        "struct": struct,
    };
}

class Subscript {
    final int subscript;

    Subscript({
        required this.subscript,
    });

    factory Subscript.fromJson(Map<String, dynamic> json) => Subscript(
        subscript: json["subscript"],
    );

    Map<String, dynamic> toJson() => {
        "subscript": subscript,
    };
}

class Symbol {
    final int symbol;

    Symbol({
        required this.symbol,
    });

    factory Symbol.fromJson(Map<String, dynamic> json) => Symbol(
        symbol: json["symbol"],
    );

    Map<String, dynamic> toJson() => {
        "symbol": symbol,
    };
}

class Synchronized {
    final int synchronized;

    Synchronized({
        required this.synchronized,
    });

    factory Synchronized.fromJson(Map<String, dynamic> json) => Synchronized(
        synchronized: json["synchronized"],
    );

    Map<String, dynamic> toJson() => {
        "synchronized": synchronized,
    };
}

class System {
    final int system;

    System({
        required this.system,
    });

    factory System.fromJson(Map<String, dynamic> json) => System(
        system: json["system"],
    );

    Map<String, dynamic> toJson() => {
        "system": system,
    };
}

class Template {
    final int template;

    Template({
        required this.template,
    });

    factory Template.fromJson(Map<String, dynamic> json) => Template(
        template: json["template"],
    );

    Map<String, dynamic> toJson() => {
        "template": template,
    };
}

class TextNode {
    final int textNode;

    TextNode({
        required this.textNode,
    });

    factory TextNode.fromJson(Map<String, dynamic> json) => TextNode(
        textNode: json["TextNode"],
    );

    Map<String, dynamic> toJson() => {
        "TextNode": textNode,
    };
}

class Then {
    final int then;

    Then({
        required this.then,
    });

    factory Then.fromJson(Map<String, dynamic> json) => Then(
        then: json["then"],
    );

    Map<String, dynamic> toJson() => {
        "then": then,
    };
}

class ThreadLocal {
    final int threadLocal;

    ThreadLocal({
        required this.threadLocal,
    });

    factory ThreadLocal.fromJson(Map<String, dynamic> json) => ThreadLocal(
        threadLocal: json["thread_local"],
    );

    Map<String, dynamic> toJson() => {
        "thread_local": threadLocal,
    };
}

class Throws {
    final int throws;

    Throws({
        required this.throws,
    });

    factory Throws.fromJson(Map<String, dynamic> json) => Throws(
        throws: json["throws"],
    );

    Map<String, dynamic> toJson() => {
        "throws": throws,
    };
}

class TimeOnly {
    final int timeOnly;

    TimeOnly({
        required this.timeOnly,
    });

    factory TimeOnly.fromJson(Map<String, dynamic> json) => TimeOnly(
        timeOnly: json["TimeOnly"],
    );

    Map<String, dynamic> toJson() => {
        "TimeOnly": timeOnly,
    };
}

class TimeOnlyConverter {
    final int timeOnlyConverter;

    TimeOnlyConverter({
        required this.timeOnlyConverter,
    });

    factory TimeOnlyConverter.fromJson(Map<String, dynamic> json) => TimeOnlyConverter(
        timeOnlyConverter: json["TimeOnlyConverter"],
    );

    Map<String, dynamic> toJson() => {
        "TimeOnlyConverter": timeOnlyConverter,
    };
}

class TimeZone {
    final int timeZone;

    TimeZone({
        required this.timeZone,
    });

    factory TimeZone.fromJson(Map<String, dynamic> json) => TimeZone(
        timeZone: json["TimeZone"],
    );

    Map<String, dynamic> toJson() => {
        "TimeZone": timeZone,
    };
}

class ToDict {
    final int toDict;

    ToDict({
        required this.toDict,
    });

    factory ToDict.fromJson(Map<String, dynamic> json) => ToDict(
        toDict: json["to_dict"],
    );

    Map<String, dynamic> toJson() => {
        "to_dict": toDict,
    };
}

class TopLevelClass {
    final int topLevel;

    TopLevelClass({
        required this.topLevel,
    });

    factory TopLevelClass.fromJson(Map<String, dynamic> json) => TopLevelClass(
        topLevel: json["top_level"],
    );

    Map<String, dynamic> toJson() => {
        "top_level": topLevel,
    };
}

class Transient {
    final int transient;

    Transient({
        required this.transient,
    });

    factory Transient.fromJson(Map<String, dynamic> json) => Transient(
        transient: json["transient"],
    );

    Map<String, dynamic> toJson() => {
        "transient": transient,
    };
}

class Obj6 {
    final int dummy;
    final Try obj6Try;
    final TypeClass obj6Type;
    final Typedef obj6Typedef;
    final Var obj6Var;
    final Void obj6Void;
    final While obj6While;
    final With obj6With;
    final Yield obj6Yield;
    final Type type;
    final Typealias typealias;
    final Typeid typeid;
    final Typename typename;
    final Typeof typeof;
    final Uint uint;
    final Ulong ulong;
    final Unchecked unchecked;
    final Undefined undefined;
    final Union union;
    final UnmarshalJson unmarshalJson;
    final Unowned unowned;
    final Unsafe unsafe;
    final Unsigned unsigned;
    final UseSerializers useSerializers;
    final Ushort ushort;
    final Using using;
    final Utf8JsonReader utf8JsonReader;
    final Utf8JsonWriter utf8JsonWriter;
    final Uuid uuid;
    final Virtual virtual;
    final Volatile volatile;
    final WcharT wcharT;
    final Weak weak;
    final Where where;
    final WillSet willSet;
    final Xor xor;
    final XorEq xorEq;
    final Yes yes;

    Obj6({
        required this.dummy,
        required this.obj6Try,
        required this.obj6Type,
        required this.obj6Typedef,
        required this.obj6Var,
        required this.obj6Void,
        required this.obj6While,
        required this.obj6With,
        required this.obj6Yield,
        required this.type,
        required this.typealias,
        required this.typeid,
        required this.typename,
        required this.typeof,
        required this.uint,
        required this.ulong,
        required this.unchecked,
        required this.undefined,
        required this.union,
        required this.unmarshalJson,
        required this.unowned,
        required this.unsafe,
        required this.unsigned,
        required this.useSerializers,
        required this.ushort,
        required this.using,
        required this.utf8JsonReader,
        required this.utf8JsonWriter,
        required this.uuid,
        required this.virtual,
        required this.volatile,
        required this.wcharT,
        required this.weak,
        required this.where,
        required this.willSet,
        required this.xor,
        required this.xorEq,
        required this.yes,
    });

    factory Obj6.fromJson(Map<String, dynamic> json) => Obj6(
        dummy: json["dummy"],
        obj6Try: Try.fromJson(json["try"]),
        obj6Type: TypeClass.fromJson(json["type"]),
        obj6Typedef: Typedef.fromJson(json["typedef"]),
        obj6Var: Var.fromJson(json["var"]),
        obj6Void: Void.fromJson(json["void"]),
        obj6While: While.fromJson(json["while"]),
        obj6With: With.fromJson(json["with"]),
        obj6Yield: Yield.fromJson(json["yield"]),
        type: Type.fromJson(json["Type"]),
        typealias: Typealias.fromJson(json["typealias"]),
        typeid: Typeid.fromJson(json["typeid"]),
        typename: Typename.fromJson(json["typename"]),
        typeof: Typeof.fromJson(json["typeof"]),
        uint: Uint.fromJson(json["uint"]),
        ulong: Ulong.fromJson(json["ulong"]),
        unchecked: Unchecked.fromJson(json["unchecked"]),
        undefined: Undefined.fromJson(json["undefined"]),
        union: Union.fromJson(json["union"]),
        unmarshalJson: UnmarshalJson.fromJson(json["UnmarshalJSON"]),
        unowned: Unowned.fromJson(json["unowned"]),
        unsafe: Unsafe.fromJson(json["unsafe"]),
        unsigned: Unsigned.fromJson(json["unsigned"]),
        useSerializers: UseSerializers.fromJson(json["UseSerializers"]),
        ushort: Ushort.fromJson(json["ushort"]),
        using: Using.fromJson(json["using"]),
        utf8JsonReader: Utf8JsonReader.fromJson(json["Utf8JsonReader"]),
        utf8JsonWriter: Utf8JsonWriter.fromJson(json["Utf8JsonWriter"]),
        uuid: Uuid.fromJson(json["UUID"]),
        virtual: Virtual.fromJson(json["virtual"]),
        volatile: Volatile.fromJson(json["volatile"]),
        wcharT: WcharT.fromJson(json["wchar_t"]),
        weak: Weak.fromJson(json["weak"]),
        where: Where.fromJson(json["where"]),
        willSet: WillSet.fromJson(json["willSet"]),
        xor: Xor.fromJson(json["xor"]),
        xorEq: XorEq.fromJson(json["xor_eq"]),
        yes: Yes.fromJson(json["YES"]),
    );

    Map<String, dynamic> toJson() => {
        "dummy": dummy,
        "try": obj6Try.toJson(),
        "type": obj6Type.toJson(),
        "typedef": obj6Typedef.toJson(),
        "var": obj6Var.toJson(),
        "void": obj6Void.toJson(),
        "while": obj6While.toJson(),
        "with": obj6With.toJson(),
        "yield": obj6Yield.toJson(),
        "Type": type.toJson(),
        "typealias": typealias.toJson(),
        "typeid": typeid.toJson(),
        "typename": typename.toJson(),
        "typeof": typeof.toJson(),
        "uint": uint.toJson(),
        "ulong": ulong.toJson(),
        "unchecked": unchecked.toJson(),
        "undefined": undefined.toJson(),
        "union": union.toJson(),
        "UnmarshalJSON": unmarshalJson.toJson(),
        "unowned": unowned.toJson(),
        "unsafe": unsafe.toJson(),
        "unsigned": unsigned.toJson(),
        "UseSerializers": useSerializers.toJson(),
        "ushort": ushort.toJson(),
        "using": using.toJson(),
        "Utf8JsonReader": utf8JsonReader.toJson(),
        "Utf8JsonWriter": utf8JsonWriter.toJson(),
        "UUID": uuid.toJson(),
        "virtual": virtual.toJson(),
        "volatile": volatile.toJson(),
        "wchar_t": wcharT.toJson(),
        "weak": weak.toJson(),
        "where": where.toJson(),
        "willSet": willSet.toJson(),
        "xor": xor.toJson(),
        "xor_eq": xorEq.toJson(),
        "YES": yes.toJson(),
    };
}

class Try {
    final int tryTry;

    Try({
        required this.tryTry,
    });

    factory Try.fromJson(Map<String, dynamic> json) => Try(
        tryTry: json["try"],
    );

    Map<String, dynamic> toJson() => {
        "try": tryTry,
    };
}

class TypeClass {
    final int type;

    TypeClass({
        required this.type,
    });

    factory TypeClass.fromJson(Map<String, dynamic> json) => TypeClass(
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
    };
}

class Typedef {
    final int typedefTypedef;

    Typedef({
        required this.typedefTypedef,
    });

    factory Typedef.fromJson(Map<String, dynamic> json) => Typedef(
        typedefTypedef: json["typedef"],
    );

    Map<String, dynamic> toJson() => {
        "typedef": typedefTypedef,
    };
}

class Var {
    final int varVar;

    Var({
        required this.varVar,
    });

    factory Var.fromJson(Map<String, dynamic> json) => Var(
        varVar: json["var"],
    );

    Map<String, dynamic> toJson() => {
        "var": varVar,
    };
}

class Void {
    final int voidVoid;

    Void({
        required this.voidVoid,
    });

    factory Void.fromJson(Map<String, dynamic> json) => Void(
        voidVoid: json["void"],
    );

    Map<String, dynamic> toJson() => {
        "void": voidVoid,
    };
}

class While {
    final int whileWhile;

    While({
        required this.whileWhile,
    });

    factory While.fromJson(Map<String, dynamic> json) => While(
        whileWhile: json["while"],
    );

    Map<String, dynamic> toJson() => {
        "while": whileWhile,
    };
}

class With {
    final int withWith;

    With({
        required this.withWith,
    });

    factory With.fromJson(Map<String, dynamic> json) => With(
        withWith: json["with"],
    );

    Map<String, dynamic> toJson() => {
        "with": withWith,
    };
}

class Yield {
    final int yieldYield;

    Yield({
        required this.yieldYield,
    });

    factory Yield.fromJson(Map<String, dynamic> json) => Yield(
        yieldYield: json["yield"],
    );

    Map<String, dynamic> toJson() => {
        "yield": yieldYield,
    };
}

class Type {
    final int type;

    Type({
        required this.type,
    });

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        type: json["Type"],
    );

    Map<String, dynamic> toJson() => {
        "Type": type,
    };
}

class Typealias {
    final int typealias;

    Typealias({
        required this.typealias,
    });

    factory Typealias.fromJson(Map<String, dynamic> json) => Typealias(
        typealias: json["typealias"],
    );

    Map<String, dynamic> toJson() => {
        "typealias": typealias,
    };
}

class Typeid {
    final int typeid;

    Typeid({
        required this.typeid,
    });

    factory Typeid.fromJson(Map<String, dynamic> json) => Typeid(
        typeid: json["typeid"],
    );

    Map<String, dynamic> toJson() => {
        "typeid": typeid,
    };
}

class Typename {
    final int typename;

    Typename({
        required this.typename,
    });

    factory Typename.fromJson(Map<String, dynamic> json) => Typename(
        typename: json["typename"],
    );

    Map<String, dynamic> toJson() => {
        "typename": typename,
    };
}

class Typeof {
    final int typeof;

    Typeof({
        required this.typeof,
    });

    factory Typeof.fromJson(Map<String, dynamic> json) => Typeof(
        typeof: json["typeof"],
    );

    Map<String, dynamic> toJson() => {
        "typeof": typeof,
    };
}

class Uint {
    final int uint;

    Uint({
        required this.uint,
    });

    factory Uint.fromJson(Map<String, dynamic> json) => Uint(
        uint: json["uint"],
    );

    Map<String, dynamic> toJson() => {
        "uint": uint,
    };
}

class Ulong {
    final int ulong;

    Ulong({
        required this.ulong,
    });

    factory Ulong.fromJson(Map<String, dynamic> json) => Ulong(
        ulong: json["ulong"],
    );

    Map<String, dynamic> toJson() => {
        "ulong": ulong,
    };
}

class Unchecked {
    final int unchecked;

    Unchecked({
        required this.unchecked,
    });

    factory Unchecked.fromJson(Map<String, dynamic> json) => Unchecked(
        unchecked: json["unchecked"],
    );

    Map<String, dynamic> toJson() => {
        "unchecked": unchecked,
    };
}

class Undefined {
    final int undefined;

    Undefined({
        required this.undefined,
    });

    factory Undefined.fromJson(Map<String, dynamic> json) => Undefined(
        undefined: json["undefined"],
    );

    Map<String, dynamic> toJson() => {
        "undefined": undefined,
    };
}

class Union {
    final int union;

    Union({
        required this.union,
    });

    factory Union.fromJson(Map<String, dynamic> json) => Union(
        union: json["union"],
    );

    Map<String, dynamic> toJson() => {
        "union": union,
    };
}

class UnmarshalJson {
    final int unmarshalJson;

    UnmarshalJson({
        required this.unmarshalJson,
    });

    factory UnmarshalJson.fromJson(Map<String, dynamic> json) => UnmarshalJson(
        unmarshalJson: json["UnmarshalJSON"],
    );

    Map<String, dynamic> toJson() => {
        "UnmarshalJSON": unmarshalJson,
    };
}

class Unowned {
    final int unowned;

    Unowned({
        required this.unowned,
    });

    factory Unowned.fromJson(Map<String, dynamic> json) => Unowned(
        unowned: json["unowned"],
    );

    Map<String, dynamic> toJson() => {
        "unowned": unowned,
    };
}

class Unsafe {
    final int unsafe;

    Unsafe({
        required this.unsafe,
    });

    factory Unsafe.fromJson(Map<String, dynamic> json) => Unsafe(
        unsafe: json["unsafe"],
    );

    Map<String, dynamic> toJson() => {
        "unsafe": unsafe,
    };
}

class Unsigned {
    final int unsigned;

    Unsigned({
        required this.unsigned,
    });

    factory Unsigned.fromJson(Map<String, dynamic> json) => Unsigned(
        unsigned: json["unsigned"],
    );

    Map<String, dynamic> toJson() => {
        "unsigned": unsigned,
    };
}

class UseSerializers {
    final int useSerializers;

    UseSerializers({
        required this.useSerializers,
    });

    factory UseSerializers.fromJson(Map<String, dynamic> json) => UseSerializers(
        useSerializers: json["UseSerializers"],
    );

    Map<String, dynamic> toJson() => {
        "UseSerializers": useSerializers,
    };
}

class Ushort {
    final int ushort;

    Ushort({
        required this.ushort,
    });

    factory Ushort.fromJson(Map<String, dynamic> json) => Ushort(
        ushort: json["ushort"],
    );

    Map<String, dynamic> toJson() => {
        "ushort": ushort,
    };
}

class Using {
    final int using;

    Using({
        required this.using,
    });

    factory Using.fromJson(Map<String, dynamic> json) => Using(
        using: json["using"],
    );

    Map<String, dynamic> toJson() => {
        "using": using,
    };
}

class Utf8JsonReader {
    final int utf8JsonReader;

    Utf8JsonReader({
        required this.utf8JsonReader,
    });

    factory Utf8JsonReader.fromJson(Map<String, dynamic> json) => Utf8JsonReader(
        utf8JsonReader: json["Utf8JsonReader"],
    );

    Map<String, dynamic> toJson() => {
        "Utf8JsonReader": utf8JsonReader,
    };
}

class Utf8JsonWriter {
    final int utf8JsonWriter;

    Utf8JsonWriter({
        required this.utf8JsonWriter,
    });

    factory Utf8JsonWriter.fromJson(Map<String, dynamic> json) => Utf8JsonWriter(
        utf8JsonWriter: json["Utf8JsonWriter"],
    );

    Map<String, dynamic> toJson() => {
        "Utf8JsonWriter": utf8JsonWriter,
    };
}

class Uuid {
    final int uuid;

    Uuid({
        required this.uuid,
    });

    factory Uuid.fromJson(Map<String, dynamic> json) => Uuid(
        uuid: json["UUID"],
    );

    Map<String, dynamic> toJson() => {
        "UUID": uuid,
    };
}

class Virtual {
    final int virtual;

    Virtual({
        required this.virtual,
    });

    factory Virtual.fromJson(Map<String, dynamic> json) => Virtual(
        virtual: json["virtual"],
    );

    Map<String, dynamic> toJson() => {
        "virtual": virtual,
    };
}

class Volatile {
    final int volatile;

    Volatile({
        required this.volatile,
    });

    factory Volatile.fromJson(Map<String, dynamic> json) => Volatile(
        volatile: json["volatile"],
    );

    Map<String, dynamic> toJson() => {
        "volatile": volatile,
    };
}

class WcharT {
    final int wcharT;

    WcharT({
        required this.wcharT,
    });

    factory WcharT.fromJson(Map<String, dynamic> json) => WcharT(
        wcharT: json["wchar_t"],
    );

    Map<String, dynamic> toJson() => {
        "wchar_t": wcharT,
    };
}

class Weak {
    final int weak;

    Weak({
        required this.weak,
    });

    factory Weak.fromJson(Map<String, dynamic> json) => Weak(
        weak: json["weak"],
    );

    Map<String, dynamic> toJson() => {
        "weak": weak,
    };
}

class Where {
    final int where;

    Where({
        required this.where,
    });

    factory Where.fromJson(Map<String, dynamic> json) => Where(
        where: json["where"],
    );

    Map<String, dynamic> toJson() => {
        "where": where,
    };
}

class WillSet {
    final int willSet;

    WillSet({
        required this.willSet,
    });

    factory WillSet.fromJson(Map<String, dynamic> json) => WillSet(
        willSet: json["willSet"],
    );

    Map<String, dynamic> toJson() => {
        "willSet": willSet,
    };
}

class Xor {
    final int xor;

    Xor({
        required this.xor,
    });

    factory Xor.fromJson(Map<String, dynamic> json) => Xor(
        xor: json["xor"],
    );

    Map<String, dynamic> toJson() => {
        "xor": xor,
    };
}

class XorEq {
    final int xorEq;

    XorEq({
        required this.xorEq,
    });

    factory XorEq.fromJson(Map<String, dynamic> json) => XorEq(
        xorEq: json["xor_eq"],
    );

    Map<String, dynamic> toJson() => {
        "xor_eq": xorEq,
    };
}

class Yes {
    final int yes;

    Yes({
        required this.yes,
    });

    factory Yes.fromJson(Map<String, dynamic> json) => Yes(
        yes: json["YES"],
    );

    Map<String, dynamic> toJson() => {
        "YES": yes,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
