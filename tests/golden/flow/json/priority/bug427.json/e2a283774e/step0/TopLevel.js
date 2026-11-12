// @flow

// To parse this data:
//
//   const Convert = require("./TopLevel");
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export type TopLevel = {
    children: TopLevelChild[];
    flags:    GetSignatureFlags;
    groups:   Group[];
    id:       number;
    kind:     number;
    name:     string;
};

export type TopLevelChild = {
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
};

export type PurpleChild = {
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
};

export type FluffyChild = {
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
};

export type TentacledChild = {
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
};

export type PurpleComment = {
    shortText: string;
};

export type PurpleFlags = {
    isExported?: boolean;
};

export type PurpleKindString =
      "Variable"
    | "Function"
    | "Property"
    | "Method"
    | "Constructor"
    | "Accessor"
    | "Enumeration member"
    | "Module"
    | "Object literal";

export type PurpleSignature = {
    comment?:   PurpleComment;
    flags:      GetSignatureFlags;
    id:         number;
    kind:       number;
    kindString: SignatureKindString;
    name:       string;
    parameters: GetSignature[];
    type:       TentacledType;
};

export type GetSignatureFlags = {
};

export type SignatureKindString =
      "Call signature"
    | "Constructor signature";

export type GetSignatureType = {
    declaration?: GetSignature;
    elementType?: ElementType;
    name?:        Name;
    type:         TypeEnum;
};

export type IndexSignatureElement = {
    flags:       GetSignatureFlags;
    id:          number;
    kind:        number;
    kindString:  string;
    name:        string;
    parameters?: GetSignature[];
    type:        PurpleType;
};

export type PurpleType = {
    declaration?: GetSignature;
    name?:        Name;
    type:         TypeEnum;
};

export type GetSignatureChild = {
    comment?:   FluffyComment;
    flags:      FluffyFlags;
    id:         number;
    kind:       number;
    kindString: PurpleKindString;
    name:       string;
    sources:    Source[];
    type:       PurpleType;
};

export type GetSignature = {
    children?:      GetSignatureChild[];
    comment?:       GetSignatureComment;
    defaultValue?:  string;
    flags:          GetSignatureFlags;
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
};

export type ElementType = {
    name: Name;
    type: TypeEnum;
};

export type Name =
      "string"
    | "number"
    | "void"
    | "T"
    | "boolean"
    | "BaseClass"
    | "any"
    | "Array"
    | "MyNumber";

export type TypeEnum =
      "intrinsic"
    | "reflection"
    | "array"
    | "reference"
    | "typeParameter"
    | "tuple"
    | "union"
    | "stringLiteral";

export type FluffyComment = {
    text: string;
};

export type FluffyFlags = {
    isOptional?: boolean;
};

export type Source = {
    character: number;
    fileName:  FileName;
    line:      number;
};

export type FileName =
      "modules.ts"
    | "classes.ts"
    | "flattened.ts"
    | "access.ts"
    | "default-export.ts"
    | "enumerations.ts"
    | "functions.ts"
    | "generics.ts"
    | "single-export.ts"
    | "typescript-1.3.ts"
    | "typescript-1.4.ts"
    | "typescript-1.5.ts"
    | "variables.ts";

export type GetSignatureComment = {
    returns?:   string;
    shortText?: string;
    text?:      string;
};

export type Group = {
    children: number[];
    kind:     number;
    title:    string;
};

export type GetSignatureParameter = {
    comment?:   TentacledComment;
    flags:      TentacledFlags;
    id:         number;
    kind:       number;
    kindString: ParameterKindString;
    name:       string;
    type:       FluffyType;
};

export type TentacledComment = {
    shortText?: string;
    text?:      string;
};

export type TentacledFlags = {
    isOptional?: boolean;
    isRest?:     boolean;
};

export type ParameterKindString =
      "Parameter";

export type FluffyType = {
    elementType?:   ElementType;
    name?:          Name;
    type:           TypeEnum;
    typeArguments?: ElementType[];
};

export type TentacledType = {
    declaration?: PurpleDeclaration;
    name?:        Name;
    type:         TypeEnum;
};

export type PurpleDeclaration = {
    children:   GetSignature[];
    flags:      GetSignatureFlags;
    groups:     Group[];
    id:         number;
    kind:       number;
    kindString: string;
    name:       string;
};

export type TypeElement = {
    declaration?:   GetSignature;
    elementType?:   ElementType;
    name?:          Name;
    type:           TypeEnum;
    typeArguments?: ElementType[];
};

export type StickyComment = {
    returns?:   string;
    shortText?: string;
    tags?:      Tag[];
    text?:      string;
};

export type Tag = {
    tag:  string;
    text: string;
};

export type StickyFlags = {
    isAbstract?:            boolean;
    isConstructorProperty?: boolean;
    isExported?:            boolean;
    isPrivate?:             boolean;
    isProtected?:           boolean;
    isPublic?:              boolean;
    isStatic?:              boolean;
};

