import * as z from "zod";


export const PurpleKindStringSchema = z.enum([
    "Variable",
    "Function",
    "Property",
    "Method",
    "Constructor",
    "Accessor",
    "Enumeration member",
    "Module",
    "Object literal",
]);
export type PurpleKindString = z.infer<typeof PurpleKindStringSchema>;


export const SignatureKindStringSchema = z.enum([
    "Call signature",
    "Constructor signature",
]);
export type SignatureKindString = z.infer<typeof SignatureKindStringSchema>;


export const NameSchema = z.enum([
    "string",
    "number",
    "void",
    "T",
    "boolean",
    "BaseClass",
    "any",
    "Array",
    "MyNumber",
]);
export type Name = z.infer<typeof NameSchema>;


export const TypeEnumSchema = z.enum([
    "intrinsic",
    "reflection",
    "array",
    "reference",
    "typeParameter",
    "tuple",
    "union",
    "stringLiteral",
]);
export type TypeEnum = z.infer<typeof TypeEnumSchema>;


export const FileNameSchema = z.enum([
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
]);
export type FileName = z.infer<typeof FileNameSchema>;


export const ParameterKindStringSchema = z.enum([
    "Parameter",
]);
export type ParameterKindString = z.infer<typeof ParameterKindStringSchema>;


export const FluffyKindStringSchema = z.enum([
    "Module",
    "Class",
    "Variable",
    "Function",
    "Interface",
    "Enumeration",
    "Object literal",
    "Type alias",
]);
export type FluffyKindString = z.infer<typeof FluffyKindStringSchema>;


export const TentacledKindStringSchema = z.enum([
    "External module",
]);
export type TentacledKindString = z.infer<typeof TentacledKindStringSchema>;

export type GetSignatureType = {
    "declaration"?: GetSignature;
    "elementType"?: ElementType;
    "name"?: Name;
    "type": TypeEnum;
};
export const GetSignatureTypeSchema: z.ZodType<GetSignatureType> = z.lazy(() =>
    z.object({
        "declaration": GetSignatureSchema.optional(),
        "elementType": ElementTypeSchema.optional(),
        "name": NameSchema.optional(),
        "type": TypeEnumSchema,
    })
);

export type IndexSignatureElement = {
    "flags": GetSignatureFlags;
    "id": number;
    "kind": number;
    "kindString": string;
    "name": string;
    "parameters"?: Array<GetSignature>;
    "type": PurpleType;
};
export const IndexSignatureElementSchema: z.ZodType<IndexSignatureElement> = z.lazy(() =>
    z.object({
        "flags": GetSignatureFlagsSchema,
        "id": z.number().int(),
        "kind": z.number().int(),
        "kindString": z.string(),
        "name": z.string(),
        "parameters": z.array(GetSignatureSchema).optional(),
        "type": PurpleTypeSchema,
    })
);

export type PurpleType = {
    "declaration"?: GetSignature;
    "name"?: Name;
    "type": TypeEnum;
};
export const PurpleTypeSchema: z.ZodType<PurpleType> = z.lazy(() =>
    z.object({
        "declaration": GetSignatureSchema.optional(),
        "name": NameSchema.optional(),
        "type": TypeEnumSchema,
    })
);

export type GetSignatureChild = {
    "comment"?: FluffyComment;
    "flags": FluffyFlags;
    "id": number;
    "kind": number;
    "kindString": PurpleKindString;
    "name": string;
    "sources": Array<Source>;
    "type": PurpleType;
};
export const GetSignatureChildSchema: z.ZodType<GetSignatureChild> = z.lazy(() =>
    z.object({
        "comment": FluffyCommentSchema.optional(),
        "flags": FluffyFlagsSchema,
        "id": z.number().int(),
        "kind": z.number().int(),
        "kindString": PurpleKindStringSchema,
        "name": z.string(),
        "sources": z.array(SourceSchema),
        "type": PurpleTypeSchema,
    })
);

