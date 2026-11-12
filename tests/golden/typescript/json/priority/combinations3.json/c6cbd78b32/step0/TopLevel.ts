// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export type TopLevel = {
    juror:            JurorElement[];
    kongoni:          Kongoni[];
    ladronism:        LadronismElement[];
    landlubberly:     LandlubberlyElement[];
    listener:         Listener[];
    lupus:            LupusElement[];
    maslin:           Maslin[];
    monazite:         MonaziteElement[];
    monoliteral:      Monoliteral[];
    monotheistically: MonotheisticallyElement[];
    montage:          Montage[];
    moralness:        Moralness[];
    mowra:            (MonaziteClass | null)[];
    mulishly:         Mulishly[];
    myoscope:         Myoscope[];
    nach:             ((number | null)[] | null)[];
    neuromastic:      Neuromastic[];
    noncontributing:  Noncontributing[];
    nonnervous:       Nonnervous[];
    nonvaluation:     Nonvaluation[];
    occupationalist:  OccupationalistElement[];
    outrival:         OutrivalElement[];
    paleographically: Paleographically[];
    pamphletwise:     Pamphletwise[];
    pediatrics:       Pediatric[];
    perceptive:       boolean[];
    piaculum:         PiaculumElement[];
    piccadilly:       Piccadilly[];
    piffler:          Piffler[];
    pithful:          Pithful[];
    placuntitis:      Placuntiti[];
    plectopterous:    Plectopterous[];
    pneumocele:       (Pneumocele | null)[];
    poliorcetic:      Poliorcetic[];
    poormaster:       Poormaster[];
    potwhisky:        PotwhiskyElement[];
    practicalizer:    Practicalizer[];
    prefreshman:      PrefreshmanElement[];
    prehensility:     Prehensility[];
    prevoidance:      Prevoidance[];
    probant:          { [key: string]: number | null }[];
    protext:          Protext[];
}

export type JurorElement = boolean | JurorClass;

export type JurorClass = {
    Olea:            null;
    adipsy:          null;
    auxiliator:      null;
    benda:           null;
    benjamin:        null;
    brandling:       null;
    epicurishly:     null;
    eremochaetous:   null;
    marten:          null;
    monocline:       null;
    palgat:          null;
    pennyworth:      null;
    pioury:          null;
    pragmatistic:    null;
    stylelessness:   null;
    systematical:    null;
    thready:         null;
    uncontemporary:  null;
    uncouched:       null;
    uninhabitedness: null;
}

export type Kongoni = number[] | { [key: string]: number };

export type LadronismElement = LadronismClass | number | string;

export type LadronismClass = {
    Prodenia:      null;
    acclaimer:     null;
    achree:        null;
    base:          null;
    conundrumize:  null;
    degerminator:  null;
    describable:   null;
    exasperatedly: null;
    heroine:       null;
    indazin:       null;
    luteous:       null;
    papular:       null;
    pritch:        null;
    seege:         null;
    shopgirl:      null;
    tragedietta:   null;
    unsparse:      null;
    uplook:        null;
    vermiformis:   null;
    whafabout:     null;
}

export type LandlubberlyElement = boolean | LandlubberlyClass | number;

export type LandlubberlyClass = {
    Amyraldism:      null;
    acropoleis:      null;
    aminate:         null;
    bipenniform:     null;
    bugre:           null;
    calycule:        null;
    caoutchouc:      null;
    disprover:       null;
    fitroot:         null;
    fulgently:       null;
    kickup:          null;
    laevoversion:    null;
    moter:           null;
    objectivity:     null;
    posterity:       null;
    postnuptial:     null;
    precedentary:    null;
    saddling:        null;
    subcurrent:      null;
    unrecriminative: null;
}

export type Listener = null[] | number;

export type LupusElement = LupusClass | number;

export type LupusClass = {
    Chirotherium?:    number;
    Chlorioninae?:    number;
    Corvinae?:        number;
    Crassina?:        number;
    Thysanocarpus?:   number;
    catharticalness?: number;
    disdiapason?:     string;
    exiguity?:        number;
    farcist?:         number;
    holographical?:   number;
    homocerc?:        boolean;
    ichthyophagan?:   number;
    implacable?:      number;
    nonbookish?:      null;
    outshiner?:       number;
    overweather?:     number;
    protonegroid?:    number;
    shallowish?:      number;
    snoke?:           number;
    snout?:           number;
    surveillance?:    number;
    threshingtime?:   number;
    unsignificantly?: number;
    unsnap?:          number;
    vendible?:        number;
}

