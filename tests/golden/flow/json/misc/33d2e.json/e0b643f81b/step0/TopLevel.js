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
    laureates: Laureate[];
};

export type Laureate = {
    born:             BornUnion;
    bornCity?:        string;
    bornCountry?:     string;
    bornCountryCode?: string;
    died:             BornUnion;
    diedCity?:        string;
    diedCountry?:     string;
    diedCountryCode?: string;
    firstname?:       string;
    gender:           Gender;
    id:               string;
    prizes:           Prize[];
    surname?:         string;
};

export type BornUnion = Date | BornEnum;

export type BornEnum =
      "0000-00-00"
    | "1898-00-00"
    | "1943-00-00";

export type Gender =
      "male"
    | "female"
    | "org";

export type Prize = {
    affiliations:       AffiliationElement[];
    category?:          Category;
    motivation?:        string;
    overallMotivation?: string;
    share?:             string;
    year?:              string;
};

export type AffiliationElement = mixed[] | AffiliationClass;

export type AffiliationClass = {
    city?:    string;
    country?: string;
    name?:    string;
};

export type Category =
      "physics"
    | "chemistry"
    | "peace"
    | "medicine"
    | "literature"
    | "economics";

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
        { json: "laureates", js: "laureates", typ: a(r("Laureate")) },
    ], false),
    "Laureate": o([
        { json: "born", js: "born", typ: u(Date, r("BornEnum")) },
        { json: "bornCity", js: "bornCity", typ: u(undefined, "") },
        { json: "bornCountry", js: "bornCountry", typ: u(undefined, "") },
        { json: "bornCountryCode", js: "bornCountryCode", typ: u(undefined, "") },
        { json: "died", js: "died", typ: u(Date, r("BornEnum")) },
        { json: "diedCity", js: "diedCity", typ: u(undefined, "") },
        { json: "diedCountry", js: "diedCountry", typ: u(undefined, "") },
        { json: "diedCountryCode", js: "diedCountryCode", typ: u(undefined, "") },
        { json: "firstname", js: "firstname", typ: u(undefined, "") },
        { json: "gender", js: "gender", typ: r("Gender") },
        { json: "id", js: "id", typ: "" },
        { json: "prizes", js: "prizes", typ: a(r("Prize")) },
        { json: "surname", js: "surname", typ: u(undefined, "") },
    ], false),
    "Prize": o([
        { json: "affiliations", js: "affiliations", typ: a(u(a("any"), r("AffiliationClass"))) },
        { json: "category", js: "category", typ: u(undefined, r("Category")) },
        { json: "motivation", js: "motivation", typ: u(undefined, "") },
        { json: "overallMotivation", js: "overallMotivation", typ: u(undefined, "") },
        { json: "share", js: "share", typ: u(undefined, "") },
        { json: "year", js: "year", typ: u(undefined, "") },
    ], false),
    "AffiliationClass": o([
        { json: "city", js: "city", typ: u(undefined, "") },
        { json: "country", js: "country", typ: u(undefined, "") },
        { json: "name", js: "name", typ: u(undefined, "") },
    ], false),
    "BornEnum": [
        "0000-00-00",
        "1898-00-00",
        "1943-00-00",
    ],
    "Gender": [
        "male",
        "female",
        "org",
    ],
    "Category": [
        "physics",
        "chemistry",
        "peace",
        "medicine",
        "literature",
        "economics",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