export type GetSignature = {
    "children"?: Array<GetSignatureChild>;
    "comment"?: GetSignatureComment;
    "defaultValue"?: string;
    "flags": GetSignatureFlags;
    "groups"?: Array<Group>;
    "id": number;
    "kind": number;
    "kindString": string;
    "name": string;
    "parameters"?: Array<GetSignatureParameter>;
    "signatures"?: Array<IndexSignatureElement>;
    "sources"?: Array<Source>;
    "type"?: GetSignatureType;
    "typeParameter"?: Array<GetSignature>;
};
export const GetSignatureSchema: z.ZodType<GetSignature> = z.lazy(() =>
    z.object({
        "children": z.array(GetSignatureChildSchema).optional(),
        "comment": GetSignatureCommentSchema.optional(),
        "defaultValue": z.string().optional(),
        "flags": GetSignatureFlagsSchema,
        "groups": z.array(GroupSchema).optional(),
        "id": z.number().int(),
        "kind": z.number().int(),
        "kindString": z.string(),
        "name": z.string(),
        "parameters": z.array(GetSignatureParameterSchema).optional(),
        "signatures": z.array(IndexSignatureElementSchema).optional(),
        "sources": z.array(SourceSchema).optional(),
        "type": GetSignatureTypeSchema.optional(),
        "typeParameter": z.array(GetSignatureSchema).optional(),
    })
);

export type ExtendedBy = {
    "constraint"?: ExtendedBy;
    "id"?: number;
    "name": string;
    "type": TypeEnum;
    "typeArguments"?: Array<ExtendedBy>;
};
export const ExtendedBySchema: z.ZodType<ExtendedBy> = z.lazy(() =>
    z.object({
        "constraint": ExtendedBySchema.optional(),
        "id": z.number().int().optional(),
        "name": z.string(),
        "type": TypeEnumSchema,
        "typeArguments": z.array(ExtendedBySchema).optional(),
    })
);

export const PurpleCommentSchema = z.object({
    "shortText": z.string(),
});
export type PurpleComment = z.infer<typeof PurpleCommentSchema>;

export const PurpleFlagsSchema = z.object({
    "isExported": z.boolean().optional(),
});
export type PurpleFlags = z.infer<typeof PurpleFlagsSchema>;

export const GetSignatureFlagsSchema = z.object({
});
export type GetSignatureFlags = z.infer<typeof GetSignatureFlagsSchema>;

export const ElementTypeSchema = z.object({
    "name": NameSchema,
    "type": TypeEnumSchema,
});
export type ElementType = z.infer<typeof ElementTypeSchema>;

export const FluffyCommentSchema = z.object({
    "text": z.string(),
});
export type FluffyComment = z.infer<typeof FluffyCommentSchema>;

export const FluffyFlagsSchema = z.object({
    "isOptional": z.boolean().optional(),
});
export type FluffyFlags = z.infer<typeof FluffyFlagsSchema>;

export const SourceSchema = z.object({
    "character": z.number().int(),
    "fileName": FileNameSchema,
    "line": z.number().int(),
});
export type Source = z.infer<typeof SourceSchema>;

export const GetSignatureCommentSchema = z.object({
    "returns": z.string().optional(),
    "shortText": z.string().optional(),
    "text": z.string().optional(),
});
export type GetSignatureComment = z.infer<typeof GetSignatureCommentSchema>;

export const GroupSchema = z.object({
    "children": z.array(z.number().int()),
    "kind": z.number().int(),
    "title": z.string(),
});
export type Group = z.infer<typeof GroupSchema>;

export const TentacledCommentSchema = z.object({
    "shortText": z.string().optional(),
    "text": z.string().optional(),
});
export type TentacledComment = z.infer<typeof TentacledCommentSchema>;

export const TentacledFlagsSchema = z.object({
    "isOptional": z.boolean().optional(),
    "isRest": z.boolean().optional(),
});
export type TentacledFlags = z.infer<typeof TentacledFlagsSchema>;

export const FluffyTypeSchema = z.object({
    "elementType": ElementTypeSchema.optional(),
    "name": NameSchema.optional(),
    "type": TypeEnumSchema,
    "typeArguments": z.array(ElementTypeSchema).optional(),
});
export type FluffyType = z.infer<typeof FluffyTypeSchema>;

export const PurpleDeclarationSchema = z.object({
    "children": z.array(GetSignatureSchema),
    "flags": GetSignatureFlagsSchema,
    "groups": z.array(GroupSchema),
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": z.string(),
    "name": z.string(),
});
export type PurpleDeclaration = z.infer<typeof PurpleDeclarationSchema>;

