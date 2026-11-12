// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface TopLevel {
    query: Query;
}

export interface Query {
    count:   number;
    created: Date;
    lang:    string;
    results: Results;
}

export interface Results {
    channel: Channel;
}

export interface Channel {
    astronomy:     Astronomy;
    atmosphere:    Atmosphere;
    description:   string;
    image:         Image;
    item:          Item;
    language:      string;
    lastBuildDate: string;
    link:          string;
    location:      Location;
    title:         string;
    ttl:           string;
    units:         Units;
    wind:          Wind;
}

export interface Astronomy {
    sunrise: string;
    sunset:  string;
}

export interface Atmosphere {
    humidity:   string;
    pressure:   string;
    rising:     string;
    visibility: string;
}

export interface Image {
    height: string;
    link:   string;
    title:  string;
    url:    string;
    width:  string;
}

export interface Item {
    condition:   Condition;
    description: string;
    forecast:    Forecast[];
    guid:        GUID;
    lat:         string;
    link:        string;
    long:        string;
    pubDate:     string;
    title:       string;
}

export interface Condition {
    code: string;
    date: string;
    temp: string;
    text: string;
}

export interface Forecast {
    code: string;
    date: string;
    day:  string;
    high: string;
    low:  string;
    text: string;
}

export interface GUID {
    isPermaLink: string;
}

export interface Location {
    city:    string;
    country: string;
    region:  string;
}

export interface Units {
    distance:    string;
    pressure:    string;
    speed:       string;
    temperature: string;
}

export interface Wind {
    chill:     string;
    direction: string;
    speed:     string;
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
        { json: "query", js: "query", typ: r("Query") },
    ], false),
    "Query": o([
        { json: "count", js: "count", typ: i(0) },
        { json: "created", js: "created", typ: Date },
        { json: "lang", js: "lang", typ: "" },
        { json: "results", js: "results", typ: r("Results") },
    ], false),
    "Results": o([
        { json: "channel", js: "channel", typ: r("Channel") },
    ], false),
    "Channel": o([
        { json: "astronomy", js: "astronomy", typ: r("Astronomy") },
        { json: "atmosphere", js: "atmosphere", typ: r("Atmosphere") },
        { json: "description", js: "description", typ: "" },
        { json: "image", js: "image", typ: r("Image") },
        { json: "item", js: "item", typ: r("Item") },
        { json: "language", js: "language", typ: "" },
        { json: "lastBuildDate", js: "lastBuildDate", typ: "" },
        { json: "link", js: "link", typ: "" },
        { json: "location", js: "location", typ: r("Location") },
        { json: "title", js: "title", typ: "" },
        { json: "ttl", js: "ttl", typ: "" },
        { json: "units", js: "units", typ: r("Units") },
        { json: "wind", js: "wind", typ: r("Wind") },
    ], false),
    "Astronomy": o([
        { json: "sunrise", js: "sunrise", typ: "" },
        { json: "sunset", js: "sunset", typ: "" },
    ], false),
    "Atmosphere": o([
        { json: "humidity", js: "humidity", typ: "" },
        { json: "pressure", js: "pressure", typ: "" },
        { json: "rising", js: "rising", typ: "" },
        { json: "visibility", js: "visibility", typ: "" },
    ], false),
    "Image": o([
        { json: "height", js: "height", typ: "" },
        { json: "link", js: "link", typ: "" },
        { json: "title", js: "title", typ: "" },
        { json: "url", js: "url", typ: "" },
        { json: "width", js: "width", typ: "" },
    ], false),
    "Item": o([
        { json: "condition", js: "condition", typ: r("Condition") },
        { json: "description", js: "description", typ: "" },
        { json: "forecast", js: "forecast", typ: a(r("Forecast")) },
        { json: "guid", js: "guid", typ: r("GUID") },
        { json: "lat", js: "lat", typ: "" },
        { json: "link", js: "link", typ: "" },
        { json: "long", js: "long", typ: "" },
        { json: "pubDate", js: "pubDate", typ: "" },
        { json: "title", js: "title", typ: "" },
    ], false),
    "Condition": o([
        { json: "code", js: "code", typ: "" },
        { json: "date", js: "date", typ: "" },
        { json: "temp", js: "temp", typ: "" },
        { json: "text", js: "text", typ: "" },
    ], false),
    "Forecast": o([
        { json: "code", js: "code", typ: "" },
        { json: "date", js: "date", typ: "" },
        { json: "day", js: "day", typ: "" },
        { json: "high", js: "high", typ: "" },
        { json: "low", js: "low", typ: "" },
        { json: "text", js: "text", typ: "" },
    ], false),
    "GUID": o([
        { json: "isPermaLink", js: "isPermaLink", typ: "" },
    ], false),
    "Location": o([
        { json: "city", js: "city", typ: "" },
        { json: "country", js: "country", typ: "" },
        { json: "region", js: "region", typ: "" },
    ], false),
    "Units": o([
        { json: "distance", js: "distance", typ: "" },
        { json: "pressure", js: "pressure", typ: "" },
        { json: "speed", js: "speed", typ: "" },
        { json: "temperature", js: "temperature", typ: "" },
    ], false),
    "Wind": o([
        { json: "chill", js: "chill", typ: "" },
        { json: "direction", js: "direction", typ: "" },
        { json: "speed", js: "speed", typ: "" },
    ], false),
};
