import * as S from "effect/Schema";


export const PurpleKindString = S.Literal(
    "Variable",
    "Function",
    "Property",
    "Method",
    "Constructor",
    "Accessor",
    "Enumeration member",
    "Module",
    "Object literal",
);
export type PurpleKindString = S.Schema.Type<typeof PurpleKindString>;


export const SignatureKindString = S.Literal(
    "Call signature",
    "Constructor signature",
);
export type SignatureKindString = S.Schema.Type<typeof SignatureKindString>;


export const Name = S.Literal(
    "string",
    "number",
    "void",
    "T",
    "boolean",
    "BaseClass",
    "any",
    "Array",
    "MyNumber",
);
export type Name = S.Schema.Type<typeof Name>;


export const TypeEnum = S.Literal(
    "intrinsic",
    "reflection",
    "array",
    "reference",
    "typeParameter",
    "tuple",
    "union",
    "stringLiteral",
);
export type TypeEnum = S.Schema.Type<typeof TypeEnum>;


export const FileName = S.Literal(
    "modules.ts",
    "classes.ts",
    "flattened.ts",
    "access.ts",
    "default-export.ts",
    "enumerations.ts",
    "functions.ts",
    "generics.ts",
    "single-export.ts",
    "typescript-1.3.ts",
    "typescript-1.4.ts",
    "typescript-1.5.ts",
    "variables.ts",
);
export type FileName = S.Schema.Type<typeof FileName>;


export const ParameterKindString = S.Literal(
    "Parameter",
);
export type ParameterKindString = S.Schema.Type<typeof ParameterKindString>;


export const FluffyKindString = S.Literal(
    "Module",
    "Class",
    "Variable",
    "Function",
    "Interface",
    "Enumeration",
    "Object literal",
    "Type alias",
);
export type FluffyKindString = S.Schema.Type<typeof FluffyKindString>;


export const TentacledKindString = S.Literal(
    "External module",
);
export type TentacledKindString = S.Schema.Type<typeof TentacledKindString>;

export class IndecentFlags extends S.Class<IndecentFlags>("IndecentFlags")({
    "hasExportAssignment": S.optional(S.Boolean),
    "isAbstract": S.optional(S.Boolean),
    "isConst": S.optional(S.Boolean),
    "isExported": S.optional(S.Boolean),
    "isLet": S.optional(S.Boolean),
    "isPrivate": S.optional(S.Boolean),
    "isProtected": S.optional(S.Boolean),
}) {}

export class IndigoComment extends S.Class<IndigoComment>("IndigoComment")({
    "returns": S.String,
    "shortText": S.String,
}) {}

export class IndigoFlags extends S.Class<IndigoFlags>("IndigoFlags")({
    "isPrivate": S.optional(S.Boolean),
    "isProtected": S.optional(S.Boolean),
}) {}

export class ExtendedBy extends S.Class<ExtendedBy>("ExtendedBy")({
    "constraint": S.optional(S.suspend(() => ExtendedBy)),
    "id": S.optional(S.Int),
    "name": S.String,
    "type": TypeEnum,
    "typeArguments": S.optional(S.Array(S.suspend(() => ExtendedBy))),
}) {}

export class StickyFlags extends S.Class<StickyFlags>("StickyFlags")({
    "isAbstract": S.optional(S.Boolean),
    "isConstructorProperty": S.optional(S.Boolean),
    "isExported": S.optional(S.Boolean),
    "isPrivate": S.optional(S.Boolean),
    "isProtected": S.optional(S.Boolean),
    "isPublic": S.optional(S.Boolean),
    "isStatic": S.optional(S.Boolean),
}) {}

export class Tag extends S.Class<Tag>("Tag")({
    "tag": S.String,
    "text": S.String,
}) {}

export class StickyComment extends S.Class<StickyComment>("StickyComment")({
    "returns": S.optional(S.String),
    "shortText": S.optional(S.String),
    "tags": S.optional(S.Array(Tag)),
    "text": S.optional(S.String),
}) {}

export class TentacledFlags extends S.Class<TentacledFlags>("TentacledFlags")({
    "isOptional": S.optional(S.Boolean),
    "isRest": S.optional(S.Boolean),
}) {}

export class TentacledComment extends S.Class<TentacledComment>("TentacledComment")({
    "shortText": S.optional(S.String),
    "text": S.optional(S.String),
}) {}

