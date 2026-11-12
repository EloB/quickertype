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
    metadata: Metadata;
    results:  Result[];
};

export type Metadata = {
    executionTime: number;
    responseInfo:  ResponseInfo;
    resultset:     Resultset;
};

export type ResponseInfo = {
    developerMessage: string;
    status:           number;
};

export type Resultset = {
    count:    number;
    page:     number;
    pagesize: number;
};

export type Result = {
    attachment: mixed[];
    body:       string;
    changed:    string;
    component:  Component[];
    created:    string;
    date:       string;
    image:      mixed[];
    location:   Location;
    teaser:     null;
    title:      string;
    topic:      mixed[];
    url:        string;
    uuid:       string;
    vuuid:      string;
};

export type Component = {
    name: string;
    uuid: string;
};

export type Location = {
    administrative_area:    string;
    country:                string;
    fax_number:             string;
    locality:               string;
    mobile_number:          string;
    phone_number:           string;
    phone_number_extension: string;
    postal_code:            string;
    sub_premise:            null;
    thoroughfare:           string;
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
        return typ.hasOwnProperty("uuid")         ? typeof val === "string" && /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(val) ? val : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("pattern")      ? typeof val === "string" && new RegExp(typ.pattern).test(val) ? val : invalidValue(typ, val, key, parent)
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
        { json: "metadata", js: "metadata", typ: r("Metadata") },
        { json: "results", js: "results", typ: a(r("Result")) },
    ], false),
    "Metadata": o([
        { json: "executionTime", js: "executionTime", typ: 3.14 },
        { json: "responseInfo", js: "responseInfo", typ: r("ResponseInfo") },
        { json: "resultset", js: "resultset", typ: r("Resultset") },
    ], false),
    "ResponseInfo": o([
        { json: "developerMessage", js: "developerMessage", typ: "" },
        { json: "status", js: "status", typ: i(0) },
    ], false),
    "Resultset": o([
        { json: "count", js: "count", typ: i(0) },
        { json: "page", js: "page", typ: i(0) },
        { json: "pagesize", js: "pagesize", typ: i(0) },
    ], false),
    "Result": o([
        { json: "attachment", js: "attachment", typ: a("any") },
        { json: "body", js: "body", typ: "" },
        { json: "changed", js: "changed", typ: "" },
        { json: "component", js: "component", typ: a(r("Component")) },
        { json: "created", js: "created", typ: "" },
        { json: "date", js: "date", typ: "" },
        { json: "image", js: "image", typ: a("any") },
        { json: "location", js: "location", typ: r("Location") },
        { json: "teaser", js: "teaser", typ: null },
        { json: "title", js: "title", typ: "" },
        { json: "topic", js: "topic", typ: a("any") },
        { json: "url", js: "url", typ: "" },
        { json: "uuid", js: "uuid", typ: { uuid: "" } },
        { json: "vuuid", js: "vuuid", typ: { uuid: "" } },
    ], false),
    "Component": o([
        { json: "name", js: "name", typ: "" },
        { json: "uuid", js: "uuid", typ: { uuid: "" } },
    ], false),
    "Location": o([
        { json: "administrative_area", js: "administrative_area", typ: "" },
        { json: "country", js: "country", typ: "" },
        { json: "fax_number", js: "fax_number", typ: "" },
        { json: "locality", js: "locality", typ: "" },
        { json: "mobile_number", js: "mobile_number", typ: "" },
        { json: "phone_number", js: "phone_number", typ: "" },
        { json: "phone_number_extension", js: "phone_number_extension", typ: "" },
        { json: "postal_code", js: "postal_code", typ: "" },
        { json: "sub_premise", js: "sub_premise", typ: null },
        { json: "thoroughfare", js: "thoroughfare", typ: "" },
    ], false),
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
