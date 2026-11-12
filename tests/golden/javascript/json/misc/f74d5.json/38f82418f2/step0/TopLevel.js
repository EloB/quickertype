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
        { json: "data", js: "data", typ: a(a(u(i(0), ""))) },
        { json: "meta", js: "meta", typ: r("Meta") },
    ], false),
    "Meta": o([
        { json: "view", js: "view", typ: r("View") },
    ], false),
    "View": o([
        { json: "averageRating", js: "averageRating", typ: i(0) },
        { json: "category", js: "category", typ: "" },
        { json: "columns", js: "columns", typ: a(r("Column")) },
        { json: "createdAt", js: "createdAt", typ: i(0) },
        { json: "displayType", js: "displayType", typ: "" },
        { json: "downloadCount", js: "downloadCount", typ: i(0) },
        { json: "flags", js: "flags", typ: a("") },
        { json: "grants", js: "grants", typ: a(r("Grant")) },
        { json: "hideFromCatalog", js: "hideFromCatalog", typ: true },
        { json: "hideFromDataJson", js: "hideFromDataJson", typ: true },
        { json: "id", js: "id", typ: "" },
        { json: "indexUpdatedAt", js: "indexUpdatedAt", typ: i(0) },
        { json: "license", js: "license", typ: r("License") },
        { json: "licenseId", js: "licenseId", typ: "" },
        { json: "locale", js: "locale", typ: "" },
        { json: "metadata", js: "metadata", typ: r("Metadata") },
        { json: "name", js: "name", typ: "" },
        { json: "newBackend", js: "newBackend", typ: true },
        { json: "numberOfComments", js: "numberOfComments", typ: i(0) },
        { json: "oid", js: "oid", typ: i(0) },
        { json: "owner", js: "owner", typ: r("Owner") },
        { json: "provenance", js: "provenance", typ: "" },
        { json: "publicationAppendEnabled", js: "publicationAppendEnabled", typ: true },
        { json: "publicationDate", js: "publicationDate", typ: i(0) },
        { json: "publicationGroup", js: "publicationGroup", typ: i(0) },
        { json: "publicationStage", js: "publicationStage", typ: "" },
        { json: "query", js: "query", typ: r("Query") },
        { json: "rights", js: "rights", typ: a("") },
        { json: "rowClass", js: "rowClass", typ: "" },
        { json: "rowsUpdatedAt", js: "rowsUpdatedAt", typ: i(0) },
        { json: "rowsUpdatedBy", js: "rowsUpdatedBy", typ: "" },
        { json: "tableAuthor", js: "tableAuthor", typ: r("Owner") },
        { json: "tableId", js: "tableId", typ: i(0) },
        { json: "totalTimesRated", js: "totalTimesRated", typ: i(0) },
        { json: "viewCount", js: "viewCount", typ: i(0) },
        { json: "viewLastModified", js: "viewLastModified", typ: i(0) },
        { json: "viewType", js: "viewType", typ: "" },
    ], false),
    "Column": o([
        { json: "cachedContents", js: "cachedContents", typ: u(undefined, r("CachedContents")) },
        { json: "dataTypeName", js: "dataTypeName", typ: r("TypeName") },
        { json: "fieldName", js: "fieldName", typ: "" },
        { json: "flags", js: "flags", typ: u(undefined, a("")) },
        { json: "format", js: "format", typ: r("Query") },
        { json: "id", js: "id", typ: i(0) },
        { json: "name", js: "name", typ: "" },
        { json: "position", js: "position", typ: i(0) },
        { json: "renderTypeName", js: "renderTypeName", typ: r("TypeName") },
        { json: "tableColumnId", js: "tableColumnId", typ: u(undefined, i(0)) },
        { json: "width", js: "width", typ: u(undefined, i(0)) },
    ], false),
    "CachedContents": o([
        { json: "average", js: "average", typ: u(undefined, "") },
        { json: "largest", js: "largest", typ: "" },
        { json: "non_null", js: "non_null", typ: i(0) },
        { json: "null", js: "null", typ: i(0) },
        { json: "smallest", js: "smallest", typ: "" },
        { json: "sum", js: "sum", typ: u(undefined, "") },
        { json: "top", js: "top", typ: a(r("Top")) },
    ], false),
    "Top": o([
        { json: "count", js: "count", typ: i(0) },
        { json: "item", js: "item", typ: "" },
    ], false),
    "Query": o([
    ], false),
    "Grant": o([
        { json: "flags", js: "flags", typ: a("") },
        { json: "inherited", js: "inherited", typ: true },
        { json: "type", js: "type", typ: "" },
    ], false),
    "License": o([
        { json: "name", js: "name", typ: "" },
    ], false),
    "Metadata": o([
        { json: "availableDisplayTypes", js: "availableDisplayTypes", typ: a("") },
        { json: "rdfClass", js: "rdfClass", typ: "" },
        { json: "rdfSubject", js: "rdfSubject", typ: "" },
        { json: "renderTypeConfig", js: "renderTypeConfig", typ: r("RenderTypeConfig") },
        { json: "rowIdentifier", js: "rowIdentifier", typ: "" },
    ], false),
    "RenderTypeConfig": o([
        { json: "visible", js: "visible", typ: r("Visible") },
    ], false),
    "Visible": o([
        { json: "table", js: "table", typ: true },
    ], false),
    "Owner": o([
        { json: "displayName", js: "displayName", typ: "" },
        { json: "id", js: "id", typ: "" },
        { json: "screenName", js: "screenName", typ: "" },
    ], false),
    "TypeName": [
        "meta_data",
        "number",
        "text",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