export const TypeElementSchema = z.object({
    "declaration": GetSignatureSchema.optional(),
    "elementType": ElementTypeSchema.optional(),
    "name": NameSchema.optional(),
    "type": TypeEnumSchema,
    "typeArguments": z.array(ElementTypeSchema).optional(),
});
export type TypeElement = z.infer<typeof TypeElementSchema>;

export const TagSchema = z.object({
    "tag": z.string(),
    "text": z.string(),
});
export type Tag = z.infer<typeof TagSchema>;

export const StickyFlagsSchema = z.object({
    "isAbstract": z.boolean().optional(),
    "isConstructorProperty": z.boolean().optional(),
    "isExported": z.boolean().optional(),
    "isPrivate": z.boolean().optional(),
    "isProtected": z.boolean().optional(),
    "isPublic": z.boolean().optional(),
    "isStatic": z.boolean().optional(),
});
export type StickyFlags = z.infer<typeof StickyFlagsSchema>;

export const IndigoFlagsSchema = z.object({
    "isPrivate": z.boolean().optional(),
    "isProtected": z.boolean().optional(),
});
export type IndigoFlags = z.infer<typeof IndigoFlagsSchema>;

export const StickyTypeSchema = z.object({
    "constraint": ExtendedBySchema.optional(),
    "declaration": GetSignatureSchema.optional(),
    "elementType": ElementTypeSchema.optional(),
    "elements": z.array(ExtendedBySchema).optional(),
    "id": z.number().int().optional(),
    "name": z.string().optional(),
    "type": TypeEnumSchema,
    "typeArguments": z.array(ElementTypeSchema).optional(),
});
export type StickyType = z.infer<typeof StickyTypeSchema>;

export const IndecentTypeSchema = z.object({
    "declaration": GetSignatureSchema.optional(),
    "elements": z.array(ElementTypeSchema).optional(),
    "name": NameSchema.optional(),
    "type": TypeEnumSchema,
});
export type IndecentType = z.infer<typeof IndecentTypeSchema>;

export const HilariousTypeSchema = z.object({
    "declaration": GetSignatureSchema,
    "type": TypeEnumSchema,
});
export type HilariousType = z.infer<typeof HilariousTypeSchema>;

export const IndigoCommentSchema = z.object({
    "returns": z.string(),
    "shortText": z.string(),
});
export type IndigoComment = z.infer<typeof IndigoCommentSchema>;

export const FluffyParameterSchema = z.object({
    "comment": FluffyCommentSchema.optional(),
    "flags": FluffyFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": z.string(),
    "name": z.string(),
    "sources": z.array(SourceSchema).optional(),
    "type": ElementTypeSchema,
});
export type FluffyParameter = z.infer<typeof FluffyParameterSchema>;

export const PurpleTypeArgumentSchema = z.object({
    "operator": z.string(),
    "target": ElementTypeSchema,
    "type": z.string(),
});
export type PurpleTypeArgument = z.infer<typeof PurpleTypeArgumentSchema>;

export const IndecentFlagsSchema = z.object({
    "hasExportAssignment": z.boolean().optional(),
    "isAbstract": z.boolean().optional(),
    "isConst": z.boolean().optional(),
    "isExported": z.boolean().optional(),
    "isLet": z.boolean().optional(),
    "isPrivate": z.boolean().optional(),
    "isProtected": z.boolean().optional(),
});
export type IndecentFlags = z.infer<typeof IndecentFlagsSchema>;

export const IndigoChildSchema = z.object({
    "comment": FluffyCommentSchema,
    "defaultValue": z.string().optional(),
    "flags": FluffyFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": PurpleKindStringSchema,
    "name": z.string(),
    "sources": z.array(SourceSchema),
    "type": IndecentTypeSchema,
});
export type IndigoChild = z.infer<typeof IndigoChildSchema>;

export const CunningTypeSchema = z.object({
    "declaration": PurpleDeclarationSchema.optional(),
    "id": z.number().int().optional(),
    "name": NameSchema.optional(),
    "type": TypeEnumSchema,
    "typeArguments": z.array(ElementTypeSchema).optional(),
});
export type CunningType = z.infer<typeof CunningTypeSchema>;

