// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface TopLevel {
    centrodesmose:      string;
    cerograph:          CerographElement[];
    chemotherapeutics:  ChemotherapeuticElement[];
    cimelia:            CimeliaElement[];
    citrated:           number;
    clinodome:          Clinodome[];
    coadjust:           CoadjustElement[];
    consilience:        Consilience[];
    constructor:        Constructor[];
    continuative:       Continuative[];
    credulity:          CredulityElement[];
    creviced:           Creviced[];
    cubiculum:          Array<(number | null)[]>;
    deruralize:         DeruralizeElement[];
    diaereses:          DiaereseElement[];
    dissolution:        (null[] | null)[];
    downstroke:         Downstroke[];
    electrotautomerism: (number | null)[];
    eleutheromania:     Eleutheromania[];
    encrust:            Encrust;
    entomoid:           Entomoid[];
    epipaleolithic:     Epipaleolithic[];
    expropriable:       Expropriable[];
    faggingly:          FagginglyElement[];
    fenks:              FenkElement[];
    flagmaking:         FlagmakingElement[];
    fluorometer:        Fluorometer[];
    fulsome:            (number | null)[];
    fuzzy:              Fuzzy[];
    gardenwards:        Gardenward[];
    generalissimo:      Generalissimo[];
    habeas:             ({ [key: string]: number } | null)[];
    hemicrystalline:    Hemicrystalline[];
    hemocoele:          HemocoeleElement[];
    hoister:            Hoister[];
    hyperpiesis:        Hyperpiesi[];
    hyppish:            Hyppish[];
    idealizer:          Idealizer[];
    incrustator:        Incrustator[];
    intentiveness:      Intentiveness[];
    interacinar:        Interacinar;
    intercorrelation:   (number[] | null)[];
    jacutinga:          Jacutinga[];
}

export type CerographElement = CerographClass | null | string;

export interface CerographClass {
    Tolowa:             null;
    apotropaion:        null;
    casuary:            null;
    creaker:            null;
    disqualification:   null;
    imperatorious:      null;
    impermeabilize:     null;
    metastoma:          null;
    noctidiurnal:       null;
    nonreserve:         null;
    ophthalmotonometry: null;
    pailful:            null;
    pigfish:            null;
    pongee:             null;
    prosodical:         null;
    scrofuloderm:       null;
    storekeeping:       null;
    therologist:        null;
    tradeful:           null;
    unriveting:         null;
}

export type ChemotherapeuticElement = ChemotherapeuticClass | number;

export interface ChemotherapeuticClass {
    Chirotherium?:      number;
    Maureen?:           null;
    angioneurotic?:     null;
    availment?:         null;
    bladelet?:          null;
    catharticalness?:   number;
    caulis?:            null;
    chalcus?:           null;
    disdiapason?:       string;
    enteradenological?: null;
    homocerc?:          boolean;
    imporosity?:        null;
    insistently?:       null;
    intraparietal?:     null;
    ivied?:             null;
    nonbookish?:        null;
    nostochine?:        null;
    nutcracker?:        null;
    ofttimes?:          null;
    phenocryst?:        null;
    precoincident?:     null;
    ramiferous?:        null;
    stagmometer?:       null;
    tetherball?:        null;
    unshy?:             null;
}

export type CimeliaElement = number[] | CimeliaClass | null;

export interface CimeliaClass {
    Chirotherium:    number;
    catharticalness: number;
    disdiapason:     string;
    homocerc:        boolean;
    nonbookish:      null;
}

export type Clinodome = number | string;

export type CoadjustElement = CoadjustClass | number;

export interface CoadjustClass {
    Benny?:            null;
    Chirotherium?:     number;
    Netherlandish?:    null;
    Phonelescope?:     null;
    Sedaceae?:         null;
    amidosulphonal?:   null;
    catharticalness?:  number;
    disdiapason?:      string;
    ensnare?:          null;
    homocerc?:         boolean;
    hybridizer?:       null;
    leastwise?:        null;
    lof?:              null;
    monkhood?:         null;
    nonbookish?:       null;
    peonism?:          null;
    porphyrogeniture?: null;
    preindemnify?:     null;
    rosal?:            null;
    scalenous?:        null;
    scopine?:          null;
    suberinize?:       null;
    symbiot?:          null;
    tablefellow?:      null;
    unchargeable?:     null;
}

export type Consilience = number | { [key: string]: number };

export type Constructor = boolean | { [key: string]: number | null };

export type Continuative = { [key: string]: number } | string;

export type CredulityElement = CredulityClass | number | string;

export interface CredulityClass {
    Flavia:               null;
    Hedychium:            null;
    Popean:               null;
    ammonolytic:          null;
    bushmaster:           null;
    considering:          null;
    consuetudinary:       null;
    embarras:             null;
    fineness:             null;
    flaithship:           null;
    gruffly:              null;
    leadwort:             null;
    overseriously:        null;
    parabola:             null;
    pectinatodenticulate: null;
    pornocrat:            null;
    quadrisect:           null;
    seriality:            null;
    vamphorn:             null;
    wharp:                null;
}

export type Creviced = boolean | { [key: string]: number } | string;

export type DeruralizeElement = null[] | boolean | DeruralizeClass;

export interface DeruralizeClass {
    Jehovistic:     null;
    Paninean:       null;
    Romney:         null;
    bockerel:       null;
    boulder:        null;
    churrus:        null;
    counterdigged:  null;
    dialogite:      null;
    digenic:        null;
    dunbird:        null;
    ergatogyne:     null;
    fiendful:       null;
    jackrod:        null;
    panther:        null;
    placentigerous: null;
    sparm:          null;
    tocsin:         null;
    unnicked:       null;
    unstavable:     null;
    windfirm:       null;
}

