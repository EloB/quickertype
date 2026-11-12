// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::TopLevel;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: TopLevel = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};
use std::collections::HashMap;

#[derive(Serialize, Deserialize)]
pub struct TopLevel {
    centrodesmose: String,

    cerograph: Vec<Option<CerographElement>>,

    chemotherapeutics: Vec<ChemotherapeuticElement>,

    cimelia: Vec<Option<CimeliaElement>>,

    citrated: i64,

    clinodome: Vec<Clinodome>,

    coadjust: Vec<CoadjustElement>,

    consilience: Vec<Consilience>,

    constructor: Vec<Constructor>,

    continuative: Vec<Continuative>,

    credulity: Vec<CredulityElement>,

    creviced: Vec<Creviced>,

    cubiculum: Vec<Vec<Option<i64>>>,

    deruralize: Vec<DeruralizeElement>,

    diaereses: Vec<DiaereseElement>,

    dissolution: Vec<Option<Vec<Option<serde_json::Value>>>>,

    downstroke: Vec<Downstroke>,

    electrotautomerism: Vec<Option<f64>>,

    eleutheromania: Vec<Eleutheromania>,

    encrust: Encrust,

    entomoid: Vec<Entomoid>,

    epipaleolithic: Vec<Epipaleolithic>,

    expropriable: Vec<Expropriable>,

    faggingly: Vec<FagginglyElement>,

    fenks: Vec<FenkElement>,

    flagmaking: Vec<FlagmakingElement>,

    fluorometer: Vec<Option<Fluorometer>>,

    fulsome: Vec<Option<i64>>,

    fuzzy: Vec<Fuzzy>,

    gardenwards: Vec<Gardenward>,

    generalissimo: Vec<Option<Generalissimo>>,

    habeas: Vec<Option<HashMap<String, i64>>>,

    hemicrystalline: Vec<Hemicrystalline>,

    hemocoele: Vec<HemocoeleElement>,

    hoister: Vec<Option<Hoister>>,

    hyperpiesis: Vec<Option<Hyperpiesi>>,

    hyppish: Vec<Option<Hyppish>>,

    idealizer: Vec<Idealizer>,

    incrustator: Vec<Incrustator>,

    intentiveness: Vec<Intentiveness>,

    interacinar: Interacinar,

    intercorrelation: Vec<Option<Vec<i64>>>,