export const IndigoDeclarationSchema = z.object({
    "children": z.array(GetSignatureSchema).optional(),
    "flags": GetSignatureFlagsSchema,
    "groups": z.array(GroupSchema).optional(),
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": z.string(),
    "name": z.string(),
    "signatures": z.array(GetSignatureSchema).optional(),
    "sources": z.array(SourceSchema),
});
export type IndigoDeclaration = z.infer<typeof IndigoDeclarationSchema>;

export const FluffyTypeArgumentSchema = z.object({
    "type": TypeEnumSchema,
    "types": z.array(ElementTypeSchema),
});
export type FluffyTypeArgument = z.infer<typeof FluffyTypeArgumentSchema>;

export const MischievousTypeSchema = z.object({
    "id": z.number().int().optional(),
    "name": NameSchema.optional(),
    "operator": z.string().optional(),
    "target": ElementTypeSchema.optional(),
    "type": z.string(),
});
export type MischievousType = z.infer<typeof MischievousTypeSchema>;

export const IndecentCommentSchema = z.object({
    "shortText": z.string(),
    "tags": z.array(TagSchema).optional(),
});
export type IndecentComment = z.infer<typeof IndecentCommentSchema>;

export const GetSignatureParameterSchema = z.object({
    "comment": TentacledCommentSchema.optional(),
    "flags": TentacledFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": ParameterKindStringSchema,
    "name": z.string(),
    "type": FluffyTypeSchema,
});
export type GetSignatureParameter = z.infer<typeof GetSignatureParameterSchema>;

export const TentacledTypeSchema = z.object({
    "declaration": PurpleDeclarationSchema.optional(),
    "name": NameSchema.optional(),
    "type": TypeEnumSchema,
});
export type TentacledType = z.infer<typeof TentacledTypeSchema>;

export const StickyCommentSchema = z.object({
    "returns": z.string().optional(),
    "shortText": z.string().optional(),
    "tags": z.array(TagSchema).optional(),
    "text": z.string().optional(),
});
export type StickyComment = z.infer<typeof StickyCommentSchema>;

export const PurpleParameterSchema = z.object({
    "comment": TentacledCommentSchema.optional(),
    "flags": GetSignatureFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": ParameterKindStringSchema,
    "name": z.string(),
    "type": StickyTypeSchema,
});
export type PurpleParameter = z.infer<typeof PurpleParameterSchema>;

export const StickyChildSchema = z.object({
    "comment": FluffyCommentSchema.optional(),
    "flags": FluffyFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": PurpleKindStringSchema,
    "name": z.string(),
    "sources": z.array(SourceSchema),
    "type": IndecentTypeSchema,
});
export type StickyChild = z.infer<typeof StickyChildSchema>;

export const IndexSignatureSchema = z.object({
    "flags": GetSignatureFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": z.string(),
    "name": z.string(),
    "parameters": z.array(GetSignatureSchema),
    "type": HilariousTypeSchema,
});
export type IndexSignature = z.infer<typeof IndexSignatureSchema>;

export const TentacledSignatureSchema = z.object({
    "comment": IndigoCommentSchema.optional(),
    "flags": GetSignatureFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": SignatureKindStringSchema,
    "name": z.string(),
    "parameters": z.array(FluffyParameterSchema).optional(),
    "type": ExtendedBySchema,
});
export type TentacledSignature = z.infer<typeof TentacledSignatureSchema>;

export const TentacledDeclarationSchema = z.object({
    "children": z.array(IndigoChildSchema).optional(),
    "flags": GetSignatureFlagsSchema,
    "groups": z.array(GroupSchema).optional(),
    "id": z.number().int(),
    "indexSignature": IndexSignatureElementSchema.optional(),
    "kind": z.number().int(),
    "kindString": z.string(),
    "name": z.string(),
    "signatures": z.array(GetSignatureSchema).optional(),
    "sources": z.array(SourceSchema),
});
export type TentacledDeclaration = z.infer<typeof TentacledDeclarationSchema>;

export const FriskyTypeSchema = z.object({
    "declaration": IndigoDeclarationSchema.optional(),
    "name": NameSchema.optional(),
    "type": TypeEnumSchema,
});
export type FriskyType = z.infer<typeof FriskyTypeSchema>;