export class Group extends S.Class<Group>("Group")({
    "children": S.Array(S.Int),
    "kind": S.Int,
    "title": S.String,
}) {}

export class GetSignatureComment extends S.Class<GetSignatureComment>("GetSignatureComment")({
    "returns": S.optional(S.String),
    "shortText": S.optional(S.String),
    "text": S.optional(S.String),
}) {}

export class Source extends S.Class<Source>("Source")({
    "character": S.Int,
    "fileName": FileName,
    "line": S.Int,
}) {}

export class FluffyFlags extends S.Class<FluffyFlags>("FluffyFlags")({
    "isOptional": S.optional(S.Boolean),
}) {}

export class FluffyComment extends S.Class<FluffyComment>("FluffyComment")({
    "text": S.String,
}) {}

export class ElementType extends S.Class<ElementType>("ElementType")({
    "name": Name,
    "type": TypeEnum,
}) {}

export class MischievousType extends S.Class<MischievousType>("MischievousType")({
    "id": S.optional(S.Int),
    "name": S.optional(Name),
    "operator": S.optional(S.String),
    "target": S.optional(ElementType),
    "type": S.String,
}) {}

export class TypeParameter extends S.Class<TypeParameter>("TypeParameter")({
    "comment": S.optional(S.suspend(() => PurpleComment)),
    "flags": S.suspend(() => GetSignatureFlags),
    "id": S.Int,
    "kind": S.Int,
    "kindString": S.String,
    "name": S.String,
    "type": S.optional(MischievousType),
}) {}

export class FluffyTypeArgument extends S.Class<FluffyTypeArgument>("FluffyTypeArgument")({
    "type": TypeEnum,
    "types": S.Array(ElementType),
}) {}

export class GetSignatureFlags extends S.Class<GetSignatureFlags>("GetSignatureFlags")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class PurpleTypeArgument extends S.Class<PurpleTypeArgument>("PurpleTypeArgument")({
    "operator": S.String,
    "target": ElementType,
    "type": S.String,
}) {}

export class PurpleFlags extends S.Class<PurpleFlags>("PurpleFlags")({
    "isExported": S.optional(S.Boolean),
}) {}

export class PurpleComment extends S.Class<PurpleComment>("PurpleComment")({
    "shortText": S.String,
}) {}

export class TentacledChild extends S.Class<TentacledChild>("TentacledChild")({
    "comment": S.optional(PurpleComment),
    "defaultValue": S.optional(S.String),
    "flags": PurpleFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": PurpleKindString,
    "name": S.String,
    "signatures": S.optional(S.Array(S.suspend(() => PurpleSignature))),
    "sources": S.Array(Source),
    "type": S.optional(S.suspend(() => TypeElement)),
}) {}

export class FluffyParameter extends S.Class<FluffyParameter>("FluffyParameter")({
    "comment": S.optional(FluffyComment),
    "flags": FluffyFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": S.String,
    "name": S.String,
    "sources": S.optional(S.Array(Source)),
    "type": ElementType,
}) {}

export class FluffyChild extends S.Class<FluffyChild>("FluffyChild")({
    "children": S.optional(S.Array(TentacledChild)),
    "comment": S.optional(StickyComment),
    "defaultValue": S.optional(S.String),
    "flags": StickyFlags,
    "getSignature": S.optional(S.suspend(() => GetSignature)),
    "groups": S.optional(S.Array(Group)),
    "id": S.Int,
    "implementationOf": S.optional(ExtendedBy),
    "inheritedFrom": S.optional(ExtendedBy),
    "kind": S.Int,
    "kindString": PurpleKindString,
    "name": S.String,
    "overwrites": S.optional(ExtendedBy),
    "setSignature": S.optional(S.suspend(() => GetSignature)),
    "signatures": S.optional(S.Array(S.suspend(() => FluffySignature))),
    "sources": S.Array(Source),
    "type": S.optional(S.suspend(() => IndigoType)),
}) {}

