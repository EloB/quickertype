// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);

export interface TopLevel {
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

export interface JurorClass {
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

export interface LadronismClass {
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

export interface LandlubberlyClass {
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

export interface LupusClass {
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

export interface Maslin {
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

export interface MonaziteClass {
    Chirotherium:    number;
    catharticalness: number;
    disdiapason:     string;
    homocerc:        boolean;
    nonbookish:      null;
}

export type Monoliteral = null[] | boolean;

export type MonotheisticallyElement = null[] | MonotheisticallyClass;

export interface MonotheisticallyClass {
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

export interface Noncontributing {
    estevin:     string;
    jolterhead:  number;
    sauternes:   number;
    sparsely:    boolean;
    unrequested: null;
}

export type Nonnervous = boolean | number;

export type Nonvaluation = null[] | boolean | number;

export type OccupationalistElement = null[] | OccupationalistClass | null;

export interface OccupationalistClass {
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

export interface OutrivalClass {
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

export interface PiaculumClass {
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

export interface Pneumocele {
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

export interface PotwhiskyClass {
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

export interface PrefreshmanClass {
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
export class Convert {
    public static toTopLevel(json: string): TopLevel {
        return JSON.parse(json);
    }

    public static topLevelToJson(value: TopLevel): string {
        return JSON.stringify(value);
    }
}
