// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<TopLevelChild> children;
    final GetSignatureFlags flags;
    final List<Group> groups;
    final int id;
    final int kind;
    final String name;

    TopLevel({
        required this.children,
        required this.flags,
        required this.groups,
        required this.id,
        required this.kind,
        required this.name,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        children: List<TopLevelChild>.from(json["children"].map((x) => TopLevelChild.fromJson(x))),
        flags: GetSignatureFlags.fromJson(json["flags"]),
        groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
        id: json["id"],
        kind: json["kind"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "flags": flags.toJson(),
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
        "id": id,
        "kind": kind,
        "name": name,
    };
}

class TopLevelChild {
    final List<PurpleChild> children;
    final IndecentComment? comment;
    final PurpleFlags flags;
    final List<Group> groups;
    final int id;
    final int kind;
    final TentacledKindString kindString;
    final String name;
    final String originalName;
    final List<Source> sources;

    TopLevelChild({
        required this.children,
        this.comment,
        required this.flags,
        required this.groups,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        required this.originalName,
        required this.sources,
    });

    factory TopLevelChild.fromJson(Map<String, dynamic> json) => TopLevelChild(
        children: List<PurpleChild>.from(json["children"].map((x) => PurpleChild.fromJson(x))),
        comment: json["comment"] == null ? null : IndecentComment.fromJson(json["comment"]),
        flags: PurpleFlags.fromJson(json["flags"]),
        groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
        id: json["id"],
        kind: json["kind"],
        kindString: tentacledKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        originalName: json["originalName"],
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "comment": comment?.toJson(),
        "flags": flags.toJson(),
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
        "id": id,
        "kind": kind,
        "kindString": tentacledKindStringValues.reverse[kindString],
        "name": name,
        "originalName": originalName,
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
    };
}

class PurpleChild {
    final List<FluffyChild>? children;
    final StickyComment? comment;
    final String? defaultValue;
    final List<ExtendedBy>? extendedBy;
    final List<ExtendedBy>? extendedTypes;
    final IndecentFlags flags;
    final List<Group>? groups;
    final int id;
    final List<ExtendedBy>? implementedBy;
    final List<ExtendedBy>? implementedTypes;
    final int kind;
    final FluffyKindString kindString;
    final String name;
    final List<StickySignature>? signatures;
    final List<Source> sources;
    final MagentaType? type;
    final List<TypeParameter>? typeParameter;

    PurpleChild({
        this.children,
        this.comment,
        this.defaultValue,
        this.extendedBy,
        this.extendedTypes,
        required this.flags,
        this.groups,
        required this.id,
        this.implementedBy,
        this.implementedTypes,
        required this.kind,
        required this.kindString,
        required this.name,
        this.signatures,
        required this.sources,
        this.type,
        this.typeParameter,
    });

    factory PurpleChild.fromJson(Map<String, dynamic> json) => PurpleChild(
        children: json["children"] == null ? null : List<FluffyChild>.from(json["children"]!.map((x) => FluffyChild.fromJson(x))),
        comment: json["comment"] == null ? null : StickyComment.fromJson(json["comment"]),
        defaultValue: json["defaultValue"],
        extendedBy: json["extendedBy"] == null ? null : List<ExtendedBy>.from(json["extendedBy"]!.map((x) => ExtendedBy.fromJson(x))),
        extendedTypes: json["extendedTypes"] == null ? null : List<ExtendedBy>.from(json["extendedTypes"]!.map((x) => ExtendedBy.fromJson(x))),
        flags: IndecentFlags.fromJson(json["flags"]),
        groups: json["groups"] == null ? null : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        id: json["id"],
        implementedBy: json["implementedBy"] == null ? null : List<ExtendedBy>.from(json["implementedBy"]!.map((x) => ExtendedBy.fromJson(x))),
        implementedTypes: json["implementedTypes"] == null ? null : List<ExtendedBy>.from(json["implementedTypes"]!.map((x) => ExtendedBy.fromJson(x))),
        kind: json["kind"],
        kindString: fluffyKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        signatures: json["signatures"] == null ? null : List<StickySignature>.from(json["signatures"]!.map((x) => StickySignature.fromJson(x))),
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        type: json["type"] == null ? null : MagentaType.fromJson(json["type"]),
        typeParameter: json["typeParameter"] == null ? null : List<TypeParameter>.from(json["typeParameter"]!.map((x) => TypeParameter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
        "comment": comment?.toJson(),
        "defaultValue": defaultValue,
        "extendedBy": extendedBy == null ? null : List<dynamic>.from(extendedBy!.map((x) => x.toJson())),
        "extendedTypes": extendedTypes == null ? null : List<dynamic>.from(extendedTypes!.map((x) => x.toJson())),
        "flags": flags.toJson(),
        "groups": groups == null ? null : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "id": id,
        "implementedBy": implementedBy == null ? null : List<dynamic>.from(implementedBy!.map((x) => x.toJson())),
        "implementedTypes": implementedTypes == null ? null : List<dynamic>.from(implementedTypes!.map((x) => x.toJson())),
        "kind": kind,
        "kindString": fluffyKindStringValues.reverse[kindString],
        "name": name,
        "signatures": signatures == null ? null : List<dynamic>.from(signatures!.map((x) => x.toJson())),
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
        "type": type?.toJson(),
        "typeParameter": typeParameter == null ? null : List<dynamic>.from(typeParameter!.map((x) => x.toJson())),
    };
}

class FluffyChild {
    final List<TentacledChild>? children;
    final StickyComment? comment;
    final String? defaultValue;
    final StickyFlags flags;
    final GetSignature? getSignature;
    final List<Group>? groups;
    final int id;
    final ExtendedBy? implementationOf;
    final ExtendedBy? inheritedFrom;
    final int kind;
    final PurpleKindString kindString;
    final String name;
    final ExtendedBy? overwrites;
    final GetSignature? setSignature;
    final List<FluffySignature>? signatures;
    final List<Source> sources;
    final IndigoType? type;

    FluffyChild({
        this.children,
        this.comment,
        this.defaultValue,
        required this.flags,
        this.getSignature,
        this.groups,
        required this.id,
        this.implementationOf,
        this.inheritedFrom,
        required this.kind,
        required this.kindString,
        required this.name,
        this.overwrites,
        this.setSignature,
        this.signatures,
        required this.sources,
        this.type,
    });

    factory FluffyChild.fromJson(Map<String, dynamic> json) => FluffyChild(
        children: json["children"] == null ? null : List<TentacledChild>.from(json["children"]!.map((x) => TentacledChild.fromJson(x))),
        comment: json["comment"] == null ? null : StickyComment.fromJson(json["comment"]),
        defaultValue: json["defaultValue"],
        flags: StickyFlags.fromJson(json["flags"]),
        getSignature: json["getSignature"] == null ? null : GetSignature.fromJson(json["getSignature"]),
        groups: json["groups"] == null ? null : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        id: json["id"],
        implementationOf: json["implementationOf"] == null ? null : ExtendedBy.fromJson(json["implementationOf"]),
        inheritedFrom: json["inheritedFrom"] == null ? null : ExtendedBy.fromJson(json["inheritedFrom"]),
        kind: json["kind"],
        kindString: purpleKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        overwrites: json["overwrites"] == null ? null : ExtendedBy.fromJson(json["overwrites"]),
        setSignature: json["setSignature"] == null ? null : GetSignature.fromJson(json["setSignature"]),
        signatures: json["signatures"] == null ? null : List<FluffySignature>.from(json["signatures"]!.map((x) => FluffySignature.fromJson(x))),
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        type: json["type"] == null ? null : IndigoType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
        "comment": comment?.toJson(),
        "defaultValue": defaultValue,
        "flags": flags.toJson(),
        "getSignature": getSignature?.toJson(),
        "groups": groups == null ? null : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "id": id,
        "implementationOf": implementationOf?.toJson(),
        "inheritedFrom": inheritedFrom?.toJson(),
        "kind": kind,
        "kindString": purpleKindStringValues.reverse[kindString],
        "name": name,
        "overwrites": overwrites?.toJson(),
        "setSignature": setSignature?.toJson(),
        "signatures": signatures == null ? null : List<dynamic>.from(signatures!.map((x) => x.toJson())),
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
        "type": type?.toJson(),
    };
}

class TentacledChild {
    final PurpleComment? comment;
    final String? defaultValue;
    final PurpleFlags flags;
    final int id;
    final int kind;
    final PurpleKindString kindString;
    final String name;
    final List<PurpleSignature>? signatures;
    final List<Source> sources;
    final TypeElement? type;

    TentacledChild({
        this.comment,
        this.defaultValue,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        this.signatures,
        required this.sources,
        this.type,
    });

    factory TentacledChild.fromJson(Map<String, dynamic> json) => TentacledChild(
        comment: json["comment"] == null ? null : PurpleComment.fromJson(json["comment"]),
        defaultValue: json["defaultValue"],
        flags: PurpleFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: purpleKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        signatures: json["signatures"] == null ? null : List<PurpleSignature>.from(json["signatures"]!.map((x) => PurpleSignature.fromJson(x))),
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        type: json["type"] == null ? null : TypeElement.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "defaultValue": defaultValue,
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": purpleKindStringValues.reverse[kindString],
        "name": name,
        "signatures": signatures == null ? null : List<dynamic>.from(signatures!.map((x) => x.toJson())),
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
        "type": type?.toJson(),
    };
}

class PurpleComment {
    final String shortText;

    PurpleComment({
        required this.shortText,
    });

    factory PurpleComment.fromJson(Map<String, dynamic> json) => PurpleComment(
        shortText: json["shortText"],
    );

    Map<String, dynamic> toJson() => {
        "shortText": shortText,
    };
}

class PurpleFlags {
    final bool? isExported;

    PurpleFlags({
        this.isExported,
    });

    factory PurpleFlags.fromJson(Map<String, dynamic> json) => PurpleFlags(
        isExported: json["isExported"],
    );

    Map<String, dynamic> toJson() => {
        "isExported": isExported,
    };
}

enum PurpleKindString {
    VARIABLE,
    FUNCTION,
    PROPERTY,
    METHOD,
    CONSTRUCTOR,
    ACCESSOR,
    ENUMERATION_MEMBER,
    MODULE,
    OBJECT_LITERAL
}

final purpleKindStringValues = EnumValues({
    "Variable": PurpleKindString.VARIABLE,
    "Function": PurpleKindString.FUNCTION,
    "Property": PurpleKindString.PROPERTY,
    "Method": PurpleKindString.METHOD,
    "Constructor": PurpleKindString.CONSTRUCTOR,
    "Accessor": PurpleKindString.ACCESSOR,
    "Enumeration member": PurpleKindString.ENUMERATION_MEMBER,
    "Module": PurpleKindString.MODULE,
    "Object literal": PurpleKindString.OBJECT_LITERAL
});

class PurpleSignature {
    final PurpleComment? comment;
    final GetSignatureFlags flags;
    final int id;
    final int kind;
    final SignatureKindString kindString;
    final String name;
    final List<GetSignature> parameters;
    final TentacledType type;

    PurpleSignature({
        this.comment,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        required this.parameters,
        required this.type,
    });

    factory PurpleSignature.fromJson(Map<String, dynamic> json) => PurpleSignature(
        comment: json["comment"] == null ? null : PurpleComment.fromJson(json["comment"]),
        flags: GetSignatureFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: signatureKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        parameters: List<GetSignature>.from(json["parameters"].map((x) => GetSignature.fromJson(x))),
        type: TentacledType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": signatureKindStringValues.reverse[kindString],
        "name": name,
        "parameters": List<dynamic>.from(parameters.map((x) => x.toJson())),
        "type": type.toJson(),
    };
}

class GetSignatureFlags {
    GetSignatureFlags();

    factory GetSignatureFlags.fromJson(Map<String, dynamic> json) => GetSignatureFlags(
    );

    Map<String, dynamic> toJson() => {
    };
}

enum SignatureKindString {
    CALL_SIGNATURE,
    CONSTRUCTOR_SIGNATURE
}

final signatureKindStringValues = EnumValues({
    "Call signature": SignatureKindString.CALL_SIGNATURE,
    "Constructor signature": SignatureKindString.CONSTRUCTOR_SIGNATURE
});

class GetSignatureType {
    final GetSignature? declaration;
    final ElementType? elementType;
    final Name? name;
    final TypeEnum type;

    GetSignatureType({
        this.declaration,
        this.elementType,
        this.name,
        required this.type,
    });

    factory GetSignatureType.fromJson(Map<String, dynamic> json) => GetSignatureType(
        declaration: json["declaration"] == null ? null : GetSignature.fromJson(json["declaration"]),
        elementType: json["elementType"] == null ? null : ElementType.fromJson(json["elementType"]),
        name: json["name"] == null ? null : nameValues.map[json["name"]]!,
        type: typeEnumValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "declaration": declaration?.toJson(),
        "elementType": elementType?.toJson(),
        "name": nameValues.reverse[name],
        "type": typeEnumValues.reverse[type],
    };
}

class IndexSignatureElement {
    final GetSignatureFlags flags;
    final int id;
    final int kind;
    final String kindString;
    final String name;
    final List<GetSignature>? parameters;
    final PurpleType type;

    IndexSignatureElement({
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        this.parameters,
        required this.type,
    });

    factory IndexSignatureElement.fromJson(Map<String, dynamic> json) => IndexSignatureElement(
        flags: GetSignatureFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: json["kindString"],
        name: json["name"],
        parameters: json["parameters"] == null ? null : List<GetSignature>.from(json["parameters"]!.map((x) => GetSignature.fromJson(x))),
        type: PurpleType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": kindString,
        "name": name,
        "parameters": parameters == null ? null : List<dynamic>.from(parameters!.map((x) => x.toJson())),
        "type": type.toJson(),
    };
}

class PurpleType {
    final GetSignature? declaration;
    final Name? name;
    final TypeEnum type;

    PurpleType({
        this.declaration,
        this.name,
        required this.type,
    });

    factory PurpleType.fromJson(Map<String, dynamic> json) => PurpleType(
        declaration: json["declaration"] == null ? null : GetSignature.fromJson(json["declaration"]),
        name: json["name"] == null ? null : nameValues.map[json["name"]]!,
        type: typeEnumValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "declaration": declaration?.toJson(),
        "name": nameValues.reverse[name],
        "type": typeEnumValues.reverse[type],
    };
}

class GetSignatureChild {
    final FluffyComment? comment;
    final FluffyFlags flags;
    final int id;
    final int kind;
    final PurpleKindString kindString;
    final String name;
    final List<Source> sources;
    final PurpleType type;

    GetSignatureChild({
        this.comment,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        required this.sources,
        required this.type,
    });

    factory GetSignatureChild.fromJson(Map<String, dynamic> json) => GetSignatureChild(
        comment: json["comment"] == null ? null : FluffyComment.fromJson(json["comment"]),
        flags: FluffyFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: purpleKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        type: PurpleType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": purpleKindStringValues.reverse[kindString],
        "name": name,
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
        "type": type.toJson(),
    };
}

class GetSignature {
    final List<GetSignatureChild>? children;
    final GetSignatureComment? comment;
    final String? defaultValue;
    final GetSignatureFlags flags;
    final List<Group>? groups;
    final int id;
    final int kind;
    final String kindString;
    final String name;
    final List<GetSignatureParameter>? parameters;
    final List<IndexSignatureElement>? signatures;
    final List<Source>? sources;
    final GetSignatureType? type;
    final List<GetSignature>? typeParameter;

    GetSignature({
        this.children,
        this.comment,
        this.defaultValue,
        required this.flags,
        this.groups,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        this.parameters,
        this.signatures,
        this.sources,
        this.type,
        this.typeParameter,
    });

    factory GetSignature.fromJson(Map<String, dynamic> json) => GetSignature(
        children: json["children"] == null ? null : List<GetSignatureChild>.from(json["children"]!.map((x) => GetSignatureChild.fromJson(x))),
        comment: json["comment"] == null ? null : GetSignatureComment.fromJson(json["comment"]),
        defaultValue: json["defaultValue"],
        flags: GetSignatureFlags.fromJson(json["flags"]),
        groups: json["groups"] == null ? null : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        id: json["id"],
        kind: json["kind"],
        kindString: json["kindString"],
        name: json["name"],
        parameters: json["parameters"] == null ? null : List<GetSignatureParameter>.from(json["parameters"]!.map((x) => GetSignatureParameter.fromJson(x))),
        signatures: json["signatures"] == null ? null : List<IndexSignatureElement>.from(json["signatures"]!.map((x) => IndexSignatureElement.fromJson(x))),
        sources: json["sources"] == null ? null : List<Source>.from(json["sources"]!.map((x) => Source.fromJson(x))),
        type: json["type"] == null ? null : GetSignatureType.fromJson(json["type"]),
        typeParameter: json["typeParameter"] == null ? null : List<GetSignature>.from(json["typeParameter"]!.map((x) => GetSignature.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
        "comment": comment?.toJson(),
        "defaultValue": defaultValue,
        "flags": flags.toJson(),
        "groups": groups == null ? null : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "id": id,
        "kind": kind,
        "kindString": kindString,
        "name": name,
        "parameters": parameters == null ? null : List<dynamic>.from(parameters!.map((x) => x.toJson())),
        "signatures": signatures == null ? null : List<dynamic>.from(signatures!.map((x) => x.toJson())),
        "sources": sources == null ? null : List<dynamic>.from(sources!.map((x) => x.toJson())),
        "type": type?.toJson(),
        "typeParameter": typeParameter == null ? null : List<dynamic>.from(typeParameter!.map((x) => x.toJson())),
    };
}

class ElementType {
    final Name name;
    final TypeEnum type;

    ElementType({
        required this.name,
        required this.type,
    });

    factory ElementType.fromJson(Map<String, dynamic> json) => ElementType(
        name: nameValues.map[json["name"]]!,
        type: typeEnumValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "type": typeEnumValues.reverse[type],
    };
}

enum Name {
    STRING,
    NUMBER,
    VOID,
    T,
    BOOLEAN,
    BASE_CLASS,
    ANY,
    ARRAY,
    MY_NUMBER
}

final nameValues = EnumValues({
    "string": Name.STRING,
    "number": Name.NUMBER,
    "void": Name.VOID,
    "T": Name.T,
    "boolean": Name.BOOLEAN,
    "BaseClass": Name.BASE_CLASS,
    "any": Name.ANY,
    "Array": Name.ARRAY,
    "MyNumber": Name.MY_NUMBER
});

enum TypeEnum {
    INTRINSIC,
    REFLECTION,
    ARRAY,
    REFERENCE,
    TYPE_PARAMETER,
    TUPLE,
    UNION,
    STRING_LITERAL
}

final typeEnumValues = EnumValues({
    "intrinsic": TypeEnum.INTRINSIC,
    "reflection": TypeEnum.REFLECTION,
    "array": TypeEnum.ARRAY,
    "reference": TypeEnum.REFERENCE,
    "typeParameter": TypeEnum.TYPE_PARAMETER,
    "tuple": TypeEnum.TUPLE,
    "union": TypeEnum.UNION,
    "stringLiteral": TypeEnum.STRING_LITERAL
});

class FluffyComment {
    final String text;

    FluffyComment({
        required this.text,
    });

    factory FluffyComment.fromJson(Map<String, dynamic> json) => FluffyComment(
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
    };
}

class FluffyFlags {
    final bool? isOptional;

    FluffyFlags({
        this.isOptional,
    });

    factory FluffyFlags.fromJson(Map<String, dynamic> json) => FluffyFlags(
        isOptional: json["isOptional"],
    );

    Map<String, dynamic> toJson() => {
        "isOptional": isOptional,
    };
}

class Source {
    final int character;
    final FileName fileName;
    final int line;

    Source({
        required this.character,
        required this.fileName,
        required this.line,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        character: json["character"],
        fileName: fileNameValues.map[json["fileName"]]!,
        line: json["line"],
    );

    Map<String, dynamic> toJson() => {
        "character": character,
        "fileName": fileNameValues.reverse[fileName],
        "line": line,
    };
}

enum FileName {
    MODULES_TS,
    CLASSES_TS,
    FLATTENED_TS,
    ACCESS_TS,
    DEFAULT_EXPORT_TS,
    ENUMERATIONS_TS,
    FUNCTIONS_TS,
    GENERICS_TS,
    SINGLE_EXPORT_TS,
    TYPESCRIPT_13_TS,
    TYPESCRIPT_14_TS,
    TYPESCRIPT_15_TS,
    VARIABLES_TS
}

final fileNameValues = EnumValues({
    "modules.ts": FileName.MODULES_TS,
    "classes.ts": FileName.CLASSES_TS,
    "flattened.ts": FileName.FLATTENED_TS,
    "access.ts": FileName.ACCESS_TS,
    "default-export.ts": FileName.DEFAULT_EXPORT_TS,
    "enumerations.ts": FileName.ENUMERATIONS_TS,
    "functions.ts": FileName.FUNCTIONS_TS,
    "generics.ts": FileName.GENERICS_TS,
    "single-export.ts": FileName.SINGLE_EXPORT_TS,
    "typescript-1.3.ts": FileName.TYPESCRIPT_13_TS,
    "typescript-1.4.ts": FileName.TYPESCRIPT_14_TS,
    "typescript-1.5.ts": FileName.TYPESCRIPT_15_TS,
    "variables.ts": FileName.VARIABLES_TS
});

class GetSignatureComment {
    final String? returns;
    final String? shortText;
    final String? text;

    GetSignatureComment({
        this.returns,
        this.shortText,
        this.text,
    });

    factory GetSignatureComment.fromJson(Map<String, dynamic> json) => GetSignatureComment(
        returns: json["returns"],
        shortText: json["shortText"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "returns": returns,
        "shortText": shortText,
        "text": text,
    };
}

class Group {
    final List<int> children;
    final int kind;
    final String title;

    Group({
        required this.children,
        required this.kind,
        required this.title,
    });

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        children: List<int>.from(json["children"].map((x) => x)),
        kind: json["kind"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x)),
        "kind": kind,
        "title": title,
    };
}

class GetSignatureParameter {
    final TentacledComment? comment;
    final TentacledFlags flags;
    final int id;
    final int kind;
    final ParameterKindString kindString;
    final String name;
    final FluffyType type;

    GetSignatureParameter({
        this.comment,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        required this.type,
    });

    factory GetSignatureParameter.fromJson(Map<String, dynamic> json) => GetSignatureParameter(
        comment: json["comment"] == null ? null : TentacledComment.fromJson(json["comment"]),
        flags: TentacledFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: parameterKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        type: FluffyType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": parameterKindStringValues.reverse[kindString],
        "name": name,
        "type": type.toJson(),
    };
}

class TentacledComment {
    final String? shortText;
    final String? text;

    TentacledComment({
        this.shortText,
        this.text,
    });

    factory TentacledComment.fromJson(Map<String, dynamic> json) => TentacledComment(
        shortText: json["shortText"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "shortText": shortText,
        "text": text,
    };
}

class TentacledFlags {
    final bool? isOptional;
    final bool? isRest;

    TentacledFlags({
        this.isOptional,
        this.isRest,
    });

    factory TentacledFlags.fromJson(Map<String, dynamic> json) => TentacledFlags(
        isOptional: json["isOptional"],
        isRest: json["isRest"],
    );

    Map<String, dynamic> toJson() => {
        "isOptional": isOptional,
        "isRest": isRest,
    };
}

enum ParameterKindString {
    PARAMETER
}

final parameterKindStringValues = EnumValues({
    "Parameter": ParameterKindString.PARAMETER
});

class FluffyType {
    final ElementType? elementType;
    final Name? name;
    final TypeEnum type;
    final List<ElementType>? typeArguments;

    FluffyType({
        this.elementType,
        this.name,
        required this.type,
        this.typeArguments,
    });

    factory FluffyType.fromJson(Map<String, dynamic> json) => FluffyType(
        elementType: json["elementType"] == null ? null : ElementType.fromJson(json["elementType"]),
        name: json["name"] == null ? null : nameValues.map[json["name"]]!,
        type: typeEnumValues.map[json["type"]]!,
        typeArguments: json["typeArguments"] == null ? null : List<ElementType>.from(json["typeArguments"]!.map((x) => ElementType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "elementType": elementType?.toJson(),
        "name": nameValues.reverse[name],
        "type": typeEnumValues.reverse[type],
        "typeArguments": typeArguments == null ? null : List<dynamic>.from(typeArguments!.map((x) => x.toJson())),
    };
}

class TentacledType {
    final PurpleDeclaration? declaration;
    final Name? name;
    final TypeEnum type;

    TentacledType({
        this.declaration,
        this.name,
        required this.type,
    });

    factory TentacledType.fromJson(Map<String, dynamic> json) => TentacledType(
        declaration: json["declaration"] == null ? null : PurpleDeclaration.fromJson(json["declaration"]),
        name: json["name"] == null ? null : nameValues.map[json["name"]]!,
        type: typeEnumValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "declaration": declaration?.toJson(),
        "name": nameValues.reverse[name],
        "type": typeEnumValues.reverse[type],
    };
}

class PurpleDeclaration {
    final List<GetSignature> children;
    final GetSignatureFlags flags;
    final List<Group> groups;
    final int id;
    final int kind;
    final String kindString;
    final String name;

    PurpleDeclaration({
        required this.children,
        required this.flags,
        required this.groups,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
    });

    factory PurpleDeclaration.fromJson(Map<String, dynamic> json) => PurpleDeclaration(
        children: List<GetSignature>.from(json["children"].map((x) => GetSignature.fromJson(x))),
        flags: GetSignatureFlags.fromJson(json["flags"]),
        groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
        id: json["id"],
        kind: json["kind"],
        kindString: json["kindString"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "flags": flags.toJson(),
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
        "id": id,
        "kind": kind,
        "kindString": kindString,
        "name": name,
    };
}

class TypeElement {
    final GetSignature? declaration;
    final ElementType? elementType;
    final Name? name;
    final TypeEnum type;
    final List<ElementType>? typeArguments;

    TypeElement({
        this.declaration,
        this.elementType,
        this.name,
        required this.type,
        this.typeArguments,
    });

    factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(
        declaration: json["declaration"] == null ? null : GetSignature.fromJson(json["declaration"]),
        elementType: json["elementType"] == null ? null : ElementType.fromJson(json["elementType"]),
        name: json["name"] == null ? null : nameValues.map[json["name"]]!,
        type: typeEnumValues.map[json["type"]]!,
        typeArguments: json["typeArguments"] == null ? null : List<ElementType>.from(json["typeArguments"]!.map((x) => ElementType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "declaration": declaration?.toJson(),
        "elementType": elementType?.toJson(),
        "name": nameValues.reverse[name],
        "type": typeEnumValues.reverse[type],
        "typeArguments": typeArguments == null ? null : List<dynamic>.from(typeArguments!.map((x) => x.toJson())),
    };
}

class StickyComment {
    final String? returns;
    final String? shortText;
    final List<Tag>? tags;
    final String? text;

    StickyComment({
        this.returns,
        this.shortText,
        this.tags,
        this.text,
    });

    factory StickyComment.fromJson(Map<String, dynamic> json) => StickyComment(
        returns: json["returns"],
        shortText: json["shortText"],
        tags: json["tags"] == null ? null : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "returns": returns,
        "shortText": shortText,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "text": text,
    };
}

class Tag {
    final String tag;
    final String text;

    Tag({
        required this.tag,
        required this.text,
    });

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        tag: json["tag"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "tag": tag,
        "text": text,
    };
}

class StickyFlags {
    final bool? isAbstract;
    final bool? isConstructorProperty;
    final bool? isExported;
    final bool? isPrivate;
    final bool? isProtected;
    final bool? isPublic;
    final bool? isStatic;

    StickyFlags({
        this.isAbstract,
        this.isConstructorProperty,
        this.isExported,
        this.isPrivate,
        this.isProtected,
        this.isPublic,
        this.isStatic,
    });

    factory StickyFlags.fromJson(Map<String, dynamic> json) => StickyFlags(
        isAbstract: json["isAbstract"],
        isConstructorProperty: json["isConstructorProperty"],
        isExported: json["isExported"],
        isPrivate: json["isPrivate"],
        isProtected: json["isProtected"],
        isPublic: json["isPublic"],
        isStatic: json["isStatic"],
    );

    Map<String, dynamic> toJson() => {
        "isAbstract": isAbstract,
        "isConstructorProperty": isConstructorProperty,
        "isExported": isExported,
        "isPrivate": isPrivate,
        "isProtected": isProtected,
        "isPublic": isPublic,
        "isStatic": isStatic,
    };
}

class ExtendedBy {
    final ExtendedBy? constraint;
    final int? id;
    final String name;
    final TypeEnum type;
    final List<ExtendedBy>? typeArguments;

    ExtendedBy({
        this.constraint,
        this.id,
        required this.name,
        required this.type,
        this.typeArguments,
    });

    factory ExtendedBy.fromJson(Map<String, dynamic> json) => ExtendedBy(
        constraint: json["constraint"] == null ? null : ExtendedBy.fromJson(json["constraint"]),
        id: json["id"],
        name: json["name"],
        type: typeEnumValues.map[json["type"]]!,
        typeArguments: json["typeArguments"] == null ? null : List<ExtendedBy>.from(json["typeArguments"]!.map((x) => ExtendedBy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "constraint": constraint?.toJson(),
        "id": id,
        "name": name,
        "type": typeEnumValues.reverse[type],
        "typeArguments": typeArguments == null ? null : List<dynamic>.from(typeArguments!.map((x) => x.toJson())),
    };
}

class FluffySignature {
    final StickyComment? comment;
    final IndigoFlags flags;
    final int id;
    final ExtendedBy? implementationOf;
    final ExtendedBy? inheritedFrom;
    final int kind;
    final SignatureKindString kindString;
    final String name;
    final ExtendedBy? overwrites;
    final List<PurpleParameter>? parameters;
    final ExtendedBy type;
    final List<GetSignature>? typeParameter;

    FluffySignature({
        this.comment,
        required this.flags,
        required this.id,
        this.implementationOf,
        this.inheritedFrom,
        required this.kind,
        required this.kindString,
        required this.name,
        this.overwrites,
        this.parameters,
        required this.type,
        this.typeParameter,
    });

    factory FluffySignature.fromJson(Map<String, dynamic> json) => FluffySignature(
        comment: json["comment"] == null ? null : StickyComment.fromJson(json["comment"]),
        flags: IndigoFlags.fromJson(json["flags"]),
        id: json["id"],
        implementationOf: json["implementationOf"] == null ? null : ExtendedBy.fromJson(json["implementationOf"]),
        inheritedFrom: json["inheritedFrom"] == null ? null : ExtendedBy.fromJson(json["inheritedFrom"]),
        kind: json["kind"],
        kindString: signatureKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        overwrites: json["overwrites"] == null ? null : ExtendedBy.fromJson(json["overwrites"]),
        parameters: json["parameters"] == null ? null : List<PurpleParameter>.from(json["parameters"]!.map((x) => PurpleParameter.fromJson(x))),
        type: ExtendedBy.fromJson(json["type"]),
        typeParameter: json["typeParameter"] == null ? null : List<GetSignature>.from(json["typeParameter"]!.map((x) => GetSignature.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "flags": flags.toJson(),
        "id": id,
        "implementationOf": implementationOf?.toJson(),
        "inheritedFrom": inheritedFrom?.toJson(),
        "kind": kind,
        "kindString": signatureKindStringValues.reverse[kindString],
        "name": name,
        "overwrites": overwrites?.toJson(),
        "parameters": parameters == null ? null : List<dynamic>.from(parameters!.map((x) => x.toJson())),
        "type": type.toJson(),
        "typeParameter": typeParameter == null ? null : List<dynamic>.from(typeParameter!.map((x) => x.toJson())),
    };
}

class IndigoFlags {
    final bool? isPrivate;
    final bool? isProtected;

    IndigoFlags({
        this.isPrivate,
        this.isProtected,
    });

    factory IndigoFlags.fromJson(Map<String, dynamic> json) => IndigoFlags(
        isPrivate: json["isPrivate"],
        isProtected: json["isProtected"],
    );

    Map<String, dynamic> toJson() => {
        "isPrivate": isPrivate,
        "isProtected": isProtected,
    };
}

class PurpleParameter {
    final TentacledComment? comment;
    final GetSignatureFlags flags;
    final int id;
    final int kind;
    final ParameterKindString kindString;
    final String name;
    final StickyType type;

    PurpleParameter({
        this.comment,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        required this.type,
    });

    factory PurpleParameter.fromJson(Map<String, dynamic> json) => PurpleParameter(
        comment: json["comment"] == null ? null : TentacledComment.fromJson(json["comment"]),
        flags: GetSignatureFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: parameterKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        type: StickyType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": parameterKindStringValues.reverse[kindString],
        "name": name,
        "type": type.toJson(),
    };
}

class StickyType {
    final ExtendedBy? constraint;
    final GetSignature? declaration;
    final ElementType? elementType;
    final List<ExtendedBy>? elements;
    final int? id;
    final String? name;
    final TypeEnum type;
    final List<ElementType>? typeArguments;

    StickyType({
        this.constraint,
        this.declaration,
        this.elementType,
        this.elements,
        this.id,
        this.name,
        required this.type,
        this.typeArguments,
    });

    factory StickyType.fromJson(Map<String, dynamic> json) => StickyType(
        constraint: json["constraint"] == null ? null : ExtendedBy.fromJson(json["constraint"]),
        declaration: json["declaration"] == null ? null : GetSignature.fromJson(json["declaration"]),
        elementType: json["elementType"] == null ? null : ElementType.fromJson(json["elementType"]),
        elements: json["elements"] == null ? null : List<ExtendedBy>.from(json["elements"]!.map((x) => ExtendedBy.fromJson(x))),
        id: json["id"],
        name: json["name"],
        type: typeEnumValues.map[json["type"]]!,
        typeArguments: json["typeArguments"] == null ? null : List<ElementType>.from(json["typeArguments"]!.map((x) => ElementType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "constraint": constraint?.toJson(),
        "declaration": declaration?.toJson(),
        "elementType": elementType?.toJson(),
        "elements": elements == null ? null : List<dynamic>.from(elements!.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "type": typeEnumValues.reverse[type],
        "typeArguments": typeArguments == null ? null : List<dynamic>.from(typeArguments!.map((x) => x.toJson())),
    };
}

class IndigoType {
    final ExtendedBy? constraint;
    final FluffyDeclaration? declaration;
    final ExtendedBy? elementType;
    final List<ElementType>? elements;
    final int? id;
    final String? name;
    final TypeEnum type;
    final List<PurpleTypeArgument>? typeArguments;
    final List<TypeElement>? types;

    IndigoType({
        this.constraint,
        this.declaration,
        this.elementType,
        this.elements,
        this.id,
        this.name,
        required this.type,
        this.typeArguments,
        this.types,
    });

    factory IndigoType.fromJson(Map<String, dynamic> json) => IndigoType(
        constraint: json["constraint"] == null ? null : ExtendedBy.fromJson(json["constraint"]),
        declaration: json["declaration"] == null ? null : FluffyDeclaration.fromJson(json["declaration"]),
        elementType: json["elementType"] == null ? null : ExtendedBy.fromJson(json["elementType"]),
        elements: json["elements"] == null ? null : List<ElementType>.from(json["elements"]!.map((x) => ElementType.fromJson(x))),
        id: json["id"],
        name: json["name"],
        type: typeEnumValues.map[json["type"]]!,
        typeArguments: json["typeArguments"] == null ? null : List<PurpleTypeArgument>.from(json["typeArguments"]!.map((x) => PurpleTypeArgument.fromJson(x))),
        types: json["types"] == null ? null : List<TypeElement>.from(json["types"]!.map((x) => TypeElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "constraint": constraint?.toJson(),
        "declaration": declaration?.toJson(),
        "elementType": elementType?.toJson(),
        "elements": elements == null ? null : List<dynamic>.from(elements!.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "type": typeEnumValues.reverse[type],
        "typeArguments": typeArguments == null ? null : List<dynamic>.from(typeArguments!.map((x) => x.toJson())),
        "types": types == null ? null : List<dynamic>.from(types!.map((x) => x.toJson())),
    };
}

class FluffyDeclaration {
    final List<StickyChild>? children;
    final GetSignatureFlags flags;
    final List<Group>? groups;
    final int id;
    final IndexSignature? indexSignature;
    final int kind;
    final String kindString;
    final String name;
    final List<TentacledSignature>? signatures;
    final List<Source> sources;

    FluffyDeclaration({
        this.children,
        required this.flags,
        this.groups,
        required this.id,
        this.indexSignature,
        required this.kind,
        required this.kindString,
        required this.name,
        this.signatures,
        required this.sources,
    });

    factory FluffyDeclaration.fromJson(Map<String, dynamic> json) => FluffyDeclaration(
        children: json["children"] == null ? null : List<StickyChild>.from(json["children"]!.map((x) => StickyChild.fromJson(x))),
        flags: GetSignatureFlags.fromJson(json["flags"]),
        groups: json["groups"] == null ? null : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        id: json["id"],
        indexSignature: json["indexSignature"] == null ? null : IndexSignature.fromJson(json["indexSignature"]),
        kind: json["kind"],
        kindString: json["kindString"],
        name: json["name"],
        signatures: json["signatures"] == null ? null : List<TentacledSignature>.from(json["signatures"]!.map((x) => TentacledSignature.fromJson(x))),
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
        "flags": flags.toJson(),
        "groups": groups == null ? null : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "id": id,
        "indexSignature": indexSignature?.toJson(),
        "kind": kind,
        "kindString": kindString,
        "name": name,
        "signatures": signatures == null ? null : List<dynamic>.from(signatures!.map((x) => x.toJson())),
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
    };
}

class StickyChild {
    final FluffyComment? comment;
    final FluffyFlags flags;
    final int id;
    final int kind;
    final PurpleKindString kindString;
    final String name;
    final List<Source> sources;
    final IndecentType type;

    StickyChild({
        this.comment,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        required this.sources,
        required this.type,
    });

    factory StickyChild.fromJson(Map<String, dynamic> json) => StickyChild(
        comment: json["comment"] == null ? null : FluffyComment.fromJson(json["comment"]),
        flags: FluffyFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: purpleKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        type: IndecentType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": purpleKindStringValues.reverse[kindString],
        "name": name,
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
        "type": type.toJson(),
    };
}

class IndecentType {
    final GetSignature? declaration;
    final List<ElementType>? elements;
    final Name? name;
    final TypeEnum type;

    IndecentType({
        this.declaration,
        this.elements,
        this.name,
        required this.type,
    });

    factory IndecentType.fromJson(Map<String, dynamic> json) => IndecentType(
        declaration: json["declaration"] == null ? null : GetSignature.fromJson(json["declaration"]),
        elements: json["elements"] == null ? null : List<ElementType>.from(json["elements"]!.map((x) => ElementType.fromJson(x))),
        name: json["name"] == null ? null : nameValues.map[json["name"]]!,
        type: typeEnumValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "declaration": declaration?.toJson(),
        "elements": elements == null ? null : List<dynamic>.from(elements!.map((x) => x.toJson())),
        "name": nameValues.reverse[name],
        "type": typeEnumValues.reverse[type],
    };
}

class IndexSignature {
    final GetSignatureFlags flags;
    final int id;
    final int kind;
    final String kindString;
    final String name;
    final List<GetSignature> parameters;
    final HilariousType type;

    IndexSignature({
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        required this.parameters,
        required this.type,
    });

    factory IndexSignature.fromJson(Map<String, dynamic> json) => IndexSignature(
        flags: GetSignatureFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: json["kindString"],
        name: json["name"],
        parameters: List<GetSignature>.from(json["parameters"].map((x) => GetSignature.fromJson(x))),
        type: HilariousType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": kindString,
        "name": name,
        "parameters": List<dynamic>.from(parameters.map((x) => x.toJson())),
        "type": type.toJson(),
    };
}

class HilariousType {
    final GetSignature declaration;
    final TypeEnum type;

    HilariousType({
        required this.declaration,
        required this.type,
    });

    factory HilariousType.fromJson(Map<String, dynamic> json) => HilariousType(
        declaration: GetSignature.fromJson(json["declaration"]),
        type: typeEnumValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "declaration": declaration.toJson(),
        "type": typeEnumValues.reverse[type],
    };
}

class TentacledSignature {
    final IndigoComment? comment;
    final GetSignatureFlags flags;
    final int id;
    final int kind;
    final SignatureKindString kindString;
    final String name;
    final List<FluffyParameter>? parameters;
    final ExtendedBy type;

    TentacledSignature({
        this.comment,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        this.parameters,
        required this.type,
    });

    factory TentacledSignature.fromJson(Map<String, dynamic> json) => TentacledSignature(
        comment: json["comment"] == null ? null : IndigoComment.fromJson(json["comment"]),
        flags: GetSignatureFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: signatureKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        parameters: json["parameters"] == null ? null : List<FluffyParameter>.from(json["parameters"]!.map((x) => FluffyParameter.fromJson(x))),
        type: ExtendedBy.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": signatureKindStringValues.reverse[kindString],
        "name": name,
        "parameters": parameters == null ? null : List<dynamic>.from(parameters!.map((x) => x.toJson())),
        "type": type.toJson(),
    };
}

class IndigoComment {
    final String returns;
    final String shortText;

    IndigoComment({
        required this.returns,
        required this.shortText,
    });

    factory IndigoComment.fromJson(Map<String, dynamic> json) => IndigoComment(
        returns: json["returns"],
        shortText: json["shortText"],
    );

    Map<String, dynamic> toJson() => {
        "returns": returns,
        "shortText": shortText,
    };
}

class FluffyParameter {
    final FluffyComment? comment;
    final FluffyFlags flags;
    final int id;
    final int kind;
    final String kindString;
    final String name;
    final List<Source>? sources;
    final ElementType type;

    FluffyParameter({
        this.comment,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        this.sources,
        required this.type,
    });

    factory FluffyParameter.fromJson(Map<String, dynamic> json) => FluffyParameter(
        comment: json["comment"] == null ? null : FluffyComment.fromJson(json["comment"]),
        flags: FluffyFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: json["kindString"],
        name: json["name"],
        sources: json["sources"] == null ? null : List<Source>.from(json["sources"]!.map((x) => Source.fromJson(x))),
        type: ElementType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": kindString,
        "name": name,
        "sources": sources == null ? null : List<dynamic>.from(sources!.map((x) => x.toJson())),
        "type": type.toJson(),
    };
}

class PurpleTypeArgument {
    final ElementType target;
    final String type;
    final String typeArgumentOperator;

    PurpleTypeArgument({
        required this.target,
        required this.type,
        required this.typeArgumentOperator,
    });

    factory PurpleTypeArgument.fromJson(Map<String, dynamic> json) => PurpleTypeArgument(
        target: ElementType.fromJson(json["target"]),
        type: json["type"],
        typeArgumentOperator: json["operator"],
    );

    Map<String, dynamic> toJson() => {
        "target": target.toJson(),
        "type": type,
        "operator": typeArgumentOperator,
    };
}

class IndecentFlags {
    final bool? hasExportAssignment;
    final bool? isAbstract;
    final bool? isConst;
    final bool? isExported;
    final bool? isLet;
    final bool? isPrivate;
    final bool? isProtected;

    IndecentFlags({
        this.hasExportAssignment,
        this.isAbstract,
        this.isConst,
        this.isExported,
        this.isLet,
        this.isPrivate,
        this.isProtected,
    });

    factory IndecentFlags.fromJson(Map<String, dynamic> json) => IndecentFlags(
        hasExportAssignment: json["hasExportAssignment"],
        isAbstract: json["isAbstract"],
        isConst: json["isConst"],
        isExported: json["isExported"],
        isLet: json["isLet"],
        isPrivate: json["isPrivate"],
        isProtected: json["isProtected"],
    );

    Map<String, dynamic> toJson() => {
        "hasExportAssignment": hasExportAssignment,
        "isAbstract": isAbstract,
        "isConst": isConst,
        "isExported": isExported,
        "isLet": isLet,
        "isPrivate": isPrivate,
        "isProtected": isProtected,
    };
}

enum FluffyKindString {
    MODULE,
    CLASS,
    VARIABLE,
    FUNCTION,
    INTERFACE,
    ENUMERATION,
    OBJECT_LITERAL,
    TYPE_ALIAS
}

final fluffyKindStringValues = EnumValues({
    "Module": FluffyKindString.MODULE,
    "Class": FluffyKindString.CLASS,
    "Variable": FluffyKindString.VARIABLE,
    "Function": FluffyKindString.FUNCTION,
    "Interface": FluffyKindString.INTERFACE,
    "Enumeration": FluffyKindString.ENUMERATION,
    "Object literal": FluffyKindString.OBJECT_LITERAL,
    "Type alias": FluffyKindString.TYPE_ALIAS
});

class StickySignature {
    final StickyComment comment;
    final IndigoFlags flags;
    final int id;
    final int kind;
    final SignatureKindString kindString;
    final String name;
    final List<TentacledParameter>? parameters;
    final CunningType type;
    final List<GetSignature>? typeParameter;

    StickySignature({
        required this.comment,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        this.parameters,
        required this.type,
        this.typeParameter,
    });

    factory StickySignature.fromJson(Map<String, dynamic> json) => StickySignature(
        comment: StickyComment.fromJson(json["comment"]),
        flags: IndigoFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: signatureKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        parameters: json["parameters"] == null ? null : List<TentacledParameter>.from(json["parameters"]!.map((x) => TentacledParameter.fromJson(x))),
        type: CunningType.fromJson(json["type"]),
        typeParameter: json["typeParameter"] == null ? null : List<GetSignature>.from(json["typeParameter"]!.map((x) => GetSignature.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment.toJson(),
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": signatureKindStringValues.reverse[kindString],
        "name": name,
        "parameters": parameters == null ? null : List<dynamic>.from(parameters!.map((x) => x.toJson())),
        "type": type.toJson(),
        "typeParameter": typeParameter == null ? null : List<dynamic>.from(typeParameter!.map((x) => x.toJson())),
    };
}

class TentacledParameter {
    final TentacledComment? comment;
    final String? defaultValue;
    final TentacledFlags flags;
    final int id;
    final int kind;
    final ParameterKindString kindString;
    final String name;
    final String? originalName;
    final AmbitiousType type;

    TentacledParameter({
        this.comment,
        this.defaultValue,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        this.originalName,
        required this.type,
    });

    factory TentacledParameter.fromJson(Map<String, dynamic> json) => TentacledParameter(
        comment: json["comment"] == null ? null : TentacledComment.fromJson(json["comment"]),
        defaultValue: json["defaultValue"],
        flags: TentacledFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: parameterKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        originalName: json["originalName"],
        type: AmbitiousType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "defaultValue": defaultValue,
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": parameterKindStringValues.reverse[kindString],
        "name": name,
        "originalName": originalName,
        "type": type.toJson(),
    };
}

class AmbitiousType {
    final TentacledDeclaration? declaration;
    final ElementType? elementType;
    final int? id;
    final String? name;
    final TypeEnum type;
    final List<ElementType>? typeArguments;

    AmbitiousType({
        this.declaration,
        this.elementType,
        this.id,
        this.name,
        required this.type,
        this.typeArguments,
    });

    factory AmbitiousType.fromJson(Map<String, dynamic> json) => AmbitiousType(
        declaration: json["declaration"] == null ? null : TentacledDeclaration.fromJson(json["declaration"]),
        elementType: json["elementType"] == null ? null : ElementType.fromJson(json["elementType"]),
        id: json["id"],
        name: json["name"],
        type: typeEnumValues.map[json["type"]]!,
        typeArguments: json["typeArguments"] == null ? null : List<ElementType>.from(json["typeArguments"]!.map((x) => ElementType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "declaration": declaration?.toJson(),
        "elementType": elementType?.toJson(),
        "id": id,
        "name": name,
        "type": typeEnumValues.reverse[type],
        "typeArguments": typeArguments == null ? null : List<dynamic>.from(typeArguments!.map((x) => x.toJson())),
    };
}

class TentacledDeclaration {
    final List<IndigoChild>? children;
    final GetSignatureFlags flags;
    final List<Group>? groups;
    final int id;
    final IndexSignatureElement? indexSignature;
    final int kind;
    final String kindString;
    final String name;
    final List<GetSignature>? signatures;
    final List<Source> sources;

    TentacledDeclaration({
        this.children,
        required this.flags,
        this.groups,
        required this.id,
        this.indexSignature,
        required this.kind,
        required this.kindString,
        required this.name,
        this.signatures,
        required this.sources,
    });

    factory TentacledDeclaration.fromJson(Map<String, dynamic> json) => TentacledDeclaration(
        children: json["children"] == null ? null : List<IndigoChild>.from(json["children"]!.map((x) => IndigoChild.fromJson(x))),
        flags: GetSignatureFlags.fromJson(json["flags"]),
        groups: json["groups"] == null ? null : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        id: json["id"],
        indexSignature: json["indexSignature"] == null ? null : IndexSignatureElement.fromJson(json["indexSignature"]),
        kind: json["kind"],
        kindString: json["kindString"],
        name: json["name"],
        signatures: json["signatures"] == null ? null : List<GetSignature>.from(json["signatures"]!.map((x) => GetSignature.fromJson(x))),
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
        "flags": flags.toJson(),
        "groups": groups == null ? null : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "id": id,
        "indexSignature": indexSignature?.toJson(),
        "kind": kind,
        "kindString": kindString,
        "name": name,
        "signatures": signatures == null ? null : List<dynamic>.from(signatures!.map((x) => x.toJson())),
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
    };
}

class IndigoChild {
    final FluffyComment comment;
    final String? defaultValue;
    final FluffyFlags flags;
    final int id;
    final int kind;
    final PurpleKindString kindString;
    final String name;
    final List<Source> sources;
    final IndecentType type;

    IndigoChild({
        required this.comment,
        this.defaultValue,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        required this.sources,
        required this.type,
    });

    factory IndigoChild.fromJson(Map<String, dynamic> json) => IndigoChild(
        comment: FluffyComment.fromJson(json["comment"]),
        defaultValue: json["defaultValue"],
        flags: FluffyFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: purpleKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        type: IndecentType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment.toJson(),
        "defaultValue": defaultValue,
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": purpleKindStringValues.reverse[kindString],
        "name": name,
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
        "type": type.toJson(),
    };
}

class CunningType {
    final PurpleDeclaration? declaration;
    final int? id;
    final Name? name;
    final TypeEnum type;
    final List<ElementType>? typeArguments;

    CunningType({
        this.declaration,
        this.id,
        this.name,
        required this.type,
        this.typeArguments,
    });

    factory CunningType.fromJson(Map<String, dynamic> json) => CunningType(
        declaration: json["declaration"] == null ? null : PurpleDeclaration.fromJson(json["declaration"]),
        id: json["id"],
        name: json["name"] == null ? null : nameValues.map[json["name"]]!,
        type: typeEnumValues.map[json["type"]]!,
        typeArguments: json["typeArguments"] == null ? null : List<ElementType>.from(json["typeArguments"]!.map((x) => ElementType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "declaration": declaration?.toJson(),
        "id": id,
        "name": nameValues.reverse[name],
        "type": typeEnumValues.reverse[type],
        "typeArguments": typeArguments == null ? null : List<dynamic>.from(typeArguments!.map((x) => x.toJson())),
    };
}

class MagentaType {
    final StickyDeclaration? declaration;
    final ElementType? elementType;
    final List<ExtendedBy>? elements;
    final int? id;
    final String? name;
    final TypeEnum type;
    final List<FluffyTypeArgument>? typeArguments;
    final List<ExtendedBy>? types;
    final String? value;

    MagentaType({
        this.declaration,
        this.elementType,
        this.elements,
        this.id,
        this.name,
        required this.type,
        this.typeArguments,
        this.types,
        this.value,
    });

    factory MagentaType.fromJson(Map<String, dynamic> json) => MagentaType(
        declaration: json["declaration"] == null ? null : StickyDeclaration.fromJson(json["declaration"]),
        elementType: json["elementType"] == null ? null : ElementType.fromJson(json["elementType"]),
        elements: json["elements"] == null ? null : List<ExtendedBy>.from(json["elements"]!.map((x) => ExtendedBy.fromJson(x))),
        id: json["id"],
        name: json["name"],
        type: typeEnumValues.map[json["type"]]!,
        typeArguments: json["typeArguments"] == null ? null : List<FluffyTypeArgument>.from(json["typeArguments"]!.map((x) => FluffyTypeArgument.fromJson(x))),
        types: json["types"] == null ? null : List<ExtendedBy>.from(json["types"]!.map((x) => ExtendedBy.fromJson(x))),
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "declaration": declaration?.toJson(),
        "elementType": elementType?.toJson(),
        "elements": elements == null ? null : List<dynamic>.from(elements!.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "type": typeEnumValues.reverse[type],
        "typeArguments": typeArguments == null ? null : List<dynamic>.from(typeArguments!.map((x) => x.toJson())),
        "types": types == null ? null : List<dynamic>.from(types!.map((x) => x.toJson())),
        "value": value,
    };
}

class StickyDeclaration {
    final List<IndecentChild>? children;
    final GetSignatureFlags flags;
    final List<Group>? groups;
    final int id;
    final int kind;
    final String kindString;
    final String name;
    final List<GetSignature> signatures;
    final List<Source> sources;

    StickyDeclaration({
        this.children,
        required this.flags,
        this.groups,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        required this.signatures,
        required this.sources,
    });

    factory StickyDeclaration.fromJson(Map<String, dynamic> json) => StickyDeclaration(
        children: json["children"] == null ? null : List<IndecentChild>.from(json["children"]!.map((x) => IndecentChild.fromJson(x))),
        flags: GetSignatureFlags.fromJson(json["flags"]),
        groups: json["groups"] == null ? null : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        id: json["id"],
        kind: json["kind"],
        kindString: json["kindString"],
        name: json["name"],
        signatures: List<GetSignature>.from(json["signatures"].map((x) => GetSignature.fromJson(x))),
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
        "flags": flags.toJson(),
        "groups": groups == null ? null : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "id": id,
        "kind": kind,
        "kindString": kindString,
        "name": name,
        "signatures": List<dynamic>.from(signatures.map((x) => x.toJson())),
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
    };
}

class IndecentChild {
    final FluffyFlags flags;
    final int id;
    final int kind;
    final PurpleKindString kindString;
    final String name;
    final List<Source> sources;
    final FriskyType type;

    IndecentChild({
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        required this.sources,
        required this.type,
    });

    factory IndecentChild.fromJson(Map<String, dynamic> json) => IndecentChild(
        flags: FluffyFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: purpleKindStringValues.map[json["kindString"]]!,
        name: json["name"],
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        type: FriskyType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": purpleKindStringValues.reverse[kindString],
        "name": name,
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
        "type": type.toJson(),
    };
}

class FriskyType {
    final IndigoDeclaration? declaration;
    final Name? name;
    final TypeEnum type;

    FriskyType({
        this.declaration,
        this.name,
        required this.type,
    });

    factory FriskyType.fromJson(Map<String, dynamic> json) => FriskyType(
        declaration: json["declaration"] == null ? null : IndigoDeclaration.fromJson(json["declaration"]),
        name: json["name"] == null ? null : nameValues.map[json["name"]]!,
        type: typeEnumValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "declaration": declaration?.toJson(),
        "name": nameValues.reverse[name],
        "type": typeEnumValues.reverse[type],
    };
}

class IndigoDeclaration {
    final List<GetSignature>? children;
    final GetSignatureFlags flags;
    final List<Group>? groups;
    final int id;
    final int kind;
    final String kindString;
    final String name;
    final List<GetSignature>? signatures;
    final List<Source> sources;

    IndigoDeclaration({
        this.children,
        required this.flags,
        this.groups,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        this.signatures,
        required this.sources,
    });

    factory IndigoDeclaration.fromJson(Map<String, dynamic> json) => IndigoDeclaration(
        children: json["children"] == null ? null : List<GetSignature>.from(json["children"]!.map((x) => GetSignature.fromJson(x))),
        flags: GetSignatureFlags.fromJson(json["flags"]),
        groups: json["groups"] == null ? null : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        id: json["id"],
        kind: json["kind"],
        kindString: json["kindString"],
        name: json["name"],
        signatures: json["signatures"] == null ? null : List<GetSignature>.from(json["signatures"]!.map((x) => GetSignature.fromJson(x))),
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
        "flags": flags.toJson(),
        "groups": groups == null ? null : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "id": id,
        "kind": kind,
        "kindString": kindString,
        "name": name,
        "signatures": signatures == null ? null : List<dynamic>.from(signatures!.map((x) => x.toJson())),
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
    };
}

class FluffyTypeArgument {
    final TypeEnum type;
    final List<ElementType> types;

    FluffyTypeArgument({
        required this.type,
        required this.types,
    });

    factory FluffyTypeArgument.fromJson(Map<String, dynamic> json) => FluffyTypeArgument(
        type: typeEnumValues.map[json["type"]]!,
        types: List<ElementType>.from(json["types"].map((x) => ElementType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": typeEnumValues.reverse[type],
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
    };
}

class TypeParameter {
    final PurpleComment? comment;
    final GetSignatureFlags flags;
    final int id;
    final int kind;
    final String kindString;
    final String name;
    final MischievousType? type;

    TypeParameter({
        this.comment,
        required this.flags,
        required this.id,
        required this.kind,
        required this.kindString,
        required this.name,
        this.type,
    });

    factory TypeParameter.fromJson(Map<String, dynamic> json) => TypeParameter(
        comment: json["comment"] == null ? null : PurpleComment.fromJson(json["comment"]),
        flags: GetSignatureFlags.fromJson(json["flags"]),
        id: json["id"],
        kind: json["kind"],
        kindString: json["kindString"],
        name: json["name"],
        type: json["type"] == null ? null : MischievousType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
        "flags": flags.toJson(),
        "id": id,
        "kind": kind,
        "kindString": kindString,
        "name": name,
        "type": type?.toJson(),
    };
}

class MischievousType {
    final int? id;
    final Name? name;
    final ElementType? target;
    final String type;
    final String? typeOperator;

    MischievousType({
        this.id,
        this.name,
        this.target,
        required this.type,
        this.typeOperator,
    });

    factory MischievousType.fromJson(Map<String, dynamic> json) => MischievousType(
        id: json["id"],
        name: json["name"] == null ? null : nameValues.map[json["name"]]!,
        target: json["target"] == null ? null : ElementType.fromJson(json["target"]),
        type: json["type"],
        typeOperator: json["operator"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "target": target?.toJson(),
        "type": type,
        "operator": typeOperator,
    };
}

class IndecentComment {
    final String shortText;
    final List<Tag>? tags;

    IndecentComment({
        required this.shortText,
        this.tags,
    });

    factory IndecentComment.fromJson(Map<String, dynamic> json) => IndecentComment(
        shortText: json["shortText"],
        tags: json["tags"] == null ? null : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "shortText": shortText,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x.toJson())),
    };
}

enum TentacledKindString {
    EXTERNAL_MODULE
}

final tentacledKindStringValues = EnumValues({
    "External module": TentacledKindString.EXTERNAL_MODULE
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
