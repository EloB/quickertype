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
    protrusive:         Protrusive[];
    pulpitism:          PulpitismElement[];
    pyodermia:          PyodermiaElement[];
    quebrachine:        QuebrachineElement[];
    querier:            Querier[];
    rebarbative:        Rebarbative[];
    reimagine:          Reimagine[];
    ressaut:            Ressaut;
    retrocervical:      Retrocervical[];
    revert:             Revert[];
    rewrite:            RewriteElement[];
    saccoderm:          Saccoderm[];
    santir:             SantirElement[];
    saprophilous:       Saprophilous[];
    saxten:             SaxtenElement[];
    scatty:             (Scatty | null)[];
    scoffer:            Scoffer[];
    scrampum:           Scrampum[];
    semantic:           number;
    serpentinic:        Serpentinic[];
    shadowable:         Shadowable[];
    sistering:          SisteringElement[];
    staghunting:        Staghunting[];
    stagmometer:        Stagmometer[];
    stimulability:      Stimulability[];
    strangleable:       Strangleable[];
    strenuosity:        StrenuosityElement[];
    tabaxir:            Tabaxir[];
    talpiform:          Talpiform[];
    thwack:             Thwack[];
    to:                 (number | null)[];
    tortricine:         Tortricine[];
    truantcy:           TruantcyElement[];
    turgesce:           string[];
    unbeginning:        Unbeginning[];
    underdunged:        number[];
    undesirability:     Undesirability[];
    unerasing:          Unerasing[];
    unguentarium:       Unguentarium[];
    unimpeachably:      UnimpeachablyElement[];
    unmortgaged:        Unmortgaged[];
    unobstructed:       Unobstructed[];
    unreceptivity:      Unreceptivity[];
    unsatisfactoriness: Unsatisfactoriness[];
    unsecurity:         number[];
    unstressed:         UnstressedElement[];
    untasked:           Untasked[];
    unvarying:          Unvarying[];
    vehemently:         Vehemently[];
    warriorship:        { [key: string]: boolean };
    whitepot:           Whitepot[];
    wrothy:             WrothyElement[];
};

export type Protrusive = (number | null)[] | number;

export type PulpitismElement = number[] | PulpitismClass | number;

export type PulpitismClass = {
    abnet:           null;
    buckhorn:        null;
    calciform:       null;
    chelophore:      null;
    cogitation:      null;
    decreeable:      null;
    despicable:      null;
    isodiazo:        null;
    jadedly:         null;
    leptochlorite:   null;
    nursling:        null;
    palamedean:      null;
    photoheliograph: null;
    pipewood:        null;
    roberd:          null;
    statable:        null;
    superassume:     null;
    syllabe:         null;
    toughhead:       null;
    underburn:       null;
};

export type PyodermiaElement = PyodermiaClass | number;

export type PyodermiaClass = {
    Gyppo:          null;
    aphoristically: null;
    apophyllous:    null;
    cognize:        null;
    dermonosology:  null;
    ither:          null;
    juglandaceous:  null;
    litho:          null;
    macropterous:   null;
    photographer:   null;
    romancing:      null;
    rumness:        null;
    somniloquist:   null;
    stressfully:    null;
    tactically:     null;
    tracheophony:   null;
    unappositely:   null;
    unclothedly:    null;
    unimplied:      null;
    unsyncopated:   null;
};

export type QuebrachineElement = boolean | QuebrachineClass | null;

export type QuebrachineClass = {
    Chirotherium:    number;
    catharticalness: number;
    disdiapason:     string;
    homocerc:        boolean;
    nonbookish:      null;
};

export type Querier = boolean | { [key: string]: number };

export type Rebarbative = number[] | boolean | number;

export type Reimagine = {
    Chirotherium?:    number;
    Hermo?:           null;
    adducible?:       null;
    anabolin?:        null;
    brainy?:          null;
    catharticalness?: number;
    chrysamine?:      null;
    disdiapason?:     string;
    fluxweed?:        null;
    glaucine?:        null;
    grobianism?:      null;
    hieroglyphist?:   null;
    homocerc?:        boolean;
    icteroid?:        null;
    immortal?:        null;
    impetulant?:      null;
    irrigate?:        null;
    myxedema?:        null;
    nonbookish?:      null;
    onyx?:            null;
    repasser?:        null;
    septomarginal?:   null;
    subdie?:          null;
    tibiometatarsal?: null;
    waltzlike?:       null;
};

export type Ressaut = {
    Freesia:         string;
    Genevieve:       string;
    Mimosaceae:      string;
    Theopaschitism:  string;
    apperceptive:    string;
    cuttoo:          string;
    douser:          string;
    drinkproof:      string;
    forementioned:   string;
    hyperdiabolical: string;
    hypocone:        string;
    irreverentially: string;
    jumart:          string;
    mollicrush:      string;
    nedder:          string;
    retinasphalt:    string;
    sough:           string;
    steading:        string;
    undurableness:   string;
    unmingleable:    string;
};

export type Retrocervical = (number | null)[] | number;

export type Revert = boolean | string;

export type RewriteElement = null[] | RewriteClass | number;

