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
                result[key] = val[key];
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
        { json: "centrodesmose", js: "centrodesmose", typ: "" },
        { json: "cerograph", js: "cerograph", typ: a(u(r("CerographClass"), null, "")) },
        { json: "chemotherapeutics", js: "chemotherapeutics", typ: a(u(r("ChemotherapeuticClass"), i(0))) },
        { json: "cimelia", js: "cimelia", typ: a(u(a(i(0)), r("CimeliaClass"), null)) },
        { json: "citrated", js: "citrated", typ: i(0) },
        { json: "clinodome", js: "clinodome", typ: a(u(3.14, "")) },
        { json: "coadjust", js: "coadjust", typ: a(u(r("CoadjustClass"), 3.14)) },
        { json: "consilience", js: "consilience", typ: a(u(3.14, m(i(0)))) },
        { json: "constructor", js: "constructor", typ: a(u(true, m(u(i(0), null)))) },
        { json: "continuative", js: "continuative", typ: a(u(m(i(0)), "")) },
        { json: "credulity", js: "credulity", typ: a(u(r("CredulityClass"), i(0), "")) },
        { json: "creviced", js: "creviced", typ: a(u(true, m(i(0)), "")) },
        { json: "cubiculum", js: "cubiculum", typ: a(a(u(i(0), null))) },
        { json: "deruralize", js: "deruralize", typ: a(u(a(null), true, r("DeruralizeClass"))) },
        { json: "diaereses", js: "diaereses", typ: a(u(a(i(0)), true, r("DiaereseClass"))) },
        { json: "dissolution", js: "dissolution", typ: a(u(a(null), null)) },
        { json: "downstroke", js: "downstroke", typ: a(u(a(null), true, "")) },
        { json: "electrotautomerism", js: "electrotautomerism", typ: a(u(3.14, null)) },
        { json: "eleutheromania", js: "eleutheromania", typ: a(u(3.14, m(i(0)), "")) },
        { json: "encrust", js: "encrust", typ: r("Encrust") },
        { json: "entomoid", js: "entomoid", typ: a(u(r("CimeliaClass"), i(0))) },
        { json: "epipaleolithic", js: "epipaleolithic", typ: a(u(a(i(0)), 3.14)) },
        { json: "expropriable", js: "expropriable", typ: a(u(a(null), r("CimeliaClass"), 3.14)) },
        { json: "faggingly", js: "faggingly", typ: a(u(r("FagginglyClass"), 3.14)) },
        { json: "fenks", js: "fenks", typ: a(u(r("FenkClass"), "")) },
        { json: "flagmaking", js: "flagmaking", typ: a(u(true, r("FlagmakingClass"), 3.14)) },
        { json: "fluorometer", js: "fluorometer", typ: a(u(i(0), null, "")) },
        { json: "fulsome", js: "fulsome", typ: a(u(i(0), null)) },
        { json: "fuzzy", js: "fuzzy", typ: a(u(i(0), m(u(i(0), null)))) },
        { json: "gardenwards", js: "gardenwards", typ: a(u(a(i(0)), true, "")) },
        { json: "generalissimo", js: "generalissimo", typ: a(u(true, m(i(0)), null)) },
        { json: "habeas", js: "habeas", typ: a(u(m(i(0)), null)) },
        { json: "hemicrystalline", js: "hemicrystalline", typ: a(u(r("CimeliaClass"), "")) },
        { json: "hemocoele", js: "hemocoele", typ: a(u(a(i(0)), r("HemocoeleClass"))) },
        { json: "hoister", js: "hoister", typ: a(u(r("CimeliaClass"), null, "")) },
        { json: "hyperpiesis", js: "hyperpiesis", typ: a(u(a(null), r("CimeliaClass"), null)) },
        { json: "hyppish", js: "hyppish", typ: a(u(true, null, "")) },
        { json: "idealizer", js: "idealizer", typ: a(u(a(null), r("CimeliaClass"), i(0))) },
        { json: "incrustator", js: "incrustator", typ: a(u(a(i(0)), i(0), "")) },
        { json: "intentiveness", js: "intentiveness", typ: a(u(r("CimeliaClass"), 3.14, "")) },
        { json: "interacinar", js: "interacinar", typ: r("Interacinar") },
        { json: "intercorrelation", js: "intercorrelation", typ: a(u(a(i(0)), null)) },
        { json: "jacutinga", js: "jacutinga", typ: a(u(a(i(0)), m(u(i(0), null)))) },
    ], false),
    "CerographClass": o([
        { json: "Tolowa", js: "Tolowa", typ: null },
        { json: "apotropaion", js: "apotropaion", typ: null },
        { json: "casuary", js: "casuary", typ: null },
        { json: "creaker", js: "creaker", typ: null },
        { json: "disqualification", js: "disqualification", typ: null },
        { json: "imperatorious", js: "imperatorious", typ: null },
        { json: "impermeabilize", js: "impermeabilize", typ: null },
        { json: "metastoma", js: "metastoma", typ: null },
        { json: "noctidiurnal", js: "noctidiurnal", typ: null },
        { json: "nonreserve", js: "nonreserve", typ: null },
        { json: "ophthalmotonometry", js: "ophthalmotonometry", typ: null },
        { json: "pailful", js: "pailful", typ: null },
        { json: "pigfish", js: "pigfish", typ: null },
        { json: "pongee", js: "pongee", typ: null },
        { json: "prosodical", js: "prosodical", typ: null },
        { json: "scrofuloderm", js: "scrofuloderm", typ: null },
        { json: "storekeeping", js: "storekeeping", typ: null },
        { json: "therologist", js: "therologist", typ: null },
        { json: "tradeful", js: "tradeful", typ: null },
        { json: "unriveting", js: "unriveting", typ: null },
    ], false),
    "ChemotherapeuticClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Maureen", js: "Maureen", typ: u(undefined, null) },
        { json: "angioneurotic", js: "angioneurotic", typ: u(undefined, null) },
        { json: "availment", js: "availment", typ: u(undefined, null) },
        { json: "bladelet", js: "bladelet", typ: u(undefined, null) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "caulis", js: "caulis", typ: u(undefined, null) },
        { json: "chalcus", js: "chalcus", typ: u(undefined, null) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "enteradenological", js: "enteradenological", typ: u(undefined, null) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "imporosity", js: "imporosity", typ: u(undefined, null) },
        { json: "insistently", js: "insistently", typ: u(undefined, null) },
        { json: "intraparietal", js: "intraparietal", typ: u(undefined, null) },
        { json: "ivied", js: "ivied", typ: u(undefined, null) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "nostochine", js: "nostochine", typ: u(undefined, null) },
        { json: "nutcracker", js: "nutcracker", typ: u(undefined, null) },
        { json: "ofttimes", js: "ofttimes", typ: u(undefined, null) },
        { json: "phenocryst", js: "phenocryst", typ: u(undefined, null) },
        { json: "precoincident", js: "precoincident", typ: u(undefined, null) },
        { json: "ramiferous", js: "ramiferous", typ: u(undefined, null) },
        { json: "stagmometer", js: "stagmometer", typ: u(undefined, null) },
        { json: "tetherball", js: "tetherball", typ: u(undefined, null) },
        { json: "unshy", js: "unshy", typ: u(undefined, null) },
    ], false),
    "CimeliaClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: i(0) },
        { json: "catharticalness", js: "catharticalness", typ: 3.14 },
        { json: "disdiapason", js: "disdiapason", typ: "" },
        { json: "homocerc", js: "homocerc", typ: true },
        { json: "nonbookish", js: "nonbookish", typ: null },
    ], false),
    "CoadjustClass": o([
        { json: "Benny", js: "Benny", typ: u(undefined, null) },
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Netherlandish", js: "Netherlandish", typ: u(undefined, null) },
        { json: "Phonelescope", js: "Phonelescope", typ: u(undefined, null) },
        { json: "Sedaceae", js: "Sedaceae", typ: u(undefined, null) },
        { json: "amidosulphonal", js: "amidosulphonal", typ: u(undefined, null) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "ensnare", js: "ensnare", typ: u(undefined, null) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "hybridizer", js: "hybridizer", typ: u(undefined, null) },
        { json: "leastwise", js: "leastwise", typ: u(undefined, null) },
        { json: "lof", js: "lof", typ: u(undefined, null) },
        { json: "monkhood", js: "monkhood", typ: u(undefined, null) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "peonism", js: "peonism", typ: u(undefined, null) },
        { json: "porphyrogeniture", js: "porphyrogeniture", typ: u(undefined, null) },
        { json: "preindemnify", js: "preindemnify", typ: u(undefined, null) },
        { json: "rosal", js: "rosal", typ: u(undefined, null) },
        { json: "scalenous", js: "scalenous", typ: u(undefined, null) },
        { json: "scopine", js: "scopine", typ: u(undefined, null) },
        { json: "suberinize", js: "suberinize", typ: u(undefined, null) },
        { json: "symbiot", js: "symbiot", typ: u(undefined, null) },
        { json: "tablefellow", js: "tablefellow", typ: u(undefined, null) },
        { json: "unchargeable", js: "unchargeable", typ: u(undefined, null) },
    ], false),
    "CredulityClass": o([
        { json: "Flavia", js: "Flavia", typ: null },
        { json: "Hedychium", js: "Hedychium", typ: null },
        { json: "Popean", js: "Popean", typ: null },
        { json: "ammonolytic", js: "ammonolytic", typ: null },
        { json: "bushmaster", js: "bushmaster", typ: null },
        { json: "considering", js: "considering", typ: null },
        { json: "consuetudinary", js: "consuetudinary", typ: null },
        { json: "embarras", js: "embarras", typ: null },
        { json: "fineness", js: "fineness", typ: null },
        { json: "flaithship", js: "flaithship", typ: null },
        { json: "gruffly", js: "gruffly", typ: null },
        { json: "leadwort", js: "leadwort", typ: null },
        { json: "overseriously", js: "overseriously", typ: null },
        { json: "parabola", js: "parabola", typ: null },
        { json: "pectinatodenticulate", js: "pectinatodenticulate", typ: null },
        { json: "pornocrat", js: "pornocrat", typ: null },
        { json: "quadrisect", js: "quadrisect", typ: null },
        { json: "seriality", js: "seriality", typ: null },
        { json: "vamphorn", js: "vamphorn", typ: null },
        { json: "wharp", js: "wharp", typ: null },
    ], false),
    "DeruralizeClass": o([
        { json: "Jehovistic", js: "Jehovistic", typ: null },
        { json: "Paninean", js: "Paninean", typ: null },
        { json: "Romney", js: "Romney", typ: null },
        { json: "bockerel", js: "bockerel", typ: null },
        { json: "boulder", js: "boulder", typ: null },
        { json: "churrus", js: "churrus", typ: null },
        { json: "counterdigged", js: "counterdigged", typ: null },
        { json: "dialogite", js: "dialogite", typ: null },
        { json: "digenic", js: "digenic", typ: null },
        { json: "dunbird", js: "dunbird", typ: null },
        { json: "ergatogyne", js: "ergatogyne", typ: null },
        { json: "fiendful", js: "fiendful", typ: null },
        { json: "jackrod", js: "jackrod", typ: null },
        { json: "panther", js: "panther", typ: null },
        { json: "placentigerous", js: "placentigerous", typ: null },
        { json: "sparm", js: "sparm", typ: null },
        { json: "tocsin", js: "tocsin", typ: null },
        { json: "unnicked", js: "unnicked", typ: null },
        { json: "unstavable", js: "unstavable", typ: null },
        { json: "windfirm", js: "windfirm", typ: null },
    ], false),
    "DiaereseClass": o([
        { json: "Amoreuxia", js: "Amoreuxia", typ: null },
        { json: "ani", js: "ani", typ: null },
        { json: "bernicle", js: "bernicle", typ: null },
        { json: "blackwasher", js: "blackwasher", typ: null },
        { json: "blowhard", js: "blowhard", typ: null },
        { json: "broma", js: "broma", typ: null },
        { json: "closecross", js: "closecross", typ: null },
        { json: "congregationalism", js: "congregationalism", typ: null },
        { json: "grayly", js: "grayly", typ: null },
        { json: "historically", js: "historically", typ: null },
        { json: "hoast", js: "hoast", typ: null },
        { json: "irretentive", js: "irretentive", typ: null },
        { json: "parcener", js: "parcener", typ: null },
        { json: "pedder", js: "pedder", typ: null },
        { json: "pseudoanatomic", js: "pseudoanatomic", typ: null },
        { json: "rhizocarpian", js: "rhizocarpian", typ: null },
        { json: "samel", js: "samel", typ: null },
        { json: "silker", js: "silker", typ: null },
        { json: "subdentated", js: "subdentated", typ: null },
        { json: "subobscure", js: "subobscure", typ: null },
    ], false),
    "Encrust": o([
        { json: "Hibernia", js: "Hibernia", typ: null },
        { json: "Hibiscus", js: "Hibiscus", typ: null },
        { json: "Lepidosauria", js: "Lepidosauria", typ: null },
        { json: "Syllidae", js: "Syllidae", typ: null },
        { json: "comradely", js: "comradely", typ: null },
        { json: "diacanthous", js: "diacanthous", typ: null },
        { json: "feminineness", js: "feminineness", typ: null },
        { json: "gossamered", js: "gossamered", typ: null },
        { json: "lollingly", js: "lollingly", typ: null },
        { json: "manager", js: "manager", typ: null },
        { json: "mechanic", js: "mechanic", typ: null },
        { json: "overminuteness", js: "overminuteness", typ: null },
        { json: "papelonne", js: "papelonne", typ: null },
        { json: "plebification", js: "plebification", typ: null },
        { json: "pugmiller", js: "pugmiller", typ: null },
        { json: "recoveror", js: "recoveror", typ: null },
        { json: "spermatoblastic", js: "spermatoblastic", typ: null },
        { json: "ungyved", js: "ungyved", typ: null },
        { json: "whirlabout", js: "whirlabout", typ: null },
        { json: "woodenware", js: "woodenware", typ: null },
    ], false),
    "FagginglyClass": o([
        { json: "Anglic", js: "Anglic", typ: null },
        { json: "Heteromeri", js: "Heteromeri", typ: null },
        { json: "Poinsettia", js: "Poinsettia", typ: null },
        { json: "abranchian", js: "abranchian", typ: null },
        { json: "aculeiform", js: "aculeiform", typ: null },
        { json: "adiaphoristic", js: "adiaphoristic", typ: null },
        { json: "adoptionism", js: "adoptionism", typ: null },
        { json: "antrotomy", js: "antrotomy", typ: null },
        { json: "coerciveness", js: "coerciveness", typ: null },
        { json: "decorist", js: "decorist", typ: null },
        { json: "duckhood", js: "duckhood", typ: null },
        { json: "hypochnose", js: "hypochnose", typ: null },
        { json: "lochage", js: "lochage", typ: null },
        { json: "melee", js: "melee", typ: null },
        { json: "nonconformitant", js: "nonconformitant", typ: null },
        { json: "putatively", js: "putatively", typ: null },
        { json: "semivolatile", js: "semivolatile", typ: null },
        { json: "soleas", js: "soleas", typ: null },
        { json: "unfastenable", js: "unfastenable", typ: null },
        { json: "unmillinered", js: "unmillinered", typ: null },
    ], false),
    "FenkClass": o([
        { json: "Dagomba", js: "Dagomba", typ: null },
        { json: "Guyandot", js: "Guyandot", typ: null },
        { json: "Reinwardtia", js: "Reinwardtia", typ: null },
        { json: "Tritoness", js: "Tritoness", typ: null },
        { json: "apoise", js: "apoise", typ: null },
        { json: "astronomize", js: "astronomize", typ: null },
        { json: "cockhorse", js: "cockhorse", typ: null },
        { json: "copular", js: "copular", typ: null },
        { json: "draffy", js: "draffy", typ: null },
        { json: "foreigner", js: "foreigner", typ: null },
        { json: "neurogliosis", js: "neurogliosis", typ: null },
        { json: "osmious", js: "osmious", typ: null },
        { json: "palpitate", js: "palpitate", typ: null },
        { json: "rebukeable", js: "rebukeable", typ: null },
        { json: "reservatory", js: "reservatory", typ: null },
        { json: "scalt", js: "scalt", typ: null },
        { json: "scripturalize", js: "scripturalize", typ: null },
        { json: "tintometer", js: "tintometer", typ: null },
        { json: "undergrade", js: "undergrade", typ: null },
        { json: "undermountain", js: "undermountain", typ: null },
    ], false),
    "FlagmakingClass": o([
        { json: "Bunodonta", js: "Bunodonta", typ: null },
        { json: "Hydrocorisae", js: "Hydrocorisae", typ: null },
        { json: "Notacanthidae", js: "Notacanthidae", typ: null },
        { json: "albarco", js: "albarco", typ: null },
        { json: "hornify", js: "hornify", typ: null },
        { json: "hypoglossus", js: "hypoglossus", typ: null },
        { json: "inexpiably", js: "inexpiably", typ: null },
        { json: "ingratitude", js: "ingratitude", typ: null },
        { json: "ladyfly", js: "ladyfly", typ: null },
        { json: "medicament", js: "medicament", typ: null },
        { json: "monogrammatic", js: "monogrammatic", typ: null },
        { json: "nobbut", js: "nobbut", typ: null },
        { json: "polyplacophore", js: "polyplacophore", typ: null },
        { json: "proexercise", js: "proexercise", typ: null },
        { json: "protoplast", js: "protoplast", typ: null },
        { json: "puzzling", js: "puzzling", typ: null },
        { json: "splanchnoskeleton", js: "splanchnoskeleton", typ: null },
        { json: "unloveliness", js: "unloveliness", typ: null },
        { json: "unquarantined", js: "unquarantined", typ: null },
        { json: "unrenounceable", js: "unrenounceable", typ: null },
    ], false),
    "HemocoeleClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Walt", js: "Walt", typ: u(undefined, null) },
        { json: "acrogamy", js: "acrogamy", typ: u(undefined, null) },
        { json: "amelification", js: "amelification", typ: u(undefined, null) },
        { json: "autobiographic", js: "autobiographic", typ: u(undefined, null) },
        { json: "berat", js: "berat", typ: u(undefined, null) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "disproportionably", js: "disproportionably", typ: u(undefined, null) },
        { json: "erythrite", js: "erythrite", typ: u(undefined, null) },
        { json: "graphic", js: "graphic", typ: u(undefined, null) },
        { json: "hepatological", js: "hepatological", typ: u(undefined, null) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "incommensurably", js: "incommensurably", typ: u(undefined, null) },
        { json: "misaffirm", js: "misaffirm", typ: u(undefined, null) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "pocketbook", js: "pocketbook", typ: u(undefined, null) },
        { json: "sclerometric", js: "sclerometric", typ: u(undefined, null) },
        { json: "stambouline", js: "stambouline", typ: u(undefined, null) },
        { json: "stickpin", js: "stickpin", typ: u(undefined, null) },
        { json: "tubulure", js: "tubulure", typ: u(undefined, null) },
        { json: "undelated", js: "undelated", typ: u(undefined, null) },
        { json: "unsalt", js: "unsalt", typ: u(undefined, null) },
        { json: "untutelar", js: "untutelar", typ: u(undefined, null) },
        { json: "vagrant", js: "vagrant", typ: u(undefined, null) },
    ], false),
    "Interacinar": o([
        { json: "assapan", js: "assapan", typ: 3.14 },
        { json: "benefactorship", js: "benefactorship", typ: true },
        { json: "triseriatim", js: "triseriatim", typ: "" },
        { json: "tubbing", js: "tubbing", typ: i(0) },
        { json: "untrimmed", js: "untrimmed", typ: null },
    ], false),
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