export const TypeParameterSchema = z.object({
    "comment": PurpleCommentSchema.optional(),
    "flags": GetSignatureFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": z.string(),
    "name": z.string(),
    "type": MischievousTypeSchema.optional(),
});
export type TypeParameter = z.infer<typeof TypeParameterSchema>;

export const PurpleSignatureSchema = z.object({
    "comment": PurpleCommentSchema.optional(),
    "flags": GetSignatureFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": SignatureKindStringSchema,
    "name": z.string(),
    "parameters": z.array(GetSignatureSchema),
    "type": TentacledTypeSchema,
});
export type PurpleSignature = z.infer<typeof PurpleSignatureSchema>;

export const FluffySignatureSchema = z.object({
    "comment": StickyCommentSchema.optional(),
    "flags": IndigoFlagsSchema,
    "id": z.number().int(),
    "implementationOf": ExtendedBySchema.optional(),
    "inheritedFrom": ExtendedBySchema.optional(),
    "kind": z.number().int(),
    "kindString": SignatureKindStringSchema,
    "name": z.string(),
    "overwrites": ExtendedBySchema.optional(),
    "parameters": z.array(PurpleParameterSchema).optional(),
    "type": ExtendedBySchema,
    "typeParameter": z.array(GetSignatureSchema).optional(),
});
export type FluffySignature = z.infer<typeof FluffySignatureSchema>;

export const FluffyDeclarationSchema = z.object({
    "children": z.array(StickyChildSchema).optional(),
    "flags": GetSignatureFlagsSchema,
    "groups": z.array(GroupSchema).optional(),
    "id": z.number().int(),
    "indexSignature": IndexSignatureSchema.optional(),
    "kind": z.number().int(),
    "kindString": z.string(),
    "name": z.string(),
    "signatures": z.array(TentacledSignatureSchema).optional(),
    "sources": z.array(SourceSchema),
});
export type FluffyDeclaration = z.infer<typeof FluffyDeclarationSchema>;

export const AmbitiousTypeSchema = z.object({
    "declaration": TentacledDeclarationSchema.optional(),
    "elementType": ElementTypeSchema.optional(),
    "id": z.number().int().optional(),
    "name": z.string().optional(),
    "type": TypeEnumSchema,
    "typeArguments": z.array(ElementTypeSchema).optional(),
});
export type AmbitiousType = z.infer<typeof AmbitiousTypeSchema>;

export const IndecentChildSchema = z.object({
    "flags": FluffyFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": PurpleKindStringSchema,
    "name": z.string(),
    "sources": z.array(SourceSchema),
    "type": FriskyTypeSchema,
});
export type IndecentChild = z.infer<typeof IndecentChildSchema>;

export const TentacledChildSchema = z.object({
    "comment": PurpleCommentSchema.optional(),
    "defaultValue": z.string().optional(),
    "flags": PurpleFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": PurpleKindStringSchema,
    "name": z.string(),
    "signatures": z.array(PurpleSignatureSchema).optional(),
    "sources": z.array(SourceSchema),
    "type": TypeElementSchema.optional(),
});
export type TentacledChild = z.infer<typeof TentacledChildSchema>;

export const IndigoTypeSchema = z.object({
    "constraint": ExtendedBySchema.optional(),
    "declaration": FluffyDeclarationSchema.optional(),
    "elementType": ExtendedBySchema.optional(),
    "elements": z.array(ElementTypeSchema).optional(),
    "id": z.number().int().optional(),
    "name": z.string().optional(),
    "type": TypeEnumSchema,
    "typeArguments": z.array(PurpleTypeArgumentSchema).optional(),
    "types": z.array(TypeElementSchema).optional(),
});
export type IndigoType = z.infer<typeof IndigoTypeSchema>;

export const TentacledParameterSchema = z.object({
    "comment": TentacledCommentSchema.optional(),
    "defaultValue": z.string().optional(),
    "flags": TentacledFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": ParameterKindStringSchema,
    "name": z.string(),
    "originalName": z.string().optional(),
    "type": AmbitiousTypeSchema,
});
export type TentacledParameter = z.infer<typeof TentacledParameterSchema>;

