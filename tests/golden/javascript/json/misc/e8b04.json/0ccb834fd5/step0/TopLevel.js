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
    return cast(JSON.parse(json), a(r("TopLevelElement")));
}

function topLevelToJson(value) {
    return JSON.stringify(uncast(value, a(r("TopLevelElement"))), null, 2);
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
    "TopLevelElement": o([
        { json: "averageRating", js: "averageRating", typ: i(0) },
        { json: "category", js: "category", typ: u(undefined, "") },
        { json: "createdAt", js: "createdAt", typ: i(0) },
        { json: "description", js: "description", typ: u(undefined, "") },
        { json: "displayType", js: "displayType", typ: u(undefined, r("DisplayType")) },
        { json: "downloadCount", js: "downloadCount", typ: i(0) },
        { json: "flags", js: "flags", typ: u(undefined, a(r("TopLevelFlag"))) },
        { json: "grants", js: "grants", typ: a(r("Grant")) },
        { json: "hideFromCatalog", js: "hideFromCatalog", typ: true },
        { json: "hideFromDataJson", js: "hideFromDataJson", typ: true },
        { json: "id", js: "id", typ: "" },
        { json: "indexUpdatedAt", js: "indexUpdatedAt", typ: u(undefined, i(0)) },
        { json: "locale", js: "locale", typ: "" },
        { json: "metadata", js: "metadata", typ: r("TopLevelMetadata") },
        { json: "moderationStatus", js: "moderationStatus", typ: u(undefined, true) },
        { json: "modifyingViewUid", js: "modifyingViewUid", typ: u(undefined, r("ModifyingViewUid")) },
        { json: "name", js: "name", typ: "" },
        { json: "newBackend", js: "newBackend", typ: true },
        { json: "numberOfComments", js: "numberOfComments", typ: i(0) },
        { json: "oid", js: "oid", typ: i(0) },
        { json: "owner", js: "owner", typ: r("Owner") },
        { json: "provenance", js: "provenance", typ: r("Provenance") },
        { json: "publicationAppendEnabled", js: "publicationAppendEnabled", typ: true },
        { json: "publicationDate", js: "publicationDate", typ: u(undefined, i(0)) },
        { json: "publicationGroup", js: "publicationGroup", typ: i(0) },
        { json: "publicationStage", js: "publicationStage", typ: r("PublicationStage") },
        { json: "ratings", js: "ratings", typ: u(undefined, r("Ratings")) },
        { json: "resourceName", js: "resourceName", typ: u(undefined, "") },
        { json: "rights", js: "rights", typ: a(r("Right")) },
        { json: "rowClass", js: "rowClass", typ: u(undefined, "") },
        { json: "rowIdentifierColumnId", js: "rowIdentifierColumnId", typ: u(undefined, i(0)) },
        { json: "rowsUpdatedAt", js: "rowsUpdatedAt", typ: u(undefined, i(0)) },
        { json: "rowsUpdatedBy", js: "rowsUpdatedBy", typ: u(undefined, r("RowsUpdatedBy")) },
        { json: "tableAuthor", js: "tableAuthor", typ: r("TableAuthor") },
        { json: "tableId", js: "tableId", typ: i(0) },
        { json: "tags", js: "tags", typ: u(undefined, a("")) },
        { json: "totalTimesRated", js: "totalTimesRated", typ: i(0) },
        { json: "viewCount", js: "viewCount", typ: i(0) },
        { json: "viewLastModified", js: "viewLastModified", typ: i(0) },
        { json: "viewType", js: "viewType", typ: r("ViewType") },
    ], false),
    "Grant": o([
        { json: "flags", js: "flags", typ: a(r("GrantFlag")) },
        { json: "inherited", js: "inherited", typ: true },
        { json: "type", js: "type", typ: r("GrantType") },
    ], false),
    "TopLevelMetadata": o([
        { json: "availableDisplayTypes", js: "availableDisplayTypes", typ: u(undefined, a(r("DisplayType"))) },
        { json: "custom_fields", js: "custom_fields", typ: u(undefined, r("CustomFields")) },
        { json: "jsonQuery", js: "jsonQuery", typ: u(undefined, r("JSONQuery")) },
        { json: "rdfClass", js: "rdfClass", typ: u(undefined, "") },
        { json: "rdfSubject", js: "rdfSubject", typ: u(undefined, "") },
        { json: "renderTypeConfig", js: "renderTypeConfig", typ: u(undefined, r("MetadataRenderTypeConfig")) },
        { json: "richRendererConfigs", js: "richRendererConfigs", typ: u(undefined, r("RichRendererConfigs")) },
        { json: "rowIdentifier", js: "rowIdentifier", typ: u(undefined, "") },
        { json: "rowLabel", js: "rowLabel", typ: u(undefined, "") },
        { json: "v1_archived_properties", js: "v1_archived_properties", typ: u(undefined, r("V1ArchivedProperties")) },
    ], false),
    "CustomFields": o([
        { json: "TEST", js: "TEST", typ: r("Test") },
    ], false),
    "Test": o([
        { json: "CFPB1", js: "CFPB1", typ: "" },
    ], false),
    "JSONQuery": o([
        { json: "group", js: "group", typ: u(undefined, a(r("Group"))) },
        { json: "order", js: "order", typ: u(undefined, a(r("Order"))) },
        { json: "select", js: "select", typ: u(undefined, a(r("Select"))) },
        { json: "where", js: "where", typ: u(undefined, r("Where")) },
    ], false),
    "Group": o([
        { json: "columnFieldName", js: "columnFieldName", typ: "" },
    ], false),
    "Order": o([
        { json: "ascending", js: "ascending", typ: true },
        { json: "columnFieldName", js: "columnFieldName", typ: r("OrderColumnFieldName") },
    ], false),
    "Select": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, "") },
        { json: "columnFieldName", js: "columnFieldName", typ: "" },
    ], false),
    "Where": o([
        { json: "children", js: "children", typ: u(undefined, a(r("Child"))) },
        { json: "columnFieldName", js: "columnFieldName", typ: u(undefined, r("ChildColumnFieldName")) },
        { json: "metadata", js: "metadata", typ: u(undefined, r("ChildMetadata")) },
        { json: "operator", js: "operator", typ: r("WhereOperator") },
        { json: "value", js: "value", typ: u(undefined, "") },
    ], false),
    "Child": o([
        { json: "columnFieldName", js: "columnFieldName", typ: r("ChildColumnFieldName") },
        { json: "metadata", js: "metadata", typ: u(undefined, r("ChildMetadata")) },
        { json: "operator", js: "operator", typ: r("ChildOperator") },
        { json: "value", js: "value", typ: u(undefined, "") },
    ], false),
    "ChildMetadata": o([
        { json: "customValues", js: "customValues", typ: u(undefined, a("")) },
        { json: "freeform", js: "freeform", typ: u(undefined, true) },
        { json: "includeAuto", js: "includeAuto", typ: u(undefined, i(0)) },
        { json: "operator", js: "operator", typ: u(undefined, r("MetadataOperator")) },
        { json: "tableColumnId", js: "tableColumnId", typ: u(undefined, r("TableColumnID")) },
        { json: "unifiedVersion", js: "unifiedVersion", typ: u(undefined, i(0)) },
    ], false),
    "TableColumnID": o([
        { json: "2819740", js: "2819740", typ: i(0) },
    ], false),
    "MetadataRenderTypeConfig": o([
        { json: "visible", js: "visible", typ: r("PurpleVisible") },
    ], false),
    "PurpleVisible": o([
        { json: "fatrow", js: "fatrow", typ: u(undefined, true) },
        { json: "table", js: "table", typ: u(undefined, true) },
    ], false),
    "RichRendererConfigs": o([
        { json: "fatRow", js: "fatRow", typ: r("FatRow") },
    ], false),
    "FatRow": o([
        { json: "columns", js: "columns", typ: a(r("Column")) },
    ], false),
    "Column": o([
        { json: "rows", js: "rows", typ: a(r("Row")) },
        { json: "styles", js: "styles", typ: r("Styles") },
    ], false),
    "Row": o([
        { json: "fields", js: "fields", typ: a(r("Field")) },
    ], false),
    "Field": o([
        { json: "tableColumnId", js: "tableColumnId", typ: i(0) },
        { json: "type", js: "type", typ: r("FieldType") },
    ], false),
    "Styles": o([
        { json: "width", js: "width", typ: r("Width") },
    ], false),
    "V1ArchivedProperties": o([
        { json: "accessPoints", js: "accessPoints", typ: r("AccessPoints") },
        { json: "blist_id", js: "blist_id", typ: "" },
        { json: "renderTypeConfig", js: "renderTypeConfig", typ: r("V1ArchivedPropertiesRenderTypeConfig") },
    ], false),
    "AccessPoints": o([
        { json: "new_view", js: "new_view", typ: "" },
    ], false),
    "V1ArchivedPropertiesRenderTypeConfig": o([
        { json: "visible", js: "visible", typ: r("FluffyVisible") },
    ], false),
    "FluffyVisible": o([
        { json: "href", js: "href", typ: true },
    ], false),
    "Owner": o([
        { json: "displayName", js: "displayName", typ: "" },
        { json: "flags", js: "flags", typ: u(undefined, a("")) },
        { json: "id", js: "id", typ: "" },
        { json: "lastNotificationSeenAt", js: "lastNotificationSeenAt", typ: u(undefined, i(0)) },
        { json: "profileImageUrlLarge", js: "profileImageUrlLarge", typ: u(undefined, "") },
        { json: "profileImageUrlMedium", js: "profileImageUrlMedium", typ: u(undefined, "") },
        { json: "profileImageUrlSmall", js: "profileImageUrlSmall", typ: u(undefined, "") },
        { json: "rights", js: "rights", typ: u(undefined, a("")) },
        { json: "roleName", js: "roleName", typ: u(undefined, r("RoleName")) },
        { json: "screenName", js: "screenName", typ: "" },
    ], false),
    "Ratings": o([
        { json: "rating", js: "rating", typ: i(0) },
    ], false),
    "TableAuthor": o([
        { json: "displayName", js: "displayName", typ: "" },
        { json: "id", js: "id", typ: "" },
        { json: "rights", js: "rights", typ: u(undefined, a("")) },
        { json: "roleName", js: "roleName", typ: u(undefined, r("RoleName")) },
        { json: "screenName", js: "screenName", typ: "" },
    ], false),
    "DisplayType": [
        "table",
        "data_lens",
        "fatrow",
        "page",
    ],
    "TopLevelFlag": [
        "default",
        "restorable",
        "restorePossibleForType",
    ],
    "GrantFlag": [
        "public",
    ],
    "GrantType": [
        "viewer",
    ],
    "OrderColumnFieldName": [
        "date_received",
        "agreement_date",
        "in_effect_as_of_1_1_2012",
    ],
    "ChildColumnFieldName": [
        "product",
        "complaint_what_happened",
        "sub_product",
        "issue",
    ],
    "MetadataOperator": [
        "EQUALS",
        "blank?",
    ],
    "ChildOperator": [
        "EQUALS",
        "IS_NOT_BLANK",
    ],
    "WhereOperator": [
        "EQUALS",
        "AND",
    ],
    "FieldType": [
        "columnLabel",
        "columnData",
    ],
    "Width": [
        "27%",
        "40%",
        "30%",
        "33%",
    ],
    "ModifyingViewUid": [
        "s6ew-h6mp",
    ],
    "RoleName": [
        "administrator",
        "publisher",
    ],
    "Provenance": [
        "official",
    ],
    "PublicationStage": [
        "published",
    ],
    "Right": [
        "read",
    ],
    "RowsUpdatedBy": [
        "pjxg-ve4m",
        "54a3-qyun",
        "9e3m-2843",
        "vvca-fr6g",
    ],
    "ViewType": [
        "tabular",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
