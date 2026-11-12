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

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
