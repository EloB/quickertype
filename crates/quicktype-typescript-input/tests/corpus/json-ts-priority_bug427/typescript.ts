export interface TopLevel {
    children: TopLevelChild[];
    flags:    object;
    groups:   Group[];
    id:       number;
    kind:     number;
    name:     string;
}

export interface TopLevelChild {
    children:     PurpleChild[];
    comment?:     IndecentComment;
    flags:        PurpleFlags;
    groups:       Group[];
    id:           number;
    kind:         number;
    kindString:   TentacledKindString;
    name:         string;
    originalName: string;
    sources:      Source[];
}

export interface PurpleChild {
    children?:         FluffyChild[];
    comment?:          StickyComment;
    defaultValue?:     string;
    extendedBy?:       ExtendedBy[];
    extendedTypes?:    ExtendedBy[];
    flags:             IndecentFlags;
    groups?:           Group[];
    id:                number;
    implementedBy?:    ExtendedBy[];
    implementedTypes?: ExtendedBy[];
    kind:              number;
    kindString:        FluffyKindString;
    name:              string;
    signatures?:       StickySignature[];
    sources:           Source[];
    type?:             MagentaType;
    typeParameter?:    TypeParameter[];
}

export interface FluffyChild {
    children?:         TentacledChild[];
    comment?:          StickyComment;
    defaultValue?:     string;
    flags:             StickyFlags;
    getSignature?:     GetSignature;
    groups?:           Group[];
    id:                number;
    implementationOf?: ExtendedBy;
    inheritedFrom?:    ExtendedBy;
    kind:              number;
    kindString:        PurpleKindString;
    name:              string;
    overwrites?:       ExtendedBy;
    setSignature?:     GetSignature;
    signatures?:       FluffySignature[];
    sources:           Source[];
    type?:             IndigoType;
}

export interface TentacledChild {
    comment?:      PurpleComment;
    defaultValue?: string;
    flags:         PurpleFlags;
    id:            number;
    kind:          number;
    kindString:    PurpleKindString;
    name:          string;
    signatures?:   PurpleSignature[];
    sources:       Source[];
    type?:         TypeElement;
}

export interface PurpleComment {
    shortText: string;
}

export interface PurpleFlags {
    isExported?: boolean;
}

export type PurpleKindString = "Variable" | "Function" | "Property" | "Method" | "Constructor" | "Accessor" | "Enumeration member" | "Module" | "Object literal";

export interface PurpleSignature {
    comment?:   PurpleComment;
    flags:      object;
    id:         number;
    kind:       number;
    kindString: SignatureKindString;
    name:       string;
    parameters: GetSignature[];
    type:       TentacledType;
}

export type SignatureKindString = "Call signature" | "Constructor signature";

export interface GetSignatureType {
    declaration?: GetSignature;
    elementType?: ElementType;
    name?:        Name;
    type:         TypeEnum;
}

export interface IndexSignatureElement {
    flags:       object;
    id:          number;
    kind:        number;
    kindString:  string;
    name:        string;
    parameters?: GetSignature[];
    type:        PurpleType;
}

export interface PurpleType {
    declaration?: GetSignature;
    name?:        Name;
    type:         TypeEnum;
}

export interface GetSignatureChild {
    comment?:   FluffyComment;
    flags:      FluffyFlags;
    id:         number;
    kind:       number;
    kindString: PurpleKindString;
    name:       string;
    sources:    Source[];
    type:       PurpleType;
}

export interface GetSignature {
    children?:      GetSignatureChild[];
    comment?:       GetSignatureComment;
    defaultValue?:  string;
    flags:          object;
    groups?:        Group[];
    id:             number;
    kind:           number;
    kindString:     string;
    name:           string;
    parameters?:    GetSignatureParameter[];
    signatures?:    IndexSignatureElement[];
    sources?:       Source[];
    type?:          GetSignatureType;
    typeParameter?: GetSignature[];
}

export interface ElementType {
    name: Name;
    type: TypeEnum;
}

export type Name = "string" | "number" | "void" | "T" | "boolean" | "BaseClass" | "any" | "Array" | "MyNumber";

export type TypeEnum = "intrinsic" | "reflection" | "array" | "reference" | "typeParameter" | "tuple" | "union" | "stringLiteral";

export interface FluffyComment {
    text: string;
}

export interface FluffyFlags {
    isOptional?: boolean;
}

export interface Source {
    character: number;
    fileName:  FileName;
    line:      number;
}

