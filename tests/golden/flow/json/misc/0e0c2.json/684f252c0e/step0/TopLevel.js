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
    count:    number;
    next:     string;
    previous: null;
    results:  Result[];
};

export type Result = {
    active_screens: number;
    collections:    Collection[];
    details:        Detail[];
    duration:       number;
    fav_movie:      FavMovie;
    id:             number;
    images:         Image[];
    language:       ResultLanguage;
    release_date:   Date;
    stars:          number;
    tags:           mixed[] | null;
    title:          string;
    videos:         Video[];
    vote_score:     VoteScore;
    watches:        number;
};

export type Collection = {
    id:     number;
    movies: number[];
    name:   string;
    slug:   string;
};

export type Detail = {
    cast:      string;
    director:  string;
    id:        number;
    language:  DetailLanguage;
    storyline: string;
    tagline:   string;
    title:     string;
};

export type DetailLanguage =
      "en"
    | "th";

export type FavMovie = {
    follow:  boolean;
    star:    boolean;
    watched: boolean;
};

export type Image = {
    favs:      number;
    id:        number;
    thumbnail: string;
    type:      Type;
    url:       string;
};

export type Type =
      "Poster"
    | "Backdrop";

export type ResultLanguage =
      "en"
    | "-";

export type Video = {
    kind:     string;
    language: ResultLanguage;
    source:   string;
    url:      string;
};

export type VoteScore = {
    avg:   number;
    score: number;
    total: number;
};

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
        { json: "count", js: "count", typ: i(0) },
        { json: "next", js: "next", typ: "" },
        { json: "previous", js: "previous", typ: null },
        { json: "results", js: "results", typ: a(r("Result")) },
    ], false),
    "Result": o([
        { json: "active_screens", js: "active_screens", typ: i(0) },
        { json: "collections", js: "collections", typ: a(r("Collection")) },
        { json: "details", js: "details", typ: a(r("Detail")) },
        { json: "duration", js: "duration", typ: i(0) },
        { json: "fav_movie", js: "fav_movie", typ: r("FavMovie") },
        { json: "id", js: "id", typ: i(0) },
        { json: "images", js: "images", typ: a(r("Image")) },
        { json: "language", js: "language", typ: r("ResultLanguage") },
        { json: "release_date", js: "release_date", typ: Date },
        { json: "stars", js: "stars", typ: i(0) },
        { json: "tags", js: "tags", typ: u(a("any"), null) },
        { json: "title", js: "title", typ: "" },
        { json: "videos", js: "videos", typ: a(r("Video")) },
        { json: "vote_score", js: "vote_score", typ: r("VoteScore") },
        { json: "watches", js: "watches", typ: i(0) },
    ], false),
    "Collection": o([
        { json: "id", js: "id", typ: i(0) },
        { json: "movies", js: "movies", typ: a(i(0)) },
        { json: "name", js: "name", typ: "" },
        { json: "slug", js: "slug", typ: "" },
    ], false),
    "Detail": o([
        { json: "cast", js: "cast", typ: "" },
        { json: "director", js: "director", typ: "" },
        { json: "id", js: "id", typ: i(0) },
        { json: "language", js: "language", typ: r("DetailLanguage") },
        { json: "storyline", js: "storyline", typ: "" },
        { json: "tagline", js: "tagline", typ: "" },
        { json: "title", js: "title", typ: "" },
    ], false),
    "FavMovie": o([
        { json: "follow", js: "follow", typ: true },
        { json: "star", js: "star", typ: true },
        { json: "watched", js: "watched", typ: true },
    ], false),
    "Image": o([
        { json: "favs", js: "favs", typ: i(0) },
        { json: "id", js: "id", typ: i(0) },
        { json: "thumbnail", js: "thumbnail", typ: "" },
        { json: "type", js: "type", typ: r("Type") },
        { json: "url", js: "url", typ: "" },
    ], false),
    "Video": o([
        { json: "kind", js: "kind", typ: "" },
        { json: "language", js: "language", typ: r("ResultLanguage") },
        { json: "source", js: "source", typ: "" },
        { json: "url", js: "url", typ: "" },
    ], false),
    "VoteScore": o([
        { json: "avg", js: "avg", typ: i(0) },
        { json: "score", js: "score", typ: i(0) },
        { json: "total", js: "total", typ: i(0) },
    ], false),
    "DetailLanguage": [
        "en",
        "th",
    ],
    "Type": [
        "Poster",
        "Backdrop",
    ],
    "ResultLanguage": [
        "en",
        "-",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
