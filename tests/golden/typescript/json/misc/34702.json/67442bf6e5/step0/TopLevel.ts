// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface TopLevel {
    crs:           CRS;
    features:      Feature[];
    totalFeatures: number;
    type:          string;
}

export interface CRS {
    properties: CRSProperties;
    type:       string;
}

export interface CRSProperties {
    name: string;
}

export interface Feature {
    geometry:      Geometry;
    geometry_name: GeometryName;
    id:            string;
    properties:    FeatureProperties;
    type:          FeatureType;
}

export interface Geometry {
    coordinates: number[];
    type:        GeometryType;
}

export type GeometryType = "Point";

export type GeometryName = "geom";

export interface FeatureProperties {
    division:   string;
    fax:        number;
    fire_ban_r: FireBanR | null;
    latitude:   number;
    local_govt: string;
    longitude:  number;
    no:         null | string;
    phone:      number;
    postcode:   number;
    psa:        string;
    region:     Region;
    station:    string;
    street:     string;
    suburb:     string;
    type:       PropertiesType | null;
}

export type FireBanR = "North Central" | "Central" | "South West" | "Wimmera" | "Northern Country" | "East Gippsland" | "North East" | "Mallee" | "West &South Gippsland" | "Ballarat";

export type Region = "Eastern" | "Northern Metro" | "Western" | "Southern Metro";

export type PropertiesType = "STREET" | "AVENUE" | "ROAD" | "HIGHWAY" | "BOULEVARD" | "COURT" | "WAY" | "DRIVE" | "SOUTH" | "HILL" | "LANE" | "CLOSE" | "PARADE" | "Road" | "PLACE" | "RD";

export type FeatureType = "Feature";

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
        { json: "crs", js: "crs", typ: r("CRS") },
        { json: "features", js: "features", typ: a(r("Feature")) },
        { json: "totalFeatures", js: "totalFeatures", typ: i(0) },
        { json: "type", js: "type", typ: "" },
    ], false),
    "CRS": o([
        { json: "properties", js: "properties", typ: r("CRSProperties") },
        { json: "type", js: "type", typ: "" },
    ], false),
    "CRSProperties": o([
        { json: "name", js: "name", typ: "" },
    ], false),
    "Feature": o([
        { json: "geometry", js: "geometry", typ: r("Geometry") },
        { json: "geometry_name", js: "geometry_name", typ: r("GeometryName") },
        { json: "id", js: "id", typ: "" },
        { json: "properties", js: "properties", typ: r("FeatureProperties") },
        { json: "type", js: "type", typ: r("FeatureType") },
    ], false),
    "Geometry": o([
        { json: "coordinates", js: "coordinates", typ: a(3.14) },
        { json: "type", js: "type", typ: r("GeometryType") },
    ], false),
    "FeatureProperties": o([
        { json: "division", js: "division", typ: "" },
        { json: "fax", js: "fax", typ: 3.14 },
        { json: "fire_ban_r", js: "fire_ban_r", typ: u(r("FireBanR"), null) },
        { json: "latitude", js: "latitude", typ: 3.14 },
        { json: "local_govt", js: "local_govt", typ: "" },
        { json: "longitude", js: "longitude", typ: 3.14 },
        { json: "no", js: "no", typ: u(null, "") },
        { json: "phone", js: "phone", typ: 3.14 },
        { json: "postcode", js: "postcode", typ: i(0) },
        { json: "psa", js: "psa", typ: "" },
        { json: "region", js: "region", typ: r("Region") },
        { json: "station", js: "station", typ: "" },
        { json: "street", js: "street", typ: "" },
        { json: "suburb", js: "suburb", typ: "" },
        { json: "type", js: "type", typ: u(r("PropertiesType"), null) },
    ], false),
    "GeometryType": [
        "Point",
    ],
    "GeometryName": [
        "geom",
    ],
    "FireBanR": [
        "North Central",
        "Central",
        "South West",
        "Wimmera",
        "Northern Country",
        "East Gippsland",
        "North East",
        "Mallee",
        "West &South Gippsland",
        "Ballarat",
    ],
    "Region": [
        "Eastern",
        "Northern Metro",
        "Western",
        "Southern Metro",
    ],
    "PropertiesType": [
        "STREET",
        "AVENUE",
        "ROAD",
        "HIGHWAY",
        "BOULEVARD",
        "COURT",
        "WAY",
        "DRIVE",
        "SOUTH",
        "HILL",
        "LANE",
        "CLOSE",
        "PARADE",
        "Road",
        "PLACE",
        "RD",
    ],
    "FeatureType": [
        "Feature",
    ],
};
