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
    data: TopLevelData;
    kind: string;
};

export type TopLevelData = {
    after:    string;
    before:   null;
    children: Child[];
    modhash:  string;
};

export type Child = {
    data: ChildData;
    kind: Kind;
};

export type ChildData = {
    approved_at_utc:         null;
    approved_by:             null;
    archived:                boolean;
    author:                  string;
    author_flair_css_class:  null;
    author_flair_text:       null;
    banned_at_utc:           null;
    banned_by:               null;
    brand_safe:              boolean;
    can_gild:                boolean;
    can_mod_post:            boolean;
    clicked:                 boolean;
    contest_mode:            boolean;
    created:                 number;
    created_utc:             number;
    distinguished:           null;
    domain:                  string;
    downs:                   number;
    edited:                  boolean;
    gilded:                  number;
    hidden:                  boolean;
    hide_score:              boolean;
    id:                      string;
    is_self:                 boolean;
    is_video:                boolean;
    likes:                   null;
    link_flair_css_class:    null;
    link_flair_text:         null;
    locked:                  boolean;
    media:                   Media | null;
    media_embed:             MediaEmbed;
    mod_reports:             mixed[];
    name:                    string;
    num_comments:            number;
    num_reports:             null;
    over_18:                 boolean;
    permalink:               string;
    post_hint?:              PostHint;
    preview?:                Preview;
    quarantine:              boolean;
    removal_reason:          null;
    report_reasons:          null;
    saved:                   boolean;
    score:                   number;
    secure_media:            Media | null;
    secure_media_embed:      MediaEmbed;
    selftext:                string;
    selftext_html:           null;
    spoiler:                 boolean;
    stickied:                boolean;
    subreddit:               Subreddit;
    subreddit_id:            SubredditID;
    subreddit_name_prefixed: SubredditNamePrefixed;
    subreddit_type:          SubredditType;
    suggested_sort:          null;
    thumbnail:               string;
    thumbnail_height:        number | null;
    thumbnail_width:         number | null;
    title:                   string;
    ups:                     number;
    url:                     string;
    user_reports:            mixed[];
    view_count:              null;
    visited:                 boolean;
};

export type Media = {
    oembed: Oembed;
    type:   string;
};

export type Oembed = {
    author_name:      string;
    author_url:       string;
    height:           number;
    html:             string;
    provider_name:    string;
    provider_url:     string;
    thumbnail_height: number;
    thumbnail_url:    string;
    thumbnail_width:  number;
    title:            string;
    type:             string;
    version:          string;
    width:            number;
};

export type MediaEmbed = {
    content?:   string;
    height?:    number;
    scrolling?: boolean;
    width?:     number;
};

export type PostHint =
      "rich:video"
    | "link";

export type Preview = {
    enabled: boolean;
    images:  Image[];
};

export type Image = {
    id:          string;
    resolutions: Source[];
    source:      Source;
    variants:    Variants;
};

export type Source = {
    height: number;
    url:    string;
    width:  number;
};

export type Variants = {
};

export type Subreddit =
      "todayilearned";

export type SubredditID =
      "t5_2qqjc";

export type SubredditNamePrefixed =
      "r/todayilearned";

export type SubredditType =
      "public";

