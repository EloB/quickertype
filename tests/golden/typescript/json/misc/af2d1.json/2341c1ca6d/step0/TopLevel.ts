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
    coordinates: Array<Array<Array<number[]>>>;
    type:        GeometryType;
}

export type GeometryType = "MultiPolygon";

export type GeometryName = "geom";

export interface FeatureProperties {
    add_improv: AddImprov | null;
    area_:      number;
    asset_numb: string;
    comments:   null | string;
    condition:  number;
    constructi: null | string;
    createdate: null;
    createuser: null;
    disposal_d: null;
    documents:  string;
    drawing_nu: null | string;
    file_numbe: null | string;
    folder_num: null | string;
    funding_ba: FundingBa | null;
    historic_c: number;
    inspection: string;
    inspectors: null;
    last_updat: null;
    level_accu: LevelAccu | null;
    material:   Material;
    mi_prinx:   number;
    mi_symbolo: MiSymbolo;
    number_lan: number;
    owner:      null | string;
    positional: LevelAccu | null;
    project_nu: null | string;
    rec_id:     number;
    record_cre: null | string;
    shape_area: number;
    shape_leng: number;
    status:     Status;
    survey_num: null;
    toe_rl:     number;
    top_rl:     number;
    type:       PropertiesType | null;
    update_dat: string;
    updatedate: null;
    updateuser: null;
}

export type AddImprov = "f" | "F" | "t";

export type FundingBa = "Non GCCC" | "Capex" | "Initial" | "Contribute";

export type LevelAccu = "GPS Corrected 1.0M" | "APPROX" | "GPS COrrected 1.0M";

export type Material = "Gravel" | "Concrete" | "Bitumen" | "Interlock Conc Block" | "Other" | "Earth";

export type MiSymbolo = "Pen (2, 2, 65535) Brush (1, 0, 16777215)";

export type Status = "CURRENT";

export type PropertiesType = "Boat Ramp";

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
        { json: "coordinates", js: "coordinates", typ: a(a(a(a(3.14)))) },
        { json: "type", js: "type", typ: r("GeometryType") },
    ], false),
    "FeatureProperties": o([
        { json: "add_improv", js: "add_improv", typ: u(r("AddImprov"), null) },
        { json: "area_", js: "area_", typ: 3.14 },
        { json: "asset_numb", js: "asset_numb", typ: "" },
        { json: "comments", js: "comments", typ: u(null, "") },
        { json: "condition", js: "condition", typ: i(0) },
        { json: "constructi", js: "constructi", typ: u(null, "") },
        { json: "createdate", js: "createdate", typ: null },
        { json: "createuser", js: "createuser", typ: null },
        { json: "disposal_d", js: "disposal_d", typ: null },
        { json: "documents", js: "documents", typ: "" },
        { json: "drawing_nu", js: "drawing_nu", typ: u(null, "") },
        { json: "file_numbe", js: "file_numbe", typ: u(null, "") },
        { json: "folder_num", js: "folder_num", typ: u(null, "") },
        { json: "funding_ba", js: "funding_ba", typ: u(r("FundingBa"), null) },
        { json: "historic_c", js: "historic_c", typ: i(0) },
        { json: "inspection", js: "inspection", typ: "" },
        { json: "inspectors", js: "inspectors", typ: null },
        { json: "last_updat", js: "last_updat", typ: null },
        { json: "level_accu", js: "level_accu", typ: u(r("LevelAccu"), null) },
        { json: "material", js: "material", typ: r("Material") },
        { json: "mi_prinx", js: "mi_prinx", typ: i(0) },
        { json: "mi_symbolo", js: "mi_symbolo", typ: r("MiSymbolo") },
        { json: "number_lan", js: "number_lan", typ: i(0) },
        { json: "owner", js: "owner", typ: u(null, "") },
        { json: "positional", js: "positional", typ: u(r("LevelAccu"), null) },
        { json: "project_nu", js: "project_nu", typ: u(null, "") },
        { json: "rec_id", js: "rec_id", typ: i(0) },
        { json: "record_cre", js: "record_cre", typ: u(null, "") },
        { json: "shape_area", js: "shape_area", typ: 3.14 },
        { json: "shape_leng", js: "shape_leng", typ: 3.14 },
        { json: "status", js: "status", typ: r("Status") },
        { json: "survey_num", js: "survey_num", typ: null },
        { json: "toe_rl", js: "toe_rl", typ: 3.14 },
        { json: "top_rl", js: "top_rl", typ: 3.14 },
        { json: "type", js: "type", typ: u(r("PropertiesType"), null) },
        { json: "update_dat", js: "update_dat", typ: "" },
        { json: "updatedate", js: "updatedate", typ: null },
        { json: "updateuser", js: "updateuser", typ: null },
    ], false),
    "GeometryType": [
        "MultiPolygon",
    ],
    "GeometryName": [
        "geom",
    ],
    "AddImprov": [
        "f",
        "F",
        "t",
    ],
    "FundingBa": [
        "Non GCCC",
        "Capex",
        "Initial",
        "Contribute",
    ],
    "LevelAccu": [
        "GPS Corrected 1.0M",
        "APPROX",
        "GPS COrrected 1.0M",
    ],
    "Material": [
        "Gravel",
        "Concrete",
        "Bitumen",
        "Interlock Conc Block",
        "Other",
        "Earth",
    ],
    "MiSymbolo": [
        "Pen (2, 2, 65535) Brush (1, 0, 16777215)",
    ],
    "Status": [
        "CURRENT",
    ],
    "PropertiesType": [
        "Boat Ramp",
    ],
    "FeatureType": [
        "Feature",
    ],
};