export type ExtendedBy = {
    constraint?:    ExtendedBy;
    id?:            number;
    name:           string;
    type:           TypeEnum;
    typeArguments?: ExtendedBy[];
};

export type FluffySignature = {
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
};

export type IndigoFlags = {
    isPrivate?:   boolean;
    isProtected?: boolean;
};

export type PurpleParameter = {
    comment?:   TentacledComment;
    flags:      GetSignatureFlags;
    id:         number;
    kind:       number;
    kindString: ParameterKindString;
    name:       string;
    type:       StickyType;
};

export type StickyType = {
    constraint?:    ExtendedBy;
    declaration?:   GetSignature;
    elementType?:   ElementType;
    elements?:      ExtendedBy[];
    id?:            number;
    name?:          string;
    type:           TypeEnum;
    typeArguments?: ElementType[];
};

export type IndigoType = {
    constraint?:    ExtendedBy;
    declaration?:   FluffyDeclaration;
    elementType?:   ExtendedBy;
    elements?:      ElementType[];
    id?:            number;
    name?:          string;
    type:           TypeEnum;
    typeArguments?: PurpleTypeArgument[];
    types?:         TypeElement[];
};

export type FluffyDeclaration = {
    children?:       StickyChild[];
    flags:           GetSignatureFlags;
    groups?:         Group[];
    id:              number;
    indexSignature?: IndexSignature;
    kind:            number;
    kindString:      string;
    name:            string;
    signatures?:     TentacledSignature[];
    sources:         Source[];
};

export type StickyChild = {
    comment?:   FluffyComment;
    flags:      FluffyFlags;
    id:         number;
    kind:       number;
    kindString: PurpleKindString;
    name:       string;
    sources:    Source[];
    type:       IndecentType;
};

export type IndecentType = {
    declaration?: GetSignature;
    elements?:    ElementType[];
    name?:        Name;
    type:         TypeEnum;
};

export type IndexSignature = {
    flags:      GetSignatureFlags;
    id:         number;
    kind:       number;
    kindString: string;
    name:       string;
    parameters: GetSignature[];
    type:       HilariousType;
};

export type HilariousType = {
    declaration: GetSignature;
    type:        TypeEnum;
};

export type TentacledSignature = {
    comment?:    IndigoComment;
    flags:       GetSignatureFlags;
    id:          number;
    kind:        number;
    kindString:  SignatureKindString;
    name:        string;
    parameters?: FluffyParameter[];
    type:        ExtendedBy;
};

export type IndigoComment = {
    returns:   string;
    shortText: string;
};

export type FluffyParameter = {
    comment?:   FluffyComment;
    flags:      FluffyFlags;
    id:         number;
    kind:       number;
    kindString: string;
    name:       string;
    sources?:   Source[];
    type:       ElementType;
};

export type PurpleTypeArgument = {
    operator: string;
    target:   ElementType;
    type:     string;
};

export type IndecentFlags = {
    hasExportAssignment?: boolean;
    isAbstract?:          boolean;
    isConst?:             boolean;
    isExported?:          boolean;
    isLet?:               boolean;
    isPrivate?:           boolean;
    isProtected?:         boolean;
};

export type FluffyKindString =
      "Module"
    | "Class"
    | "Variable"
    | "Function"
    | "Interface"
    | "Enumeration"
    | "Object literal"
    | "Type alias";

export type StickySignature = {
    comment:        StickyComment;
    flags:          IndigoFlags;
    id:             number;
    kind:           number;
    kindString:     SignatureKindString;
    name:           string;
    parameters?:    TentacledParameter[];
    type:           CunningType;
    typeParameter?: GetSignature[];
};

export type TentacledParameter = {
    comment?:      TentacledComment;
    defaultValue?: string;
    flags:         TentacledFlags;
    id:            number;
    kind:          number;
    kindString:    ParameterKindString;
    name:          string;
    originalName?: string;
    type:          AmbitiousType;
};

export type AmbitiousType = {
    declaration?:   TentacledDeclaration;
    elementType?:   ElementType;
    id?:            number;
    name?:          string;
    type:           TypeEnum;
    typeArguments?: ElementType[];
};

export type TentacledDeclaration = {
    children?:       IndigoChild[];
    flags:           GetSignatureFlags;
    groups?:         Group[];
    id:              number;
    indexSignature?: IndexSignatureElement;
    kind:            number;
    kindString:      string;
    name:            string;
    signatures?:     GetSignature[];
    sources:         Source[];
};

export type IndigoChild = {
    comment:       FluffyComment;
    defaultValue?: string;
    flags:         FluffyFlags;
    id:            number;
    kind:          number;
    kindString:    PurpleKindString;
    name:          string;
    sources:       Source[];
    type:          IndecentType;
};