export type Maslin = {
    Alicant?:         number;
    Bakuninist?:      null;
    Chirotherium?:    number;
    Dimitry?:         number;
    antiatonement?:   null;
    anticorrosive?:   number;
    aphidozer?:       null;
    be?:              number;
    catharticalness?: number;
    chub?:            number;
    cuprosilicon?:    number;
    curtailedly?:     number;
    dellenite?:       number;
    disdiapason?:     string;
    edifying?:        null;
    ethmoiditis?:     number;
    gastralgy?:       null;
    goatherd?:        number;
    hammerdress?:     number;
    hangfire?:        null;
    homocerc?:        boolean;
    lacunosity?:      number;
    longiloquence?:   null;
    mameliere?:       number;
    motherless?:      null;
    nonbookish?:      null;
    noncorrodible?:   null;
    nonsensicality?:  null;
    oafishly?:        number;
    pfund?:           null;
    preadvisory?:     null;
    retroflexed?:     null;
    saccharulmic?:    number;
    scowlful?:        number;
    secluded?:        null;
    slackage?:        null;
    sphaeridial?:     number;
    spondulics?:      null;
    subsecive?:       number;
    swellmobsman?:    null;
    trachyglossate?:  number;
    trialogue?:       null;
    unassuaged?:      number;
    ungross?:         null;
    unjudiciously?:   null;
}

export type MonaziteElement = MonaziteClass | number;

export type MonaziteClass = {
    Chirotherium:    number;
    catharticalness: number;
    disdiapason:     string;
    homocerc:        boolean;
    nonbookish:      null;
}

export type Monoliteral = null[] | boolean;

export type MonotheisticallyElement = null[] | MonotheisticallyClass;

export type MonotheisticallyClass = {
    Chirotherium?:       number;
    blaspheme?:          null;
    catharticalness?:    number;
    celiosalpingectomy?: null;
    consummativeness?:   null;
    disdiapason?:        string;
    egestive?:           null;
    enchylema?:          null;
    gasconade?:          null;
    holidayer?:          null;
    homocerc?:           boolean;
    intuitionalism?:     null;
    lophiostomate?:      null;
    nonbookish?:         null;
    nonvolition?:        null;
    palatableness?:      null;
    pimpery?:            null;
    previolation?:       null;
    reconveyance?:       null;
    registership?:       null;
    rhyacolite?:         null;
    smithereens?:        null;
    superedification?:   null;
    trust?:              null;
    whitestone?:         null;
}

export type Montage = null[] | number | string;

export type Moralness = null[] | number | null;

export type Mulishly = number[] | number | null;

export type Myoscope = null[] | boolean | number;

export type Neuromastic = null[] | number;

export type Noncontributing = {
    estevin:     string;
    jolterhead:  number;
    sauternes:   number;
    sparsely:    boolean;
    unrequested: null;
}

export type Nonnervous = boolean | number;

export type Nonvaluation = null[] | boolean | number;

export type OccupationalistElement = null[] | OccupationalistClass | null;

export type OccupationalistClass = {
    Chimakum:         null;
    Fin:              null;
    beholdable:       null;
    brotuliform:      null;
    doodler:          null;
    emulsin:          null;
    flourishing:      null;
    flueless:         null;
    furtively:        null;
    gritter:          null;
    interwish:        null;
    monoxylic:        null;
    myristic:         null;
    nightwear:        null;
    peruser:          null;
    theoastrological: null;
    thumby:           null;
    tingitid:         null;
    trailless:        null;
    unpocketed:       null;
}

export type OutrivalElement = OutrivalClass | number | null;

export type OutrivalClass = {
    Castoroides:     null;
    Czechoslovak:    null;
    Lingulidae:      null;
    adroitly:        null;
    bridehood:       null;
    diagenesis:      null;
    dihexahedron:    null;
    dopester:        null;
    eumerism:        null;
    flyness:         null;
    fouler:          null;
    laudanosine:     null;
    minutary:        null;
    mitra:           null;
    opisthorchiasis: null;
    pensively:       null;
    pubigerous:      null;
    rebellious:      null;
    recodify:        null;
    unpaced:         null;
}

export type Paleographically = number | { [key: string]: number | null };

export type Pamphletwise = number | { [key: string]: number } | string;

export type Pediatric = boolean | number | null;

export type PiaculumElement = PiaculumClass | number;