export type RewriteClass = {
    Hyades:           null;
    Ptenoglossa:      null;
    Whiggification:   null;
    accountancy:      null;
    cacotrophic:      null;
    contest:          null;
    couthily:         null;
    falculate:        null;
    foreseize:        null;
    lemnad:           null;
    monotheistically: null;
    nonflying:        null;
    repatch:          null;
    rodman:           null;
    strung:           null;
    titmal:           null;
    twalpennyworth:   null;
    unblamable:       null;
    vertical:         null;
    yardman:          null;
};

export type Saccoderm = number[] | null | string;

export type SantirElement = SantirClass | number;

export type SantirClass = {
    Suessiones:      null;
    admiredly:       null;
    demicaponier:    null;
    epitympanic:     null;
    investitor:      null;
    lupiform:        null;
    monoflagellate:  null;
    paleoethnic:     null;
    prediscountable: null;
    rhetoricals:     null;
    roomth:          null;
    saccharose:      null;
    septonasal:      null;
    serpenticide:    null;
    setarious:       null;
    spaework:        null;
    stylite:         null;
    timelily:        null;
    unprofaned:      null;
    vorticular:      null;
};

export type Saprophilous = { [key: string]: number } | null | string;

export type SaxtenElement = SaxtenClass | string;

export type SaxtenClass = {
    Centaurid?:       null;
    Chirotherium?:    number;
    algarrobilla?:    null;
    bowgrace?:        null;
    catharticalness?: number;
    disdiapason?:     string;
    flix?:            null;
    germanely?:       null;
    homocerc?:        boolean;
    inhume?:          null;
    lepidote?:        null;
    megalochirous?:   null;
    ninepenny?:       null;
    nonbookish?:      null;
    nondeist?:        null;
    nymphaeaceous?:   null;
    parietofrontal?:  null;
    sancyite?:        null;
    subjectivist?:    null;
    tibiad?:          null;
    transonic?:       null;
    tripetalous?:     null;
    trunchman?:       null;
    urger?:           null;
    withdrawnness?:   null;
};

export type Scatty = {
    Tabasco:            null;
    aeriferous:         null;
    antical:            null;
    antighostism:       null;
    arcanum:            null;
    autotrophy:         null;
    baronial:           null;
    caffeine:           null;
    gorgoniacean:       null;
    heroical:           null;
    hydropical:         null;
    mechanology:        null;
    musicopoetic:       null;
    officiality:        null;
    oftentimes:         null;
    ophthalmotonometer: null;
    reflectively:       null;
    springer:           null;
    teleianthous:       null;
    uncombated:         null;
};

export type Scoffer = null[] | { [key: string]: number } | null;

export type Scrampum = number[] | boolean | null;

export type Serpentinic = number[] | number;

export type Shadowable = (number | null)[] | boolean;

export type SisteringElement = null[] | SisteringClass | number;

export type SisteringClass = {
    Chianti:          null;
    Haplomi:          null;
    Micropterygidae:  null;
    amphicarpic:      null;
    frigorific:       null;
    hyperkinesis:     null;
    laudable:         null;
    madwoman:         null;
    maimedly:         null;
    microrhabdus:     null;
    nondense:         null;
    phlebemphraxis:   null;
    redsear:          null;
    schismatical:     null;
    tartryl:          null;
    unabhorred:       null;
    undeliberateness: null;
    unmixable:        null;
    untruckling:      null;
    vineal:           null;
};

export type Staghunting = {
    Chirotherium?:       number;
    calorimetric?:       number;
    canid?:              number;
    catharticalness?:    number;
    disdiapason?:        string;
    ditriglyphic?:       number;
    floriferousness?:    number;
    gamelike?:           number;
    grig?:               number;
    homocerc?:           boolean;
    interloan?:          number;
    lithotomy?:          number;
    loric?:              number;
    membranocoriaceous?: number;
    membranogenic?:      number;
    nonbookish?:         null;
    overtrump?:          number;
    scotino?:            number;
    seasonable?:         number;
    sephen?:             number;
    stigmarioid?:        number;
    tired?:              number;
    trifid?:             number;
    undefeatedly?:       number;
    ungirlish?:          number;
};

export type Stagmometer = (number | null)[] | string;

export type Stimulability = boolean | number | { [key: string]: number };

export type Strangleable = null[] | number;

export type StrenuosityElement = null[] | StrenuosityClass;

export type StrenuosityClass = {
    Chirotherium?:    number;
    Onopordon?:       number;
    Sodomite?:        number;
    Yankeeist?:       number;
    bliss?:           number;
    buccate?:         number;
    bulletproof?:     number;
    catharticalness?: number;
    crumblingness?:   number;
    disdiapason?:     string;
    engagedly?:       number;
    fightable?:       number;
    hoariness?:       number;
    homocerc?:        boolean;
    hypopodium?:      number;
    luxurist?:        number;
    mechanician?:     number;
    nonbookish?:      null;
    podgily?:         number;
    reformableness?:  number;
    scatterbrains?:   number;
    seminuria?:       number;
    tramp?:           number;
    undueness?:       number;
    worthily?:        number;
};

