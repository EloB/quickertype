// @flow

// To parse this data:
//
//   const Convert = require("./TopLevel");
//
//   const topLevel = Convert.toTopLevel(json);

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
function toTopLevel(json: string): TopLevel {
    return JSON.parse(json);
}

function topLevelToJson(value: TopLevel): string {
    return JSON.stringify(value);
}

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