export type CunningType = {
    declaration?:   PurpleDeclaration;
    id?:            number;
    name?:          Name;
    type:           TypeEnum;
    typeArguments?: ElementType[];
};

export type MagentaType = {
    declaration?:   StickyDeclaration;
    elementType?:   ElementType;
    elements?:      ExtendedBy[];
    id?:            number;
    name?:          string;
    type:           TypeEnum;
    typeArguments?: FluffyTypeArgument[];
    types?:         ExtendedBy[];
    value?:         string;
};

export type StickyDeclaration = {
    children?:  IndecentChild[];
    flags:      GetSignatureFlags;
    groups?:    Group[];
    id:         number;
    kind:       number;
    kindString: string;
    name:       string;
    signatures: GetSignature[];
    sources:    Source[];
};

export type IndecentChild = {
    flags:      FluffyFlags;
    id:         number;
    kind:       number;
    kindString: PurpleKindString;
    name:       string;
    sources:    Source[];
    type:       FriskyType;
};

export type FriskyType = {
    declaration?: IndigoDeclaration;
    name?:        Name;
    type:         TypeEnum;
};

export type IndigoDeclaration = {
    children?:   GetSignature[];
    flags:       GetSignatureFlags;
    groups?:     Group[];
    id:          number;
    kind:        number;
    kindString:  string;
    name:        string;
    signatures?: GetSignature[];
    sources:     Source[];
};

export type FluffyTypeArgument = {
    type:  TypeEnum;
    types: ElementType[];
};

export type TypeParameter = {
    comment?:   PurpleComment;
    flags:      GetSignatureFlags;
    id:         number;
    kind:       number;
    kindString: string;
    name:       string;
    type?:      MischievousType;
};

export type MischievousType = {
    id?:       number;
    name?:     Name;
    operator?: string;
    target?:   ElementType;
    type:      string;
};

export type IndecentComment = {
    shortText: string;
    tags?:     Tag[];
};

export type TentacledKindString =
      "External module";

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
function toTopLevel(json: string): TopLevel {
    return cast(JSON.parse(json), r("TopLevel"));
}

function topLevelToJson(value: TopLevel): string {
    return JSON.stringify(uncast(value, r("TopLevel")), null, 2);
}

function invalidValue(typ: any, val: any, key: any, parent: any = '') {
    const prettyTyp = prettyTypeName(typ);
    const parentText = parent ? ` on ${parent}` : '';
    const keyText = key ? ` for key "${key}"` : '';
    throw Error(`Invalid value${keyText}${parentText}. Expected ${prettyTyp} but got ${JSON.stringify(val)}`);
}

function prettyTypeName(typ: any): string {
    if (Array.isArray(typ)) {
        if (typ.length === 2 && typ[0] === undefined) {
            return `an optional ${prettyTypeName(typ[1])}`;
        } else {
            return `one of [${typ.map(a => { return prettyTypeName(a); }).join(", ")}]`;
        }
    } else if (typeof typ === "object" && typ.literal !== undefined) {
        return typ.literal;
    } else {
        return typeof typ;
    }
}

function jsonToJSProps(typ: any): any {
    if (typ.jsonToJS === undefined) {
        const map: any = {};
        typ.props.forEach((p: any) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ: any): any {
    if (typ.jsToJSON === undefined) {
        const map: any = {};
        typ.props.forEach((p: any) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val: any, typ: any, getProps: any, key: any = '', parent: any = ''): any {
    function transformPrimitive(typ: string, val: any): any {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val, key, parent);
    }

    function transformUnion(typs: any[], val: any): any {
        // val must validate against one typ in typs
        const l = typs.length;
        for (let i = 0; i < l; i++) {
            const typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val, key, parent);
    }

    function transformEnum(cases: string[], val: any): any {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases.map(a => { return l(a); }), val, key, parent);
    }

    function transformArray(typ: any, val: any): any {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue(l("array"), val, key, parent);

        return val.map(el => transform(el, typ, getProps));
    }

    function transformDate(val: any): any {
        if (val === null) {
            return null;
        }
        const d = new Date(val);
        if (isNaN(d.valueOf())) {
            return invalidValue(l("Date"), val, key, parent);
        }
        return d;
    }

    function transformObject(props: { [k: string]: any }, additional: any, val: any): any {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue(l(ref || "object"), val, key, parent);
        }
        const result: any = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps, key, ref);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = transform(val[key], additional, getProps, key, ref);
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val, key, parent);
    }
    if (typ === false) return invalidValue(typ, val, key, parent);
    let ref: any = undefined;
    while (typeof typ === "object" && typ.ref !== undefined) {
        ref = typ.ref;
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return typ.hasOwnProperty("pattern")      ? typeof val === "string" && new RegExp(typ.pattern).test(val) ? val : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("string")       ? typeof val === "string" && (typ.min === undefined || Array.from(val).length >= typ.min) && (typ.max === undefined || Array.from(val).length <= typ.max) ? transform(val, typ.string, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("number")       ? typeof val === "number" && (typ.min === undefined || val >= typ.min) && (typ.max === undefined || val <= typ.max) ? transform(val, typ.number, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("integer")      ? typeof val === "number" && val % 1 === 0 ? val : invalidValue(l("integer"), val, key, parent)
            : typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ.arrayItems, val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val, key, parent);
    }
    // Numbers can be parsed by Date but shouldn't be.
    if (typ === Date && (typeof val === "string" || val instanceof Date)) return transformDate(val);
    return transformPrimitive(typ, val);
}

