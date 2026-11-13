// To parse this data:
//
//   import { Convert } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export type TopLevel = TopLevelUnion[];

export type TopLevelUnion = PurpleTopLevel[] | FluffyTopLevel | string;

export interface PurpleTopLevel {
    ALIENLEVEL:          number;
    BREED:               Breed;
    CHAR_DIMENSION:      number;
    CHAR_INSTANCE:       number;
    DEFENDER_RANK_TITLE: string;
    FIRSTNAME:           Firstname;
    HEADID:              number;
    LASTNAME:            Lastname;
    LEVELX:              number;
    NAME:                string;
    PROF:                string;
    PROF_TITLE:          string;
    PVPRATING:           number;
    PVPTITLE:            Pvptitle;
    RANK:                number;
    RANK_TITLE:          RankTitle;
    SEX:                 Sex;
}

export type Breed = "Atrox" | "Solitus" | "Opifex" | "Nano";

export type Firstname = "" | "Chi";

export type Lastname = "" | "Washko";

export type Pvptitle = "Freshman";

export type RankTitle = "President" | "Advisor" | "Veteran" | "Applicant";

export type Sex = "Neuter" | "Male" | "Female";

export interface FluffyTopLevel {
    ADVENTURERCOUNT: number;
    AGENTCOUNT:      number;
    ATROXCOUNT:      number;
    AVGLVL:          number;
    BTCOUNT:         number;
    DESCRIPTION:     string;
    DOCTORCOUNT:     number;
    ENFCOUNT:        number;
    ENGINEEERCOUNT:  number;
    FEMALECOUNT:     number;
    FIXERCOUNT:      number;
    GOVERNINGNAME:   string;
    HISTORY:         string;
    KEEPERCOUNT:     number;
    MACOUNT:         number;
    MALECOUNT:       number;
    MAXLVL:          number;
    METACOUNT:       number;
    MINLVL:          number;
    MONSTERCOUNT:    number;
    NAME:            string;
    NANOCOUNT:       number;
    NANORACECOUNT:   number;
    NEUTERCOUNT:     number;
    NUMMEMBERS:      number;
    OBJECTIVE:       string;
    OPIFEXCOUNT:     number;
    ORG_DIMENSION:   number;
    ORG_INSTANCE:    number;
    SHADECOUNT:      number;
    SIDE:            number;
    SIDE_NAME:       string;
    SOLIDERCOUNT:    number;
    SOLITUSCOUNT:    number;
    TRADERCOUNT:     number;
}

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export class Convert {
    public static toTopLevel(json: string): TopLevelUnion[] {
        return cast(JSON.parse(json), a(u(a(r("PurpleTopLevel")), r("FluffyTopLevel"), "")));
    }

    public static topLevelToJson(value: TopLevelUnion[]): string {
        return JSON.stringify(uncast(value, a(u(a(r("PurpleTopLevel")), r("FluffyTopLevel"), ""))), null, 2);
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
    "PurpleTopLevel": o([
        { json: "ALIENLEVEL", js: "ALIENLEVEL", typ: i(0) },
        { json: "BREED", js: "BREED", typ: r("Breed") },
        { json: "CHAR_DIMENSION", js: "CHAR_DIMENSION", typ: i(0) },
        { json: "CHAR_INSTANCE", js: "CHAR_INSTANCE", typ: i(0) },
        { json: "DEFENDER_RANK_TITLE", js: "DEFENDER_RANK_TITLE", typ: "" },
        { json: "FIRSTNAME", js: "FIRSTNAME", typ: r("Firstname") },
        { json: "HEADID", js: "HEADID", typ: i(0) },
        { json: "LASTNAME", js: "LASTNAME", typ: r("Lastname") },
        { json: "LEVELX", js: "LEVELX", typ: i(0) },
        { json: "NAME", js: "NAME", typ: "" },
        { json: "PROF", js: "PROF", typ: "" },
        { json: "PROF_TITLE", js: "PROF_TITLE", typ: "" },
        { json: "PVPRATING", js: "PVPRATING", typ: i(0) },
        { json: "PVPTITLE", js: "PVPTITLE", typ: r("Pvptitle") },
        { json: "RANK", js: "RANK", typ: i(0) },
        { json: "RANK_TITLE", js: "RANK_TITLE", typ: r("RankTitle") },
        { json: "SEX", js: "SEX", typ: r("Sex") },
    ], false),
    "FluffyTopLevel": o([
        { json: "ADVENTURERCOUNT", js: "ADVENTURERCOUNT", typ: i(0) },
        { json: "AGENTCOUNT", js: "AGENTCOUNT", typ: i(0) },
        { json: "ATROXCOUNT", js: "ATROXCOUNT", typ: i(0) },
        { json: "AVGLVL", js: "AVGLVL", typ: 3.14 },
        { json: "BTCOUNT", js: "BTCOUNT", typ: i(0) },
        { json: "DESCRIPTION", js: "DESCRIPTION", typ: "" },
        { json: "DOCTORCOUNT", js: "DOCTORCOUNT", typ: i(0) },
        { json: "ENFCOUNT", js: "ENFCOUNT", typ: i(0) },
        { json: "ENGINEEERCOUNT", js: "ENGINEEERCOUNT", typ: i(0) },
        { json: "FEMALECOUNT", js: "FEMALECOUNT", typ: i(0) },
        { json: "FIXERCOUNT", js: "FIXERCOUNT", typ: i(0) },
        { json: "GOVERNINGNAME", js: "GOVERNINGNAME", typ: "" },
        { json: "HISTORY", js: "HISTORY", typ: "" },
        { json: "KEEPERCOUNT", js: "KEEPERCOUNT", typ: i(0) },
        { json: "MACOUNT", js: "MACOUNT", typ: i(0) },
        { json: "MALECOUNT", js: "MALECOUNT", typ: i(0) },
        { json: "MAXLVL", js: "MAXLVL", typ: i(0) },
        { json: "METACOUNT", js: "METACOUNT", typ: i(0) },
        { json: "MINLVL", js: "MINLVL", typ: i(0) },
        { json: "MONSTERCOUNT", js: "MONSTERCOUNT", typ: i(0) },
        { json: "NAME", js: "NAME", typ: "" },
        { json: "NANOCOUNT", js: "NANOCOUNT", typ: i(0) },
        { json: "NANORACECOUNT", js: "NANORACECOUNT", typ: i(0) },
        { json: "NEUTERCOUNT", js: "NEUTERCOUNT", typ: i(0) },
        { json: "NUMMEMBERS", js: "NUMMEMBERS", typ: i(0) },
        { json: "OBJECTIVE", js: "OBJECTIVE", typ: "" },
        { json: "OPIFEXCOUNT", js: "OPIFEXCOUNT", typ: i(0) },
        { json: "ORG_DIMENSION", js: "ORG_DIMENSION", typ: i(0) },
        { json: "ORG_INSTANCE", js: "ORG_INSTANCE", typ: i(0) },
        { json: "SHADECOUNT", js: "SHADECOUNT", typ: i(0) },
        { json: "SIDE", js: "SIDE", typ: i(0) },
        { json: "SIDE_NAME", js: "SIDE_NAME", typ: "" },
        { json: "SOLIDERCOUNT", js: "SOLIDERCOUNT", typ: i(0) },
        { json: "SOLITUSCOUNT", js: "SOLITUSCOUNT", typ: i(0) },
        { json: "TRADERCOUNT", js: "TRADERCOUNT", typ: i(0) },
    ], false),
    "Breed": [
        "Atrox",
        "Solitus",
        "Opifex",
        "Nano",
    ],
    "Firstname": [
        "",
        "Chi",
    ],
    "Lastname": [
        "",
        "Washko",
    ],
    "Pvptitle": [
        "Freshman",
    ],
    "RankTitle": [
        "President",
        "Advisor",
        "Veteran",
        "Applicant",
    ],
    "Sex": [
        "Neuter",
        "Male",
        "Female",
    ],
};
