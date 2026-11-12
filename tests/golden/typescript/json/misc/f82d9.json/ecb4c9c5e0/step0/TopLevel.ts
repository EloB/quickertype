// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface TopLevel {
    basePath:    string;
    definitions: Definitions;
    host:        string;
    info:        Info;
    paths:       Paths;
    produces:    string[];
    schemes:     string[];
    swagger:     string;
}

export interface Definitions {
    Report: Report;
}

export interface Report {
    properties: Properties;
}

export interface Properties {
    click_url:       ClickURL;
    country:         ClickURL;
    description:     ClickURL;
    expiration_date: ClickURL;
    id:              ClickURL;
    industry:        ClickURL;
    report_type:     ClickURL;
    source_industry: ClickURL;
    title:           ClickURL;
    url:             ClickURL;
}

export interface ClickURL {
    description: string;
    type:        Type;
}

export type Type = "string";

export interface Info {
    description: string;
    title:       string;
    version:     string;
}

export interface Paths {
    "/market_research_library/search": MarketResearchLibrarySearch;
}

export interface MarketResearchLibrarySearch {
    get: Get;
}

export interface Get {
    description: string;
    parameters:  Parameter[];
    responses:   Responses;
    summary:     string;
    tags:        string[];
}

export interface Parameter {
    description: string;
    format:      Type;
    in:          string;
    name:        string;
    required:    boolean;
    type:        Type;
}

export interface Responses {
    "200": The200;
}

export interface The200 {
    description: string;
    schema:      Schema;
}

export interface Schema {
    items: Items;
    type:  string;
}

export interface Items {
    $ref: string;
}

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export class Convert {
    public static toTopLevel(json: string): TopLevel {
        return cast(JSON.parse(json), r("TopLevel"));
    }

    public static topLevelToJson(value: TopLevel): string {
        return JSON.stringify(uncast(value, r("TopLevel")), null, 2);
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
    "TopLevel": o([
        { json: "basePath", js: "basePath", typ: "" },
        { json: "definitions", js: "definitions", typ: r("Definitions") },
        { json: "host", js: "host", typ: "" },
        { json: "info", js: "info", typ: r("Info") },
        { json: "paths", js: "paths", typ: r("Paths") },
        { json: "produces", js: "produces", typ: a("") },
        { json: "schemes", js: "schemes", typ: a("") },
        { json: "swagger", js: "swagger", typ: "" },
    ], false),
    "Definitions": o([
        { json: "Report", js: "Report", typ: r("Report") },
    ], false),
    "Report": o([
        { json: "properties", js: "properties", typ: r("Properties") },
    ], false),
    "Properties": o([
        { json: "click_url", js: "click_url", typ: r("ClickURL") },
        { json: "country", js: "country", typ: r("ClickURL") },
        { json: "description", js: "description", typ: r("ClickURL") },
        { json: "expiration_date", js: "expiration_date", typ: r("ClickURL") },
        { json: "id", js: "id", typ: r("ClickURL") },
        { json: "industry", js: "industry", typ: r("ClickURL") },
        { json: "report_type", js: "report_type", typ: r("ClickURL") },
        { json: "source_industry", js: "source_industry", typ: r("ClickURL") },
        { json: "title", js: "title", typ: r("ClickURL") },
        { json: "url", js: "url", typ: r("ClickURL") },
    ], false),
    "ClickURL": o([
        { json: "description", js: "description", typ: "" },
        { json: "type", js: "type", typ: r("Type") },
    ], false),
    "Info": o([
        { json: "description", js: "description", typ: "" },
        { json: "title", js: "title", typ: "" },
        { json: "version", js: "version", typ: "" },
    ], false),
    "Paths": o([
        { json: "/market_research_library/search", js: "/market_research_library/search", typ: r("MarketResearchLibrarySearch") },
    ], false),
    "MarketResearchLibrarySearch": o([
        { json: "get", js: "get", typ: r("Get") },
    ], false),
    "Get": o([
        { json: "description", js: "description", typ: "" },
        { json: "parameters", js: "parameters", typ: a(r("Parameter")) },
        { json: "responses", js: "responses", typ: r("Responses") },
        { json: "summary", js: "summary", typ: "" },
        { json: "tags", js: "tags", typ: a("") },
    ], false),
    "Parameter": o([
        { json: "description", js: "description", typ: "" },
        { json: "format", js: "format", typ: r("Type") },
        { json: "in", js: "in", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "required", js: "required", typ: true },
        { json: "type", js: "type", typ: r("Type") },
    ], false),
    "Responses": o([
        { json: "200", js: "200", typ: r("The200") },
    ], false),
    "The200": o([
        { json: "description", js: "description", typ: "" },
        { json: "schema", js: "schema", typ: r("Schema") },
    ], false),
    "Schema": o([
        { json: "items", js: "items", typ: r("Items") },
        { json: "type", js: "type", typ: "" },
    ], false),
    "Items": o([
        { json: "$ref", js: "$ref", typ: "" },
    ], false),
    "Type": [
        "string",
    ],
};