export type Kind =
      "t3";

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
        { json: "data", js: "data", typ: r("TopLevelData") },
        { json: "kind", js: "kind", typ: "" },
    ], false),
    "TopLevelData": o([
        { json: "after", js: "after", typ: "" },
        { json: "before", js: "before", typ: null },
        { json: "children", js: "children", typ: a(r("Child")) },
        { json: "modhash", js: "modhash", typ: "" },
    ], false),
    "Child": o([
        { json: "data", js: "data", typ: r("ChildData") },
        { json: "kind", js: "kind", typ: r("Kind") },
    ], false),
    "ChildData": o([
        { json: "approved_at_utc", js: "approved_at_utc", typ: null },
        { json: "approved_by", js: "approved_by", typ: null },
        { json: "archived", js: "archived", typ: true },
        { json: "author", js: "author", typ: "" },
        { json: "author_flair_css_class", js: "author_flair_css_class", typ: null },
        { json: "author_flair_text", js: "author_flair_text", typ: null },
        { json: "banned_at_utc", js: "banned_at_utc", typ: null },
        { json: "banned_by", js: "banned_by", typ: null },
        { json: "brand_safe", js: "brand_safe", typ: true },
        { json: "can_gild", js: "can_gild", typ: true },
        { json: "can_mod_post", js: "can_mod_post", typ: true },
        { json: "clicked", js: "clicked", typ: true },
        { json: "contest_mode", js: "contest_mode", typ: true },
        { json: "created", js: "created", typ: 3.14 },
        { json: "created_utc", js: "created_utc", typ: 3.14 },
        { json: "distinguished", js: "distinguished", typ: null },
        { json: "domain", js: "domain", typ: "" },
        { json: "downs", js: "downs", typ: i(0) },
        { json: "edited", js: "edited", typ: true },
        { json: "gilded", js: "gilded", typ: i(0) },
        { json: "hidden", js: "hidden", typ: true },
        { json: "hide_score", js: "hide_score", typ: true },
        { json: "id", js: "id", typ: "" },
        { json: "is_self", js: "is_self", typ: true },
        { json: "is_video", js: "is_video", typ: true },
        { json: "likes", js: "likes", typ: null },
        { json: "link_flair_css_class", js: "link_flair_css_class", typ: null },
        { json: "link_flair_text", js: "link_flair_text", typ: null },
        { json: "locked", js: "locked", typ: true },
        { json: "media", js: "media", typ: u(r("Media"), null) },
        { json: "media_embed", js: "media_embed", typ: r("MediaEmbed") },
        { json: "mod_reports", js: "mod_reports", typ: a("any") },
        { json: "name", js: "name", typ: "" },
        { json: "num_comments", js: "num_comments", typ: i(0) },
        { json: "num_reports", js: "num_reports", typ: null },
        { json: "over_18", js: "over_18", typ: true },
        { json: "permalink", js: "permalink", typ: "" },
        { json: "post_hint", js: "post_hint", typ: u(undefined, r("PostHint")) },
        { json: "preview", js: "preview", typ: u(undefined, r("Preview")) },
        { json: "quarantine", js: "quarantine", typ: true },
        { json: "removal_reason", js: "removal_reason", typ: null },
        { json: "report_reasons", js: "report_reasons", typ: null },
        { json: "saved", js: "saved", typ: true },
        { json: "score", js: "score", typ: i(0) },
        { json: "secure_media", js: "secure_media", typ: u(r("Media"), null) },
        { json: "secure_media_embed", js: "secure_media_embed", typ: r("MediaEmbed") },
        { json: "selftext", js: "selftext", typ: "" },
        { json: "selftext_html", js: "selftext_html", typ: null },
        { json: "spoiler", js: "spoiler", typ: true },
        { json: "stickied", js: "stickied", typ: true },
        { json: "subreddit", js: "subreddit", typ: r("Subreddit") },
        { json: "subreddit_id", js: "subreddit_id", typ: r("SubredditID") },
        { json: "subreddit_name_prefixed", js: "subreddit_name_prefixed", typ: r("SubredditNamePrefixed") },
        { json: "subreddit_type", js: "subreddit_type", typ: r("SubredditType") },
        { json: "suggested_sort", js: "suggested_sort", typ: null },
        { json: "thumbnail", js: "thumbnail", typ: "" },
        { json: "thumbnail_height", js: "thumbnail_height", typ: u(i(0), null) },
        { json: "thumbnail_width", js: "thumbnail_width", typ: u(i(0), null) },
        { json: "title", js: "title", typ: "" },
        { json: "ups", js: "ups", typ: i(0) },
        { json: "url", js: "url", typ: "" },
        { json: "user_reports", js: "user_reports", typ: a("any") },
        { json: "view_count", js: "view_count", typ: null },
        { json: "visited", js: "visited", typ: true },
    ], false),
    "Media": o([
        { json: "oembed", js: "oembed", typ: r("Oembed") },
        { json: "type", js: "type", typ: "" },
    ], false),
    "Oembed": o([
        { json: "author_name", js: "author_name", typ: "" },
        { json: "author_url", js: "author_url", typ: "" },
        { json: "height", js: "height", typ: i(0) },
        { json: "html", js: "html", typ: "" },
        { json: "provider_name", js: "provider_name", typ: "" },
        { json: "provider_url", js: "provider_url", typ: "" },
        { json: "thumbnail_height", js: "thumbnail_height", typ: i(0) },
        { json: "thumbnail_url", js: "thumbnail_url", typ: "" },
        { json: "thumbnail_width", js: "thumbnail_width", typ: i(0) },
        { json: "title", js: "title", typ: "" },
        { json: "type", js: "type", typ: "" },
        { json: "version", js: "version", typ: "" },
        { json: "width", js: "width", typ: i(0) },
    ], false),
    "MediaEmbed": o([
        { json: "content", js: "content", typ: u(undefined, "") },
        { json: "height", js: "height", typ: u(undefined, i(0)) },
        { json: "scrolling", js: "scrolling", typ: u(undefined, true) },
        { json: "width", js: "width", typ: u(undefined, i(0)) },
    ], false),
    "Preview": o([
        { json: "enabled", js: "enabled", typ: true },
        { json: "images", js: "images", typ: a(r("Image")) },
    ], false),
    "Image": o([
        { json: "id", js: "id", typ: "" },
        { json: "resolutions", js: "resolutions", typ: a(r("Source")) },
        { json: "source", js: "source", typ: r("Source") },
        { json: "variants", js: "variants", typ: r("Variants") },
    ], false),
    "Source": o([
        { json: "height", js: "height", typ: i(0) },
        { json: "url", js: "url", typ: "" },
        { json: "width", js: "width", typ: i(0) },
    ], false),
    "Variants": o([
    ], false),
    "PostHint": [
        "rich:video",
        "link",
    ],
    "Subreddit": [
        "todayilearned",
    ],
    "SubredditID": [
        "t5_2qqjc",
    ],
    "SubredditNamePrefixed": [
        "r/todayilearned",
    ],
    "SubredditType": [
        "public",
    ],
    "Kind": [
        "t3",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
