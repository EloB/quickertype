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
        { json: "version", js: "version", typ: u(undefined, p("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}$")) },
        { json: "fruits", js: "fruits", typ: u(undefined, a(r("Fruit"))) },
        { json: "vehicles", js: "vehicles", typ: u(undefined, a(r("Vehicle"))) },
    ], "any"),
    "Fruit": o([
        { json: "apple", js: "apple", typ: u(undefined, true) },
        { json: "berries", js: "berries", typ: u(undefined, a(r("Berry"))) },
        { json: "orange", js: "orange", typ: u(undefined, true) },
    ], "any"),
    "Berry": o([
        { json: "color", js: "color", typ: u(undefined, r("Color")) },
        { json: "name", js: "name", typ: u(undefined, s("", 1, undefined)) },
        { json: "shapes", js: "shapes", typ: u(undefined, a(r("Shape"))) },
    ], "any"),
    "Color": o([
        { json: "rgb", js: "rgb", typ: u(undefined, 3.14) },
    ], "any"),
    "Shape": o([
        { json: "geometry", js: "geometry", typ: u(undefined, r("Geometry")) },
        { json: "history", js: "history", typ: u(undefined, r("History")) },
    ], "any"),
    "Geometry": o([
        { json: "rectShape", js: "rectShape", typ: u(undefined, r("RectShape")) },
        { json: "circularShape", js: "circularShape", typ: u(undefined, a(r("CircularShape"))) },
    ], "any"),
    "CircularShape": o([
        { json: "shapeName", js: "shapeName", typ: u(undefined, "") },
    ], "any"),
    "RectShape": o([
        { json: "parts", js: "parts", typ: u(undefined, a(r("Part"))) },
    ], "any"),
    "Part": o([
        { json: "depth", js: "depth", typ: u(undefined, "") },
        { json: "length", js: "length", typ: u(undefined, "") },
        { json: "width", js: "width", typ: u(undefined, "") },
    ], "any"),
    "History": o([
        { json: "class", js: "class", typ: u(undefined, "") },
    ], "any"),
    "Vehicle": o([
        { json: "brand", js: "brand", typ: u(undefined, "") },
        { json: "id", js: "id", typ: u(undefined, s("", 1, undefined)) },
        { json: "speed", js: "speed", typ: u(undefined, r("Speed")) },
        { json: "subModule", js: "subModule", typ: u(undefined, true) },
        { json: "type", js: "type", typ: u(undefined, r("VehicleType")) },
        { json: "year", js: "year", typ: u(undefined, "") },
    ], "any"),
    "Speed": o([
        { json: "velocity", js: "velocity", typ: u(undefined, r("Limit")) },
    ], "any"),
    "Limit": o([
        { json: "maximum", js: "maximum", typ: u(undefined, 3.14) },
        { json: "minimum", js: "minimum", typ: u(undefined, 3.14) },
    ], "any"),
    "VehicleType": o([
        { json: "name", js: "name", typ: u(undefined, r("Name")) },
        { json: "width", js: "width", typ: u(undefined, r("Axis")) },
        { json: "length", js: "length", typ: u(undefined, r("Axis")) },
    ], "any"),
    "Axis": [
        "X",
        "Y",
        "Z",
        "YZ",
        "ZX",
        "XY",
    ],
    "Name": [
        "truck",
        "bus",
        "car",
        "van",
        "train",
        "Bike",
        "Aeroplane",
        "Jeep",
        "Trolley",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
