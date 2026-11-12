// To parse this data:
//
//   const Convert = require("./TopLevel");
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
function toTopLevel(json) {
    return cast(JSON.parse(json), r("TopLevel"));
}

function topLevelToJson(value) {
    return JSON.stringify(uncast(value, r("TopLevel")), null, 2);
}

function invalidValue(typ, val, key, parent = '') {
    const prettyTyp = prettyTypeName(typ);
    const parentText = parent ? ` on ${parent}` : '';
    const keyText = key ? ` for key "${key}"` : '';
    throw Error(`Invalid value${keyText}${parentText}. Expected ${prettyTyp} but got ${JSON.stringify(val)}`);
}

function prettyTypeName(typ) {
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

function jsonToJSProps(typ) {
    if (typ.jsonToJS === undefined) {
        const map = {};
        typ.props.forEach((p) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ) {
    if (typ.jsToJSON === undefined) {
        const map = {};
        typ.props.forEach((p) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val, typ, getProps, key = '', parent = '') {
    function transformPrimitive(typ, val) {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val, key, parent);
    }

    function transformUnion(typs, val) {
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

    function transformEnum(cases, val) {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases.map(a => { return l(a); }), val, key, parent);
    }

    function transformArray(typ, val) {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue(l("array"), val, key, parent);

        return val.map(el => transform(el, typ, getProps));
    }

    function transformDate(val) {
        if (val === null) {
            return null;
        }
        const d = new Date(val);
        if (isNaN(d.valueOf())) {
            return invalidValue(l("Date"), val, key, parent);
        }
        return d;
    }

    function transformObject(props, additional, val) {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue(l(ref || "object"), val, key, parent);
        }
        const result = {};
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
    let ref = undefined;
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

function cast(val, typ) {
    return transform(val, typ, jsonToJSProps);
}

function uncast(val, typ) {
    return transform(val, typ, jsToJSONProps);
}

function l(typ) {
    return { literal: typ };
}

function a(typ) {
    return { arrayItems: typ };
}

function i(typ) {
    return { integer: typ };
}

function p(pattern) {
    return { pattern };
}

function s(typ, min, max) {
    return { string: typ, min, max };
}

function n(typ, min, max) {
    return { number: typ, min, max };
}

function u(...typs) {
    return { unionMembers: typs };
}

function o(props, additional) {
    return { props, additional };
}

function m(additional) {
    const props = [];
    return { props, additional };
}

function r(name) {
    return { ref: name };
}

const typeMap = {
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
