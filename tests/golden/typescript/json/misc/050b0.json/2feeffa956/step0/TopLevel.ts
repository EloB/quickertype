// To parse this data:
//
//   import { Convert } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export type TopLevel = TopLevelElement[];

export interface TopLevelElement {
    id:            string;
    identifiers:   Identifier[];
    keywords:      Keyword[];
    links:         Link[];
    name:          string;
    other_names:   OtherName[];
    superseded_by: null | string;
    text:          Text[];
}

export interface Identifier {
    identifier: string;
    scheme:     Scheme;
}

export type Scheme = "DEP5" | "SPDX" | "Trove";

export type Keyword = "osi-approved" | "popular" | "permissive" | "copyleft";

export interface Link {
    note: Note;
    url:  string;
}

export type Note = "tl;dr legal" | "Wikipedia page" | "OSI Page" | "Wikipedia Page" | "Mozilla Page";

export interface OtherName {
    name: string;
    note: null | string;
}

export interface Text {
    media_type: MediaType;
    title:      Title;
    url:        string;
}

export type MediaType = "text/html" | "text/plain";

export type Title = "HTML" | "Plain Text";

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export class Convert {
    public static toTopLevel(json: string): TopLevelElement[] {
        return cast(JSON.parse(json), a(r("TopLevelElement")));
    }

    public static topLevelToJson(value: TopLevelElement[]): string {
        return JSON.stringify(uncast(value, a(r("TopLevelElement"))), null, 2);
    }
}

function invalidValue(typ: any, val: any, key: any, parent: any = ''): never {
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
    "TopLevelElement": o([
        { json: "id", js: "id", typ: "" },
        { json: "identifiers", js: "identifiers", typ: a(r("Identifier")) },
        { json: "keywords", js: "keywords", typ: a(r("Keyword")) },
        { json: "links", js: "links", typ: a(r("Link")) },
        { json: "name", js: "name", typ: "" },
        { json: "other_names", js: "other_names", typ: a(r("OtherName")) },
        { json: "superseded_by", js: "superseded_by", typ: u(null, "") },
        { json: "text", js: "text", typ: a(r("Text")) },
    ], false),
    "Identifier": o([
        { json: "identifier", js: "identifier", typ: "" },
        { json: "scheme", js: "scheme", typ: r("Scheme") },
    ], false),
    "Link": o([
        { json: "note", js: "note", typ: r("Note") },
        { json: "url", js: "url", typ: "" },
    ], false),
    "OtherName": o([
        { json: "name", js: "name", typ: "" },
        { json: "note", js: "note", typ: u(null, "") },
    ], false),
    "Text": o([
        { json: "media_type", js: "media_type", typ: r("MediaType") },
        { json: "title", js: "title", typ: r("Title") },
        { json: "url", js: "url", typ: "" },
    ], false),
    "Scheme": [
        "DEP5",
        "SPDX",
        "Trove",
    ],
    "Keyword": [
        "osi-approved",
        "popular",
        "permissive",
        "copyleft",
    ],
    "Note": [
        "tl;dr legal",
        "Wikipedia page",
        "OSI Page",
        "Wikipedia Page",
        "Mozilla Page",
    ],
    "MediaType": [
        "text/html",
        "text/plain",
    ],
    "Title": [
        "HTML",
        "Plain Text",
    ],
};
