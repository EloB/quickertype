// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface TopLevel {
    meta:    Meta;
    objects: Object[];
}

export interface Meta {
    limit:       number;
    offset:      number;
    total_count: number;
}

export interface Object {
    caucus:              Party | null;
    congress_numbers:    number[];
    current:             boolean;
    description:         string;
    district:            null;
    enddate:             Date;
    extra:               Extra;
    id:                  number;
    leadership_title:    null | string;
    party:               Party;
    person:              Person;
    phone:               string;
    role_type:           RoleType;
    role_type_label:     RoleTypeLabel;
    senator_class:       SenatorClass;
    senator_class_label: SenatorClassLabel;
    senator_rank:        SenatorRank;
    senator_rank_label:  SenatorRankLabel;
    startdate:           Date;
    state:               string;
    title:               Title;
    title_long:          RoleTypeLabel;
    website:             string;
}

export type Party = "Republican" | "Democrat" | "Independent";

export interface Extra {
    address:      string;
    contact_form: string;
    fax?:         string;
    office:       string;
    rss_url?:     string;
}

export interface Person {
    bioguideid:   string;
    birthday:     Date;
    cspanid:      number;
    firstname:    string;
    gender:       Gender;
    gender_label: GenderLabel;
    id:           number;
    lastname:     string;
    link:         string;
    middlename:   string;
    name:         string;
    namemod:      Namemod;
    nickname:     string;
    osid:         string;
    pvsid:        string;
    sortname:     string;
    twitterid:    null | string;
    youtubeid:    null | string;
}

export type Gender = "male" | "female";

export type GenderLabel = "Male" | "Female";

export type Namemod = "" | "III" | "Jr.";

export type RoleType = "senator";

export type RoleTypeLabel = "Senator";

export type SenatorClass = "class2" | "class1" | "class3";

export type SenatorClassLabel = "Class 2" | "Class 1" | "Class 3";

export type SenatorRank = "senior" | "junior";

export type SenatorRankLabel = "Senior" | "Junior";

export type Title = "Sen.";

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
        { json: "meta", js: "meta", typ: r("Meta") },
        { json: "objects", js: "objects", typ: a(r("Object")) },
    ], false),
    "Meta": o([
        { json: "limit", js: "limit", typ: i(0) },
        { json: "offset", js: "offset", typ: i(0) },
        { json: "total_count", js: "total_count", typ: i(0) },
    ], false),
    "Object": o([
        { json: "caucus", js: "caucus", typ: u(r("Party"), null) },
        { json: "congress_numbers", js: "congress_numbers", typ: a(i(0)) },
        { json: "current", js: "current", typ: true },
        { json: "description", js: "description", typ: "" },
        { json: "district", js: "district", typ: null },
        { json: "enddate", js: "enddate", typ: Date },
        { json: "extra", js: "extra", typ: r("Extra") },
        { json: "id", js: "id", typ: i(0) },
        { json: "leadership_title", js: "leadership_title", typ: u(null, "") },
        { json: "party", js: "party", typ: r("Party") },
        { json: "person", js: "person", typ: r("Person") },
        { json: "phone", js: "phone", typ: "" },
        { json: "role_type", js: "role_type", typ: r("RoleType") },
        { json: "role_type_label", js: "role_type_label", typ: r("RoleTypeLabel") },
        { json: "senator_class", js: "senator_class", typ: r("SenatorClass") },
        { json: "senator_class_label", js: "senator_class_label", typ: r("SenatorClassLabel") },
        { json: "senator_rank", js: "senator_rank", typ: r("SenatorRank") },
        { json: "senator_rank_label", js: "senator_rank_label", typ: r("SenatorRankLabel") },
        { json: "startdate", js: "startdate", typ: Date },
        { json: "state", js: "state", typ: "" },
        { json: "title", js: "title", typ: r("Title") },
        { json: "title_long", js: "title_long", typ: r("RoleTypeLabel") },
        { json: "website", js: "website", typ: "" },
    ], false),
    "Extra": o([
        { json: "address", js: "address", typ: "" },
        { json: "contact_form", js: "contact_form", typ: "" },
        { json: "fax", js: "fax", typ: u(undefined, "") },
        { json: "office", js: "office", typ: "" },
        { json: "rss_url", js: "rss_url", typ: u(undefined, "") },
    ], false),
    "Person": o([
        { json: "bioguideid", js: "bioguideid", typ: "" },
        { json: "birthday", js: "birthday", typ: Date },
        { json: "cspanid", js: "cspanid", typ: i(0) },
        { json: "firstname", js: "firstname", typ: "" },
        { json: "gender", js: "gender", typ: r("Gender") },
        { json: "gender_label", js: "gender_label", typ: r("GenderLabel") },
        { json: "id", js: "id", typ: i(0) },
        { json: "lastname", js: "lastname", typ: "" },
        { json: "link", js: "link", typ: "" },
        { json: "middlename", js: "middlename", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "namemod", js: "namemod", typ: r("Namemod") },
        { json: "nickname", js: "nickname", typ: "" },
        { json: "osid", js: "osid", typ: "" },
        { json: "pvsid", js: "pvsid", typ: "" },
        { json: "sortname", js: "sortname", typ: "" },
        { json: "twitterid", js: "twitterid", typ: u(null, "") },
        { json: "youtubeid", js: "youtubeid", typ: u(null, "") },
    ], false),
    "Party": [
        "Republican",
        "Democrat",
        "Independent",
    ],
    "Gender": [
        "male",
        "female",
    ],
    "GenderLabel": [
        "Male",
        "Female",
    ],
    "Namemod": [
        "",
        "III",
        "Jr.",
    ],
    "RoleType": [
        "senator",
    ],
    "RoleTypeLabel": [
        "Senator",
    ],
    "SenatorClass": [
        "class2",
        "class1",
        "class3",
    ],
    "SenatorClassLabel": [
        "Class 2",
        "Class 1",
        "Class 3",
    ],
    "SenatorRank": [
        "senior",
        "junior",
    ],
    "SenatorRankLabel": [
        "Senior",
        "Junior",
    ],
    "Title": [
        "Sen.",
    ],
};