export type PiaculumClass = {
    Chirotherium?:    number;
    Zipper?:          number;
    alada?:           number;
    amphistomous?:    number;
    boysenberry?:     number;
    catharticalness?: number;
    decardinalize?:   number;
    discouragement?:  number;
    disdiapason?:     string;
    doitrified?:      number;
    hexaspermous?:    number;
    homocerc?:        boolean;
    insinking?:       number;
    loathfulness?:    number;
    miasmatical?:     number;
    neurofibril?:     number;
    nonbookish?:      null;
    phonendoscope?:   number;
    pilferment?:      number;
    predismissory?:   number;
    preinscription?:  number;
    quotative?:       number;
    sienna?:          number;
    thorax?:          number;
    yachting?:        number;
}

export type Piccadilly = number | null | string;

export type Piffler = null[] | MonaziteClass;

export type Pithful = boolean | number | null;

export type Placuntiti = number | { [key: string]: number };

export type Plectopterous = number | { [key: string]: number };

export type Pneumocele = {
    Carbonarism?:     null;
    Chirotherium?:    number;
    Koniga?:          null;
    Micky?:           null;
    catharticalness?: number;
    cineolic?:        null;
    cobbly?:          null;
    conchyliferous?:  null;
    congregation?:    null;
    disdiapason?:     string;
    enterotomy?:      null;
    entophytal?:      null;
    fewtrils?:        null;
    herem?:           null;
    homocerc?:        boolean;
    meticulosity?:    null;
    mismarriage?:     null;
    neurotrophic?:    null;
    nonbookish?:      null;
    persuasively?:    null;
    replaceable?:     null;
    silex?:           null;
    taillight?:       null;
    unjealous?:       null;
    visitorial?:      null;
}

export type Poliorcetic = boolean | MonaziteClass;

export type Poormaster = number[] | { [key: string]: number } | null;

export type PotwhiskyElement = PotwhiskyClass | number | null;

export type PotwhiskyClass = {
    Euchorda:          null;
    Yoruba:            null;
    arciform:          null;
    cresolin:          null;
    disheartener:      null;
    disproportionable: null;
    ferryway:          null;
    filamentiferous:   null;
    flemish:           null;
    forgainst:         null;
    grainering:        null;
    irrevoluble:       null;
    kindredship:       null;
    pinguitudinous:    null;
    simpletonic:       null;
    singsong:          null;
    submergement:      null;
    supraoesophagal:   null;
    thrashel:          null;
    tyremesis:         null;
}

export type Practicalizer = null[] | MonaziteClass | string;

export type PrefreshmanElement = null[] | PrefreshmanClass | string;

export type PrefreshmanClass = {
    Dolphus:       null;
    Ficus:         null;
    Gemaric:       null;
    Phaet:         null;
    azorubine:     null;
    choroiditis:   null;
    coagulatory:   null;
    cyclorama:     null;
    duckhearted:   null;
    jugation:      null;
    myoliposis:    null;
    nonnomination: null;
    palay:         null;
    pentactinal:   null;
    piquant:       null;
    registration:  null;
    remancipation: null;
    scutatiform:   null;
    theodolite:    null;
    underward:     null;
}

export type Prehensility = null[] | boolean | MonaziteClass;

export type Prevoidance = number[] | MonaziteClass | number;