    jacutinga: Vec<Jacutinga>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum CerographElement {
    CerographClass(CerographClass),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
pub struct CerographClass {
    apotropaion: Option<serde_json::Value>,

    casuary: Option<serde_json::Value>,

    creaker: Option<serde_json::Value>,

    disqualification: Option<serde_json::Value>,

    imperatorious: Option<serde_json::Value>,

    impermeabilize: Option<serde_json::Value>,

    metastoma: Option<serde_json::Value>,

    noctidiurnal: Option<serde_json::Value>,

    nonreserve: Option<serde_json::Value>,

    ophthalmotonometry: Option<serde_json::Value>,

    pailful: Option<serde_json::Value>,

    pigfish: Option<serde_json::Value>,

    pongee: Option<serde_json::Value>,

    prosodical: Option<serde_json::Value>,

    scrofuloderm: Option<serde_json::Value>,

    storekeeping: Option<serde_json::Value>,

    therologist: Option<serde_json::Value>,

    #[serde(rename = "Tolowa")]
    tolowa: Option<serde_json::Value>,

    tradeful: Option<serde_json::Value>,

    unriveting: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum ChemotherapeuticElement {
    ChemotherapeuticClass(ChemotherapeuticClass),

    Integer(i64),
}

#[derive(Serialize, Deserialize)]
pub struct ChemotherapeuticClass {
    angioneurotic: Option<serde_json::Value>,

    availment: Option<serde_json::Value>,

    bladelet: Option<serde_json::Value>,

    catharticalness: Option<f64>,

    caulis: Option<serde_json::Value>,

    chalcus: Option<serde_json::Value>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    disdiapason: Option<String>,

    enteradenological: Option<serde_json::Value>,

    homocerc: Option<bool>,

    imporosity: Option<serde_json::Value>,

    insistently: Option<serde_json::Value>,

    intraparietal: Option<serde_json::Value>,

    ivied: Option<serde_json::Value>,

    #[serde(rename = "Maureen")]
    maureen: Option<serde_json::Value>,

    nonbookish: Option<serde_json::Value>,

    nostochine: Option<serde_json::Value>,

    nutcracker: Option<serde_json::Value>,

    ofttimes: Option<serde_json::Value>,

    phenocryst: Option<serde_json::Value>,

    precoincident: Option<serde_json::Value>,

    ramiferous: Option<serde_json::Value>,

    stagmometer: Option<serde_json::Value>,

    tetherball: Option<serde_json::Value>,

    unshy: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum CimeliaElement {
    CimeliaClass(CimeliaClass),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
pub struct CimeliaClass {
    catharticalness: f64,

    #[serde(rename = "Chirotherium")]
    chirotherium: i64,

    disdiapason: String,

    homocerc: bool,

    nonbookish: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Clinodome {
    Double(f64),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum CoadjustElement {
    CoadjustClass(CoadjustClass),

    Double(f64),
}

#[derive(Serialize, Deserialize)]
pub struct CoadjustClass {
    amidosulphonal: Option<serde_json::Value>,

    #[serde(rename = "Benny")]
    benny: Option<serde_json::Value>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    disdiapason: Option<String>,

    ensnare: Option<serde_json::Value>,

    homocerc: Option<bool>,

    hybridizer: Option<serde_json::Value>,

    leastwise: Option<serde_json::Value>,

    lof: Option<serde_json::Value>,

    monkhood: Option<serde_json::Value>,

    #[serde(rename = "Netherlandish")]
    netherlandish: Option<serde_json::Value>,

    nonbookish: Option<serde_json::Value>,

    peonism: Option<serde_json::Value>,

    #[serde(rename = "Phonelescope")]
    phonelescope: Option<serde_json::Value>,

    porphyrogeniture: Option<serde_json::Value>,

    preindemnify: Option<serde_json::Value>,

    rosal: Option<serde_json::Value>,

    scalenous: Option<serde_json::Value>,

    scopine: Option<serde_json::Value>,

    #[serde(rename = "Sedaceae")]
    sedaceae: Option<serde_json::Value>,

    suberinize: Option<serde_json::Value>,

    symbiot: Option<serde_json::Value>,

    tablefellow: Option<serde_json::Value>,

    unchargeable: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Consilience {
    Double(f64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Constructor {
    Bool(bool),

    UnionMap(HashMap<String, Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Continuative {
    IntegerMap(HashMap<String, i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum CredulityElement {
    CredulityClass(CredulityClass),

    Integer(i64),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
pub struct CredulityClass {
    ammonolytic: Option<serde_json::Value>,

    bushmaster: Option<serde_json::Value>,

    considering: Option<serde_json::Value>,

    consuetudinary: Option<serde_json::Value>,

    embarras: Option<serde_json::Value>,

    fineness: Option<serde_json::Value>,

    flaithship: Option<serde_json::Value>,

    #[serde(rename = "Flavia")]
    flavia: Option<serde_json::Value>,

    gruffly: Option<serde_json::Value>,

    #[serde(rename = "Hedychium")]
    hedychium: Option<serde_json::Value>,

    leadwort: Option<serde_json::Value>,

    overseriously: Option<serde_json::Value>,

    parabola: Option<serde_json::Value>,

    pectinatodenticulate: Option<serde_json::Value>,

    #[serde(rename = "Popean")]
    popean: Option<serde_json::Value>,

    pornocrat: Option<serde_json::Value>,

    quadrisect: Option<serde_json::Value>,

    seriality: Option<serde_json::Value>,

    vamphorn: Option<serde_json::Value>,

    wharp: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Creviced {
    Bool(bool),

    IntegerMap(HashMap<String, i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum DeruralizeElement {
    Bool(bool),

    DeruralizeClass(DeruralizeClass),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
pub struct DeruralizeClass {
    bockerel: Option<serde_json::Value>,

    boulder: Option<serde_json::Value>,

    churrus: Option<serde_json::Value>,

    counterdigged: Option<serde_json::Value>,

    dialogite: Option<serde_json::Value>,

    digenic: Option<serde_json::Value>,

    dunbird: Option<serde_json::Value>,

    ergatogyne: Option<serde_json::Value>,

    fiendful: Option<serde_json::Value>,

    jackrod: Option<serde_json::Value>,

    #[serde(rename = "Jehovistic")]
    jehovistic: Option<serde_json::Value>,

    #[serde(rename = "Paninean")]
    paninean: Option<serde_json::Value>,

    panther: Option<serde_json::Value>,

    placentigerous: Option<serde_json::Value>,

    #[serde(rename = "Romney")]
    romney: Option<serde_json::Value>,

    sparm: Option<serde_json::Value>,

    tocsin: Option<serde_json::Value>,

    unnicked: Option<serde_json::Value>,

    unstavable: Option<serde_json::Value>,

    windfirm: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum DiaereseElement {
    Bool(bool),

    DiaereseClass(DiaereseClass),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
pub struct DiaereseClass {
    #[serde(rename = "Amoreuxia")]
    amoreuxia: Option<serde_json::Value>,

    ani: Option<serde_json::Value>,

    bernicle: Option<serde_json::Value>,

    blackwasher: Option<serde_json::Value>,

    blowhard: Option<serde_json::Value>,

    broma: Option<serde_json::Value>,

    closecross: Option<serde_json::Value>,

    congregationalism: Option<serde_json::Value>,

    grayly: Option<serde_json::Value>,

    historically: Option<serde_json::Value>,

    hoast: Option<serde_json::Value>,

    irretentive: Option<serde_json::Value>,

    parcener: Option<serde_json::Value>,

    pedder: Option<serde_json::Value>,

    pseudoanatomic: Option<serde_json::Value>,

    rhizocarpian: Option<serde_json::Value>,

    samel: Option<serde_json::Value>,

    silker: Option<serde_json::Value>,

    subdentated: Option<serde_json::Value>,

    subobscure: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Downstroke {
    Bool(bool),

    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Eleutheromania {
    Double(f64),

    IntegerMap(HashMap<String, i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
pub struct Encrust {
    comradely: Option<serde_json::Value>,

    diacanthous: Option<serde_json::Value>,

    feminineness: Option<serde_json::Value>,

    gossamered: Option<serde_json::Value>,

    #[serde(rename = "Hibernia")]
    hibernia: Option<serde_json::Value>,

    #[serde(rename = "Hibiscus")]
    hibiscus: Option<serde_json::Value>,

    #[serde(rename = "Lepidosauria")]
    lepidosauria: Option<serde_json::Value>,

    lollingly: Option<serde_json::Value>,

    manager: Option<serde_json::Value>,

    mechanic: Option<serde_json::Value>,

    overminuteness: Option<serde_json::Value>,

    papelonne: Option<serde_json::Value>,

    plebification: Option<serde_json::Value>,

    pugmiller: Option<serde_json::Value>,

    recoveror: Option<serde_json::Value>,

    spermatoblastic: Option<serde_json::Value>,

    #[serde(rename = "Syllidae")]
    syllidae: Option<serde_json::Value>,

    ungyved: Option<serde_json::Value>,

    whirlabout: Option<serde_json::Value>,

    woodenware: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Entomoid {
    CimeliaClass(CimeliaClass),

    Integer(i64),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Epipaleolithic {
    Double(f64),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Expropriable {
    CimeliaClass(CimeliaClass),

    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum FagginglyElement {
    Double(f64),

    FagginglyClass(FagginglyClass),
}

#[derive(Serialize, Deserialize)]
pub struct FagginglyClass {
    abranchian: Option<serde_json::Value>,

    aculeiform: Option<serde_json::Value>,

    adiaphoristic: Option<serde_json::Value>,

    adoptionism: Option<serde_json::Value>,

    #[serde(rename = "Anglic")]
    anglic: Option<serde_json::Value>,

    antrotomy: Option<serde_json::Value>,

    coerciveness: Option<serde_json::Value>,

    decorist: Option<serde_json::Value>,

    duckhood: Option<serde_json::Value>,

    #[serde(rename = "Heteromeri")]
    heteromeri: Option<serde_json::Value>,

    hypochnose: Option<serde_json::Value>,

    lochage: Option<serde_json::Value>,

    melee: Option<serde_json::Value>,

    nonconformitant: Option<serde_json::Value>,

    #[serde(rename = "Poinsettia")]
    poinsettia: Option<serde_json::Value>,

    putatively: Option<serde_json::Value>,

    semivolatile: Option<serde_json::Value>,

    soleas: Option<serde_json::Value>,

    unfastenable: Option<serde_json::Value>,

    unmillinered: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum FenkElement {
    FenkClass(FenkClass),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
pub struct FenkClass {
    apoise: Option<serde_json::Value>,

    astronomize: Option<serde_json::Value>,

    cockhorse: Option<serde_json::Value>,

    copular: Option<serde_json::Value>,

    #[serde(rename = "Dagomba")]
    dagomba: Option<serde_json::Value>,

    draffy: Option<serde_json::Value>,

    foreigner: Option<serde_json::Value>,

    #[serde(rename = "Guyandot")]
    guyandot: Option<serde_json::Value>,

    neurogliosis: Option<serde_json::Value>,

    osmious: Option<serde_json::Value>,

    palpitate: Option<serde_json::Value>,

    rebukeable: Option<serde_json::Value>,

    #[serde(rename = "Reinwardtia")]
    reinwardtia: Option<serde_json::Value>,

    reservatory: Option<serde_json::Value>,

    scalt: Option<serde_json::Value>,

    scripturalize: Option<serde_json::Value>,

    tintometer: Option<serde_json::Value>,

    #[serde(rename = "Tritoness")]
    tritoness: Option<serde_json::Value>,

    undergrade: Option<serde_json::Value>,

    undermountain: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum FlagmakingElement {
    Bool(bool),

    Double(f64),

    FlagmakingClass(FlagmakingClass),
}

#[derive(Serialize, Deserialize)]
pub struct FlagmakingClass {
    albarco: Option<serde_json::Value>,

    #[serde(rename = "Bunodonta")]
    bunodonta: Option<serde_json::Value>,

    hornify: Option<serde_json::Value>,

    #[serde(rename = "Hydrocorisae")]
    hydrocorisae: Option<serde_json::Value>,

    hypoglossus: Option<serde_json::Value>,

    inexpiably: Option<serde_json::Value>,

    ingratitude: Option<serde_json::Value>,

    ladyfly: Option<serde_json::Value>,

    medicament: Option<serde_json::Value>,

    monogrammatic: Option<serde_json::Value>,

    nobbut: Option<serde_json::Value>,

    #[serde(rename = "Notacanthidae")]
    notacanthidae: Option<serde_json::Value>,

    polyplacophore: Option<serde_json::Value>,

    proexercise: Option<serde_json::Value>,

    protoplast: Option<serde_json::Value>,

    puzzling: Option<serde_json::Value>,

    splanchnoskeleton: Option<serde_json::Value>,

    unloveliness: Option<serde_json::Value>,

    unquarantined: Option<serde_json::Value>,

    unrenounceable: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Fluorometer {
    Integer(i64),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Fuzzy {
    Integer(i64),

    UnionMap(HashMap<String, Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Gardenward {
    Bool(bool),

    IntegerArray(Vec<i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Generalissimo {
    Bool(bool),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Hemicrystalline {
    CimeliaClass(CimeliaClass),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum HemocoeleElement {
    HemocoeleClass(HemocoeleClass),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
pub struct HemocoeleClass {
    acrogamy: Option<serde_json::Value>,

    amelification: Option<serde_json::Value>,

    autobiographic: Option<serde_json::Value>,

    berat: Option<serde_json::Value>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    disdiapason: Option<String>,

    disproportionably: Option<serde_json::Value>,

    erythrite: Option<serde_json::Value>,

    graphic: Option<serde_json::Value>,

    hepatological: Option<serde_json::Value>,

    homocerc: Option<bool>,

    incommensurably: Option<serde_json::Value>,

    misaffirm: Option<serde_json::Value>,

    nonbookish: Option<serde_json::Value>,

    pocketbook: Option<serde_json::Value>,

    sclerometric: Option<serde_json::Value>,

    stambouline: Option<serde_json::Value>,

    stickpin: Option<serde_json::Value>,

    tubulure: Option<serde_json::Value>,

    undelated: Option<serde_json::Value>,

    unsalt: Option<serde_json::Value>,

    untutelar: Option<serde_json::Value>,

    vagrant: Option<serde_json::Value>,

    #[serde(rename = "Walt")]
    walt: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Hoister {
    CimeliaClass(CimeliaClass),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Hyperpiesi {
    CimeliaClass(CimeliaClass),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Hyppish {
    Bool(bool),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Idealizer {
    CimeliaClass(CimeliaClass),

    Integer(i64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Incrustator {
    Integer(i64),

    IntegerArray(Vec<i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Intentiveness {
    CimeliaClass(CimeliaClass),

    Double(f64),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
pub struct Interacinar {
    assapan: f64,

    benefactorship: bool,

    triseriatim: String,

    tubbing: i64,

    untrimmed: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Jacutinga {
    IntegerArray(Vec<i64>),

    UnionMap(HashMap<String, Option<i64>>),
}
