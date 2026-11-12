// @flow

// To parse this data:
//
//   const Convert = require("./TopLevel");
//
//   const topLevel = Convert.toTopLevel(json);

export type TopLevel = {
    Abranchiata:      Abranchiata[];
    Andriana:         (null | string)[];
    Ansarie:          AnsarieElement[];
    Chytridiaceae:    ChytridiaceaeElement[];
    Discordia:        DiscordiaElement[];
    Endomyces:        Endomyce[];
    Epinephelidae:    Epinephelidae[];
    Eupatorium:       Eupatorium[];
    Gryphosaurus:     GryphosaurusElement[];
    Koryak:           Koryak[];
    Lavinia:          LaviniaElement[];
    Oskar:            OskarElement[];
    Rebecca:          RebeccaElement[];
    Rhomboganoidei:   Rhomboganoidei[];
    Rigsmal:          boolean;
    Ruellia:          Ruellia[];
    School:           School[];
    Shakespearolater: Shakespearolater[];
    Svan:             number[];
    Wayao:            { [key: string]: number };
    academe:          Academe[];
    acquirable:       Acquirable[];
    aerometry:        Aerometry[];
    alexin:           Alexin[];
    alleviate:        AlleviateElement[];
    amaas:            Amaa[];
    ambassage:        Ambassage[];
    amphithyron:      (Amphithyron | null)[];
    ankee:            AnkeeElement[];
    annihilator:      ({ [key: string]: number | null } | null)[];
    annulose:         null;
    aphasia:          Aphasia[];
    asprawl:          Asprawl[];
    attractive:       (boolean | null)[];
    barksome:         { [key: string]: number };
    bedesman:         Bedesman[];
    belard:           Belard[];
    bocking:          Bocking[];
    brawlingly:       Brawlingly[];
    brookie:          Brookie[];
    bumboatman:       Bumboatman[];
    bystreet:         null[];
    calaverite:       Calaverite[];
    catallactic:      Catallactic[];
    cemental:         Cemental[];
};

export type Abranchiata = number[] | number | null;

export type AnsarieElement = number[] | AnsarieClass | null;

export type AnsarieClass = {
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
};

export type ChytridiaceaeElement = boolean | ChytridiaceaeClass | null;

export type ChytridiaceaeClass = {
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
};

export type DiscordiaElement = number[] | DiscordiaClass;

export type DiscordiaClass = {
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
};

export type Endomyce = number | string;

export type Epinephelidae = boolean | number | string;

export type Eupatorium = null[] | { [key: string]: number };

export type GryphosaurusElement = number[] | GryphosaurusClass | string;

export type GryphosaurusClass = {
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
};

export type Koryak = { [key: string]: number | null } | string;

export type LaviniaElement = LaviniaClass | string;

export type LaviniaClass = {
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
};

export type OskarElement = number[] | OskarClass;

export type OskarClass = {
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
};

export type RebeccaElement = Rebecca | number | string;

export type Rebecca = {
    Chirotherium:    number;
    catharticalness: number;
    disdiapason:     string;
    homocerc:        boolean;
    nonbookish:      null;
};

export type Rhomboganoidei = number[] | Rebecca | string;

export type Ruellia = boolean | Rebecca | string;

export type School = number | { [key: string]: number } | null;

export type Shakespearolater = number[] | number | string;

export type Academe = number[] | number | { [key: string]: number };

export type Acquirable = (number | null)[] | { [key: string]: number };

export type Aerometry = boolean | number;

export type Alexin = number[] | boolean;

export type AlleviateElement = (number | null)[] | AlleviateClass;

export type AlleviateClass = {
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
};

export type Amaa = boolean | Rebecca | number;

export type Ambassage = null[] | string;

export type Amphithyron = {
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
};

export type AnkeeElement = number[] | AnkeeClass | number;

export type AnkeeClass = {
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
};

export type Aphasia = number[] | number;

export type Asprawl = number | string;

export type Bedesman = boolean | number | string;

export type Belard = number[] | Rebecca | number;

export type Bocking = number[] | boolean | { [key: string]: number };

export type Brawlingly = null[] | { [key: string]: number | null };

export type Brookie = number[] | Rebecca;

export type Bumboatman = null[] | null | string;

export type Calaverite = number[] | string;

export type Catallactic = null[] | boolean | { [key: string]: number };

export type Cemental = number[] | number | { [key: string]: number };

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