export type Tabaxir = boolean | number;

export type Talpiform = QuebrachineClass | number | null;

export type Thwack = boolean | QuebrachineClass | number;

export type Tortricine = (number | null)[] | QuebrachineClass;

export type TruantcyElement = boolean | TruantcyClass;

export type TruantcyClass = {
    Chirotherium?:    number;
    Epeira?:          null;
    Eurylaimi?:       null;
    Yuman?:           null;
    alfiona?:         null;
    ascaridiasis?:    null;
    bungey?:          null;
    catharticalness?: number;
    ceroxyle?:        null;
    chorology?:       null;
    disdiapason?:     string;
    enmarble?:        null;
    germination?:     null;
    hallelujah?:      null;
    homocerc?:        boolean;
    lev?:             null;
    mouthing?:        null;
    nonbookish?:      null;
    philliloo?:       null;
    planetal?:        null;
    poney?:           null;
    punctualist?:     null;
    returnlessly?:    null;
    skelder?:         null;
    windwaywardly?:   null;
};

export type Unbeginning = null[] | { [key: string]: number } | string;

export type Undesirability = number[] | { [key: string]: number } | string;

export type Unerasing = null[] | number | { [key: string]: number };

export type Unguentarium = null[] | number | null;

export type UnimpeachablyElement = boolean | UnimpeachablyClass;

export type UnimpeachablyClass = {
    Bobadil?:            number;
    Chirotherium?:       number;
    Quiina?:             number;
    Robert?:             number;
    acerin?:             number;
    catharticalness?:    number;
    chlorophylligenous?: number;
    conversational?:     number;
    demiowl?:            number;
    disdiapason?:        string;
    ectorhinal?:         number;
    gamblesomeness?:     number;
    homocerc?:           boolean;
    irrorate?:           number;
    kindergartening?:    number;
    lateritic?:          number;
    mespil?:             number;
    misconfiguration?:   number;
    nonbookish?:         null;
    planometry?:         number;
    rot?:                number;
    subcinctorium?:      number;
    tussocker?:          number;
    ultraproud?:         number;
    unsuggestedness?:    number;
};

export type Unmortgaged = number | { [key: string]: number } | null;

export type Unobstructed = QuebrachineClass | number | null;

export type Unreceptivity = null[] | number | string;

export type Unsatisfactoriness = number[] | boolean | number;

export type UnstressedElement = boolean | UnstressedClass | string;

export type UnstressedClass = {
    Alain:           null;
    Amphirhina:      null;
    Lincolnian:      null;
    Sarcophilus:     null;
    antimachinery:   null;
    coldish:         null;
    crantara:        null;
    distinguishing:  null;
    elytroposis:     null;
    gentianwort:     null;
    heliosis:        null;
    instrumental:    null;
    introinflection: null;
    kala:            null;
    metad:           null;
    swingingly:      null;
    unconformity:    null;
    undecreed:       null;
    venerable:       null;
    vowellessness:   null;
};

export type Untasked = null[] | number | { [key: string]: number };

export type Unvarying = boolean | number | { [key: string]: number };

export type Vehemently = null[] | boolean | null;

export type Whitepot = QuebrachineClass | number;

export type WrothyElement = null[] | WrothyClass;

