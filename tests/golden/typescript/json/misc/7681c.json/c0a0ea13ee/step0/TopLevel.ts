// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface TopLevel {
    data:       Datum[];
    meta:       Meta;
    pagination: Pagination;
}

export interface Datum {
    bitly_gif_url:     string;
    bitly_url:         string;
    content_url:       string;
    embed_url:         string;
    id:                string;
    images:            Images;
    import_datetime:   string;
    is_indexable:      number;
    rating:            Rating;
    slug:              string;
    source:            string;
    source_post_url:   string;
    source_tld:        string;
    trending_datetime: string;
    type:              Type;
    url:               string;
    user?:             User;
    username:          Username;
}

export interface Images {
    "480w_still"?:            The480_WStill;
    downsized:                The480_WStill;
    downsized_large:          The480_WStill;
    downsized_medium:         The480_WStill;
    downsized_small:          DownsizedSmall;
    downsized_still:          The480_WStill;
    fixed_height:             FixedHeight;
    fixed_height_downsampled: FixedHeight;
    fixed_height_small:       FixedHeight;
    fixed_height_small_still: The480_WStill;
    fixed_height_still:       The480_WStill;
    fixed_width:              FixedHeight;
    fixed_width_downsampled:  FixedHeight;
    fixed_width_small:        FixedHeight;
    fixed_width_small_still:  The480_WStill;
    fixed_width_still:        The480_WStill;
    looping:                  Looping;
    original:                 FixedHeight;
    original_mp4:             DownsizedSmall;
    original_still:           The480_WStill;
    preview:                  DownsizedSmall;
    preview_gif:              The480_WStill;
    preview_webp:             The480_WStill;
}

export interface The480_WStill {
    height: string;
    size?:  string;
    url:    string;
    width:  string;
}

export interface DownsizedSmall {
    height:   string;
    mp4:      string;
    mp4_size: string;
    width:    string;
}

export interface FixedHeight {
    frames?:   string;
    hash?:     string;
    height:    string;
    mp4?:      string;
    mp4_size?: string;
    size:      string;
    url:       string;
    webp:      string;
    webp_size: string;
    width:     string;
}

export interface Looping {
    mp4:      string;
    mp4_size: string;
}

export type Rating = "g" | "pg" | "pg-13";

export type Type = "gif";

export interface User {
    avatar_url:   string;
    banner_url:   string;
    display_name: string;
    profile_url:  string;
    twitter?:     string;
    username:     string;
}

export type Username = "" | "mashable" | "nba" | "Originals";

export interface Meta {
    msg:         string;
    response_id: string;
    status:      number;
}

