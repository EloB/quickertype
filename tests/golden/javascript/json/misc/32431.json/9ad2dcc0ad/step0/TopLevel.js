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
        { json: "bbox", js: "bbox", typ: a(3.14) },
        { json: "features", js: "features", typ: a(r("Feature")) },
        { json: "metadata", js: "metadata", typ: r("Metadata") },
        { json: "type", js: "type", typ: "" },
    ], false),
    "Feature": o([
        { json: "geometry", js: "geometry", typ: r("Geometry") },
        { json: "id", js: "id", typ: "" },
        { json: "properties", js: "properties", typ: r("Properties") },
        { json: "type", js: "type", typ: r("FeatureType") },
    ], false),
    "Geometry": o([
        { json: "coordinates", js: "coordinates", typ: a(3.14) },
        { json: "type", js: "type", typ: r("GeometryType") },
    ], false),
    "Properties": o([
        { json: "alert", js: "alert", typ: null },
        { json: "cdi", js: "cdi", typ: null },
        { json: "code", js: "code", typ: "" },
        { json: "detail", js: "detail", typ: "" },
        { json: "dmin", js: "dmin", typ: u(3.14, null) },
        { json: "felt", js: "felt", typ: null },
        { json: "gap", js: "gap", typ: u(i(0), null) },
        { json: "ids", js: "ids", typ: "" },
        { json: "mag", js: "mag", typ: 3.14 },
        { json: "magType", js: "magType", typ: r("MagType") },
        { json: "mmi", js: "mmi", typ: null },
        { json: "net", js: "net", typ: "" },
        { json: "nst", js: "nst", typ: u(i(0), null) },
        { json: "place", js: "place", typ: "" },
        { json: "rms", js: "rms", typ: 3.14 },
        { json: "sig", js: "sig", typ: i(0) },
        { json: "sources", js: "sources", typ: "" },
        { json: "status", js: "status", typ: r("Status") },
        { json: "time", js: "time", typ: i(0) },
        { json: "title", js: "title", typ: "" },
        { json: "tsunami", js: "tsunami", typ: i(0) },
        { json: "type", js: "type", typ: r("PropertiesType") },
        { json: "types", js: "types", typ: "" },
        { json: "tz", js: "tz", typ: i(0) },
        { json: "updated", js: "updated", typ: i(0) },
        { json: "url", js: "url", typ: "" },
    ], false),
    "Metadata": o([
        { json: "api", js: "api", typ: "" },
        { json: "count", js: "count", typ: i(0) },
        { json: "generated", js: "generated", typ: i(0) },
        { json: "status", js: "status", typ: i(0) },
        { json: "title", js: "title", typ: "" },
        { json: "url", js: "url", typ: "" },
    ], false),
    "GeometryType": [
        "Point",
    ],
    "MagType": [
        "md",
        "ml",
        "mb",
    ],
    "Status": [
        "automatic",
        "reviewed",
    ],
    "PropertiesType": [
        "earthquake",
    ],
    "FeatureType": [
        "Feature",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