export type FileName = "modules.ts" | "classes.ts" | "flattened.ts" | "access.ts" | "default-export.ts" | "enumerations.ts" | "functions.ts" | "generics.ts" | "single-export.ts" | "typescript-1.3.ts" | "typescript-1.4.ts" | "typescript-1.5.ts" | "variables.ts";

export interface GetSignatureComment {
    returns?:   string;
    shortText?: string;
    text?:      string;
}

export interface Group {
    children: number[];
    kind:     number;
    title:    string;
}

export interface GetSignatureParameter {
    comment?:   TentacledComment;
    flags:      TentacledFlags;
    id:         number;
    kind:       number;
    kindString: ParameterKindString;
    name:       string;
    type:       FluffyType;
}

export interface TentacledComment {
    shortText?: string;
    text?:      string;
}

export interface TentacledFlags {
    isOptional?: boolean;
    isRest?:     boolean;
}

export type ParameterKindString = "Parameter";

export interface FluffyType {
    elementType?:   ElementType;
    name?:          Name;
    type:           TypeEnum;
    typeArguments?: ElementType[];
}

export interface TentacledType {
    declaration?: PurpleDeclaration;
    name?:        Name;
    type:         TypeEnum;
}

export interface PurpleDeclaration {
    children:   GetSignature[];
    flags:      object;
    groups:     Group[];
    id:         number;
    kind:       number;
    kindString: string;
    name:       string;
}

export interface TypeElement {
    declaration?:   GetSignature;
    elementType?:   ElementType;
    name?:          Name;
    type:           TypeEnum;
    typeArguments?: ElementType[];
}

export interface StickyComment {
    returns?:   string;
    shortText?: string;
    tags?:      Tag[];
    text?:      string;
}

export interface Tag {
    tag:  string;
    text: string;
}

export interface StickyFlags {
    isAbstract?:            boolean;
    isConstructorProperty?: boolean;
    isExported?:            boolean;
    isPrivate?:             boolean;
    isProtected?:           boolean;
    isPublic?:              boolean;
    isStatic?:              boolean;
}

export interface ExtendedBy {
    constraint?:    ExtendedBy;
    id?:            number;
    name:           string;
    type:           TypeEnum;
    typeArguments?: ExtendedBy[];
}

export interface FluffySignature {
    comment?:          StickyComment;
    flags:             IndigoFlags;
    id:                number;
    implementationOf?: ExtendedBy;
    inheritedFrom?:    ExtendedBy;
    kind:              number;
    kindString:        SignatureKindString;
    name:              string;
    overwrites?:       ExtendedBy;
    parameters?:       PurpleParameter[];
    type:              ExtendedBy;
    typeParameter?:    GetSignature[];
}

export interface IndigoFlags {
    isPrivate?:   boolean;
    isProtected?: boolean;
}

export interface PurpleParameter {
    comment?:   TentacledComment;
    flags:      object;
    id:         number;
    kind:       number;
    kindString: ParameterKindString;
    name:       string;
    type:       StickyType;
}

export interface StickyType {
    constraint?:    ExtendedBy;
    declaration?:   GetSignature;
    elementType?:   ElementType;
    elements?:      ExtendedBy[];
    id?:            number;
    name?:          string;
    type:           TypeEnum;
    typeArguments?: ElementType[];
}

export interface IndigoType {
    constraint?:    ExtendedBy;
    declaration?:   FluffyDeclaration;
    elementType?:   ExtendedBy;
    elements?:      ElementType[];
    id?:            number;
    name?:          string;
    type:           TypeEnum;
    typeArguments?: PurpleTypeArgument[];
    types?:         TypeElement[];
}

export interface FluffyDeclaration {
    children?:       StickyChild[];
    flags:           object;
    groups?:         Group[];
    id:              number;
    indexSignature?: IndexSignature;
    kind:            number;
    kindString:      string;
    name:            string;
    signatures?:     TentacledSignature[];
    sources:         Source[];
}

export interface StickyChild {
    comment?:   FluffyComment;
    flags:      FluffyFlags;
    id:         number;
    kind:       number;
    kindString: PurpleKindString;
    name:       string;
    sources:    Source[];
    type:       IndecentType;
}

export interface IndecentType {
    declaration?: GetSignature;
    elements?:    ElementType[];
    name?:        Name;
    type:         TypeEnum;
}

export interface IndexSignature {
    flags:      object;
    id:         number;
    kind:       number;
    kindString: string;
    name:       string;
    parameters: GetSignature[];
    type:       HilariousType;
}

