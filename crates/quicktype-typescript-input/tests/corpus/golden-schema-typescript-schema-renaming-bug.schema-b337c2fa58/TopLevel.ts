// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface TopLevel {
    version?:  string;
    fruits?:   Fruit[];
    vehicles?: Vehicle[];
    [property: string]: unknown;
}

export interface Fruit {
    apple?:   boolean;
    berries?: Berry[];
    orange?:  boolean;
    [property: string]: unknown;
}

export interface Berry {
    color?:  Color;
    name?:   string;
    shapes?: Shape[];
    [property: string]: unknown;
}

export interface Color {
    rgb?: number;
    [property: string]: unknown;
}

export interface Shape {
    geometry?: Geometry;
    history?:  History;
    [property: string]: unknown;
}

export interface Geometry {
    rectShape?:     RectShape;
    circularShape?: CircularShape[];
    [property: string]: unknown;
}

export interface CircularShape {
    shapeName?: string;
    [property: string]: unknown;
}

export interface RectShape {
    parts?: Part[];
    [property: string]: unknown;
}

export interface Part {
    depth?:  string;
    length?: string;
    width?:  string;
    [property: string]: unknown;
}

export interface History {
    class?: string;
    [property: string]: unknown;
}

export interface Vehicle {
    brand?:     string;
    id?:        string;
    speed?:     Speed;
    subModule?: boolean;
    type?:      VehicleType;
    year?:      string;
    [property: string]: unknown;
}

export interface Speed {
    velocity?: Limit;
    [property: string]: unknown;
}

export interface Limit {
    maximum?: number;
    minimum?: number;
    [property: string]: unknown;
}

export interface VehicleType {
    name?:   Name;
    width?:  Axis;
    length?: Axis;
    [property: string]: unknown;
}

export type Axis = "X" | "Y" | "Z" | "YZ" | "ZX" | "XY";

export type Name = "truck" | "bus" | "car" | "van" | "train" | "Bike" | "Aeroplane" | "Jeep" | "Trolley";

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
        { json: "version", js: "version", typ: u(undefined, p("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}$")) },
        { json: "fruits", js: "fruits", typ: u(undefined, a(r("Fruit"))) },
        { json: "vehicles", js: "vehicles", typ: u(undefined, a(r("Vehicle"))) },
    ], "any"),
    "Fruit": o([
        { json: "apple", js: "apple", typ: u(undefined, true) },
        { json: "berries", js: "berries", typ: u(undefined, a(r("Berry"))) },
        { json: "orange", js: "orange", typ: u(undefined, true) },
    ], "any"),
    "Berry": o([
        { json: "color", js: "color", typ: u(undefined, r("Color")) },
        { json: "name", js: "name", typ: u(undefined, s("", 1, undefined)) },
        { json: "shapes", js: "shapes", typ: u(undefined, a(r("Shape"))) },
    ], "any"),
    "Color": o([
        { json: "rgb", js: "rgb", typ: u(undefined, 3.14) },
    ], "any"),
    "Shape": o([
        { json: "geometry", js: "geometry", typ: u(undefined, r("Geometry")) },
        { json: "history", js: "history", typ: u(undefined, r("History")) },
    ], "any"),
    "Geometry": o([
        { json: "rectShape", js: "rectShape", typ: u(undefined, r("RectShape")) },
        { json: "circularShape", js: "circularShape", typ: u(undefined, a(r("CircularShape"))) },
    ], "any"),
    "CircularShape": o([
        { json: "shapeName", js: "shapeName", typ: u(undefined, "") },
    ], "any"),
    "RectShape": o([
        { json: "parts", js: "parts", typ: u(undefined, a(r("Part"))) },
    ], "any"),
    "Part": o([
        { json: "depth", js: "depth", typ: u(undefined, "") },
        { json: "length", js: "length", typ: u(undefined, "") },
        { json: "width", js: "width", typ: u(undefined, "") },
    ], "any"),
    "History": o([
        { json: "class", js: "class", typ: u(undefined, "") },
    ], "any"),
    "Vehicle": o([
        { json: "brand", js: "brand", typ: u(undefined, "") },
        { json: "id", js: "id", typ: u(undefined, s("", 1, undefined)) },
        { json: "speed", js: "speed", typ: u(undefined, r("Speed")) },
        { json: "subModule", js: "subModule", typ: u(undefined, true) },
        { json: "type", js: "type", typ: u(undefined, r("VehicleType")) },
        { json: "year", js: "year", typ: u(undefined, "") },
    ], "any"),
    "Speed": o([
        { json: "velocity", js: "velocity", typ: u(undefined, r("Limit")) },
    ], "any"),
    "Limit": o([
        { json: "maximum", js: "maximum", typ: u(undefined, 3.14) },
        { json: "minimum", js: "minimum", typ: u(undefined, 3.14) },
    ], "any"),
    "VehicleType": o([
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "width", js: "width", typ: u(undefined, r("Axis")) },
        { json: "length", js: "length", typ: u(undefined, r("Axis")) },
    ], "any"),
    "Axis": [
        "X",
        "Y",
        "Z",
        "YZ",
        "ZX",
        "XY",
    ],
    "Name": [
        "truck",
        "bus",
        "car",
        "van",
        "train",
        "Bike",
        "Aeroplane",
        "Jeep",
        "Trolley",
    ],
};
