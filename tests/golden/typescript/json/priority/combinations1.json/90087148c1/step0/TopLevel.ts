// To parse this data:
//
//   import { Convert, TopLevel } from "./TopLevel";
//
//   const topLevel = Convert.toTopLevel(json);

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
export class Convert {
    public static toTopLevel(json: string): TopLevel {
        return JSON.parse(json);
    }

    public static topLevelToJson(value: TopLevel): string {
        return JSON.stringify(value);
    }
}
