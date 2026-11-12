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
    count:    number;
    facets:   Facets;
    limit:    number;
    next:     string;
    offset:   number;
    previous: boolean;
    results:  Result[];
};

export type Facets = {
};

export type Result = {
    cost_absolute:                  number | null;
    cost_max:                       number | null;
    cost_min:                       number | null;
    created_at:                     Date;
    customIncomes:                  CustomIncome[];
    direct_rep_costs_max:           null;
    direct_rep_costs_min:           null;
    end_date:                       Date;
    eur_sources_grants:             number;
    eur_sources_grants_src:         null | string;
    eur_sources_procurement:        number;
    eur_sources_procurement_src:    null | string;
    id:                             string;
    new_organisation:               null;
    no_clients:                     null | string;
    other_financial_information:    null | string;
    other_sources_contributions:    number | null;
    other_sources_donation:         number | null;
    other_sources_total:            number | null;
    public_financing_infranational: number | null;
    public_financing_national:      number | null;
    public_financing_total:         number | null;
    representative:                 string;
    start_date:                     Date;
    status:                         Status;
    total_budget:                   number | null;
    turnover_absolute:              number | null;
    turnover_max:                   number | null;
    turnover_min:                   number | null;
    type:                           ResultType;
    updated_at:                     Date;
    uri:                            string;
};

export type CustomIncome = {
    amount:     number;
    created_at: Date;
    id:         string;
    name:       string;
    status:     Status;
    type:       CustomIncomeType;
    updated_at: Date;
    uri:        string;
};

export type Status =
      "active"
    | "inactive";

export type CustomIncomeType =
      "public"
    | "other";

export type ResultType =
      "FinancialDataNGO"
    | "FinancialDataLawyer"
    | "FinancialDataTradeAssociation";

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
        { json: "count", js: "count", typ: i(0) },
        { json: "facets", js: "facets", typ: r("Facets") },
        { json: "limit", js: "limit", typ: i(0) },
        { json: "next", js: "next", typ: "" },
        { json: "offset", js: "offset", typ: i(0) },
        { json: "previous", js: "previous", typ: true },
        { json: "results", js: "results", typ: a(r("Result")) },
    ], false),
    "Facets": o([
    ], false),
    "Result": o([
        { json: "cost_absolute", js: "cost_absolute", typ: u(i(0), null) },
        { json: "cost_max", js: "cost_max", typ: u(i(0), null) },
        { json: "cost_min", js: "cost_min", typ: u(i(0), null) },
        { json: "created_at", js: "created_at", typ: Date },
        { json: "customIncomes", js: "customIncomes", typ: a(r("CustomIncome")) },
        { json: "direct_rep_costs_max", js: "direct_rep_costs_max", typ: null },
        { json: "direct_rep_costs_min", js: "direct_rep_costs_min", typ: null },
        { json: "end_date", js: "end_date", typ: Date },
        { json: "eur_sources_grants", js: "eur_sources_grants", typ: i(0) },
        { json: "eur_sources_grants_src", js: "eur_sources_grants_src", typ: u(null, "") },
        { json: "eur_sources_procurement", js: "eur_sources_procurement", typ: i(0) },
        { json: "eur_sources_procurement_src", js: "eur_sources_procurement_src", typ: u(null, "") },
        { json: "id", js: "id", typ: "" },
        { json: "new_organisation", js: "new_organisation", typ: null },
        { json: "no_clients", js: "no_clients", typ: u(null, "") },
        { json: "other_financial_information", js: "other_financial_information", typ: u(null, "") },
        { json: "other_sources_contributions", js: "other_sources_contributions", typ: u(i(0), null) },
        { json: "other_sources_donation", js: "other_sources_donation", typ: u(i(0), null) },
        { json: "other_sources_total", js: "other_sources_total", typ: u(i(0), null) },
        { json: "public_financing_infranational", js: "public_financing_infranational", typ: u(i(0), null) },
        { json: "public_financing_national", js: "public_financing_national", typ: u(i(0), null) },
        { json: "public_financing_total", js: "public_financing_total", typ: u(i(0), null) },
        { json: "representative", js: "representative", typ: "" },
        { json: "start_date", js: "start_date", typ: Date },
        { json: "status", js: "status", typ: r("Status") },
        { json: "total_budget", js: "total_budget", typ: u(i(0), null) },
        { json: "turnover_absolute", js: "turnover_absolute", typ: u(i(0), null) },
        { json: "turnover_max", js: "turnover_max", typ: u(i(0), null) },
        { json: "turnover_min", js: "turnover_min", typ: u(i(0), null) },
        { json: "type", js: "type", typ: r("ResultType") },
        { json: "updated_at", js: "updated_at", typ: Date },
        { json: "uri", js: "uri", typ: "" },
    ], false),
    "CustomIncome": o([
        { json: "amount", js: "amount", typ: i(0) },
        { json: "created_at", js: "created_at", typ: Date },
        { json: "id", js: "id", typ: "" },
        { json: "name", js: "name", typ: "" },
        { json: "status", js: "status", typ: r("Status") },
        { json: "type", js: "type", typ: r("CustomIncomeType") },
        { json: "updated_at", js: "updated_at", typ: Date },
        { json: "uri", js: "uri", typ: "" },
    ], false),
    "Status": [
        "active",
        "inactive",
    ],
    "CustomIncomeType": [
        "public",
        "other",
    ],
    "ResultType": [
        "FinancialDataNGO",
        "FinancialDataLawyer",
        "FinancialDataTradeAssociation",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
