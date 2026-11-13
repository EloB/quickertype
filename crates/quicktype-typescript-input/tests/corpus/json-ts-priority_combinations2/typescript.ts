export interface TopLevel {
    Abranchiata:      Array<number[] | number | null>;
    Andriana:         Array<null | string>;
    Ansarie:          Array<number[] | AnsarieClass | null>;
    Chytridiaceae:    Array<boolean | ChytridiaceaeClass | null>;
    Discordia:        Array<number[] | DiscordiaClass>;
    Endomyces:        Array<number | string>;
    Epinephelidae:    Array<boolean | number | string>;
    Eupatorium:       Array<null[] | { [key: string]: number }>;
    Gryphosaurus:     Array<number[] | GryphosaurusClass | string>;
    Koryak:           Array<{ [key: string]: number | null } | string>;
    Lavinia:          Array<LaviniaClass | string>;
    Oskar:            Array<number[] | OskarClass>;
    Rebecca:          Array<Rebecca | number | string>;
    Rhomboganoidei:   Array<number[] | Rebecca | string>;
    Rigsmal:          boolean;
    Ruellia:          Array<boolean | Rebecca | string>;
    School:           Array<number | { [key: string]: number } | null>;
    Shakespearolater: Array<number[] | number | string>;
    Svan:             number[];
    Wayao:            { [key: string]: number };
    academe:          Array<number[] | number | { [key: string]: number }>;
    acquirable:       Array<Array<number | null> | { [key: string]: number }>;
    aerometry:        Array<boolean | number>;
    alexin:           Array<number[] | boolean>;
    alleviate:        Array<Array<number | null> | AlleviateClass>;
    amaas:            Array<boolean | Rebecca | number>;
    ambassage:        Array<null[] | string>;
    amphithyron:      Array<Amphithyron | null>;
    ankee:            Array<number[] | AnkeeClass | number>;
    annihilator:      Array<{ [key: string]: number | null } | null>;
    annulose:         null;
    aphasia:          Array<number[] | number>;
    asprawl:          Array<number | string>;
    attractive:       Array<boolean | null>;
    barksome:         { [key: string]: number };
    bedesman:         Array<boolean | number | string>;
    belard:           Array<number[] | Rebecca | number>;
    bocking:          Array<number[] | boolean | { [key: string]: number }>;
    brawlingly:       Array<null[] | { [key: string]: number | null }>;
    brookie:          Array<number[] | Rebecca>;
    bumboatman:       Array<null[] | null | string>;
    bystreet:         null[];
    calaverite:       Array<number[] | string>;
    catallactic:      Array<null[] | boolean | { [key: string]: number }>;
    cemental:         Array<number[] | number | { [key: string]: number }>;
}

export interface AnsarieClass {
    Alida:          null;
    Ictonyx:        null;
    Ramist:         null;
    accension:      null;
    asteria:        null;
    beriberic:      null;
    edgebone:       null;
    gastrodialysis: null;
    geographic:     null;
    metrocele:      null;
    misgraft:       null;
    monteith:       null;
    notcher:        null;
    prorestriction: null;
    throatlet:      null;
    unfair:         null;
    unsynonymous:   null;
    water:          null;
    zestfully:      null;
    zincic:         null;
}

export interface ChytridiaceaeClass {
    Batidaceae:     null;
    Brechites:      null;
    Emery:          null;
    Narraganset:    null;
    codespairer:    null;
    enervative:     null;
    excriminate:    null;
    goshenite:      null;
    grime:          null;
    gritten:        null;
    hectorly:       null;
    intermediation: null;
    meeterly:       null;
    onymatic:       null;
    paddlecock:     null;
    thana:          null;
    thornily:       null;
    uckia:          null;
    unmettle:       null;
    vorticellid:    null;
}

export interface DiscordiaClass {
    Altaic?:           number;
    Chirotherium?:     number;
    Patarin?:          number;
    amoristic?:        number;
    blennophthalmia?:  number;
    catharticalness?:  number;
    disciplinability?: number;
    disdiapason?:      string;
    goofer?:           number;
    homocerc?:         boolean;
    laryngograph?:     number;
    leucitis?:         number;
    lymphocyst?:       number;
    microcosmology?:   number;
    nauseation?:       number;
    nonbookish?:       null;
    preliberal?:       number;
    prettifier?:       number;
    rangework?:        number;
    redient?:          number;
    subfusiform?:      number;
    suicidical?:       number;
    swow?:             number;
    wastrel?:          number;
    wingle?:           number;
}