export type Protext = number[] | boolean | MonaziteClass;

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
        { json: "juror", js: "juror", typ: a(u(true, r("JurorClass"))) },
        { json: "kongoni", js: "kongoni", typ: a(u(a(i(0)), m(i(0)))) },
        { json: "ladronism", js: "ladronism", typ: a(u(r("LadronismClass"), 3.14, "")) },
        { json: "landlubberly", js: "landlubberly", typ: a(u(true, r("LandlubberlyClass"), i(0))) },
        { json: "listener", js: "listener", typ: a(u(a(null), i(0))) },
        { json: "lupus", js: "lupus", typ: a(u(r("LupusClass"), i(0))) },
        { json: "maslin", js: "maslin", typ: a(r("Maslin")) },
        { json: "monazite", js: "monazite", typ: a(u(r("MonaziteClass"), 3.14)) },
        { json: "monoliteral", js: "monoliteral", typ: a(u(a(null), true)) },
        { json: "monotheistically", js: "monotheistically", typ: a(u(a(null), r("MonotheisticallyClass"))) },
        { json: "montage", js: "montage", typ: a(u(a(null), 3.14, "")) },
        { json: "moralness", js: "moralness", typ: a(u(a(null), 3.14, null)) },
        { json: "mowra", js: "mowra", typ: a(u(r("MonaziteClass"), null)) },
        { json: "mulishly", js: "mulishly", typ: a(u(a(i(0)), 3.14, null)) },
        { json: "myoscope", js: "myoscope", typ: a(u(a(null), true, i(0))) },
        { json: "nach", js: "nach", typ: a(u(a(u(i(0), null)), null)) },
        { json: "neuromastic", js: "neuromastic", typ: a(u(a(null), 3.14)) },
        { json: "noncontributing", js: "noncontributing", typ: a(r("Noncontributing")) },
        { json: "nonnervous", js: "nonnervous", typ: a(u(true, i(0))) },
        { json: "nonvaluation", js: "nonvaluation", typ: a(u(a(null), true, 3.14)) },
        { json: "occupationalist", js: "occupationalist", typ: a(u(a(null), r("OccupationalistClass"), null)) },
        { json: "outrival", js: "outrival", typ: a(u(r("OutrivalClass"), 3.14, null)) },
        { json: "paleographically", js: "paleographically", typ: a(u(3.14, m(u(i(0), null)))) },
        { json: "pamphletwise", js: "pamphletwise", typ: a(u(i(0), m(i(0)), "")) },
        { json: "pediatrics", js: "pediatrics", typ: a(u(true, 3.14, null)) },
        { json: "perceptive", js: "perceptive", typ: a(true) },
        { json: "piaculum", js: "piaculum", typ: a(u(r("PiaculumClass"), 3.14)) },
        { json: "piccadilly", js: "piccadilly", typ: a(u(3.14, null, "")) },
        { json: "piffler", js: "piffler", typ: a(u(a(null), r("MonaziteClass"))) },
        { json: "pithful", js: "pithful", typ: a(u(true, i(0), null)) },
        { json: "placuntitis", js: "placuntitis", typ: a(u(i(0), m(i(0)))) },
        { json: "plectopterous", js: "plectopterous", typ: a(u(3.14, m(i(0)))) },
        { json: "pneumocele", js: "pneumocele", typ: a(u(r("Pneumocele"), null)) },
        { json: "poliorcetic", js: "poliorcetic", typ: a(u(true, r("MonaziteClass"))) },
        { json: "poormaster", js: "poormaster", typ: a(u(a(i(0)), m(i(0)), null)) },
        { json: "potwhisky", js: "potwhisky", typ: a(u(r("PotwhiskyClass"), i(0), null)) },
        { json: "practicalizer", js: "practicalizer", typ: a(u(a(null), r("MonaziteClass"), "")) },
        { json: "prefreshman", js: "prefreshman", typ: a(u(a(null), r("PrefreshmanClass"), "")) },
        { json: "prehensility", js: "prehensility", typ: a(u(a(null), true, r("MonaziteClass"))) },
        { json: "prevoidance", js: "prevoidance", typ: a(u(a(i(0)), r("MonaziteClass"), i(0))) },
        { json: "probant", js: "probant", typ: a(m(u(i(0), null))) },
        { json: "protext", js: "protext", typ: a(u(a(i(0)), true, r("MonaziteClass"))) },
    ], false),
    "JurorClass": o([
        { json: "Olea", js: "Olea", typ: null },
        { json: "adipsy", js: "adipsy", typ: null },
        { json: "auxiliator", js: "auxiliator", typ: null },
        { json: "benda", js: "benda", typ: null },
        { json: "benjamin", js: "benjamin", typ: null },
        { json: "brandling", js: "brandling", typ: null },
        { json: "epicurishly", js: "epicurishly", typ: null },
        { json: "eremochaetous", js: "eremochaetous", typ: null },
        { json: "marten", js: "marten", typ: null },
        { json: "monocline", js: "monocline", typ: null },
        { json: "palgat", js: "palgat", typ: null },
        { json: "pennyworth", js: "pennyworth", typ: null },
        { json: "pioury", js: "pioury", typ: null },
        { json: "pragmatistic", js: "pragmatistic", typ: null },
        { json: "stylelessness", js: "stylelessness", typ: null },
        { json: "systematical", js: "systematical", typ: null },
        { json: "thready", js: "thready", typ: null },
        { json: "uncontemporary", js: "uncontemporary", typ: null },
        { json: "uncouched", js: "uncouched", typ: null },
        { json: "uninhabitedness", js: "uninhabitedness", typ: null },
    ], false),
    "LadronismClass": o([
        { json: "Prodenia", js: "Prodenia", typ: null },
        { json: "acclaimer", js: "acclaimer", typ: null },
        { json: "achree", js: "achree", typ: null },
        { json: "base", js: "base", typ: null },
        { json: "conundrumize", js: "conundrumize", typ: null },
        { json: "degerminator", js: "degerminator", typ: null },
        { json: "describable", js: "describable", typ: null },
        { json: "exasperatedly", js: "exasperatedly", typ: null },
        { json: "heroine", js: "heroine", typ: null },
        { json: "indazin", js: "indazin", typ: null },
        { json: "luteous", js: "luteous", typ: null },
        { json: "papular", js: "papular", typ: null },
        { json: "pritch", js: "pritch", typ: null },
        { json: "seege", js: "seege", typ: null },
        { json: "shopgirl", js: "shopgirl", typ: null },
        { json: "tragedietta", js: "tragedietta", typ: null },
        { json: "unsparse", js: "unsparse", typ: null },
        { json: "uplook", js: "uplook", typ: null },
        { json: "vermiformis", js: "vermiformis", typ: null },
        { json: "whafabout", js: "whafabout", typ: null },
    ], false),
    "LandlubberlyClass": o([
        { json: "Amyraldism", js: "Amyraldism", typ: null },
        { json: "acropoleis", js: "acropoleis", typ: null },
        { json: "aminate", js: "aminate", typ: null },
        { json: "bipenniform", js: "bipenniform", typ: null },
        { json: "bugre", js: "bugre", typ: null },
        { json: "calycule", js: "calycule", typ: null },
        { json: "caoutchouc", js: "caoutchouc", typ: null },
        { json: "disprover", js: "disprover", typ: null },
        { json: "fitroot", js: "fitroot", typ: null },
        { json: "fulgently", js: "fulgently", typ: null },
        { json: "kickup", js: "kickup", typ: null },
        { json: "laevoversion", js: "laevoversion", typ: null },
        { json: "moter", js: "moter", typ: null },
        { json: "objectivity", js: "objectivity", typ: null },
        { json: "posterity", js: "posterity", typ: null },
        { json: "postnuptial", js: "postnuptial", typ: null },
        { json: "precedentary", js: "precedentary", typ: null },
        { json: "saddling", js: "saddling", typ: null },
        { json: "subcurrent", js: "subcurrent", typ: null },
        { json: "unrecriminative", js: "unrecriminative", typ: null },
    ], false),
    "LupusClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Chlorioninae", js: "Chlorioninae", typ: u(undefined, i(0)) },
        { json: "Corvinae", js: "Corvinae", typ: u(undefined, i(0)) },
        { json: "Crassina", js: "Crassina", typ: u(undefined, i(0)) },
        { json: "Thysanocarpus", js: "Thysanocarpus", typ: u(undefined, i(0)) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "exiguity", js: "exiguity", typ: u(undefined, i(0)) },
        { json: "farcist", js: "farcist", typ: u(undefined, i(0)) },
        { json: "holographical", js: "holographical", typ: u(undefined, i(0)) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "ichthyophagan", js: "ichthyophagan", typ: u(undefined, i(0)) },
        { json: "implacable", js: "implacable", typ: u(undefined, i(0)) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "outshiner", js: "outshiner", typ: u(undefined, i(0)) },
        { json: "overweather", js: "overweather", typ: u(undefined, i(0)) },
        { json: "protonegroid", js: "protonegroid", typ: u(undefined, i(0)) },
        { json: "shallowish", js: "shallowish", typ: u(undefined, i(0)) },
        { json: "snoke", js: "snoke", typ: u(undefined, i(0)) },
        { json: "snout", js: "snout", typ: u(undefined, i(0)) },
        { json: "surveillance", js: "surveillance", typ: u(undefined, i(0)) },
        { json: "threshingtime", js: "threshingtime", typ: u(undefined, i(0)) },
        { json: "unsignificantly", js: "unsignificantly", typ: u(undefined, i(0)) },
        { json: "unsnap", js: "unsnap", typ: u(undefined, i(0)) },
        { json: "vendible", js: "vendible", typ: u(undefined, i(0)) },
    ], false),
    "Maslin": o([
        { json: "Alicant", js: "Alicant", typ: u(undefined, i(0)) },
        { json: "Bakuninist", js: "Bakuninist", typ: u(undefined, null) },
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Dimitry", js: "Dimitry", typ: u(undefined, i(0)) },
        { json: "antiatonement", js: "antiatonement", typ: u(undefined, null) },
        { json: "anticorrosive", js: "anticorrosive", typ: u(undefined, i(0)) },
        { json: "aphidozer", js: "aphidozer", typ: u(undefined, null) },
        { json: "be", js: "be", typ: u(undefined, i(0)) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "chub", js: "chub", typ: u(undefined, i(0)) },
        { json: "cuprosilicon", js: "cuprosilicon", typ: u(undefined, i(0)) },
        { json: "curtailedly", js: "curtailedly", typ: u(undefined, i(0)) },
        { json: "dellenite", js: "dellenite", typ: u(undefined, i(0)) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "edifying", js: "edifying", typ: u(undefined, null) },
        { json: "ethmoiditis", js: "ethmoiditis", typ: u(undefined, i(0)) },
        { json: "gastralgy", js: "gastralgy", typ: u(undefined, null) },
        { json: "goatherd", js: "goatherd", typ: u(undefined, i(0)) },
        { json: "hammerdress", js: "hammerdress", typ: u(undefined, i(0)) },
        { json: "hangfire", js: "hangfire", typ: u(undefined, null) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "lacunosity", js: "lacunosity", typ: u(undefined, i(0)) },
        { json: "longiloquence", js: "longiloquence", typ: u(undefined, null) },
        { json: "mameliere", js: "mameliere", typ: u(undefined, i(0)) },
        { json: "motherless", js: "motherless", typ: u(undefined, null) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "noncorrodible", js: "noncorrodible", typ: u(undefined, null) },
        { json: "nonsensicality", js: "nonsensicality", typ: u(undefined, null) },
        { json: "oafishly", js: "oafishly", typ: u(undefined, i(0)) },
        { json: "pfund", js: "pfund", typ: u(undefined, null) },
        { json: "preadvisory", js: "preadvisory", typ: u(undefined, null) },
        { json: "retroflexed", js: "retroflexed", typ: u(undefined, null) },
        { json: "saccharulmic", js: "saccharulmic", typ: u(undefined, i(0)) },
        { json: "scowlful", js: "scowlful", typ: u(undefined, i(0)) },
        { json: "secluded", js: "secluded", typ: u(undefined, null) },
        { json: "slackage", js: "slackage", typ: u(undefined, null) },
        { json: "sphaeridial", js: "sphaeridial", typ: u(undefined, i(0)) },
        { json: "spondulics", js: "spondulics", typ: u(undefined, null) },
        { json: "subsecive", js: "subsecive", typ: u(undefined, i(0)) },
        { json: "swellmobsman", js: "swellmobsman", typ: u(undefined, null) },
        { json: "trachyglossate", js: "trachyglossate", typ: u(undefined, i(0)) },
        { json: "trialogue", js: "trialogue", typ: u(undefined, null) },
        { json: "unassuaged", js: "unassuaged", typ: u(undefined, i(0)) },
        { json: "ungross", js: "ungross", typ: u(undefined, null) },
        { json: "unjudiciously", js: "unjudiciously", typ: u(undefined, null) },
    ], false),
    "MonaziteClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: i(0) },
        { json: "catharticalness", js: "catharticalness", typ: 3.14 },
        { json: "disdiapason", js: "disdiapason", typ: "" },
        { json: "homocerc", js: "homocerc", typ: true },
        { json: "nonbookish", js: "nonbookish", typ: null },
    ], false),
    "MonotheisticallyClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "blaspheme", js: "blaspheme", typ: u(undefined, null) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "celiosalpingectomy", js: "celiosalpingectomy", typ: u(undefined, null) },
        { json: "consummativeness", js: "consummativeness", typ: u(undefined, null) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "egestive", js: "egestive", typ: u(undefined, null) },
        { json: "enchylema", js: "enchylema", typ: u(undefined, null) },
        { json: "gasconade", js: "gasconade", typ: u(undefined, null) },
        { json: "holidayer", js: "holidayer", typ: u(undefined, null) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "intuitionalism", js: "intuitionalism", typ: u(undefined, null) },
        { json: "lophiostomate", js: "lophiostomate", typ: u(undefined, null) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "nonvolition", js: "nonvolition", typ: u(undefined, null) },
        { json: "palatableness", js: "palatableness", typ: u(undefined, null) },
        { json: "pimpery", js: "pimpery", typ: u(undefined, null) },
        { json: "previolation", js: "previolation", typ: u(undefined, null) },
        { json: "reconveyance", js: "reconveyance", typ: u(undefined, null) },
        { json: "registership", js: "registership", typ: u(undefined, null) },
        { json: "rhyacolite", js: "rhyacolite", typ: u(undefined, null) },
        { json: "smithereens", js: "smithereens", typ: u(undefined, null) },
        { json: "superedification", js: "superedification", typ: u(undefined, null) },
        { json: "trust", js: "trust", typ: u(undefined, null) },
        { json: "whitestone", js: "whitestone", typ: u(undefined, null) },
    ], false),
    "Noncontributing": o([
        { json: "estevin", js: "estevin", typ: "" },
        { json: "jolterhead", js: "jolterhead", typ: 3.14 },
        { json: "sauternes", js: "sauternes", typ: i(0) },
        { json: "sparsely", js: "sparsely", typ: true },
        { json: "unrequested", js: "unrequested", typ: null },
    ], false),
    "OccupationalistClass": o([
        { json: "Chimakum", js: "Chimakum", typ: null },
        { json: "Fin", js: "Fin", typ: null },
        { json: "beholdable", js: "beholdable", typ: null },
        { json: "brotuliform", js: "brotuliform", typ: null },
        { json: "doodler", js: "doodler", typ: null },
        { json: "emulsin", js: "emulsin", typ: null },
        { json: "flourishing", js: "flourishing", typ: null },
        { json: "flueless", js: "flueless", typ: null },
        { json: "furtively", js: "furtively", typ: null },
        { json: "gritter", js: "gritter", typ: null },
        { json: "interwish", js: "interwish", typ: null },
        { json: "monoxylic", js: "monoxylic", typ: null },
        { json: "myristic", js: "myristic", typ: null },
        { json: "nightwear", js: "nightwear", typ: null },
        { json: "peruser", js: "peruser", typ: null },
        { json: "theoastrological", js: "theoastrological", typ: null },
        { json: "thumby", js: "thumby", typ: null },
        { json: "tingitid", js: "tingitid", typ: null },
        { json: "trailless", js: "trailless", typ: null },
        { json: "unpocketed", js: "unpocketed", typ: null },
    ], false),
    "OutrivalClass": o([
        { json: "Castoroides", js: "Castoroides", typ: null },
        { json: "Czechoslovak", js: "Czechoslovak", typ: null },
        { json: "Lingulidae", js: "Lingulidae", typ: null },
        { json: "adroitly", js: "adroitly", typ: null },
        { json: "bridehood", js: "bridehood", typ: null },
        { json: "diagenesis", js: "diagenesis", typ: null },
        { json: "dihexahedron", js: "dihexahedron", typ: null },
        { json: "dopester", js: "dopester", typ: null },
        { json: "eumerism", js: "eumerism", typ: null },
        { json: "flyness", js: "flyness", typ: null },
        { json: "fouler", js: "fouler", typ: null },
        { json: "laudanosine", js: "laudanosine", typ: null },
        { json: "minutary", js: "minutary", typ: null },
        { json: "mitra", js: "mitra", typ: null },
        { json: "opisthorchiasis", js: "opisthorchiasis", typ: null },
        { json: "pensively", js: "pensively", typ: null },
        { json: "pubigerous", js: "pubigerous", typ: null },
        { json: "rebellious", js: "rebellious", typ: null },
        { json: "recodify", js: "recodify", typ: null },
        { json: "unpaced", js: "unpaced", typ: null },
    ], false),
    "PiaculumClass": o([
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Zipper", js: "Zipper", typ: u(undefined, i(0)) },
        { json: "alada", js: "alada", typ: u(undefined, i(0)) },
        { json: "amphistomous", js: "amphistomous", typ: u(undefined, i(0)) },
        { json: "boysenberry", js: "boysenberry", typ: u(undefined, i(0)) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "decardinalize", js: "decardinalize", typ: u(undefined, i(0)) },
        { json: "discouragement", js: "discouragement", typ: u(undefined, i(0)) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "doitrified", js: "doitrified", typ: u(undefined, i(0)) },
        { json: "hexaspermous", js: "hexaspermous", typ: u(undefined, i(0)) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "insinking", js: "insinking", typ: u(undefined, i(0)) },
        { json: "loathfulness", js: "loathfulness", typ: u(undefined, i(0)) },
        { json: "miasmatical", js: "miasmatical", typ: u(undefined, i(0)) },
        { json: "neurofibril", js: "neurofibril", typ: u(undefined, i(0)) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "phonendoscope", js: "phonendoscope", typ: u(undefined, i(0)) },
        { json: "pilferment", js: "pilferment", typ: u(undefined, i(0)) },
        { json: "predismissory", js: "predismissory", typ: u(undefined, i(0)) },
        { json: "preinscription", js: "preinscription", typ: u(undefined, i(0)) },
        { json: "quotative", js: "quotative", typ: u(undefined, i(0)) },
        { json: "sienna", js: "sienna", typ: u(undefined, i(0)) },
        { json: "thorax", js: "thorax", typ: u(undefined, i(0)) },
        { json: "yachting", js: "yachting", typ: u(undefined, i(0)) },
    ], false),
    "Pneumocele": o([
        { json: "Carbonarism", js: "Carbonarism", typ: u(undefined, null) },
        { json: "Chirotherium", js: "Chirotherium", typ: u(undefined, i(0)) },
        { json: "Koniga", js: "Koniga", typ: u(undefined, null) },
        { json: "Micky", js: "Micky", typ: u(undefined, null) },
        { json: "catharticalness", js: "catharticalness", typ: u(undefined, 3.14) },
        { json: "cineolic", js: "cineolic", typ: u(undefined, null) },
        { json: "cobbly", js: "cobbly", typ: u(undefined, null) },
        { json: "conchyliferous", js: "conchyliferous", typ: u(undefined, null) },
        { json: "congregation", js: "congregation", typ: u(undefined, null) },
        { json: "disdiapason", js: "disdiapason", typ: u(undefined, "") },
        { json: "enterotomy", js: "enterotomy", typ: u(undefined, null) },
        { json: "entophytal", js: "entophytal", typ: u(undefined, null) },
        { json: "fewtrils", js: "fewtrils", typ: u(undefined, null) },
        { json: "herem", js: "herem", typ: u(undefined, null) },
        { json: "homocerc", js: "homocerc", typ: u(undefined, true) },
        { json: "meticulosity", js: "meticulosity", typ: u(undefined, null) },
        { json: "mismarriage", js: "mismarriage", typ: u(undefined, null) },
        { json: "neurotrophic", js: "neurotrophic", typ: u(undefined, null) },
        { json: "nonbookish", js: "nonbookish", typ: u(undefined, null) },
        { json: "persuasively", js: "persuasively", typ: u(undefined, null) },
        { json: "replaceable", js: "replaceable", typ: u(undefined, null) },
        { json: "silex", js: "silex", typ: u(undefined, null) },
        { json: "taillight", js: "taillight", typ: u(undefined, null) },
        { json: "unjealous", js: "unjealous", typ: u(undefined, null) },
        { json: "visitorial", js: "visitorial", typ: u(undefined, null) },
    ], false),
    "PotwhiskyClass": o([
        { json: "Euchorda", js: "Euchorda", typ: null },
        { json: "Yoruba", js: "Yoruba", typ: null },
        { json: "arciform", js: "arciform", typ: null },
        { json: "cresolin", js: "cresolin", typ: null },
        { json: "disheartener", js: "disheartener", typ: null },
        { json: "disproportionable", js: "disproportionable", typ: null },
        { json: "ferryway", js: "ferryway", typ: null },
        { json: "filamentiferous", js: "filamentiferous", typ: null },
        { json: "flemish", js: "flemish", typ: null },
        { json: "forgainst", js: "forgainst", typ: null },
        { json: "grainering", js: "grainering", typ: null },
        { json: "irrevoluble", js: "irrevoluble", typ: null },
        { json: "kindredship", js: "kindredship", typ: null },
        { json: "pinguitudinous", js: "pinguitudinous", typ: null },
        { json: "simpletonic", js: "simpletonic", typ: null },
        { json: "singsong", js: "singsong", typ: null },
        { json: "submergement", js: "submergement", typ: null },
        { json: "supraoesophagal", js: "supraoesophagal", typ: null },
        { json: "thrashel", js: "thrashel", typ: null },
        { json: "tyremesis", js: "tyremesis", typ: null },
    ], false),
    "PrefreshmanClass": o([
        { json: "Dolphus", js: "Dolphus", typ: null },
        { json: "Ficus", js: "Ficus", typ: null },
        { json: "Gemaric", js: "Gemaric", typ: null },
        { json: "Phaet", js: "Phaet", typ: null },
        { json: "azorubine", js: "azorubine", typ: null },
        { json: "choroiditis", js: "choroiditis", typ: null },
        { json: "coagulatory", js: "coagulatory", typ: null },
        { json: "cyclorama", js: "cyclorama", typ: null },
        { json: "duckhearted", js: "duckhearted", typ: null },
        { json: "jugation", js: "jugation", typ: null },
        { json: "myoliposis", js: "myoliposis", typ: null },
        { json: "nonnomination", js: "nonnomination", typ: null },
        { json: "palay", js: "palay", typ: null },
        { json: "pentactinal", js: "pentactinal", typ: null },
        { json: "piquant", js: "piquant", typ: null },
        { json: "registration", js: "registration", typ: null },
        { json: "remancipation", js: "remancipation", typ: null },
        { json: "scutatiform", js: "scutatiform", typ: null },
        { json: "theodolite", js: "theodolite", typ: null },
        { json: "underward", js: "underward", typ: null },
    ], false),
};
