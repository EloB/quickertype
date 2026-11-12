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
        { json: "basePath", js: "basePath", typ: "" },
        { json: "definitions", js: "definitions", typ: r("Definitions") },
        { json: "host", js: "host", typ: "" },
        { json: "info", js: "info", typ: r("Info") },
        { json: "paths", js: "paths", typ: r("Paths") },
        { json: "produces", js: "produces", typ: a("") },
        { json: "schemes", js: "schemes", typ: a("") },
        { json: "swagger", js: "swagger", typ: "" },
    ], false),
    "Definitions": o([
        { json: "Article", js: "Article", typ: r("Article") },
        { json: "Center", js: "Center", typ: r("Article") },
        { json: "DeMinimis", js: "DeMinimis", typ: r("DeMinimis") },
        { json: "Event", js: "Event", typ: r("Article") },
        { json: "FAQ", js: "FAQ", typ: r("FAQ") },
        { json: "Lead", js: "Lead", typ: r("Article") },
        { json: "List", js: "List", typ: r("Article") },
        { json: "MarketIntelligence", js: "MarketIntelligence", typ: r("Article") },
        { json: "Office", js: "Office", typ: r("Article") },
        { json: "Provider", js: "Provider", typ: r("Article") },
        { json: "Rate", js: "Rate", typ: r("Article") },
        { json: "Report", js: "Report", typ: r("Report") },
        { json: "Taxonomy", js: "Taxonomy", typ: r("Taxonomy") },
    ], false),
    "Article": o([
        { json: "properties", js: "properties", typ: m(r("Property")) },
    ], false),
    "Property": o([
        { json: "description", js: "description", typ: "" },
        { json: "type", js: "type", typ: r("FormatEnum") },
    ], false),
    "DeMinimis": o([
        { json: "properties", js: "properties", typ: r("DeMinimisProperties") },
    ], false),
    "DeMinimisProperties": o([
        { json: "countries", js: "countries", typ: r("Property") },
        { json: "country", js: "country", typ: r("Property") },
        { json: "de_minimis_currency", js: "de_minimis_currency", typ: r("Property") },
        { json: "de_minimis_value", js: "de_minimis_value", typ: r("Property") },
        { json: "notes", js: "notes", typ: r("Property") },
        { json: "vat_amount", js: "vat_amount", typ: r("Property") },
        { json: "vat_currency", js: "vat_currency", typ: r("Property") },
    ], false),
    "FAQ": o([
        { json: "properties", js: "properties", typ: r("FAQProperties") },
    ], false),
    "FAQProperties": o([
        { json: "answer", js: "answer", typ: r("Property") },
        { json: "countries", js: "countries", typ: r("Property") },
        { json: "first_published_date", js: "first_published_date", typ: r("Property") },
        { json: "id", js: "id", typ: r("Property") },
        { json: "industries", js: "industries", typ: r("Property") },
        { json: "last_published_date", js: "last_published_date", typ: r("Property") },
        { json: "question", js: "question", typ: r("Property") },
        { json: "topics", js: "topics", typ: r("Property") },
        { json: "trade_regions", js: "trade_regions", typ: r("Property") },
        { json: "url", js: "url", typ: r("Property") },
        { json: "world_regions", js: "world_regions", typ: r("Property") },
    ], false),
    "Report": o([
        { json: "properties", js: "properties", typ: r("ReportProperties") },
    ], false),
    "ReportProperties": o([
        { json: "countries", js: "countries", typ: r("Property") },
        { json: "description", js: "description", typ: r("Property") },
        { json: "expiration_date", js: "expiration_date", typ: r("Property") },
        { json: "id", js: "id", typ: r("Property") },
        { json: "industries", js: "industries", typ: r("Property") },
        { json: "ita_industries", js: "ita_industries", typ: r("Property") },
        { json: "report_type", js: "report_type", typ: r("Property") },
        { json: "title", js: "title", typ: r("Property") },
        { json: "url", js: "url", typ: r("Property") },
    ], false),
    "Taxonomy": o([
        { json: "properties", js: "properties", typ: r("TaxonomyProperties") },
    ], false),
    "TaxonomyProperties": o([
        { json: "annotations", js: "annotations", typ: r("Property") },
        { json: "datatype_properties", js: "datatype_properties", typ: r("Property") },
        { json: "id", js: "id", typ: r("Property") },
        { json: "label", js: "label", typ: r("Property") },
        { json: "sub_class_of", js: "sub_class_of", typ: r("Property") },
        { json: "type", js: "type", typ: r("Property") },
    ], false),
    "Info": o([
        { json: "description", js: "description", typ: "" },
        { json: "title", js: "title", typ: "" },
        { json: "version", js: "version", typ: "" },
    ], false),
    "Paths": o([
        { json: "/business_service_providers/search", js: "/business_service_providers/search", typ: r("BusinessServiceProvidersSearchClass") },
        { json: "/consolidated_screening_list/search", js: "/consolidated_screening_list/search", typ: r("ConsolidatedScreeningListSearchClass") },
        { json: "/de_minimis/search", js: "/de_minimis/search", typ: r("ConsolidatedScreeningListSearchClass") },
        { json: "/ita_faqs/search", js: "/ita_faqs/search", typ: r("ConsolidatedScreeningListSearchClass") },
        { json: "/ita_office_locations/search", js: "/ita_office_locations/search", typ: r("ConsolidatedScreeningListSearchClass") },
        { json: "/ita_taxonomies/search", js: "/ita_taxonomies/search", typ: r("BusinessServiceProvidersSearchClass") },
        { json: "/ita_zipcode_to_post/search", js: "/ita_zipcode_to_post/search", typ: r("BusinessServiceProvidersSearchClass") },
        { json: "/market_intelligence/search", js: "/market_intelligence/search", typ: r("ConsolidatedScreeningListSearchClass") },
        { json: "/market_research_library/search", js: "/market_research_library/search", typ: r("ConsolidatedScreeningListSearchClass") },
        { json: "/tariff_rates/search", js: "/tariff_rates/search", typ: r("ConsolidatedScreeningListSearchClass") },
        { json: "/trade_articles/search", js: "/trade_articles/search", typ: r("ConsolidatedScreeningListSearchClass") },
        { json: "/trade_events/search", js: "/trade_events/search", typ: r("ConsolidatedScreeningListSearchClass") },
        { json: "/trade_leads/search", js: "/trade_leads/search", typ: r("ConsolidatedScreeningListSearchClass") },
    ], false),
    "BusinessServiceProvidersSearchClass": o([
        { json: "get", js: "get", typ: r("BusinessServiceProvidersSearchGet") },
    ], false),
    "BusinessServiceProvidersSearchGet": o([
        { json: "description", js: "description", typ: "" },
        { json: "parameters", js: "parameters", typ: a(r("Parameter")) },
        { json: "responses", js: "responses", typ: r("PurpleResponses") },
        { json: "summary", js: "summary", typ: "" },
        { json: "tags", js: "tags", typ: a("") },
    ], false),
    "Parameter": o([
        { json: "description", js: "description", typ: "" },
        { json: "format", js: "format", typ: r("FormatEnum") },
        { json: "in", js: "in", typ: r("In") },
        { json: "name", js: "name", typ: "" },
        { json: "required", js: "required", typ: true },
        { json: "type", js: "type", typ: r("FormatEnum") },
    ], false),
    "PurpleResponses": o([
        { json: "200", js: "200", typ: r("Purple200") },
    ], false),
    "Purple200": o([
        { json: "description", js: "description", typ: "" },
        { json: "schema", js: "schema", typ: r("ItemsClass") },
    ], false),
    "ItemsClass": o([
        { json: "$ref", js: "$ref", typ: "" },
    ], false),
    "ConsolidatedScreeningListSearchClass": o([
        { json: "get", js: "get", typ: r("ConsolidatedScreeningListSearchGet") },
    ], false),
    "ConsolidatedScreeningListSearchGet": o([
        { json: "description", js: "description", typ: "" },
        { json: "parameters", js: "parameters", typ: a(r("Parameter")) },
        { json: "responses", js: "responses", typ: r("FluffyResponses") },
        { json: "summary", js: "summary", typ: "" },
        { json: "tags", js: "tags", typ: a("") },
    ], false),
    "FluffyResponses": o([
        { json: "200", js: "200", typ: r("Fluffy200") },
    ], false),
    "Fluffy200": o([
        { json: "description", js: "description", typ: "" },
        { json: "schema", js: "schema", typ: r("PurpleSchema") },
    ], false),
    "PurpleSchema": o([
        { json: "items", js: "items", typ: r("ItemsClass") },
        { json: "type", js: "type", typ: r("SchemaType") },
    ], false),
    "FormatEnum": [
        "string",
    ],
    "In": [
        "query",
    ],
    "SchemaType": [
        "array",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
