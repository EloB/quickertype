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
        { json: "Abranchiata", js: "Abranchiata", typ: a(u(a(i(0)), i(0), null)) },
        { json: "Andriana", js: "Andriana", typ: a(u(null, "")) },
        { json: "Ansarie", js: "Ansarie", typ: a(u(a(i(0)), r("AnsarieClass"), null)) },
        { json: "Chytridiaceae", js: "Chytridiaceae", typ: a(u(true, r("ChytridiaceaeClass"), null)) },
        { json: "Discordia", js: "Discordia", typ: a(u(a(i(0)), r("DiscordiaClass"))) },
        { json: "Endomyces", js: "Endomyces", typ: a(u(i(0), "")) },
        { json: "Epinephelidae", js: "Epinephelidae", typ: a(u(true, i(0), "")) },
        { json: "Eupatorium", js: "Eupatorium", typ: a(u(a(null), m(i(0)))) },
        { json: "Gryphosaurus", js: "Gryphosaurus", typ: a(u(a(i(0)), r("GryphosaurusClass"), "")) },
        { json: "Koryak", js: "Koryak", typ: a(u(m(u(i(0), null)), "")) },
        { json: "Lavinia", js: "Lavinia", typ: a(u(r("LaviniaClass"), "")) },
        { json: "Oskar", js: "Oskar", typ: a(u(a(i(0)), r("OskarClass"))) },
        { json: "Rebecca", js: "Rebecca", typ: a(u(r("Rebecca"), i(0), "")) },
        { json: "Rhomboganoidei", js: "Rhomboganoidei", typ: a(u(a(i(0)), r("Rebecca"), "")) },
        { json: "Rigsmal", js: "Rigsmal", typ: true },
        { json: "Ruellia", js: "Ruellia", typ: a(u(true, r("Rebecca"), "")) },
        { json: "School", js: "School", typ: a(u(i(0), m(i(0)), null)) },
        { json: "Shakespearolater", js: "Shakespearolater", typ: a(u(a(i(0)), 3.14, "")) },
        { json: "Svan", js: "Svan", typ: a(3.14) },
        { json: "Wayao", js: "Wayao", typ: m(3.14) },
        { json: "academe", js: "academe", typ: a(u(a(i(0)), i(0), m(i(0)))) },
        { json: "acquirable", js: "acquirable", typ: a(u(a(u(i(0), null)), m(i(0)))) },
        { json: "aerometry", js: "aerometry", typ: a(u(true, 3.14)) },
        { json: "alexin", js: "alexin", typ: a(u(a(i(0)), true)) },
        { json: "alleviate", js: "alleviate", typ: a(u(a(u(i(0), null)), r("AlleviateClass"))) },
        { json: "amaas", js: "amaas", typ: a(u(true, r("Rebecca"), i(0))) },
        { json: "ambassage", js: "ambassage", typ: a(u(a(null), "")) },
        { json: "amphithyron", js: "amphithyron", typ: a(u(r("Amphithyron"), null)) },
        { json: "ankee", js: "ankee", typ: a(u(a(i(0)), r("AnkeeClass"), i(0))) },
        { json: "annihilator", js: "annihilator", typ: a(u(m(u(i(0), null)), null)) },
        { json: "annulose", js: "annulose", typ: null },
        { json: "aphasia", js: "aphasia", typ: a(u(a(i(0)), i(0))) },
        { json: "asprawl", js: "asprawl", typ: a(u(3.14, "")) },
        { json: "attractive", js: "attractive", typ: a(u(true, null)) },
        { json: "barksome", js: "barksome", typ: m(i(0)) },
        { json: "bedesman", js: "bedesman", typ: a(u(true, 3.14, "")) },
        { json: "belard", js: "belard", typ: a(u(a(i(0)), r("Rebecca"), 3.14)) },
        { json: "bocking", js: "bocking", typ: a(u(a(i(0)), true, m(i(0)))) },
        { json: "brawlingly", js: "brawlingly", typ: a(u(a(null), m(u(i(0), null)))) },
        { json: "brookie", js: "brookie", typ: a(u(a(i(0)), r("Rebecca"))) },
        { json: "bumboatman", js: "bumboatman", typ: a(u(a(null), null, "")) },
        { json: "bystreet", js: "bystreet", typ: a(null) },
        { json: "calaverite", js: "calaverite", typ: a(u(a(i(0)), "")) },
        { json: "catallactic", js: "catallactic", typ: a(u(a(null), true, m(i(0)))) },
        { json: "cemental", js: "cemental", typ: a(u(a(i(0)), 3.14, m(i(0)))) },
    ], false),
    "AnsarieClass": o([
        { json: "Alida", js: "Alida", typ: null },
        { json: "Ictonyx", js: "Ictonyx", typ: null },
        { json: "Ramist", js: "Ramist", typ: null },
        { json: "accension", js: "accension", typ: null },
        { json: "asteria", js: "asteria", typ: null },
        { json: "beriberic", js: "beriberic", typ: null },
        { json: "edgebone", js: "edgebone", typ: null },
        { json: "gastrodialysis", js: "gastrodialysis", typ: null },
        { json: "geographic", js: "geographic", typ: null },
        { json: "metrocele", js: "metrocele", typ: null },
        { json: "misgraft", js: "misgraft", typ: null },
        { json: "monteith", js: "monteith", typ: null },
        { json: "notcher", js: "notcher", typ: null },
        { json: "prorestriction", js: "prorestriction", typ: null },
        { json: "throatlet", js: "throatlet", typ: null },
        { json: "unfair", js: "unfair", typ: null },
        { json: "unsynonymous", js: "unsynonymous", typ: null },
        { json: "water", js: "water", typ: null },
        { json: "zestfully", js: "zestfully", typ: null },
        { json: "zincic", js: "zincic", typ: null },
    ], false),
    "ChytridiaceaeClass": o([
        { json: "Batidaceae", js: "Batidaceae", typ: null },
        { json: "Brechites", js: "Brechites", typ: null },
        { json: "Emery", js: "Emery", typ: null },
        { json: "Narraganset", js: "Narraganset", typ: null },
        { json: "codespairer", js: "codespairer", typ: null },
        { json: "enervative", js: "enervative", typ: null },
        { json: "excriminate", js: "excriminate", typ: null },
        { json: "goshenite", js: "goshenite", typ: null },
        { json: "grime", js: "grime", typ: null },
        { json: "gritten", js: "gritten", typ: null },
        { json: "hectorly", js: "hectorly", typ: null },
        { json: "intermediation", js: "intermediation", typ: null },
        { json: "meeterly", js: "meeterly", typ: null },
        { json: "onymatic", js: "onymatic", typ: null },
        { json: "paddlecock", js: "paddlecock", typ: null },
        { json: "thana", js: "thana", typ: null },
        { json: "thornily", js: "thornily", typ: null },
        { json: "uckia", js: "uckia", typ: null },
        { json: "unmettle", js: "unmettle", typ: null },
        { json: "vorticellid", js: "vorticellid", typ: null },
    ], false),
    "DiscordiaClass": o([
        { json: "Altaic", js: "Altaic", typ: u(undefined, i(0)) },
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Patarin", js: "Patarin", typ: u(undefined, i(0)) },
        { json: "amoristic", js: "amoristic", typ: u(undefined, i(0)) },
        { json: "blennophthalmia", js: "blennophthalmia", typ: u(undefined, i(0)) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "disciplinability", js: "disciplinability", typ: u(undefined, i(0)) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "goofer", js: "goofer", typ: u(undefined, i(0)) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "laryngograph", js: "laryngograph", typ: u(undefined, i(0)) },
        { json: "leucitis", js: "leucitis", typ: u(undefined, i(0)) },
        { json: "lymphocyst", js: "lymphocyst", typ: u(undefined, i(0)) },
        { json: "microcosmology", js: "microcosmology", typ: u(undefined, i(0)) },
        { json: "nauseation", js: "nauseation", typ: u(undefined, i(0)) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "preliberal", js: "preliberal", typ: u(undefined, i(0)) },
        { json: "prettifier", js: "prettifier", typ: u(undefined, i(0)) },
        { json: "rangework", js: "rangework", typ: u(undefined, i(0)) },
        { json: "redient", js: "redient", typ: u(undefined, i(0)) },
        { json: "subfusiform", js: "subfusiform", typ: u(undefined, i(0)) },
        { json: "suicidical", js: "suicidical", typ: u(undefined, i(0)) },
        { json: "swow", js: "swow", typ: u(undefined, i(0)) },
        { json: "wastrel", js: "wastrel", typ: u(undefined, i(0)) },
        { json: "wingle", js: "wingle", typ: u(undefined, i(0)) },
    ], false),
    "GryphosaurusClass": o([
        { json: "Burushaski", js: "Burushaski", typ: null },
        { json: "Tahami", js: "Tahami", typ: null },
        { json: "amissibility", js: "amissibility", typ: null },
        { json: "citronin", js: "citronin", typ: null },
        { json: "coplaintiff", js: "coplaintiff", typ: null },
        { json: "disquisitionary", js: "disquisitionary", typ: null },
        { json: "enoplan", js: "enoplan", typ: null },
        { json: "faintness", js: "faintness", typ: null },
        { json: "hebetomy", js: "hebetomy", typ: null },
        { json: "islandry", js: "islandry", typ: null },
        { json: "lameduck", js: "lameduck", typ: null },
        { json: "overbattle", js: "overbattle", typ: null },
        { json: "overinterested", js: "overinterested", typ: null },
        { json: "phrenologic", js: "phrenologic", typ: null },
        { json: "rainband", js: "rainband", typ: null },
        { json: "shiningly", js: "shiningly", typ: null },
        { json: "stamineous", js: "stamineous", typ: null },
        { json: "subscapularis", js: "subscapularis", typ: null },
        { json: "undaubed", js: "undaubed", typ: null },
        { json: "underntime", js: "underntime", typ: null },
    ], false),
    "LaviniaClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Tacana", js: "Tacana", typ: u(undefined, i(0)) },
        { json: "agitable", js: "agitable", typ: u(undefined, i(0)) },
        { json: "asininity", js: "asininity", typ: u(undefined, i(0)) },
        { json: "benefiter", js: "benefiter", typ: u(undefined, i(0)) },
        { json: "bronzelike", js: "bronzelike", typ: u(undefined, i(0)) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "cholesteatomatous", js: "cholesteatomatous", typ: u(undefined, i(0)) },
        { json: "deprivement", js: "deprivement", typ: u(undefined, i(0)) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "flippantness", js: "flippantness", typ: u(undefined, i(0)) },
        { json: "fogproof", js: "fogproof", typ: u(undefined, i(0)) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "merrymeeting", js: "merrymeeting", typ: u(undefined, i(0)) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "overcareful", js: "overcareful", typ: u(undefined, i(0)) },
        { json: "panaris", js: "panaris", typ: u(undefined, i(0)) },
        { json: "preacceptance", js: "preacceptance", typ: u(undefined, i(0)) },
        { json: "quinoxaline", js: "quinoxaline", typ: u(undefined, i(0)) },
        { json: "sig", js: "sig", typ: u(undefined, i(0)) },
        { json: "superconfusion", js: "superconfusion", typ: u(undefined, i(0)) },
        { json: "tillotter", js: "tillotter", typ: u(undefined, i(0)) },
        { json: "tranquillize", js: "tranquillize", typ: u(undefined, i(0)) },
        { json: "unquestionable", js: "unquestionable", typ: u(undefined, i(0)) },
        { json: "uproute", js: "uproute", typ: u(undefined, i(0)) },
    ], false),
    "OskarClass": o([
        { json: "Acrobates", js: "Acrobates", typ: null },
        { json: "Cayuga", js: "Cayuga", typ: null },
        { json: "Netherlandish", js: "Netherlandish", typ: null },
        { json: "beanshooter", js: "beanshooter", typ: null },
        { json: "bearhound", js: "bearhound", typ: null },
        { json: "guarneri", js: "guarneri", typ: null },
        { json: "hypochondriacism", js: "hypochondriacism", typ: null },
        { json: "indication", js: "indication", typ: null },
        { json: "jaculative", js: "jaculative", typ: null },
        { json: "nagana", js: "nagana", typ: null },
        { json: "noctivagous", js: "noctivagous", typ: null },
        { json: "nonphysiological", js: "nonphysiological", typ: null },
        { json: "praxis", js: "praxis", typ: null },
        { json: "provision", js: "provision", typ: null },
        { json: "subterhuman", js: "subterhuman", typ: null },
        { json: "sunlit", js: "sunlit", typ: null },
        { json: "syncraniate", js: "syncraniate", typ: null },
        { json: "teachment", js: "teachment", typ: null },
        { json: "unmutinous", js: "unmutinous", typ: null },
        { json: "unstoppable", js: "unstoppable", typ: null },
    ], false),
    "Rebecca": o([
        { json: "Chirotherium", js: "Chirotherium", typ: i(0) },
        { json: "catharticalness", js: "catharticalness", typ: 3.14 },
        { json: "disdiapason", js: "disdiapason", typ: "" },
        { json: "homocerc", js: "homocerc", typ: true },
        { json: "nonbookish", js: "nonbookish", typ: null },
    ], false),
    "AlleviateClass": o([
        { json: "Hulsean", js: "Hulsean", typ: null },
        { json: "apriori", js: "apriori", typ: null },
        { json: "beggarer", js: "beggarer", typ: null },
        { json: "brokenheartedly", js: "brokenheartedly", typ: null },
        { json: "debilitation", js: "debilitation", typ: null },
        { json: "frike", js: "frike", typ: null },
        { json: "gastrolith", js: "gastrolith", typ: null },
        { json: "orthocentric", js: "orthocentric", typ: null },
        { json: "petaly", js: "petaly", typ: null },
        { json: "probudgeting", js: "probudgeting", typ: null },
        { json: "reacquire", js: "reacquire", typ: null },
        { json: "scow", js: "scow", typ: null },
        { json: "shutoff", js: "shutoff", typ: null },
        { json: "subcontiguous", js: "subcontiguous", typ: null },
        { json: "suffumigate", js: "suffumigate", typ: null },
        { json: "transformable", js: "transformable", typ: null },
        { json: "uncoroneted", js: "uncoroneted", typ: null },
        { json: "unparking", js: "unparking", typ: null },
        { json: "unvarnishedness", js: "unvarnishedness", typ: null },
        { json: "wherewithal", js: "wherewithal", typ: null },
    ], false),
    "Amphithyron": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Juniperus", js: "Juniperus", typ: u(undefined, i(0)) },
        { json: "Nazirite", js: "Nazirite", typ: u(undefined, i(0)) },
        { json: "Those", js: "Those", typ: u(undefined, i(0)) },
        { json: "akroasis", js: "akroasis", typ: u(undefined, i(0)) },
        { json: "antiphonical", js: "antiphonical", typ: u(undefined, i(0)) },
        { json: "basebred", js: "basebred", typ: u(undefined, i(0)) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "conductometric", js: "conductometric", typ: u(undefined, i(0)) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "ensilation", js: "ensilation", typ: u(undefined, i(0)) },
        { json: "eyebolt", js: "eyebolt", typ: u(undefined, i(0)) },
        { json: "fistulated", js: "fistulated", typ: u(undefined, i(0)) },
        { json: "heteropod", js: "heteropod", typ: u(undefined, i(0)) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "labyrinthically", js: "labyrinthically", typ: u(undefined, i(0)) },
        { json: "martyrization", js: "martyrization", typ: u(undefined, i(0)) },
        { json: "mispolicy", js: "mispolicy", typ: u(undefined, i(0)) },
        { json: "multipara", js: "multipara", typ: u(undefined, i(0)) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "possessorial", js: "possessorial", typ: u(undefined, i(0)) },
        { json: "shamed", js: "shamed", typ: u(undefined, i(0)) },
        { json: "shelfworn", js: "shelfworn", typ: u(undefined, i(0)) },
        { json: "stagnum", js: "stagnum", typ: u(undefined, i(0)) },
        { json: "undecimal", js: "undecimal", typ: u(undefined, i(0)) },
    ], false),
    "AnkeeClass": o([
        { json: "Anomoean", js: "Anomoean", typ: null },
        { json: "Naja", js: "Naja", typ: null },
        { json: "barleyhood", js: "barleyhood", typ: null },
        { json: "befriender", js: "befriender", typ: null },
        { json: "brutishness", js: "brutishness", typ: null },
        { json: "cephalalgy", js: "cephalalgy", typ: null },
        { json: "cirurgian", js: "cirurgian", typ: null },
        { json: "conventionally", js: "conventionally", typ: null },
        { json: "jackshay", js: "jackshay", typ: null },
        { json: "milammeter", js: "milammeter", typ: null },
        { json: "ombrological", js: "ombrological", typ: null },
        { json: "phonasthenia", js: "phonasthenia", typ: null },
        { json: "retrievableness", js: "retrievableness", typ: null },
        { json: "snakily", js: "snakily", typ: null },
        { json: "swot", js: "swot", typ: null },
        { json: "tartlet", js: "tartlet", typ: null },
        { json: "thiofuran", js: "thiofuran", typ: null },
        { json: "tracheophone", js: "tracheophone", typ: null },
        { json: "tuglike", js: "tuglike", typ: null },
        { json: "unscratchingly", js: "unscratchingly", typ: null },
    ], false),
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