export type WrothyClass = {
    Aeschynanthus:    null;
    Ephesine:         null;
    aquiferous:       null;
    cheapener:        null;
    enumeration:      null;
    escadrille:       null;
    estrous:          null;
    interestedly:     null;
    katakinetomer:    null;
    mortification:    null;
    morula:           null;
    orthosymmetrical: null;
    overbark:         null;
    politist:         null;
    qualified:        null;
    sphenomalar:      null;
    throatful:        null;
    transhumance:     null;
    triandrian:       null;
    unbooked:         null;
};

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
        { json: "protrusive", js: "protrusive", typ: a(u(a(u(i(0), null)), 3.14)) },
        { json: "pulpitism", js: "pulpitism", typ: a(u(a(i(0)), r("PulpitismClass"), 3.14)) },
        { json: "pyodermia", js: "pyodermia", typ: a(u(r("PyodermiaClass"), i(0))) },
        { json: "quebrachine", js: "quebrachine", typ: a(u(true, r("QuebrachineClass"), null)) },
        { json: "querier", js: "querier", typ: a(u(true, m(i(0)))) },
        { json: "rebarbative", js: "rebarbative", typ: a(u(a(i(0)), true, 3.14)) },
        { json: "reimagine", js: "reimagine", typ: a(r("Reimagine")) },
        { json: "ressaut", js: "ressaut", typ: r("Ressaut") },
        { json: "retrocervical", js: "retrocervical", typ: a(u(a(u(i(0), null)), i(0))) },
        { json: "revert", js: "revert", typ: a(u(true, "")) },
        { json: "rewrite", js: "rewrite", typ: a(u(a(null), r("RewriteClass"), 3.14)) },
        { json: "saccoderm", js: "saccoderm", typ: a(u(a(i(0)), null, "")) },
        { json: "santir", js: "santir", typ: a(u(r("SantirClass"), 3.14)) },
        { json: "saprophilous", js: "saprophilous", typ: a(u(m(i(0)), null, "")) },
        { json: "saxten", js: "saxten", typ: a(u(r("SaxtenClass"), "")) },
        { json: "scatty", js: "scatty", typ: a(u(r("Scatty"), null)) },
        { json: "scoffer", js: "scoffer", typ: a(u(a(null), m(i(0)), null)) },
        { json: "scrampum", js: "scrampum", typ: a(u(a(i(0)), true, null)) },
        { json: "semantic", js: "semantic", typ: 3.14 },
        { json: "serpentinic", js: "serpentinic", typ: a(u(a(i(0)), 3.14)) },
        { json: "shadowable", js: "shadowable", typ: a(u(a(u(i(0), null)), true)) },
        { json: "sistering", js: "sistering", typ: a(u(a(null), r("SisteringClass"), i(0))) },
        { json: "staghunting", js: "staghunting", typ: a(r("Staghunting")) },
        { json: "stagmometer", js: "stagmometer", typ: a(u(a(u(i(0), null)), "")) },
        { json: "stimulability", js: "stimulability", typ: a(u(true, i(0), m(i(0)))) },
        { json: "strangleable", js: "strangleable", typ: a(u(a(null), 3.14)) },
        { json: "strenuosity", js: "strenuosity", typ: a(u(a(null), r("StrenuosityClass"))) },
        { json: "tabaxir", js: "tabaxir", typ: a(u(true, 3.14)) },
        { json: "talpiform", js: "talpiform", typ: a(u(r("QuebrachineClass"), 3.14, null)) },
        { json: "thwack", js: "thwack", typ: a(u(true, r("QuebrachineClass"), 3.14)) },
        { json: "to", js: "to", typ: a(u(3.14, null)) },
        { json: "tortricine", js: "tortricine", typ: a(u(a(u(i(0), null)), r("QuebrachineClass"))) },
        { json: "truantcy", js: "truantcy", typ: a(u(true, r("TruantcyClass"))) },
        { json: "turgesce", js: "turgesce", typ: a("") },
        { json: "unbeginning", js: "unbeginning", typ: a(u(a(null), m(i(0)), "")) },
        { json: "underdunged", js: "underdunged", typ: a(3.14) },
        { json: "undesirability", js: "undesirability", typ: a(u(a(i(0)), m(i(0)), "")) },
        { json: "unerasing", js: "unerasing", typ: a(u(a(null), i(0), m(i(0)))) },
        { json: "unguentarium", js: "unguentarium", typ: a(u(a(null), i(0), null)) },
        { json: "unimpeachably", js: "unimpeachably", typ: a(u(true, r("UnimpeachablyClass"))) },
        { json: "unmortgaged", js: "unmortgaged", typ: a(u(3.14, m(i(0)), null)) },
        { json: "unobstructed", js: "unobstructed", typ: a(u(r("QuebrachineClass"), i(0), null)) },
        { json: "unreceptivity", js: "unreceptivity", typ: a(u(a(null), i(0), "")) },
        { json: "unsatisfactoriness", js: "unsatisfactoriness", typ: a(u(a(i(0)), true, i(0))) },
        { json: "unsecurity", js: "unsecurity", typ: a(i(0)) },
        { json: "unstressed", js: "unstressed", typ: a(u(true, r("UnstressedClass"), "")) },
        { json: "untasked", js: "untasked", typ: a(u(a(null), 3.14, m(i(0)))) },
        { json: "unvarying", js: "unvarying", typ: a(u(true, 3.14, m(i(0)))) },
        { json: "vehemently", js: "vehemently", typ: a(u(a(null), true, null)) },
        { json: "warriorship", js: "warriorship", typ: m(true) },
        { json: "whitepot", js: "whitepot", typ: a(u(r("QuebrachineClass"), 3.14)) },
        { json: "wrothy", js: "wrothy", typ: a(u(a(null), r("WrothyClass"))) },
    ], false),
    "PulpitismClass": o([
        { json: "abnet", js: "abnet", typ: null },
        { json: "buckhorn", js: "buckhorn", typ: null },
        { json: "calciform", js: "calciform", typ: null },
        { json: "chelophore", js: "chelophore", typ: null },
        { json: "cogitation", js: "cogitation", typ: null },
        { json: "decreeable", js: "decreeable", typ: null },
        { json: "despicable", js: "despicable", typ: null },
        { json: "isodiazo", js: "isodiazo", typ: null },
        { json: "jadedly", js: "jadedly", typ: null },
        { json: "leptochlorite", js: "leptochlorite", typ: null },
        { json: "nursling", js: "nursling", typ: null },
        { json: "palamedean", js: "palamedean", typ: null },
        { json: "photoheliograph", js: "photoheliograph", typ: null },
        { json: "pipewood", js: "pipewood", typ: null },
        { json: "roberd", js: "roberd", typ: null },
        { json: "statable", js: "statable", typ: null },
        { json: "superassume", js: "superassume", typ: null },
        { json: "syllabe", js: "syllabe", typ: null },
        { json: "toughhead", js: "toughhead", typ: null },
        { json: "underburn", js: "underburn", typ: null },
    ], false),
    "PyodermiaClass": o([
        { json: "Gyppo", js: "Gyppo", typ: null },
        { json: "aphoristically", js: "aphoristically", typ: null },
        { json: "apophyllous", js: "apophyllous", typ: null },
        { json: "cognize", js: "cognize", typ: null },
        { json: "dermonosology", js: "dermonosology", typ: null },
        { json: "ither", js: "ither", typ: null },
        { json: "juglandaceous", js: "juglandaceous", typ: null },
        { json: "litho", js: "litho", typ: null },
        { json: "macropterous", js: "macropterous", typ: null },
        { json: "photographer", js: "photographer", typ: null },
        { json: "romancing", js: "romancing", typ: null },
        { json: "rumness", js: "rumness", typ: null },
        { json: "somniloquist", js: "somniloquist", typ: null },
        { json: "stressfully", js: "stressfully", typ: null },
        { json: "tactically", js: "tactically", typ: null },
        { json: "tracheophony", js: "tracheophony", typ: null },
        { json: "unappositely", js: "unappositely", typ: null },
        { json: "unclothedly", js: "unclothedly", typ: null },
        { json: "unimplied", js: "unimplied", typ: null },
        { json: "unsyncopated", js: "unsyncopated", typ: null },
    ], false),
    "QuebrachineClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: i(0) },
        { json: "catharticalness", js: "catharticalness", typ: 3.14 },
        { json: "disdiapason", js: "disdiapason", typ: "" },
        { json: "homocerc", js: "homocerc", typ: true },
        { json: "nonbookish", js: "nonbookish", typ: null },
    ], false),
    "Reimagine": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Hermo", js: "Hermo", typ: u(undefined, null) },
        { json: "adducible", js: "adducible", typ: u(undefined, null) },
        { json: "anabolin", js: "anabolin", typ: u(undefined, null) },
        { json: "brainy", js: "brainy", typ: u(undefined, null) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "chrysamine", js: "chrysamine", typ: u(undefined, null) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "fluxweed", js: "fluxweed", typ: u(undefined, null) },
        { json: "glaucine", js: "glaucine", typ: u(undefined, null) },
        { json: "grobianism", js: "grobianism", typ: u(undefined, null) },
        { json: "hieroglyphist", js: "hieroglyphist", typ: u(undefined, null) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "icteroid", js: "icteroid", typ: u(undefined, null) },
        { json: "immortal", js: "immortal", typ: u(undefined, null) },
        { json: "impetulant", js: "impetulant", typ: u(undefined, null) },
        { json: "irrigate", js: "irrigate", typ: u(undefined, null) },
        { json: "myxedema", js: "myxedema", typ: u(undefined, null) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "onyx", js: "onyx", typ: u(undefined, null) },
        { json: "repasser", js: "repasser", typ: u(undefined, null) },
        { json: "septomarginal", js: "septomarginal", typ: u(undefined, null) },
        { json: "subdie", js: "subdie", typ: u(undefined, null) },
        { json: "tibiometatarsal", js: "tibiometatarsal", typ: u(undefined, null) },
        { json: "waltzlike", js: "waltzlike", typ: u(undefined, null) },
    ], false),
    "Ressaut": o([
        { json: "Freesia", js: "Freesia", typ: "" },
        { json: "Genevieve", js: "Genevieve", typ: "" },
        { json: "Mimosaceae", js: "Mimosaceae", typ: "" },
        { json: "Theopaschitism", js: "Theopaschitism", typ: "" },
        { json: "apperceptive", js: "apperceptive", typ: "" },
        { json: "cuttoo", js: "cuttoo", typ: "" },
        { json: "douser", js: "douser", typ: "" },
        { json: "drinkproof", js: "drinkproof", typ: "" },
        { json: "forementioned", js: "forementioned", typ: "" },
        { json: "hyperdiabolical", js: "hyperdiabolical", typ: "" },
        { json: "hypocone", js: "hypocone", typ: "" },
        { json: "irreverentially", js: "irreverentially", typ: "" },
        { json: "jumart", js: "jumart", typ: "" },
        { json: "mollicrush", js: "mollicrush", typ: "" },
        { json: "nedder", js: "nedder", typ: "" },
        { json: "retinasphalt", js: "retinasphalt", typ: "" },
        { json: "sough", js: "sough", typ: "" },
        { json: "steading", js: "steading", typ: "" },
        { json: "undurableness", js: "undurableness", typ: "" },
        { json: "unmingleable", js: "unmingleable", typ: "" },
    ], false),
    "RewriteClass": o([
        { json: "Hyades", js: "Hyades", typ: null },
        { json: "Ptenoglossa", js: "Ptenoglossa", typ: null },
        { json: "Whiggification", js: "Whiggification", typ: null },
        { json: "accountancy", js: "accountancy", typ: null },
        { json: "cacotrophic", js: "cacotrophic", typ: null },
        { json: "contest", js: "contest", typ: null },
        { json: "couthily", js: "couthily", typ: null },
        { json: "falculate", js: "falculate", typ: null },
        { json: "foreseize", js: "foreseize", typ: null },
        { json: "lemnad", js: "lemnad", typ: null },
        { json: "monotheistically", js: "monotheistically", typ: null },
        { json: "nonflying", js: "nonflying", typ: null },
        { json: "repatch", js: "repatch", typ: null },
        { json: "rodman", js: "rodman", typ: null },
        { json: "strung", js: "strung", typ: null },
        { json: "titmal", js: "titmal", typ: null },
        { json: "twalpennyworth", js: "twalpennyworth", typ: null },
        { json: "unblamable", js: "unblamable", typ: null },
        { json: "vertical", js: "vertical", typ: null },
        { json: "yardman", js: "yardman", typ: null },
    ], false),
    "SantirClass": o([
        { json: "Suessiones", js: "Suessiones", typ: null },
        { json: "admiredly", js: "admiredly", typ: null },
        { json: "demicaponier", js: "demicaponier", typ: null },
        { json: "epitympanic", js: "epitympanic", typ: null },
        { json: "investitor", js: "investitor", typ: null },
        { json: "lupiform", js: "lupiform", typ: null },
        { json: "monoflagellate", js: "monoflagellate", typ: null },
        { json: "paleoethnic", js: "paleoethnic", typ: null },
        { json: "prediscountable", js: "prediscountable", typ: null },
        { json: "rhetoricals", js: "rhetoricals", typ: null },
        { json: "roomth", js: "roomth", typ: null },
        { json: "saccharose", js: "saccharose", typ: null },
        { json: "septonasal", js: "septonasal", typ: null },
        { json: "serpenticide", js: "serpenticide", typ: null },
        { json: "setarious", js: "setarious", typ: null },
        { json: "spaework", js: "spaework", typ: null },
        { json: "stylite", js: "stylite", typ: null },
        { json: "timelily", js: "timelily", typ: null },
        { json: "unprofaned", js: "unprofaned", typ: null },
        { json: "vorticular", js: "vorticular", typ: null },
    ], false),
    "SaxtenClass": o([
        { json: "Centaurid", js: "Centaurid", typ: u(undefined, null) },
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "algarrobilla", js: "algarrobilla", typ: u(undefined, null) },
        { json: "bowgrace", js: "bowgrace", typ: u(undefined, null) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "flix", js: "flix", typ: u(undefined, null) },
        { json: "germanely", js: "germanely", typ: u(undefined, null) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "inhume", js: "inhume", typ: u(undefined, null) },
        { json: "lepidote", js: "lepidote", typ: u(undefined, null) },
        { json: "megalochirous", js: "megalochirous", typ: u(undefined, null) },
        { json: "ninepenny", js: "ninepenny", typ: u(undefined, null) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "nondeist", js: "nondeist", typ: u(undefined, null) },
        { json: "nymphaeaceous", js: "nymphaeaceous", typ: u(undefined, null) },
        { json: "parietofrontal", js: "parietofrontal", typ: u(undefined, null) },
        { json: "sancyite", js: "sancyite", typ: u(undefined, null) },
        { json: "subjectivist", js: "subjectivist", typ: u(undefined, null) },
        { json: "tibiad", js: "tibiad", typ: u(undefined, null) },
        { json: "transonic", js: "transonic", typ: u(undefined, null) },
        { json: "tripetalous", js: "tripetalous", typ: u(undefined, null) },
        { json: "trunchman", js: "trunchman", typ: u(undefined, null) },
        { json: "urger", js: "urger", typ: u(undefined, null) },
        { json: "withdrawnness", js: "withdrawnness", typ: u(undefined, null) },
    ], false),
    "Scatty": o([
        { json: "Tabasco", js: "Tabasco", typ: null },
        { json: "aeriferous", js: "aeriferous", typ: null },
        { json: "antical", js: "antical", typ: null },
        { json: "antighostism", js: "antighostism", typ: null },
        { json: "arcanum", js: "arcanum", typ: null },
        { json: "autotrophy", js: "autotrophy", typ: null },
        { json: "baronial", js: "baronial", typ: null },
        { json: "caffeine", js: "caffeine", typ: null },
        { json: "gorgoniacean", js: "gorgoniacean", typ: null },
        { json: "heroical", js: "heroical", typ: null },
        { json: "hydropical", js: "hydropical", typ: null },
        { json: "mechanology", js: "mechanology", typ: null },
        { json: "musicopoetic", js: "musicopoetic", typ: null },
        { json: "officiality", js: "officiality", typ: null },
        { json: "oftentimes", js: "oftentimes", typ: null },
        { json: "ophthalmotonometer", js: "ophthalmotonometer", typ: null },
        { json: "reflectively", js: "reflectively", typ: null },
        { json: "springer", js: "springer", typ: null },
        { json: "teleianthous", js: "teleianthous", typ: null },
        { json: "uncombated", js: "uncombated", typ: null },
    ], false),
    "SisteringClass": o([
        { json: "Chianti", js: "Chianti", typ: null },
        { json: "Haplomi", js: "Haplomi", typ: null },
        { json: "Micropterygidae", js: "Micropterygidae", typ: null },
        { json: "amphicarpic", js: "amphicarpic", typ: null },
        { json: "frigorific", js: "frigorific", typ: null },
        { json: "hyperkinesis", js: "hyperkinesis", typ: null },
        { json: "laudable", js: "laudable", typ: null },
        { json: "madwoman", js: "madwoman", typ: null },
        { json: "maimedly", js: "maimedly", typ: null },
        { json: "microrhabdus", js: "microrhabdus", typ: null },
        { json: "nondense", js: "nondense", typ: null },
        { json: "phlebemphraxis", js: "phlebemphraxis", typ: null },
        { json: "redsear", js: "redsear", typ: null },
        { json: "schismatical", js: "schismatical", typ: null },
        { json: "tartryl", js: "tartryl", typ: null },
        { json: "unabhorred", js: "unabhorred", typ: null },
        { json: "undeliberateness", js: "undeliberateness", typ: null },
        { json: "unmixable", js: "unmixable", typ: null },
        { json: "untruckling", js: "untruckling", typ: null },
        { json: "vineal", js: "vineal", typ: null },
    ], false),
    "Staghunting": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "calorimetric", js: "calorimetric", typ: u(undefined, i(0)) },
        { json: "canid", js: "canid", typ: u(undefined, i(0)) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "ditriglyphic", js: "ditriglyphic", typ: u(undefined, i(0)) },
        { json: "floriferousness", js: "floriferousness", typ: u(undefined, i(0)) },
        { json: "gamelike", js: "gamelike", typ: u(undefined, i(0)) },
        { json: "grig", js: "grig", typ: u(undefined, i(0)) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "interloan", js: "interloan", typ: u(undefined, i(0)) },
        { json: "lithotomy", js: "lithotomy", typ: u(undefined, i(0)) },
        { json: "loric", js: "loric", typ: u(undefined, i(0)) },
        { json: "membranocoriaceous", js: "membranocoriaceous", typ: u(undefined, i(0)) },
        { json: "membranogenic", js: "membranogenic", typ: u(undefined, i(0)) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "overtrump", js: "overtrump", typ: u(undefined, i(0)) },
        { json: "scotino", js: "scotino", typ: u(undefined, i(0)) },
        { json: "seasonable", js: "seasonable", typ: u(undefined, i(0)) },
        { json: "sephen", js: "sephen", typ: u(undefined, i(0)) },
        { json: "stigmarioid", js: "stigmarioid", typ: u(undefined, i(0)) },
        { json: "tired", js: "tired", typ: u(undefined, i(0)) },
        { json: "trifid", js: "trifid", typ: u(undefined, i(0)) },
        { json: "undefeatedly", js: "undefeatedly", typ: u(undefined, i(0)) },
        { json: "ungirlish", js: "ungirlish", typ: u(undefined, i(0)) },
    ], false),
    "StrenuosityClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Onopordon", js: "Onopordon", typ: u(undefined, i(0)) },
        { json: "Sodomite", js: "Sodomite", typ: u(undefined, i(0)) },
        { json: "Yankeeist", js: "Yankeeist", typ: u(undefined, i(0)) },
        { json: "bliss", js: "bliss", typ: u(undefined, i(0)) },
        { json: "buccate", js: "buccate", typ: u(undefined, i(0)) },
        { json: "bulletproof", js: "bulletproof", typ: u(undefined, i(0)) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "crumblingness", js: "crumblingness", typ: u(undefined, i(0)) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "engagedly", js: "engagedly", typ: u(undefined, i(0)) },
        { json: "fightable", js: "fightable", typ: u(undefined, i(0)) },
        { json: "hoariness", js: "hoariness", typ: u(undefined, i(0)) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "hypopodium", js: "hypopodium", typ: u(undefined, i(0)) },
        { json: "luxurist", js: "luxurist", typ: u(undefined, i(0)) },
        { json: "mechanician", js: "mechanician", typ: u(undefined, i(0)) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "podgily", js: "podgily", typ: u(undefined, i(0)) },
        { json: "reformableness", js: "reformableness", typ: u(undefined, i(0)) },
        { json: "scatterbrains", js: "scatterbrains", typ: u(undefined, i(0)) },
        { json: "seminuria", js: "seminuria", typ: u(undefined, i(0)) },
        { json: "tramp", js: "tramp", typ: u(undefined, i(0)) },
        { json: "undueness", js: "undueness", typ: u(undefined, i(0)) },
        { json: "worthily", js: "worthily", typ: u(undefined, i(0)) },
    ], false),
    "TruantcyClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Epeira", js: "Epeira", typ: u(undefined, null) },
        { json: "Eurylaimi", js: "Eurylaimi", typ: u(undefined, null) },
        { json: "Yuman", js: "Yuman", typ: u(undefined, null) },
        { json: "alfiona", js: "alfiona", typ: u(undefined, null) },
        { json: "ascaridiasis", js: "ascaridiasis", typ: u(undefined, null) },
        { json: "bungey", js: "bungey", typ: u(undefined, null) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "ceroxyle", js: "ceroxyle", typ: u(undefined, null) },
        { json: "chorology", js: "chorology", typ: u(undefined, null) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "enmarble", js: "enmarble", typ: u(undefined, null) },
        { json: "germination", js: "germination", typ: u(undefined, null) },
        { json: "hallelujah", js: "hallelujah", typ: u(undefined, null) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "lev", js: "lev", typ: u(undefined, null) },
        { json: "mouthing", js: "mouthing", typ: u(undefined, null) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "philliloo", js: "philliloo", typ: u(undefined, null) },
        { json: "planetal", js: "planetal", typ: u(undefined, null) },
        { json: "poney", js: "poney", typ: u(undefined, null) },
        { json: "punctualist", js: "punctualist", typ: u(undefined, null) },
        { json: "returnlessly", js: "returnlessly", typ: u(undefined, null) },
        { json: "skelder", js: "skelder", typ: u(undefined, null) },
        { json: "windwaywardly", js: "windwaywardly", typ: u(undefined, null) },
    ], false),
    "UnimpeachablyClass": o([
        { json: "Bobadil", js: "Bobadil", typ: u(undefined, i(0)) },
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Quiina", js: "Quiina", typ: u(undefined, i(0)) },
        { json: "Robert", js: "Robert", typ: u(undefined, i(0)) },
        { json: "acerin", js: "acerin", typ: u(undefined, i(0)) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "chlorophylligenous", js: "chlorophylligenous", typ: u(undefined, i(0)) },
        { json: "conversational", js: "conversational", typ: u(undefined, i(0)) },
        { json: "demiowl", js: "demiowl", typ: u(undefined, i(0)) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "ectorhinal", js: "ectorhinal", typ: u(undefined, i(0)) },
        { json: "gamblesomeness", js: "gamblesomeness", typ: u(undefined, i(0)) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "irrorate", js: "irrorate", typ: u(undefined, i(0)) },
        { json: "kindergartening", js: "kindergartening", typ: u(undefined, i(0)) },
        { json: "lateritic", js: "lateritic", typ: u(undefined, i(0)) },
        { json: "mespil", js: "mespil", typ: u(undefined, i(0)) },
        { json: "misconfiguration", js: "misconfiguration", typ: u(undefined, i(0)) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "planometry", js: "planometry", typ: u(undefined, i(0)) },
        { json: "rot", js: "rot", typ: u(undefined, i(0)) },
        { json: "subcinctorium", js: "subcinctorium", typ: u(undefined, i(0)) },
        { json: "tussocker", js: "tussocker", typ: u(undefined, i(0)) },
        { json: "ultraproud", js: "ultraproud", typ: u(undefined, i(0)) },
        { json: "unsuggestedness", js: "unsuggestedness", typ: u(undefined, i(0)) },
    ], false),
    "UnstressedClass": o([
        { json: "Alain", js: "Alain", typ: null },
        { json: "Amphirhina", js: "Amphirhina", typ: null },
        { json: "Lincolnian", js: "Lincolnian", typ: null },
        { json: "Sarcophilus", js: "Sarcophilus", typ: null },
        { json: "antimachinery", js: "antimachinery", typ: null },
        { json: "coldish", js: "coldish", typ: null },
        { json: "crantara", js: "crantara", typ: null },
        { json: "distinguishing", js: "distinguishing", typ: null },
        { json: "elytroposis", js: "elytroposis", typ: null },
        { json: "gentianwort", js: "gentianwort", typ: null },
        { json: "heliosis", js: "heliosis", typ: null },
        { json: "instrumental", js: "instrumental", typ: null },
        { json: "introinflection", js: "introinflection", typ: null },
        { json: "kala", js: "kala", typ: null },
        { json: "metad", js: "metad", typ: null },
        { json: "swingingly", js: "swingingly", typ: null },
        { json: "unconformity", js: "unconformity", typ: null },
        { json: "undecreed", js: "undecreed", typ: null },
        { json: "venerable", js: "venerable", typ: null },
        { json: "vowellessness", js: "vowellessness", typ: null },
    ], false),
    "WrothyClass": o([
        { json: "Aeschynanthus", js: "Aeschynanthus", typ: null },
        { json: "Ephesine", js: "Ephesine", typ: null },
        { json: "aquiferous", js: "aquiferous", typ: null },
        { json: "cheapener", js: "cheapener", typ: null },
        { json: "enumeration", js: "enumeration", typ: null },
        { json: "escadrille", js: "escadrille", typ: null },
        { json: "estrous", js: "estrous", typ: null },
        { json: "interestedly", js: "interestedly", typ: null },
        { json: "katakinetomer", js: "katakinetomer", typ: null },
        { json: "mortification", js: "mortification", typ: null },
        { json: "morula", js: "morula", typ: null },
        { json: "orthosymmetrical", js: "orthosymmetrical", typ: null },
        { json: "overbark", js: "overbark", typ: null },
        { json: "politist", js: "politist", typ: null },
        { json: "qualified", js: "qualified", typ: null },
        { json: "sphenomalar", js: "sphenomalar", typ: null },
        { json: "throatful", js: "throatful", typ: null },
        { json: "transhumance", js: "transhumance", typ: null },
        { json: "triandrian", js: "triandrian", typ: null },
        { json: "unbooked", js: "unbooked", typ: null },
    ], false),
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
