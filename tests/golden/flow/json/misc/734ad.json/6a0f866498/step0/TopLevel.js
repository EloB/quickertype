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
    facets:   Facets;
    limit:    number;
    next:     string;
    offset:   number;
    previous: boolean;
    results:  Result[];
};

export type Facets = {
};

export type Result = {
    acronym:                     null | string;
    activity_consult_committees: string;
    activity_eu_legislative:     string;
    activity_expert_groups:      string;
    activity_high_level_groups:  string;
    activity_industry_forums:    string;
    activity_inter_groups:       string;
    activity_other:              null | string;
    activity_relevant_comm:      string;
    be_office_country?:          string;
    be_office_lat?:              number | null;
    be_office_lon?:              number | null;
    be_office_phone?:            string;
    be_office_post_code?:        null | string;
    be_office_postbox?:          null | string;
    be_office_street?:           string;
    be_office_town?:             string;
    code_of_conduct:             string;
    contact_country:             number;
    created_at:                  Date;
    entity:                      string;
    goals:                       string;
    head:                        string;
    head_office_country:         string;
    head_office_lat:             number | null;
    head_office_lon:             number | null;
    head_office_phone:           string;
    head_office_post_code:       null | string;
    head_office_postbox:         null | string;
    head_office_street:          string;
    head_office_town:            string;
    id:                          string;
    identification_code:         string;
    info_members:                string;
    last_update_date:            Date;
    legal:                       string;
    legal_status:                string;
    main_category:               number;
    main_category_title:         string;
    members:                     number;
    members_100:                 number | null;
    members_25:                  number | null;
    members_50:                  number | null;
    members_75:                  number | null;
    members_fte:                 number;
    name:                        string;
    native_name:                 null;
    networking:                  null | string;
    number_of_natural_persons:   number | null;
    other_code_of_conduct:       null | string;
    registration_date:           Date;
    status:                      Status;
    structure_members:           string;
    sub_category:                number;
    sub_category_title:          string;
    updated_at:                  Date;
    uri:                         string;
    web_site_url:                null | string;
};

export type Status =
      "active"
    | "inactive";

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
        { json: "facets", js: "facets", typ: r("Facets") },
        { json: "limit", js: "limit", typ: i(0) },
        { json: "next", js: "next", typ: "" },
        { json: "offset", js: "offset", typ: i(0) },
        { json: "previous", js: "previous", typ: true },
        { json: "results", js: "results", typ: a(r("Result")) },
    ], false),
    "Facets": o([
    ], false),
    "Result": o([
        { json: "acronym", js: "acronym", typ: u(null, "") },
        { json: "activity_consult_committees", js: "activity_consult_committees", typ: "" },
        { json: "activity_eu_legislative", js: "activity_eu_legislative", typ: "" },
        { json: "activity_expert_groups", js: "activity_expert_groups", typ: "" },
        { json: "activity_high_level_groups", js: "activity_high_level_groups", typ: "" },
        { json: "activity_industry_forums", js: "activity_industry_forums", typ: "" },
        { json: "activity_inter_groups", js: "activity_inter_groups", typ: "" },
        { json: "activity_other", js: "activity_other", typ: u(null, "") },
        { json: "activity_relevant_comm", js: "activity_relevant_comm", typ: "" },
        { json: "be_office_country", js: "be_office_country", typ: u(undefined, "") },
        { json: "be_office_lat", js: "be_office_lat", typ: u(undefined, u(3.14, null)) },
        { json: "be_office_lon", js: "be_office_lon", typ: u(undefined, u(3.14, null)) },
        { json: "be_office_phone", js: "be_office_phone", typ: u(undefined, "") },
        { json: "be_office_post_code", js: "be_office_post_code", typ: u(undefined, u(null, "")) },
        { json: "be_office_postbox", js: "be_office_postbox", typ: u(undefined, u(null, "")) },
        { json: "be_office_street", js: "be_office_street", typ: u(undefined, "") },
        { json: "be_office_town", js: "be_office_town", typ: u(undefined, "") },
        { json: "code_of_conduct", js: "code_of_conduct", typ: "" },
        { json: "contact_country", js: "contact_country", typ: i(0) },
        { json: "created_at", js: "created_at", typ: Date },
        { json: "entity", js: "entity", typ: "" },
        { json: "goals", js: "goals", typ: "" },
        { json: "head", js: "head", typ: "" },
        { json: "head_office_country", js: "head_office_country", typ: "" },
        { json: "head_office_lat", js: "head_office_lat", typ: u(3.14, null) },
        { json: "head_office_lon", js: "head_office_lon", typ: u(3.14, null) },
        { json: "head_office_phone", js: "head_office_phone", typ: "" },
        { json: "head_office_post_code", js: "head_office_post_code", typ: u(null, "") },
        { json: "head_office_postbox", js: "head_office_postbox", typ: u(null, "") },
        { json: "head_office_street", js: "head_office_street", typ: "" },
        { json: "head_office_town", js: "head_office_town", typ: "" },
        { json: "id", js: "id", typ: "" },
        { json: "identification_code", js: "identification_code", typ: "" },
        { json: "info_members", js: "info_members", typ: "" },
        { json: "last_update_date", js: "last_update_date", typ: Date },
        { json: "legal", js: "legal", typ: "" },
        { json: "legal_status", js: "legal_status", typ: "" },
        { json: "main_category", js: "main_category", typ: i(0) },
        { json: "main_category_title", js: "main_category_title", typ: "" },
        { json: "members", js: "members", typ: i(0) },
        { json: "members_100", js: "members_100", typ: u(i(0), null) },
        { json: "members_25", js: "members_25", typ: u(i(0), null) },
        { json: "members_50", js: "members_50", typ: u(i(0), null) },
        { json: "members_75", js: "members_75", typ: u(i(0), null) },
        { json: "members_fte", js: "members_fte", typ: 3.14 },
        { json: "name", js: "name", typ: "" },
        { json: "native_name", js: "native_name", typ: null },
        { json: "networking", js: "networking", typ: u(null, "") },
        { json: "number_of_natural_persons", js: "number_of_natural_persons", typ: u(i(0), null) },
        { json: "other_code_of_conduct", js: "other_code_of_conduct", typ: u(null, "") },
        { json: "registration_date", js: "registration_date", typ: Date },
        { json: "status", js: "status", typ: r("Status") },
        { json: "structure_members", js: "structure_members", typ: "" },
        { json: "sub_category", js: "sub_category", typ: i(0) },
        { json: "sub_category_title", js: "sub_category_title", typ: "" },
        { json: "updated_at", js: "updated_at", typ: Date },
        { json: "uri", js: "uri", typ: "" },
        { json: "web_site_url", js: "web_site_url", typ: u(null, "") },
    ], false),
    "Status": [
        "active",
        "inactive",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