export const StickyDeclarationSchema = z.object({
    "children": z.array(IndecentChildSchema).optional(),
    "flags": GetSignatureFlagsSchema,
    "groups": z.array(GroupSchema).optional(),
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": z.string(),
    "name": z.string(),
    "signatures": z.array(GetSignatureSchema),
    "sources": z.array(SourceSchema),
});
export type StickyDeclaration = z.infer<typeof StickyDeclarationSchema>;

export const FluffyChildSchema = z.object({
    "children": z.array(TentacledChildSchema).optional(),
    "comment": StickyCommentSchema.optional(),
    "defaultValue": z.string().optional(),
    "flags": StickyFlagsSchema,
    "getSignature": GetSignatureSchema.optional(),
    "groups": z.array(GroupSchema).optional(),
    "id": z.number().int(),
    "implementationOf": ExtendedBySchema.optional(),
    "inheritedFrom": ExtendedBySchema.optional(),
    "kind": z.number().int(),
    "kindString": PurpleKindStringSchema,
    "name": z.string(),
    "overwrites": ExtendedBySchema.optional(),
    "setSignature": GetSignatureSchema.optional(),
    "signatures": z.array(FluffySignatureSchema).optional(),
    "sources": z.array(SourceSchema),
    "type": IndigoTypeSchema.optional(),
});
export type FluffyChild = z.infer<typeof FluffyChildSchema>;

export const StickySignatureSchema = z.object({
    "comment": StickyCommentSchema,
    "flags": IndigoFlagsSchema,
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": SignatureKindStringSchema,
    "name": z.string(),
    "parameters": z.array(TentacledParameterSchema).optional(),
    "type": CunningTypeSchema,
    "typeParameter": z.array(GetSignatureSchema).optional(),
});
export type StickySignature = z.infer<typeof StickySignatureSchema>;

export const MagentaTypeSchema = z.object({
    "declaration": StickyDeclarationSchema.optional(),
    "elementType": ElementTypeSchema.optional(),
    "elements": z.array(ExtendedBySchema).optional(),
    "id": z.number().int().optional(),
    "name": z.string().optional(),
    "type": TypeEnumSchema,
    "typeArguments": z.array(FluffyTypeArgumentSchema).optional(),
    "types": z.array(ExtendedBySchema).optional(),
    "value": z.string().optional(),
});
export type MagentaType = z.infer<typeof MagentaTypeSchema>;

export const PurpleChildSchema = z.object({
    "children": z.array(FluffyChildSchema).optional(),
    "comment": StickyCommentSchema.optional(),
    "defaultValue": z.string().optional(),
    "extendedBy": z.array(ExtendedBySchema).optional(),
    "extendedTypes": z.array(ExtendedBySchema).optional(),
    "flags": IndecentFlagsSchema,
    "groups": z.array(GroupSchema).optional(),
    "id": z.number().int(),
    "implementedBy": z.array(ExtendedBySchema).optional(),
    "implementedTypes": z.array(ExtendedBySchema).optional(),
    "kind": z.number().int(),
    "kindString": FluffyKindStringSchema,
    "name": z.string(),
    "signatures": z.array(StickySignatureSchema).optional(),
    "sources": z.array(SourceSchema),
    "type": MagentaTypeSchema.optional(),
    "typeParameter": z.array(TypeParameterSchema).optional(),
});
export type PurpleChild = z.infer<typeof PurpleChildSchema>;

export const TopLevelChildSchema = z.object({
    "children": z.array(PurpleChildSchema),
    "comment": IndecentCommentSchema.optional(),
    "flags": PurpleFlagsSchema,
    "groups": z.array(GroupSchema),
    "id": z.number().int(),
    "kind": z.number().int(),
    "kindString": TentacledKindStringSchema,
    "name": z.string(),
    "originalName": z.string(),
    "sources": z.array(SourceSchema),
});
export type TopLevelChild = z.infer<typeof TopLevelChildSchema>;

export const TopLevelSchema = z.object({
    "children": z.array(TopLevelChildSchema),
    "flags": GetSignatureFlagsSchema,
    "groups": z.array(GroupSchema),
    "id": z.number().int(),
    "kind": z.number().int(),
    "name": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