export interface HilariousType {
    declaration: GetSignature;
    type:        TypeEnum;
}

export interface TentacledSignature {
    comment?:    IndigoComment;
    flags:       object;
    id:          number;
    kind:        number;
    kindString:  SignatureKindString;
    name:        string;
    parameters?: FluffyParameter[];
    type:        ExtendedBy;
}

export interface IndigoComment {
    returns:   string;
    shortText: string;
}

export interface FluffyParameter {
    comment?:   FluffyComment;
    flags:      FluffyFlags;
    id:         number;
    kind:       number;
    kindString: string;
    name:       string;
    sources?:   Source[];
    type:       ElementType;
}

export interface PurpleTypeArgument {
    operator: string;
    target:   ElementType;
    type:     string;
}

export interface IndecentFlags {
    hasExportAssignment?: boolean;
    isAbstract?:          boolean;
    isConst?:             boolean;
    isExported?:          boolean;
    isLet?:               boolean;
    isPrivate?:           boolean;
    isProtected?:         boolean;
}

export type FluffyKindString = "Module" | "Class" | "Variable" | "Function" | "Interface" | "Enumeration" | "Object literal" | "Type alias";

export interface StickySignature {
    comment:        StickyComment;
    flags:          IndigoFlags;
    id:             number;
    kind:           number;
    kindString:     SignatureKindString;
    name:           string;
    parameters?:    TentacledParameter[];
    type:           CunningType;
    typeParameter?: GetSignature[];
}

export interface TentacledParameter {
    comment?:      TentacledComment;
    defaultValue?: string;
    flags:         TentacledFlags;
    id:            number;
    kind:          number;
    kindString:    ParameterKindString;
    name:          string;
    originalName?: string;
    type:          AmbitiousType;
}

export interface AmbitiousType {
    declaration?:   TentacledDeclaration;
    elementType?:   ElementType;
    id?:            number;
    name?:          string;
    type:           TypeEnum;
    typeArguments?: ElementType[];
}

export interface TentacledDeclaration {
    children?:       IndigoChild[];
    flags:           object;
    groups?:         Group[];
    id:              number;
    indexSignature?: IndexSignatureElement;
    kind:            number;
    kindString:      string;
    name:            string;
    signatures?:     GetSignature[];
    sources:         Source[];
}

export interface IndigoChild {
    comment:       FluffyComment;
    defaultValue?: string;
    flags:         FluffyFlags;
    id:            number;
    kind:          number;
    kindString:    PurpleKindString;
    name:          string;
    sources:       Source[];
    type:          IndecentType;
}

export interface CunningType {
    declaration?:   PurpleDeclaration;
    id?:            number;
    name?:          Name;
    type:           TypeEnum;
    typeArguments?: ElementType[];
}

export interface MagentaType {
    declaration?:   StickyDeclaration;
    elementType?:   ElementType;
    elements?:      ExtendedBy[];
    id?:            number;
    name?:          string;
    type:           TypeEnum;
    typeArguments?: FluffyTypeArgument[];
    types?:         ExtendedBy[];
    value?:         string;
}

export interface StickyDeclaration {
    children?:  IndecentChild[];
    flags:      object;
    groups?:    Group[];
    id:         number;
    kind:       number;
    kindString: string;
    name:       string;
    signatures: GetSignature[];
    sources:    Source[];
}

export interface IndecentChild {
    flags:      FluffyFlags;
    id:         number;
    kind:       number;
    kindString: PurpleKindString;
    name:       string;
    sources:    Source[];
    type:       FriskyType;
}

export interface FriskyType {
    declaration?: IndigoDeclaration;
    name?:        Name;
    type:         TypeEnum;
}

export interface IndigoDeclaration {
    children?:   GetSignature[];
    flags:       object;
    groups?:     Group[];
    id:          number;
    kind:        number;
    kindString:  string;
    name:        string;
    signatures?: GetSignature[];
    sources:     Source[];
}

export interface FluffyTypeArgument {
    type:  TypeEnum;
    types: ElementType[];
}

export interface TypeParameter {
    comment?:   PurpleComment;
    flags:      object;
    id:         number;
    kind:       number;
    kindString: string;
    name:       string;
    type?:      MischievousType;
}

export interface MischievousType {
    id?:       number;
    name?:     Name;
    operator?: string;
    target?:   ElementType;
    type:      string;
}

export interface IndecentComment {
    shortText: string;
    tags?:     Tag[];
}

export type TentacledKindString = "External module";
