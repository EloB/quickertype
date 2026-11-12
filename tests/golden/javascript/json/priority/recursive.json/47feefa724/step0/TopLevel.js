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
        { json: "category", js: "category", typ: r("Category") },
        { json: "details", js: "details", typ: r("Details") },
        { json: "match", js: "match", typ: "" },
        { json: "page", js: "page", typ: i(0) },
        { json: "product", js: "product", typ: a(r("ProductElement")) },
        { json: "schk", js: "schk", typ: true },
        { json: "totallooseoffers", js: "totallooseoffers", typ: i(0) },
        { json: "totalpages", js: "totalpages", typ: i(0) },
        { json: "totalresultsavailable", js: "totalresultsavailable", typ: i(0) },
        { json: "totalresultsreturned", js: "totalresultsreturned", typ: i(0) },
    ], false),
    "Category": o([
        { json: "concatenatecategoryname", js: "concatenatecategoryname", typ: true },
        { json: "hasoffer", js: "hasoffer", typ: true },
        { json: "id", js: "id", typ: i(0) },
        { json: "isfinal", js: "isfinal", typ: true },
        { json: "links", js: "links", typ: a(r("LinkElement")) },
        { json: "name", js: "name", typ: "" },
        { json: "parentcategoryid", js: "parentcategoryid", typ: i(0) },
        { json: "thumbnail", js: "thumbnail", typ: r("CategoryThumbnail") },
    ], false),
    "LinkElement": o([
        { json: "link", js: "link", typ: r("LinkLink") },
    ], false),
    "LinkLink": o([
        { json: "type", js: "type", typ: "" },
        { json: "url", js: "url", typ: "" },
    ], false),
    "CategoryThumbnail": o([
        { json: "url", js: "url", typ: "" },
    ], false),
    "Details": o([
        { json: "applicationid", js: "applicationid", typ: "" },
        { json: "applicationversion", js: "applicationversion", typ: "" },
        { json: "code", js: "code", typ: i(0) },
        { json: "date", js: "date", typ: r("Date") },
        { json: "elapsedtime", js: "elapsedtime", typ: i(0) },
        { json: "message", js: "message", typ: "" },
        { json: "status", js: "status", typ: "" },
    ], false),
    "Date": o([
        { json: "day", js: "day", typ: i(0) },
        { json: "eonandyear", js: "eonandyear", typ: r("Eonandyear") },
        { json: "hour", js: "hour", typ: i(0) },
        { json: "millisecond", js: "millisecond", typ: i(0) },
        { json: "minute", js: "minute", typ: i(0) },
        { json: "month", js: "month", typ: i(0) },
        { json: "second", js: "second", typ: i(0) },
        { json: "timezone", js: "timezone", typ: i(0) },
        { json: "valid", js: "valid", typ: true },
        { json: "xmlschematype", js: "xmlschematype", typ: r("Xmlschematype") },
        { json: "year", js: "year", typ: i(0) },
    ], false),
    "Eonandyear": o([
        { json: "lowestsetbit", js: "lowestsetbit", typ: i(0) },
    ], false),
    "Xmlschematype": o([
        { json: "localpart", js: "localpart", typ: "" },
        { json: "namespaceuri", js: "namespaceuri", typ: "" },
        { json: "prefix", js: "prefix", typ: "" },
    ], false),
    "ProductElement": o([
        { json: "product", js: "product", typ: r("ProductProduct") },
    ], false),
    "ProductProduct": o([
        { json: "categoryid", js: "categoryid", typ: i(0) },
        { json: "currency", js: "currency", typ: r("Currency") },
        { json: "eco", js: "eco", typ: true },
        { json: "fulldescription", js: "fulldescription", typ: true },
        { json: "hasmetasearch", js: "hasmetasearch", typ: true },
        { json: "id", js: "id", typ: i(0) },
        { json: "links", js: "links", typ: a(r("LinkElement")) },
        { json: "numoffers", js: "numoffers", typ: i(0) },
        { json: "pricemax", js: "pricemax", typ: "" },
        { json: "pricemin", js: "pricemin", typ: "" },
        { json: "productname", js: "productname", typ: "" },
        { json: "quantity", js: "quantity", typ: i(0) },
        { json: "rating", js: "rating", typ: r("Rating") },
        { json: "specification", js: "specification", typ: r("Specification") },
        { json: "thumbnail", js: "thumbnail", typ: r("FormatsClass") },
        { json: "totalsellers", js: "totalsellers", typ: i(0) },
    ], false),
    "Currency": o([
        { json: "abbreviation", js: "abbreviation", typ: "" },
    ], false),
    "Rating": o([
        { json: "useraveragerating", js: "useraveragerating", typ: r("Useraveragerating") },
    ], false),
    "Useraveragerating": o([
        { json: "links", js: "links", typ: a(r("LinkElement")) },
        { json: "numcomments", js: "numcomments", typ: i(0) },
        { json: "rating", js: "rating", typ: "" },
    ], false),
    "Specification": o([
        { json: "links", js: "links", typ: a(r("LinkElement")) },
    ], false),
    "Format": o([
        { json: "formats", js: "formats", typ: r("FormatsClass") },
    ], false),
    "FormatsClass": o([
        { json: "formats", js: "formats", typ: u(undefined, a(r("Format"))) },
        { json: "height", js: "height", typ: i(0) },
        { json: "url", js: "url", typ: "" },
        { json: "width", js: "width", typ: i(0) },
    ], false),
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