function cast<T>(val: any, typ: any): T {
    return transform(val, typ, jsonToJSProps);
}

function uncast<T>(val: T, typ: any): any {
    return transform(val, typ, jsToJSONProps);
}

function l(typ: any) {
    return { literal: typ };
}

function a(typ: any) {
    return { arrayItems: typ };
}

function i(typ: any) {
    return { integer: typ };
}

function p(pattern: any) {
    return { pattern };
}

function s(typ: any, min: any, max: any) {
    return { string: typ, min, max };
}

function n(typ: any, min: any, max: any) {
    return { number: typ, min, max };
}

function u(...typs: any[]) {
    return { unionMembers: typs };
}

function o(props: any[], additional: any) {
    return { props, additional };
}

function m(additional: any) {
    const props: any[] = [];
    return { props, additional };
}

function r(name: string) {
    return { ref: name };
}

const typeMap: any = {
    "TopLevel": o([
        { json: "children", js: "children", typ: a(r("TopLevelChild")) },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "groups", js: "groups", typ: a(r("Group")) },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "name", js: "name", typ: "" },
    ], false),
    "TopLevelChild": o([
        { json: "children", js: "children", typ: a(r("PurpleChild")) },
        { json: "comment", js: "comment", typ: u(undefined, r("IndecentComment")) },
        { json: "flags", js: "flags", typ: r("PurpleFlags") },
        { json: "groups", js: "groups", typ: a(r("Group")) },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("TentacledKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "originalName", js: "originalName", typ: "" },
        { json: "sources", js: "sources", typ: a(r("Source")) },
    ], false),
    "PurpleChild": o([
        { json: "children", js: "children", typ: u(undefined, a(r("FluffyChild"))) },
        { json: "comment", js: "comment", typ: u(undefined, r("StickyComment")) },
        { json: "defaultValue", js: "defaultValue", typ: u(undefined, "") },
        { json: "extendedBy", js: "extendedBy", typ: u(undefined, a(r("ExtendedBy"))) },
        { json: "extendedTypes", js: "extendedTypes", typ: u(undefined, a(r("ExtendedBy"))) },
        { json: "flags", js: "flags", typ: r("IndecentFlags") },
        { json: "groups", js: "groups", typ: u(undefined, a(r("Group"))) },
        { json: "id", js: "id", typ: i(0) },
        { json: "implementedBy", js: "implementedBy", typ: u(undefined, a(r("ExtendedBy"))) },
        { json: "implementedTypes", js: "implementedTypes", typ: u(undefined, a(r("ExtendedBy"))) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("FluffyKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "signatures", js: "signatures", typ: u(undefined, a(r("StickySignature"))) },
        { json: "sources", js: "sources", typ: a(r("Source")) },
        { json: "type", js: "type", typ: u(undefined, r("MagentaType")) },
        { json: "typeParameter", js: "typeParameter", typ: u(undefined, a(r("TypeParameter"))) },
    ], false),
    "FluffyChild": o([
        { json: "children", js: "children", typ: u(undefined, a(r("TentacledChild"))) },
        { json: "comment", js: "comment", typ: u(undefined, r("StickyComment")) },
        { json: "defaultValue", js: "defaultValue", typ: u(undefined, "") },
        { json: "flags", js: "flags", typ: r("StickyFlags") },
        { json: "getSignature", js: "getSignature", typ: u(undefined, r("GetSignature")) },
        { json: "groups", js: "groups", typ: u(undefined, a(r("Group"))) },
        { json: "id", js: "id", typ: i(0) },
        { json: "implementationOf", js: "implementationOf", typ: u(undefined, r("ExtendedBy")) },
        { json: "inheritedFrom", js: "inheritedFrom", typ: u(undefined, r("ExtendedBy")) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("PurpleKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "overwrites", js: "overwrites", typ: u(undefined, r("ExtendedBy")) },
        { json: "setSignature", js: "setSignature", typ: u(undefined, r("GetSignature")) },
        { json: "signatures", js: "signatures", typ: u(undefined, a(r("FluffySignature"))) },
        { json: "sources", js: "sources", typ: a(r("Source")) },
        { json: "type", js: "type", typ: u(undefined, r("IndigoType")) },
    ], false),
    "TentacledChild": o([
        { json: "comment", js: "comment", typ: u(undefined, r("PurpleComment")) },
        { json: "defaultValue", js: "defaultValue", typ: u(undefined, "") },
        { json: "flags", js: "flags", typ: r("PurpleFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("PurpleKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "signatures", js: "signatures", typ: u(undefined, a(r("PurpleSignature"))) },
        { json: "sources", js: "sources", typ: a(r("Source")) },
        { json: "type", js: "type", typ: u(undefined, r("TypeElement")) },
    ], false),
    "PurpleComment": o([
        { json: "shortText", js: "shortText", typ: "" },
    ], false),
    "PurpleFlags": o([
        { json: "isExported", js: "isExported", typ: u(undefined, true) },
    ], false),
    "PurpleSignature": o([
        { json: "comment", js: "comment", typ: u(undefined, r("PurpleComment")) },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("SignatureKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "parameters", js: "parameters", typ: a(r("GetSignature")) },
        { json: "type", js: "type", typ: r("TentacledType") },
    ], false),
    "GetSignatureFlags": o([
    ], false),
    "GetSignatureType": o([
        { json: "declaration", js: "declaration", typ: u(undefined, r("GetSignature")) },
        { json: "elementType", js: "elementType", typ: u(undefined, r("ElementType")) },
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "type", js: "type", typ: r("TypeEnum") },
    ], false),
    "IndexSignatureElement": o([
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "parameters", js: "parameters", typ: u(undefined, a(r("GetSignature"))) },
        { json: "type", js: "type", typ: r("PurpleType") },
    ], false),
    "PurpleType": o([
        { json: "declaration", js: "declaration", typ: u(undefined, r("GetSignature")) },
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "type", js: "type", typ: r("TypeEnum") },
    ], false),
    "GetSignatureChild": o([
        { json: "comment", js: "comment", typ: u(undefined, r("FluffyComment")) },
        { json: "flags", js: "flags", typ: r("FluffyFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("PurpleKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "sources", js: "sources", typ: a(r("Source")) },
        { json: "type", js: "type", typ: r("PurpleType") },
    ], false),
    "GetSignature": o([
        { json: "children", js: "children", typ: u(undefined, a(r("GetSignatureChild"))) },
        { json: "comment", js: "comment", typ: u(undefined, r("GetSignatureComment")) },
        { json: "defaultValue", js: "defaultValue", typ: u(undefined, "") },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "groups", js: "groups", typ: u(undefined, a(r("Group"))) },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "parameters", js: "parameters", typ: u(undefined, a(r("GetSignatureParameter"))) },
        { json: "signatures", js: "signatures", typ: u(undefined, a(r("IndexSignatureElement"))) },
        { json: "sources", js: "sources", typ: u(undefined, a(r("Source"))) },
        { json: "type", js: "type", typ: u(undefined, r("GetSignatureType")) },
        { json: "typeParameter", js: "typeParameter", typ: u(undefined, a(r("GetSignature"))) },
    ], false),
    "ElementType": o([
        { json: "name", js: "name", typ: r("Name") },
        { json: "type", js: "type", typ: r("TypeEnum") },
    ], false),
    "FluffyComment": o([
        { json: "text", js: "text", typ: "" },
    ], false),
    "FluffyFlags": o([
        { json: "isOptional", js: "isOptional", typ: u(undefined, true) },
    ], false),
    "Source": o([
        { json: "character", js: "character", typ: i(0) },
        { json: "fileName", js: "fileName", typ: r("FileName") },
        { json: "line", js: "line", typ: i(0) },
    ], false),
    "GetSignatureComment": o([
        { json: "returns", js: "returns", typ: u(undefined, "") },
        { json: "shortText", js: "shortText", typ: u(undefined, "") },
        { json: "text", js: "text", typ: u(undefined, "") },
    ], false),
    "Group": o([
        { json: "children", js: "children", typ: a(i(0)) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "title", js: "title", typ: "" },
    ], false),
    "GetSignatureParameter": o([
        { json: "comment", js: "comment", typ: u(undefined, r("TentacledComment")) },
        { json: "flags", js: "flags", typ: r("TentacledFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("ParameterKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "type", js: "type", typ: r("FluffyType") },
    ], false),
    "TentacledComment": o([
        { json: "shortText", js: "shortText", typ: u(undefined, "") },
        { json: "text", js: "text", typ: u(undefined, "") },
    ], false),
    "TentacledFlags": o([
        { json: "isOptional", js: "isOptional", typ: u(undefined, true) },
        { json: "isRest", js: "isRest", typ: u(undefined, true) },
    ], false),
    "FluffyType": o([
        { json: "elementType", js: "elementType", typ: u(undefined, r("ElementType")) },
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "type", js: "type", typ: r("TypeEnum") },
        { json: "typeArguments", js: "typeArguments", typ: u(undefined, a(r("ElementType"))) },
    ], false),
    "TentacledType": o([
        { json: "declaration", js: "declaration", typ: u(undefined, r("PurpleDeclaration")) },
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "type", js: "type", typ: r("TypeEnum") },
    ], false),
    "PurpleDeclaration": o([
        { json: "children", js: "children", typ: a(r("GetSignature")) },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "groups", js: "groups", typ: a(r("Group")) },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: "" },
        { json: "name", js: "name", typ: "" },
    ], false),
    "TypeElement": o([
        { json: "declaration", js: "declaration", typ: u(undefined, r("GetSignature")) },
        { json: "elementType", js: "elementType", typ: u(undefined, r("ElementType")) },
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "type", js: "type", typ: r("TypeEnum") },
        { json: "typeArguments", js: "typeArguments", typ: u(undefined, a(r("ElementType"))) },
    ], false),
    "StickyComment": o([
        { json: "returns", js: "returns", typ: u(undefined, "") },
        { json: "shortText", js: "shortText", typ: u(undefined, "") },
        { json: "tags", js: "tags", typ: u(undefined, a(r("Tag"))) },
        { json: "text", js: "text", typ: u(undefined, "") },
    ], false),
    "Tag": o([
        { json: "tag", js: "tag", typ: "" },
        { json: "text", js: "text", typ: "" },
    ], false),
    "StickyFlags": o([
        { json: "isAbstract", js: "isAbstract", typ: u(undefined, true) },
        { json: "isConstructorProperty", js: "isConstructorProperty", typ: u(undefined, true) },
        { json: "isExported", js: "isExported", typ: u(undefined, true) },
        { json: "isPrivate", js: "isPrivate", typ: u(undefined, true) },
        { json: "isProtected", js: "isProtected", typ: u(undefined, true) },
        { json: "isPublic", js: "isPublic", typ: u(undefined, true) },
        { json: "isStatic", js: "isStatic", typ: u(undefined, true) },
    ], false),
    "ExtendedBy": o([
        { json: "constraint", js: "constraint", typ: u(undefined, r("ExtendedBy")) },
        { json: "id", js: "id", typ: u(undefined, i(0)) },
        { json: "name", js: "name", typ: "" },
        { json: "type", js: "type", typ: r("TypeEnum") },
        { json: "typeArguments", js: "typeArguments", typ: u(undefined, a(r("ExtendedBy"))) },
    ], false),
    "FluffySignature": o([
        { json: "comment", js: "comment", typ: u(undefined, r("StickyComment")) },
        { json: "flags", js: "flags", typ: r("IndigoFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "implementationOf", js: "implementationOf", typ: u(undefined, r("ExtendedBy")) },
        { json: "inheritedFrom", js: "inheritedFrom", typ: u(undefined, r("ExtendedBy")) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("SignatureKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "overwrites", js: "overwrites", typ: u(undefined, r("ExtendedBy")) },
        { json: "parameters", js: "parameters", typ: u(undefined, a(r("PurpleParameter"))) },
        { json: "type", js: "type", typ: r("ExtendedBy") },
        { json: "typeParameter", js: "typeParameter", typ: u(undefined, a(r("GetSignature"))) },
    ], false),
    "IndigoFlags": o([
        { json: "isPrivate", js: "isPrivate", typ: u(undefined, true) },
        { json: "isProtected", js: "isProtected", typ: u(undefined, true) },
    ], false),
    "PurpleParameter": o([
        { json: "comment", js: "comment", typ: u(undefined, r("TentacledComment")) },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("ParameterKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "type", js: "type", typ: r("StickyType") },
    ], false),
    "StickyType": o([
        { json: "constraint", js: "constraint", typ: u(undefined, r("ExtendedBy")) },
        { json: "declaration", js: "declaration", typ: u(undefined, r("GetSignature")) },
        { json: "elementType", js: "elementType", typ: u(undefined, r("ElementType")) },
        { json: "elements", js: "elements", typ: u(undefined, a(r("ExtendedBy"))) },
        { json: "id", js: "id", typ: u(undefined, i(0)) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "type", js: "type", typ: r("TypeEnum") },
        { json: "typeArguments", js: "typeArguments", typ: u(undefined, a(r("ElementType"))) },
    ], false),
    "IndigoType": o([
        { json: "constraint", js: "constraint", typ: u(undefined, r("ExtendedBy")) },
        { json: "declaration", js: "declaration", typ: u(undefined, r("FluffyDeclaration")) },
        { json: "elementType", js: "elementType", typ: u(undefined, r("ExtendedBy")) },
        { json: "elements", js: "elements", typ: u(undefined, a(r("ElementType"))) },
        { json: "id", js: "id", typ: u(undefined, i(0)) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "type", js: "type", typ: r("TypeEnum") },
        { json: "typeArguments", js: "typeArguments", typ: u(undefined, a(r("PurpleTypeArgument"))) },
        { json: "types", js: "types", typ: u(undefined, a(r("TypeElement"))) },
    ], false),
    "FluffyDeclaration": o([
        { json: "children", js: "children", typ: u(undefined, a(r("StickyChild"))) },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "groups", js: "groups", typ: u(undefined, a(r("Group"))) },
        { json: "id", js: "id", typ: i(0) },
        { json: "indexSignature", js: "indexSignature", typ: u(undefined, r("IndexSignature")) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "signatures", js: "signatures", typ: u(undefined, a(r("TentacledSignature"))) },
        { json: "sources", js: "sources", typ: a(r("Source")) },
    ], false),
    "StickyChild": o([
        { json: "comment", js: "comment", typ: u(undefined, r("FluffyComment")) },
        { json: "flags", js: "flags", typ: r("FluffyFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("PurpleKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "sources", js: "sources", typ: a(r("Source")) },
        { json: "type", js: "type", typ: r("IndecentType") },
    ], false),
    "IndecentType": o([
        { json: "declaration", js: "declaration", typ: u(undefined, r("GetSignature")) },
        { json: "elements", js: "elements", typ: u(undefined, a(r("ElementType"))) },
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "type", js: "type", typ: r("TypeEnum") },
    ], false),
    "IndexSignature": o([
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "parameters", js: "parameters", typ: a(r("GetSignature")) },
        { json: "type", js: "type", typ: r("HilariousType") },
    ], false),
    "HilariousType": o([
        { json: "declaration", js: "declaration", typ: r("GetSignature") },
        { json: "type", js: "type", typ: r("TypeEnum") },
    ], false),
    "TentacledSignature": o([
        { json: "comment", js: "comment", typ: u(undefined, r("IndigoComment")) },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("SignatureKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "parameters", js: "parameters", typ: u(undefined, a(r("FluffyParameter"))) },
        { json: "type", js: "type", typ: r("ExtendedBy") },
    ], false),
    "IndigoComment": o([
        { json: "returns", js: "returns", typ: "" },
        { json: "shortText", js: "shortText", typ: "" },
    ], false),
    "FluffyParameter": o([
        { json: "comment", js: "comment", typ: u(undefined, r("FluffyComment")) },
        { json: "flags", js: "flags", typ: r("FluffyFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "sources", js: "sources", typ: u(undefined, a(r("Source"))) },
        { json: "type", js: "type", typ: r("ElementType") },
    ], false),
    "PurpleTypeArgument": o([
        { json: "operator", js: "operator", typ: "" },
        { json: "target", js: "target", typ: r("ElementType") },
        { json: "type", js: "type", typ: "" },
    ], false),
    "IndecentFlags": o([
        { json: "hasExportAssignment", js: "hasExportAssignment", typ: u(undefined, true) },
        { json: "isAbstract", js: "isAbstract", typ: u(undefined, true) },
        { json: "isConst", js: "isConst", typ: u(undefined, true) },
        { json: "isExported", js: "isExported", typ: u(undefined, true) },
        { json: "isLet", js: "isLet", typ: u(undefined, true) },
        { json: "isPrivate", js: "isPrivate", typ: u(undefined, true) },
        { json: "isProtected", js: "isProtected", typ: u(undefined, true) },
    ], false),
    "StickySignature": o([
        { json: "comment", js: "comment", typ: r("StickyComment") },
        { json: "flags", js: "flags", typ: r("IndigoFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("SignatureKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "parameters", js: "parameters", typ: u(undefined, a(r("TentacledParameter"))) },
        { json: "type", js: "type", typ: r("CunningType") },
        { json: "typeParameter", js: "typeParameter", typ: u(undefined, a(r("GetSignature"))) },
    ], false),
    "TentacledParameter": o([
        { json: "comment", js: "comment", typ: u(undefined, r("TentacledComment")) },
        { json: "defaultValue", js: "defaultValue", typ: u(undefined, "") },
        { json: "flags", js: "flags", typ: r("TentacledFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("ParameterKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "originalName", js: "originalName", typ: u(undefined, "") },
        { json: "type", js: "type", typ: r("AmbitiousType") },
    ], false),
    "AmbitiousType": o([
        { json: "declaration", js: "declaration", typ: u(undefined, r("TentacledDeclaration")) },
        { json: "elementType", js: "elementType", typ: u(undefined, r("ElementType")) },
        { json: "id", js: "id", typ: u(undefined, i(0)) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "type", js: "type", typ: r("TypeEnum") },
        { json: "typeArguments", js: "typeArguments", typ: u(undefined, a(r("ElementType"))) },
    ], false),
    "TentacledDeclaration": o([
        { json: "children", js: "children", typ: u(undefined, a(r("IndigoChild"))) },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "groups", js: "groups", typ: u(undefined, a(r("Group"))) },
        { json: "id", js: "id", typ: i(0) },
        { json: "indexSignature", js: "indexSignature", typ: u(undefined, r("IndexSignatureElement")) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "signatures", js: "signatures", typ: u(undefined, a(r("GetSignature"))) },
        { json: "sources", js: "sources", typ: a(r("Source")) },
    ], false),
    "IndigoChild": o([
        { json: "comment", js: "comment", typ: r("FluffyComment") },
        { json: "defaultValue", js: "defaultValue", typ: u(undefined, "") },
        { json: "flags", js: "flags", typ: r("FluffyFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("PurpleKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "sources", js: "sources", typ: a(r("Source")) },
        { json: "type", js: "type", typ: r("IndecentType") },
    ], false),
    "CunningType": o([
        { json: "declaration", js: "declaration", typ: u(undefined, r("PurpleDeclaration")) },
        { json: "id", js: "id", typ: u(undefined, i(0)) },
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "type", js: "type", typ: r("TypeEnum") },
        { json: "typeArguments", js: "typeArguments", typ: u(undefined, a(r("ElementType"))) },
    ], false),
    "MagentaType": o([
        { json: "declaration", js: "declaration", typ: u(undefined, r("StickyDeclaration")) },
        { json: "elementType", js: "elementType", typ: u(undefined, r("ElementType")) },
        { json: "elements", js: "elements", typ: u(undefined, a(r("ExtendedBy"))) },
        { json: "id", js: "id", typ: u(undefined, i(0)) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "type", js: "type", typ: r("TypeEnum") },
        { json: "typeArguments", js: "typeArguments", typ: u(undefined, a(r("FluffyTypeArgument"))) },
        { json: "types", js: "types", typ: u(undefined, a(r("ExtendedBy"))) },
        { json: "value", js: "value", typ: u(undefined, "") },
    ], false),
    "StickyDeclaration": o([
        { json: "children", js: "children", typ: u(undefined, a(r("IndecentChild"))) },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "groups", js: "groups", typ: u(undefined, a(r("Group"))) },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "signatures", js: "signatures", typ: a(r("GetSignature")) },
        { json: "sources", js: "sources", typ: a(r("Source")) },
    ], false),
    "IndecentChild": o([
        { json: "flags", js: "flags", typ: r("FluffyFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: r("PurpleKindString") },
        { json: "name", js: "name", typ: "" },
        { json: "sources", js: "sources", typ: a(r("Source")) },
        { json: "type", js: "type", typ: r("FriskyType") },
    ], false),
    "FriskyType": o([
        { json: "declaration", js: "declaration", typ: u(undefined, r("IndigoDeclaration")) },
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "type", js: "type", typ: r("TypeEnum") },
    ], false),
    "IndigoDeclaration": o([
        { json: "children", js: "children", typ: u(undefined, a(r("GetSignature"))) },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "groups", js: "groups", typ: u(undefined, a(r("Group"))) },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "signatures", js: "signatures", typ: u(undefined, a(r("GetSignature"))) },
        { json: "sources", js: "sources", typ: a(r("Source")) },
    ], false),
    "FluffyTypeArgument": o([
        { json: "type", js: "type", typ: r("TypeEnum") },
        { json: "types", js: "types", typ: a(r("ElementType")) },
    ], false),
    "TypeParameter": o([
        { json: "comment", js: "comment", typ: u(undefined, r("PurpleComment")) },
        { json: "flags", js: "flags", typ: r("GetSignatureFlags") },
        { json: "id", js: "id", typ: i(0) },
        { json: "kind", js: "kind", typ: i(0) },
        { json: "kindString", js: "kindString", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "type", js: "type", typ: u(undefined, r("MischievousType")) },
    ], false),
    "MischievousType": o([
        { json: "id", js: "id", typ: u(undefined, i(0)) },
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "operator", js: "operator", typ: u(undefined, "") },
        { json: "target", js: "target", typ: u(undefined, r("ElementType")) },
        { json: "type", js: "type", typ: "" },
    ], false),
    "IndecentComment": o([
        { json: "shortText", js: "shortText", typ: "" },
        { json: "tags", js: "tags", typ: u(undefined, a(r("Tag"))) },
    ], false),
    "PurpleKindString": [
        "Variable",
        "Function",
        "Property",
        "Method",
        "Constructor",
        "Accessor",
        "Enumeration member",
        "Module",
        "Object literal",
    ],
    "SignatureKindString": [
        "Call signature",
        "Constructor signature",
    ],
    "Name": [
        "string",
        "number",
        "void",
        "T",
        "boolean",
        "BaseClass",
        "any",
        "Array",
        "MyNumber",
    ],
    "TypeEnum": [
        "intrinsic",
        "reflection",
        "array",
        "reference",
        "typeParameter",
        "tuple",
        "union",
        "stringLiteral",
    ],
    "FileName": [
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
    ],
    "ParameterKindString": [
        "Parameter",
    ],
    "FluffyKindString": [
        "Module",
        "Class",
        "Variable",
        "Function",
        "Interface",
        "Enumeration",
        "Object literal",
        "Type alias",
    ],
    "TentacledKindString": [
        "External module",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