export interface GryphosaurusClass {
    Burushaski:      null;
    Tahami:          null;
    amissibility:    null;
    citronin:        null;
    coplaintiff:     null;
    disquisitionary: null;
    enoplan:         null;
    faintness:       null;
    hebetomy:        null;
    islandry:        null;
    lameduck:        null;
    overbattle:      null;
    overinterested:  null;
    phrenologic:     null;
    rainband:        null;
    shiningly:       null;
    stamineous:      null;
    subscapularis:   null;
    undaubed:        null;
    underntime:      null;
}

export interface LaviniaClass {
    Chirotherium?:      number;
    Tacana?:            number;
    agitable?:          number;
    asininity?:         number;
    benefiter?:         number;
    bronzelike?:        number;
    catharticalness?:   number;
    cholesteatomatous?: number;
    deprivement?:       number;
    disdiapason?:       string;
    flippantness?:      number;
    fogproof?:          number;
    homocerc?:          boolean;
    merrymeeting?:      number;
    nonbookish?:        null;
    overcareful?:       number;
    panaris?:           number;
    preacceptance?:     number;
    quinoxaline?:       number;
    sig?:               number;
    superconfusion?:    number;
    tillotter?:         number;
    tranquillize?:      number;
    unquestionable?:    number;
    uproute?:           number;
}

export interface OskarClass {
    Acrobates:        null;
    Cayuga:           null;
    Netherlandish:    null;
    beanshooter:      null;
    bearhound:        null;
    guarneri:         null;
    hypochondriacism: null;
    indication:       null;
    jaculative:       null;
    nagana:           null;
    noctivagous:      null;
    nonphysiological: null;
    praxis:           null;
    provision:        null;
    subterhuman:      null;
    sunlit:           null;
    syncraniate:      null;
    teachment:        null;
    unmutinous:       null;
    unstoppable:      null;
}

export interface Rebecca {
    Chirotherium:    number;
    catharticalness: number;
    disdiapason:     string;
    homocerc:        boolean;
    nonbookish:      null;
}

export interface AlleviateClass {
    Hulsean:         null;
    apriori:         null;
    beggarer:        null;
    brokenheartedly: null;
    debilitation:    null;
    frike:           null;
    gastrolith:      null;
    orthocentric:    null;
    petaly:          null;
    probudgeting:    null;
    reacquire:       null;
    scow:            null;
    shutoff:         null;
    subcontiguous:   null;
    suffumigate:     null;
    transformable:   null;
    uncoroneted:     null;
    unparking:       null;
    unvarnishedness: null;
    wherewithal:     null;
}

export interface Amphithyron {
    Chirotherium?:    number;
    Juniperus?:       number;
    Nazirite?:        number;
    Those?:           number;
    akroasis?:        number;
    antiphonical?:    number;
    basebred?:        number;
    catharticalness?: number;
    conductometric?:  number;
    disdiapason?:     string;
    ensilation?:      number;
    eyebolt?:         number;
    fistulated?:      number;
    heteropod?:       number;
    homocerc?:        boolean;
    labyrinthically?: number;
    martyrization?:   number;
    mispolicy?:       number;
    multipara?:       number;
    nonbookish?:      null;
    possessorial?:    number;
    shamed?:          number;
    shelfworn?:       number;
    stagnum?:         number;
    undecimal?:       number;
}

export interface AnkeeClass {
    Anomoean:        null;
    Naja:            null;
    barleyhood:      null;
    befriender:      null;
    brutishness:     null;
    cephalalgy:      null;
    cirurgian:       null;
    conventionally:  null;
    jackshay:        null;
    milammeter:      null;
    ombrological:    null;
    phonasthenia:    null;
    retrievableness: null;
    snakily:         null;
    swot:            null;
    tartlet:         null;
    thiofuran:       null;
    tracheophone:    null;
    tuglike:         null;
    unscratchingly:  null;
}