export interface Pagination {
    count:       number;
    offset:      number;
    total_count: number;
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
        { json: "data", js: "data", typ: a(r("Datum")) },
        { json: "meta", js: "meta", typ: r("Meta") },
        { json: "pagination", js: "pagination", typ: r("Pagination") },
    ], false),
    "Datum": o([
        { json: "bitly_gif_url", js: "bitly_gif_url", typ: "" },
        { json: "bitly_url", js: "bitly_url", typ: "" },
        { json: "content_url", js: "content_url", typ: "" },
        { json: "embed_url", js: "embed_url", typ: "" },
        { json: "id", js: "id", typ: "" },
        { json: "images", js: "images", typ: r("Images") },
        { json: "import_datetime", js: "import_datetime", typ: "" },
        { json: "is_indexable", js: "is_indexable", typ: i(0) },
        { json: "rating", js: "rating", typ: r("Rating") },
        { json: "slug", js: "slug", typ: "" },
        { json: "source", js: "source", typ: "" },
        { json: "source_post_url", js: "source_post_url", typ: "" },
        { json: "source_tld", js: "source_tld", typ: "" },
        { json: "trending_datetime", js: "trending_datetime", typ: "" },
        { json: "type", js: "type", typ: r("Type") },
        { json: "url", js: "url", typ: "" },
        { json: "user", js: "user", typ: u(undefined, r("User")) },
        { json: "username", js: "username", typ: r("Username") },
    ], false),
    "Images": o([
        { json: "480w_still", js: "480w_still", typ: u(undefined, r("The480_WStill")) },
        { json: "downsized", js: "downsized", typ: r("The480_WStill") },
        { json: "downsized_large", js: "downsized_large", typ: r("The480_WStill") },
        { json: "downsized_medium", js: "downsized_medium", typ: r("The480_WStill") },
        { json: "downsized_small", js: "downsized_small", typ: r("DownsizedSmall") },
        { json: "downsized_still", js: "downsized_still", typ: r("The480_WStill") },
        { json: "fixed_height", js: "fixed_height", typ: r("FixedHeight") },
        { json: "fixed_height_downsampled", js: "fixed_height_downsampled", typ: r("FixedHeight") },
        { json: "fixed_height_small", js: "fixed_height_small", typ: r("FixedHeight") },
        { json: "fixed_height_small_still", js: "fixed_height_small_still", typ: r("The480_WStill") },
        { json: "fixed_height_still", js: "fixed_height_still", typ: r("The480_WStill") },
        { json: "fixed_width", js: "fixed_width", typ: r("FixedHeight") },
        { json: "fixed_width_downsampled", js: "fixed_width_downsampled", typ: r("FixedHeight") },
        { json: "fixed_width_small", js: "fixed_width_small", typ: r("FixedHeight") },
        { json: "fixed_width_small_still", js: "fixed_width_small_still", typ: r("The480_WStill") },
        { json: "fixed_width_still", js: "fixed_width_still", typ: r("The480_WStill") },
        { json: "looping", js: "looping", typ: r("Looping") },
        { json: "original", js: "original", typ: r("FixedHeight") },
        { json: "original_mp4", js: "original_mp4", typ: r("DownsizedSmall") },
        { json: "original_still", js: "original_still", typ: r("The480_WStill") },
        { json: "preview", js: "preview", typ: r("DownsizedSmall") },
        { json: "preview_gif", js: "preview_gif", typ: r("The480_WStill") },
        { json: "preview_webp", js: "preview_webp", typ: r("The480_WStill") },
    ], false),
    "The480_WStill": o([
        { json: "height", js: "height", typ: "" },
        { json: "size", js: "size", typ: u(undefined, "") },
        { json: "url", js: "url", typ: "" },
        { json: "width", js: "width", typ: "" },
    ], false),
    "DownsizedSmall": o([
        { json: "height", js: "height", typ: "" },
        { json: "mp4", js: "mp4", typ: "" },
        { json: "mp4_size", js: "mp4_size", typ: "" },
        { json: "width", js: "width", typ: "" },
    ], false),
    "FixedHeight": o([
        { json: "frames", js: "frames", typ: u(undefined, "") },
        { json: "hash", js: "hash", typ: u(undefined, "") },
        { json: "height", js: "height", typ: "" },
        { json: "mp4", js: "mp4", typ: u(undefined, "") },
        { json: "mp4_size", js: "mp4_size", typ: u(undefined, "") },
        { json: "size", js: "size", typ: "" },
        { json: "url", js: "url", typ: "" },
        { json: "webp", js: "webp", typ: "" },
        { json: "webp_size", js: "webp_size", typ: "" },
        { json: "width", js: "width", typ: "" },
    ], false),
    "Looping": o([
        { json: "mp4", js: "mp4", typ: "" },
        { json: "mp4_size", js: "mp4_size", typ: "" },
    ], false),
    "User": o([
        { json: "avatar_url", js: "avatar_url", typ: "" },
        { json: "banner_url", js: "banner_url", typ: "" },
        { json: "display_name", js: "display_name", typ: "" },
        { json: "profile_url", js: "profile_url", typ: "" },
        { json: "twitter", js: "twitter", typ: u(undefined, "") },
        { json: "username", js: "username", typ: "" },
    ], false),
    "Meta": o([
        { json: "msg", js: "msg", typ: "" },
        { json: "response_id", js: "response_id", typ: "" },
        { json: "status", js: "status", typ: i(0) },
    ], false),
    "Pagination": o([
        { json: "count", js: "count", typ: i(0) },
        { json: "offset", js: "offset", typ: i(0) },
        { json: "total_count", js: "total_count", typ: i(0) },
    ], false),
    "Rating": [
        "g",
        "pg",
        "pg-13",
    ],
    "Type": [
        "gif",
    ],
    "Username": [
        "",
        "mashable",
        "nba",
        "Originals",
    ],
};