export type DiaereseElement = number[] | boolean | DiaereseClass;

export interface DiaereseClass {
    Amoreuxia:         null;
    ani:               null;
    bernicle:          null;
    blackwasher:       null;
    blowhard:          null;
    broma:             null;
    closecross:        null;
    congregationalism: null;
    grayly:            null;
    historically:      null;
    hoast:             null;
    irretentive:       null;
    parcener:          null;
    pedder:            null;
    pseudoanatomic:    null;
    rhizocarpian:      null;
    samel:             null;
    silker:            null;
    subdentated:       null;
    subobscure:        null;
}

export type Downstroke = null[] | boolean | string;

export type Eleutheromania = number | { [key: string]: number } | string;

export interface Encrust {
    Hibernia:        null;
    Hibiscus:        null;
    Lepidosauria:    null;
    Syllidae:        null;
    comradely:       null;
    diacanthous:     null;
    feminineness:    null;
    gossamered:      null;
    lollingly:       null;
    manager:         null;
    mechanic:        null;
    overminuteness:  null;
    papelonne:       null;
    plebification:   null;
    pugmiller:       null;
    recoveror:       null;
    spermatoblastic: null;
    ungyved:         null;
    whirlabout:      null;
    woodenware:      null;
}

export type Entomoid = CimeliaClass | number;

export type Epipaleolithic = number[] | number;

export type Expropriable = null[] | CimeliaClass | number;

export type FagginglyElement = FagginglyClass | number;

export interface FagginglyClass {
    Anglic:          null;
    Heteromeri:      null;
    Poinsettia:      null;
    abranchian:      null;
    aculeiform:      null;
    adiaphoristic:   null;
    adoptionism:     null;
    antrotomy:       null;
    coerciveness:    null;
    decorist:        null;
    duckhood:        null;
    hypochnose:      null;
    lochage:         null;
    melee:           null;
    nonconformitant: null;
    putatively:      null;
    semivolatile:    null;
    soleas:          null;
    unfastenable:    null;
    unmillinered:    null;
}

export type FenkElement = FenkClass | string;

export interface FenkClass {
    Dagomba:       null;
    Guyandot:      null;
    Reinwardtia:   null;
    Tritoness:     null;
    apoise:        null;
    astronomize:   null;
    cockhorse:     null;
    copular:       null;
    draffy:        null;
    foreigner:     null;
    neurogliosis:  null;
    osmious:       null;
    palpitate:     null;
    rebukeable:    null;
    reservatory:   null;
    scalt:         null;
    scripturalize: null;
    tintometer:    null;
    undergrade:    null;
    undermountain: null;
}

export type FlagmakingElement = boolean | FlagmakingClass | number;

export interface FlagmakingClass {
    Bunodonta:         null;
    Hydrocorisae:      null;
    Notacanthidae:     null;
    albarco:           null;
    hornify:           null;
    hypoglossus:       null;
    inexpiably:        null;
    ingratitude:       null;
    ladyfly:           null;
    medicament:        null;
    monogrammatic:     null;
    nobbut:            null;
    polyplacophore:    null;
    proexercise:       null;
    protoplast:        null;
    puzzling:          null;
    splanchnoskeleton: null;
    unloveliness:      null;
    unquarantined:     null;
    unrenounceable:    null;
}

export type Fluorometer = number | null | string;

export type Fuzzy = number | { [key: string]: number | null };

export type Gardenward = number[] | boolean | string;

export type Generalissimo = boolean | { [key: string]: number } | null;

export type Hemicrystalline = CimeliaClass | string;

export type HemocoeleElement = number[] | HemocoeleClass;

export interface HemocoeleClass {
    Chirotherium?:      number;
    Walt?:              null;
    acrogamy?:          null;
    amelification?:     null;
    autobiographic?:    null;
    berat?:             null;
    catharticalness?:   number;
    disdiapason?:       string;
    disproportionably?: null;
    erythrite?:         null;
    graphic?:           null;
    hepatological?:     null;
    homocerc?:          boolean;
    incommensurably?:   null;
    misaffirm?:         null;
    nonbookish?:        null;
    pocketbook?:        null;
    sclerometric?:      null;
    stambouline?:       null;
    stickpin?:          null;
    tubulure?:          null;
    undelated?:         null;
    unsalt?:            null;
    untutelar?:         null;
    vagrant?:           null;
}

export type Hoister = CimeliaClass | null | string;

export type Hyperpiesi = null[] | CimeliaClass | null;

export type Hyppish = boolean | null | string;

export type Idealizer = null[] | CimeliaClass | number;

export type Incrustator = number[] | number | string;

export type Intentiveness = CimeliaClass | number | string;

export interface Interacinar {
    assapan:        number;
    benefactorship: boolean;
    triseriatim:    string;
    tubbing:        number;
    untrimmed:      null;
}

export type Jacutinga = number[] | { [key: string]: number | null };

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export class Convert {
    public static toTopLevel(json: string): TopLevel {
        return cast(JSON.parse(json), r("TopLevel"));
    }

    public static topLevelToJson(value: TopLevel): string {
        return JSON.stringify(uncast(value, r("TopLevel")), null, 2);
    }
}

function invalidValue(typ: any, val: any, key: any, parent: any = ''): never {
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
