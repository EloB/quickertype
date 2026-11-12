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
    booster:            Booster[];
    border:             string;
    cards:              Card[];
    code:               string;
    gathererCode:       string;
    magicCardsInfoCode: string;
    mkm_id:             number;
    mkm_name:           string;
    name:               string;
    releaseDate:        Date;
    type:               string;
};

export type Booster =
      "rare"
    | "uncommon"
    | "common";

export type Card = {
    artist:         string;
    cmc:            number;
    colorIdentity?: ColorIdentity[];
    colors?:        Color[];
    flavor?:        string;
    id:             string;
    imageName:      string;
    layout:         Layout;
    legalities:     LegalityElement[];
    manaCost?:      string;
    mciNumber?:     string;
    multiverseid:   number;
    name:           string;
    originalText?:  string;
    originalType:   string;
    power?:         string;
    printings:      string[];
    rarity:         Rarity;
    reserved?:      boolean;
    rulings?:       Ruling[];
    subtypes?:      string[];
    supertypes?:    Supertype[];
    text?:          string;
    toughness?:     string;
    type:           string;
    types:          Type[];
    variations?:    number[];
};

export type ColorIdentity =
      "U"
    | "B"
    | "W"
    | "G"
    | "R";

export type Color =
      "Blue"
    | "Black"
    | "White"
    | "Green"
    | "Red";

export type Layout =
      "normal";

export type LegalityElement = {
    format:   Format;
    legality: LegalityEnum;
};

export type Format =
      "Commander"
    | "Legacy"
    | "Modern"
    | "Vintage"
    | "Time Spiral Block"
    | "Ravnica Block"
    | "Ice Age Block"
    | "Tempest Block"
    | "Onslaught Block"
    | "Masques Block"
    | "Mirage Block"
    | "Urza Block"
    | "Scars of Mirrodin Block"
    | "Mirrodin Block"
    | "Amonkhet Block"
    | "Battle for Zendikar Block"
    | "Innistrad Block"
    | "Invasion Block"
    | "Kaladesh Block"
    | "Kamigawa Block"
    | "Khans of Tarkir Block"
    | "Lorwyn-Shadowmoor Block"
    | "Odyssey Block"
    | "Return to Ravnica Block"
    | "Shadows over Innistrad Block"
    | "Shards of Alara Block"
    | "Standard"
    | "Theros Block"
    | "Un-Sets"
    | "Zendikar Block";

export type LegalityEnum =
      "Legal"
    | "Banned"
    | "Restricted";

export type Rarity =
      "Uncommon"
    | "Rare"
    | "Common"
    | "Basic Land";

export type Ruling = {
    date: Date;
    text: string;
};

export type Supertype =
      "Basic";

export type Type =
      "Creature"
    | "Instant"
    | "Enchantment"
    | "Artifact"
    | "Sorcery"
    | "Land";

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
        { json: "booster", js: "booster", typ: a(r("Booster")) },
        { json: "border", js: "border", typ: "" },
        { json: "cards", js: "cards", typ: a(r("Card")) },
        { json: "code", js: "code", typ: "" },
        { json: "gathererCode", js: "gathererCode", typ: "" },
        { json: "magicCardsInfoCode", js: "magicCardsInfoCode", typ: "" },
        { json: "mkm_id", js: "mkm_id", typ: i(0) },
        { json: "mkm_name", js: "mkm_name", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "releaseDate", js: "releaseDate", typ: Date },
        { json: "type", js: "type", typ: "" },
    ], false),
    "Card": o([
        { json: "artist", js: "artist", typ: "" },
        { json: "cmc", js: "cmc", typ: i(0) },
        { json: "colorIdentity", js: "colorIdentity", typ: u(undefined, a(r("ColorIdentity"))) },
        { json: "colors", js: "colors", typ: u(undefined, a(r("Color"))) },
        { json: "flavor", js: "flavor", typ: u(undefined, "") },
        { json: "id", js: "id", typ: "" },
        { json: "imageName", js: "imageName", typ: "" },
        { json: "layout", js: "layout", typ: r("Layout") },
        { json: "legalities", js: "legalities", typ: a(r("LegalityElement")) },
        { json: "manaCost", js: "manaCost", typ: u(undefined, "") },
        { json: "mciNumber", js: "mciNumber", typ: u(undefined, "") },
        { json: "multiverseid", js: "multiverseid", typ: i(0) },
        { json: "name", js: "name", typ: "" },
        { json: "originalText", js: "originalText", typ: u(undefined, "") },
        { json: "originalType", js: "originalType", typ: "" },
        { json: "power", js: "power", typ: u(undefined, "") },
        { json: "printings", js: "printings", typ: a("") },
        { json: "rarity", js: "rarity", typ: r("Rarity") },
        { json: "reserved", js: "reserved", typ: u(undefined, true) },
        { json: "rulings", js: "rulings", typ: u(undefined, a(r("Ruling"))) },
        { json: "subtypes", js: "subtypes", typ: u(undefined, a("")) },
        { json: "supertypes", js: "supertypes", typ: u(undefined, a(r("Supertype"))) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "toughness", js: "toughness", typ: u(undefined, "") },
        { json: "type", js: "type", typ: "" },
        { json: "types", js: "types", typ: a(r("Type")) },
        { json: "variations", js: "variations", typ: u(undefined, a(i(0))) },
    ], false),
    "LegalityElement": o([
        { json: "format", js: "format", typ: r("Format") },
        { json: "legality", js: "legality", typ: r("LegalityEnum") },
    ], false),
    "Ruling": o([
        { json: "date", js: "date", typ: Date },
        { json: "text", js: "text", typ: "" },
    ], false),
    "Booster": [
        "rare",
        "uncommon",
        "common",
    ],
    "ColorIdentity": [
        "U",
        "B",
        "W",
        "G",
        "R",
    ],
    "Color": [
        "Blue",
        "Black",
        "White",
        "Green",
        "Red",
    ],
    "Layout": [
        "normal",
    ],
    "Format": [
        "Commander",
        "Legacy",
        "Modern",
        "Vintage",
        "Time Spiral Block",
        "Ravnica Block",
        "Ice Age Block",
        "Tempest Block",
        "Onslaught Block",
        "Masques Block",
        "Mirage Block",
        "Urza Block",
        "Scars of Mirrodin Block",
        "Mirrodin Block",
        "Amonkhet Block",
        "Battle for Zendikar Block",
        "Innistrad Block",
        "Invasion Block",
        "Kaladesh Block",
        "Kamigawa Block",
        "Khans of Tarkir Block",
        "Lorwyn-Shadowmoor Block",
        "Odyssey Block",
        "Return to Ravnica Block",
        "Shadows over Innistrad Block",
        "Shards of Alara Block",
        "Standard",
        "Theros Block",
        "Un-Sets",
        "Zendikar Block",
    ],
    "LegalityEnum": [
        "Legal",
        "Banned",
        "Restricted",
    ],
    "Rarity": [
        "Uncommon",
        "Rare",
        "Common",
        "Basic Land",
    ],
    "Supertype": [
        "Basic",
    ],
    "Type": [
        "Creature",
        "Instant",
        "Enchantment",
        "Artifact",
        "Sorcery",
        "Land",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