export class PurpleChild extends S.Class<PurpleChild>("PurpleChild")({
    "children": S.optional(S.Array(FluffyChild)),
    "comment": S.optional(StickyComment),
    "defaultValue": S.optional(S.String),
    "extendedBy": S.optional(S.Array(ExtendedBy)),
    "extendedTypes": S.optional(S.Array(ExtendedBy)),
    "flags": IndecentFlags,
    "groups": S.optional(S.Array(Group)),
    "id": S.Int,
    "implementedBy": S.optional(S.Array(ExtendedBy)),
    "implementedTypes": S.optional(S.Array(ExtendedBy)),
    "kind": S.Int,
    "kindString": FluffyKindString,
    "name": S.String,
    "signatures": S.optional(S.Array(S.suspend(() => StickySignature))),
    "sources": S.Array(Source),
    "type": S.optional(S.suspend(() => MagentaType)),
    "typeParameter": S.optional(S.Array(TypeParameter)),
}) {}

export class TopLevelChild extends S.Class<TopLevelChild>("TopLevelChild")({
    "children": S.Array(PurpleChild),
    "comment": S.optional(S.suspend(() => IndecentComment)),
    "flags": PurpleFlags,
    "groups": S.Array(Group),
    "id": S.Int,
    "kind": S.Int,
    "kindString": TentacledKindString,
    "name": S.String,
    "originalName": S.String,
    "sources": S.Array(Source),
}) {}

export class IndigoDeclaration extends S.Class<IndigoDeclaration>("IndigoDeclaration")({
    "children": S.optional(S.Array(S.suspend(() => GetSignature))),
    "flags": GetSignatureFlags,
    "groups": S.optional(S.Array(Group)),
    "id": S.Int,
    "kind": S.Int,
    "kindString": S.String,
    "name": S.String,
    "signatures": S.optional(S.Array(S.suspend(() => GetSignature))),
    "sources": S.Array(Source),
}) {}

export class FriskyType extends S.Class<FriskyType>("FriskyType")({
    "declaration": S.optional(IndigoDeclaration),
    "name": S.optional(Name),
    "type": TypeEnum,
}) {}

export class IndecentComment extends S.Class<IndecentComment>("IndecentComment")({
    "shortText": S.String,
    "tags": S.optional(S.Array(Tag)),
}) {}

export class IndecentChild extends S.Class<IndecentChild>("IndecentChild")({
    "flags": FluffyFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": PurpleKindString,
    "name": S.String,
    "sources": S.Array(Source),
    "type": FriskyType,
}) {}

export class StickyDeclaration extends S.Class<StickyDeclaration>("StickyDeclaration")({
    "children": S.optional(S.Array(IndecentChild)),
    "flags": GetSignatureFlags,
    "groups": S.optional(S.Array(Group)),
    "id": S.Int,
    "kind": S.Int,
    "kindString": S.String,
    "name": S.String,
    "signatures": S.Array(S.suspend(() => GetSignature)),
    "sources": S.Array(Source),
}) {}

export class FluffyType extends S.Class<FluffyType>("FluffyType")({
    "elementType": S.optional(ElementType),
    "name": S.optional(Name),
    "type": TypeEnum,
    "typeArguments": S.optional(S.Array(ElementType)),
}) {}

export class PurpleSignature extends S.Class<PurpleSignature>("PurpleSignature")({
    "comment": S.optional(PurpleComment),
    "flags": GetSignatureFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": SignatureKindString,
    "name": S.String,
    "parameters": S.Array(S.suspend(() => GetSignature)),
    "type": S.suspend(() => TentacledType),
}) {}

export class CunningType extends S.Class<CunningType>("CunningType")({
    "declaration": S.optional(S.suspend(() => PurpleDeclaration)),
    "id": S.optional(S.Int),
    "name": S.optional(Name),
    "type": TypeEnum,
    "typeArguments": S.optional(S.Array(ElementType)),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "children": S.Array(TopLevelChild),
    "flags": GetSignatureFlags,
    "groups": S.Array(Group),
    "id": S.Int,
    "kind": S.Int,
    "name": S.String,
}) {}

export class GetSignatureParameter extends S.Class<GetSignatureParameter>("GetSignatureParameter")({
    "comment": S.optional(TentacledComment),
    "flags": TentacledFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": ParameterKindString,
    "name": S.String,
    "type": FluffyType,
}) {}

export class HilariousType extends S.Class<HilariousType>("HilariousType")({
    "declaration": S.suspend(() => GetSignature),
    "type": TypeEnum,
}) {}

export class IndexSignature extends S.Class<IndexSignature>("IndexSignature")({
    "flags": GetSignatureFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": S.String,
    "name": S.String,
    "parameters": S.Array(S.suspend(() => GetSignature)),
    "type": HilariousType,
}) {}

export class MagentaType extends S.Class<MagentaType>("MagentaType")({
    "declaration": S.optional(StickyDeclaration),
    "elementType": S.optional(ElementType),
    "elements": S.optional(S.Array(ExtendedBy)),
    "id": S.optional(S.Int),
    "name": S.optional(S.String),
    "type": TypeEnum,
    "typeArguments": S.optional(S.Array(FluffyTypeArgument)),
    "types": S.optional(S.Array(ExtendedBy)),
    "value": S.optional(S.String),
}) {}

export class IndecentType extends S.Class<IndecentType>("IndecentType")({
    "declaration": S.optional(S.suspend(() => GetSignature)),
    "elements": S.optional(S.Array(ElementType)),
    "name": S.optional(Name),
    "type": TypeEnum,
}) {}

export class StickyChild extends S.Class<StickyChild>("StickyChild")({
    "comment": S.optional(FluffyComment),
    "flags": FluffyFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": PurpleKindString,
    "name": S.String,
    "sources": S.Array(Source),
    "type": IndecentType,
}) {}

export class GetSignatureType extends S.Class<GetSignatureType>("GetSignatureType")({
    "declaration": S.optional(S.suspend(() => GetSignature)),
    "elementType": S.optional(ElementType),
    "name": S.optional(Name),
    "type": TypeEnum,
}) {}

export class IndexSignatureElement extends S.Class<IndexSignatureElement>("IndexSignatureElement")({
    "flags": GetSignatureFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": S.String,
    "name": S.String,
    "parameters": S.optional(S.Array(S.suspend(() => GetSignature))),
    "type": S.suspend(() => PurpleType),
}) {}

export class PurpleType extends S.Class<PurpleType>("PurpleType")({
    "declaration": S.optional(S.suspend(() => GetSignature)),
    "name": S.optional(Name),
    "type": TypeEnum,
}) {}

export class TentacledSignature extends S.Class<TentacledSignature>("TentacledSignature")({
    "comment": S.optional(IndigoComment),
    "flags": GetSignatureFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": SignatureKindString,
    "name": S.String,
    "parameters": S.optional(S.Array(FluffyParameter)),
    "type": ExtendedBy,
}) {}

export class GetSignatureChild extends S.Class<GetSignatureChild>("GetSignatureChild")({
    "comment": S.optional(FluffyComment),
    "flags": FluffyFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": PurpleKindString,
    "name": S.String,
    "sources": S.Array(Source),
    "type": PurpleType,
}) {}

export class GetSignature extends S.Class<GetSignature>("GetSignature")({
    "children": S.optional(S.Array(GetSignatureChild)),
    "comment": S.optional(GetSignatureComment),
    "defaultValue": S.optional(S.String),
    "flags": GetSignatureFlags,
    "groups": S.optional(S.Array(Group)),
    "id": S.Int,
    "kind": S.Int,
    "kindString": S.String,
    "name": S.String,
    "parameters": S.optional(S.Array(GetSignatureParameter)),
    "signatures": S.optional(S.Array(IndexSignatureElement)),
    "sources": S.optional(S.Array(Source)),
    "type": S.optional(GetSignatureType),
    "typeParameter": S.optional(S.Array(S.suspend(() => GetSignature))),
}) {}

export class TypeElement extends S.Class<TypeElement>("TypeElement")({
    "declaration": S.optional(GetSignature),
    "elementType": S.optional(ElementType),
    "name": S.optional(Name),
    "type": TypeEnum,
    "typeArguments": S.optional(S.Array(ElementType)),
}) {}

export class IndigoChild extends S.Class<IndigoChild>("IndigoChild")({
    "comment": FluffyComment,
    "defaultValue": S.optional(S.String),
    "flags": FluffyFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": PurpleKindString,
    "name": S.String,
    "sources": S.Array(Source),
    "type": IndecentType,
}) {}

export class TentacledDeclaration extends S.Class<TentacledDeclaration>("TentacledDeclaration")({
    "children": S.optional(S.Array(IndigoChild)),
    "flags": GetSignatureFlags,
    "groups": S.optional(S.Array(Group)),
    "id": S.Int,
    "indexSignature": S.optional(IndexSignatureElement),
    "kind": S.Int,
    "kindString": S.String,
    "name": S.String,
    "signatures": S.optional(S.Array(GetSignature)),
    "sources": S.Array(Source),
}) {}

export class AmbitiousType extends S.Class<AmbitiousType>("AmbitiousType")({
    "declaration": S.optional(TentacledDeclaration),
    "elementType": S.optional(ElementType),
    "id": S.optional(S.Int),
    "name": S.optional(S.String),
    "type": TypeEnum,
    "typeArguments": S.optional(S.Array(ElementType)),
}) {}

export class TentacledParameter extends S.Class<TentacledParameter>("TentacledParameter")({
    "comment": S.optional(TentacledComment),
    "defaultValue": S.optional(S.String),
    "flags": TentacledFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": ParameterKindString,
    "name": S.String,
    "originalName": S.optional(S.String),
    "type": AmbitiousType,
}) {}

export class StickySignature extends S.Class<StickySignature>("StickySignature")({
    "comment": StickyComment,
    "flags": IndigoFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": SignatureKindString,
    "name": S.String,
    "parameters": S.optional(S.Array(TentacledParameter)),
    "type": CunningType,
    "typeParameter": S.optional(S.Array(GetSignature)),
}) {}

export class PurpleDeclaration extends S.Class<PurpleDeclaration>("PurpleDeclaration")({
    "children": S.Array(GetSignature),
    "flags": GetSignatureFlags,
    "groups": S.Array(Group),
    "id": S.Int,
    "kind": S.Int,
    "kindString": S.String,
    "name": S.String,
}) {}

export class FluffyDeclaration extends S.Class<FluffyDeclaration>("FluffyDeclaration")({
    "children": S.optional(S.Array(StickyChild)),
    "flags": GetSignatureFlags,
    "groups": S.optional(S.Array(Group)),
    "id": S.Int,
    "indexSignature": S.optional(IndexSignature),
    "kind": S.Int,
    "kindString": S.String,
    "name": S.String,
    "signatures": S.optional(S.Array(TentacledSignature)),
    "sources": S.Array(Source),
}) {}

export class IndigoType extends S.Class<IndigoType>("IndigoType")({
    "constraint": S.optional(ExtendedBy),
    "declaration": S.optional(FluffyDeclaration),
    "elementType": S.optional(ExtendedBy),
    "elements": S.optional(S.Array(ElementType)),
    "id": S.optional(S.Int),
    "name": S.optional(S.String),
    "type": TypeEnum,
    "typeArguments": S.optional(S.Array(PurpleTypeArgument)),
    "types": S.optional(S.Array(TypeElement)),
}) {}

export class StickyType extends S.Class<StickyType>("StickyType")({
    "constraint": S.optional(ExtendedBy),
    "declaration": S.optional(GetSignature),
    "elementType": S.optional(ElementType),
    "elements": S.optional(S.Array(ExtendedBy)),
    "id": S.optional(S.Int),
    "name": S.optional(S.String),
    "type": TypeEnum,
    "typeArguments": S.optional(S.Array(ElementType)),
}) {}

export class PurpleParameter extends S.Class<PurpleParameter>("PurpleParameter")({
    "comment": S.optional(TentacledComment),
    "flags": GetSignatureFlags,
    "id": S.Int,
    "kind": S.Int,
    "kindString": ParameterKindString,
    "name": S.String,
    "type": StickyType,
}) {}

export class TentacledType extends S.Class<TentacledType>("TentacledType")({
    "declaration": S.optional(PurpleDeclaration),
    "name": S.optional(Name),
    "type": TypeEnum,
}) {}

export class FluffySignature extends S.Class<FluffySignature>("FluffySignature")({
    "comment": S.optional(StickyComment),
    "flags": IndigoFlags,
    "id": S.Int,
    "implementationOf": S.optional(ExtendedBy),
    "inheritedFrom": S.optional(ExtendedBy),
    "kind": S.Int,
    "kindString": SignatureKindString,
    "name": S.String,
    "overwrites": S.optional(ExtendedBy),
    "parameters": S.optional(S.Array(PurpleParameter)),
    "type": ExtendedBy,
    "typeParameter": S.optional(S.Array(GetSignature)),
}) {}
