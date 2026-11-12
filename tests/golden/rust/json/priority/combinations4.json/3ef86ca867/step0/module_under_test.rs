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
    protrusive: Vec<Protrusive>,

    pulpitism: Vec<PulpitismElement>,

    pyodermia: Vec<PyodermiaElement>,

    quebrachine: Vec<Option<QuebrachineElement>>,

    querier: Vec<Querier>,

    rebarbative: Vec<Rebarbative>,

    reimagine: Vec<Reimagine>,

    ressaut: Ressaut,

    retrocervical: Vec<Retrocervical>,

    revert: Vec<Revert>,

    rewrite: Vec<RewriteElement>,

    saccoderm: Vec<Option<Saccoderm>>,

    santir: Vec<SantirElement>,

    saprophilous: Vec<Option<Saprophilous>>,

    saxten: Vec<SaxtenElement>,

    scatty: Vec<Option<Scatty>>,

    scoffer: Vec<Option<Scoffer>>,

    scrampum: Vec<Option<Scrampum>>,

    semantic: f64,

    serpentinic: Vec<Serpentinic>,

    shadowable: Vec<Shadowable>,

    sistering: Vec<SisteringElement>,

    staghunting: Vec<Staghunting>,

    stagmometer: Vec<Stagmometer>,

    stimulability: Vec<Stimulability>,

    strangleable: Vec<Strangleable>,

    strenuosity: Vec<StrenuosityElement>,

    tabaxir: Vec<Tabaxir>,

    talpiform: Vec<Option<Talpiform>>,

    thwack: Vec<Thwack>,

    to: Vec<Option<f64>>,

    tortricine: Vec<Tortricine>,

    truantcy: Vec<TruantcyElement>,

    turgesce: Vec<String>,

    unbeginning: Vec<Unbeginning>,

    underdunged: Vec<f64>,

    undesirability: Vec<Undesirability>,

    unerasing: Vec<Unerasing>,

    unguentarium: Vec<Option<Unguentarium>>,

    unimpeachably: Vec<UnimpeachablyElement>,

    unmortgaged: Vec<Option<Unmortgaged>>,

    unobstructed: Vec<Option<Unobstructed>>,

    unreceptivity: Vec<Unreceptivity>,

    unsatisfactoriness: Vec<Unsatisfactoriness>,

    unsecurity: Vec<i64>,

    unstressed: Vec<UnstressedElement>,

    untasked: Vec<Untasked>,

    unvarying: Vec<Unvarying>,

    vehemently: Vec<Option<Vehemently>>,

    warriorship: HashMap<String, bool>,

    whitepot: Vec<Whitepot>,

    wrothy: Vec<WrothyElement>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Protrusive {
    Double(f64),

    UnionArray(Vec<Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum PulpitismElement {
    Double(f64),

    IntegerArray(Vec<i64>),

    PulpitismClass(PulpitismClass),
}

#[derive(Serialize, Deserialize)]
pub struct PulpitismClass {
    abnet: Option<serde_json::Value>,

    buckhorn: Option<serde_json::Value>,

    calciform: Option<serde_json::Value>,

    chelophore: Option<serde_json::Value>,

    cogitation: Option<serde_json::Value>,

    decreeable: Option<serde_json::Value>,

    despicable: Option<serde_json::Value>,

    isodiazo: Option<serde_json::Value>,

    jadedly: Option<serde_json::Value>,

    leptochlorite: Option<serde_json::Value>,

    nursling: Option<serde_json::Value>,

    palamedean: Option<serde_json::Value>,

    photoheliograph: Option<serde_json::Value>,

    pipewood: Option<serde_json::Value>,

    roberd: Option<serde_json::Value>,

    statable: Option<serde_json::Value>,

    superassume: Option<serde_json::Value>,

    syllabe: Option<serde_json::Value>,

    toughhead: Option<serde_json::Value>,

    underburn: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum PyodermiaElement {
    Integer(i64),

    PyodermiaClass(PyodermiaClass),
}

#[derive(Serialize, Deserialize)]
pub struct PyodermiaClass {
    aphoristically: Option<serde_json::Value>,

    apophyllous: Option<serde_json::Value>,

    cognize: Option<serde_json::Value>,

    dermonosology: Option<serde_json::Value>,

    #[serde(rename = "Gyppo")]
    gyppo: Option<serde_json::Value>,

    ither: Option<serde_json::Value>,

    juglandaceous: Option<serde_json::Value>,

    litho: Option<serde_json::Value>,

    macropterous: Option<serde_json::Value>,

    photographer: Option<serde_json::Value>,

    romancing: Option<serde_json::Value>,

    rumness: Option<serde_json::Value>,

    somniloquist: Option<serde_json::Value>,

    stressfully: Option<serde_json::Value>,

    tactically: Option<serde_json::Value>,

    tracheophony: Option<serde_json::Value>,

    unappositely: Option<serde_json::Value>,

    unclothedly: Option<serde_json::Value>,

    unimplied: Option<serde_json::Value>,

    unsyncopated: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum QuebrachineElement {
    Bool(bool),

    QuebrachineClass(QuebrachineClass),
}

#[derive(Serialize, Deserialize)]
pub struct QuebrachineClass {
    catharticalness: f64,

    #[serde(rename = "Chirotherium")]
    chirotherium: i64,

    disdiapason: String,

    homocerc: bool,

    nonbookish: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Querier {
    Bool(bool),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Rebarbative {
    Bool(bool),

    Double(f64),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
pub struct Reimagine {
    adducible: Option<serde_json::Value>,

    anabolin: Option<serde_json::Value>,

    brainy: Option<serde_json::Value>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    chrysamine: Option<serde_json::Value>,

    disdiapason: Option<String>,

    fluxweed: Option<serde_json::Value>,

    glaucine: Option<serde_json::Value>,

    grobianism: Option<serde_json::Value>,

    #[serde(rename = "Hermo")]
    hermo: Option<serde_json::Value>,

    hieroglyphist: Option<serde_json::Value>,

    homocerc: Option<bool>,

    icteroid: Option<serde_json::Value>,

    immortal: Option<serde_json::Value>,

    impetulant: Option<serde_json::Value>,

    irrigate: Option<serde_json::Value>,

    myxedema: Option<serde_json::Value>,

    nonbookish: Option<serde_json::Value>,

    onyx: Option<serde_json::Value>,

    repasser: Option<serde_json::Value>,

    septomarginal: Option<serde_json::Value>,

    subdie: Option<serde_json::Value>,

    tibiometatarsal: Option<serde_json::Value>,

    waltzlike: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
pub struct Ressaut {
    apperceptive: String,

    cuttoo: String,

    douser: String,

    drinkproof: String,

    forementioned: String,

    #[serde(rename = "Freesia")]
    freesia: String,

    #[serde(rename = "Genevieve")]
    genevieve: String,

    hyperdiabolical: String,

    hypocone: String,

    irreverentially: String,

    jumart: String,

    #[serde(rename = "Mimosaceae")]
    mimosaceae: String,

    mollicrush: String,

    nedder: String,

    retinasphalt: String,

    sough: String,

    steading: String,

    #[serde(rename = "Theopaschitism")]
    theopaschitism: String,

    undurableness: String,

    unmingleable: String,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Retrocervical {
    Integer(i64),

    UnionArray(Vec<Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Revert {
    Bool(bool),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum RewriteElement {
    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),

    RewriteClass(RewriteClass),
}

#[derive(Serialize, Deserialize)]
pub struct RewriteClass {
    accountancy: Option<serde_json::Value>,

    cacotrophic: Option<serde_json::Value>,

    contest: Option<serde_json::Value>,

    couthily: Option<serde_json::Value>,

    falculate: Option<serde_json::Value>,

    foreseize: Option<serde_json::Value>,

    #[serde(rename = "Hyades")]
    hyades: Option<serde_json::Value>,

    lemnad: Option<serde_json::Value>,

    monotheistically: Option<serde_json::Value>,

    nonflying: Option<serde_json::Value>,

    #[serde(rename = "Ptenoglossa")]
    ptenoglossa: Option<serde_json::Value>,

    repatch: Option<serde_json::Value>,

    rodman: Option<serde_json::Value>,

    strung: Option<serde_json::Value>,

    titmal: Option<serde_json::Value>,

    twalpennyworth: Option<serde_json::Value>,

    unblamable: Option<serde_json::Value>,

    vertical: Option<serde_json::Value>,

    #[serde(rename = "Whiggification")]
    whiggification: Option<serde_json::Value>,

    yardman: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Saccoderm {
    IntegerArray(Vec<i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum SantirElement {
    Double(f64),

    SantirClass(SantirClass),
}

#[derive(Serialize, Deserialize)]
pub struct SantirClass {
    admiredly: Option<serde_json::Value>,

    demicaponier: Option<serde_json::Value>,

    epitympanic: Option<serde_json::Value>,

    investitor: Option<serde_json::Value>,

    lupiform: Option<serde_json::Value>,

    monoflagellate: Option<serde_json::Value>,

    paleoethnic: Option<serde_json::Value>,

    prediscountable: Option<serde_json::Value>,

    rhetoricals: Option<serde_json::Value>,

    roomth: Option<serde_json::Value>,

    saccharose: Option<serde_json::Value>,

    septonasal: Option<serde_json::Value>,

    serpenticide: Option<serde_json::Value>,

    setarious: Option<serde_json::Value>,

    spaework: Option<serde_json::Value>,

    stylite: Option<serde_json::Value>,

    #[serde(rename = "Suessiones")]
    suessiones: Option<serde_json::Value>,

    timelily: Option<serde_json::Value>,

    unprofaned: Option<serde_json::Value>,

    vorticular: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Saprophilous {
    IntegerMap(HashMap<String, i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum SaxtenElement {
    PurpleString(String),

    SaxtenClass(SaxtenClass),
}

#[derive(Serialize, Deserialize)]
pub struct SaxtenClass {
    algarrobilla: Option<serde_json::Value>,

    bowgrace: Option<serde_json::Value>,

    catharticalness: Option<f64>,

    #[serde(rename = "Centaurid")]
    centaurid: Option<serde_json::Value>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    disdiapason: Option<String>,

    flix: Option<serde_json::Value>,

    germanely: Option<serde_json::Value>,

    homocerc: Option<bool>,

    inhume: Option<serde_json::Value>,

    lepidote: Option<serde_json::Value>,

    megalochirous: Option<serde_json::Value>,

    ninepenny: Option<serde_json::Value>,

    nonbookish: Option<serde_json::Value>,

    nondeist: Option<serde_json::Value>,

    nymphaeaceous: Option<serde_json::Value>,

    parietofrontal: Option<serde_json::Value>,

    sancyite: Option<serde_json::Value>,

    subjectivist: Option<serde_json::Value>,

    tibiad: Option<serde_json::Value>,

    transonic: Option<serde_json::Value>,

    tripetalous: Option<serde_json::Value>,

    trunchman: Option<serde_json::Value>,

    urger: Option<serde_json::Value>,

    withdrawnness: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
pub struct Scatty {
    aeriferous: Option<serde_json::Value>,

    antical: Option<serde_json::Value>,

    antighostism: Option<serde_json::Value>,

    arcanum: Option<serde_json::Value>,

    autotrophy: Option<serde_json::Value>,

    baronial: Option<serde_json::Value>,

    caffeine: Option<serde_json::Value>,

    gorgoniacean: Option<serde_json::Value>,

    heroical: Option<serde_json::Value>,

    hydropical: Option<serde_json::Value>,

    mechanology: Option<serde_json::Value>,

    musicopoetic: Option<serde_json::Value>,

    officiality: Option<serde_json::Value>,

    oftentimes: Option<serde_json::Value>,

    ophthalmotonometer: Option<serde_json::Value>,

    reflectively: Option<serde_json::Value>,

    springer: Option<serde_json::Value>,

    #[serde(rename = "Tabasco")]
    tabasco: Option<serde_json::Value>,

    teleianthous: Option<serde_json::Value>,

    uncombated: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Scoffer {
    IntegerMap(HashMap<String, i64>),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Scrampum {
    Bool(bool),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Serpentinic {
    Double(f64),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Shadowable {
    Bool(bool),

    UnionArray(Vec<Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum SisteringElement {
    Integer(i64),

    NullArray(Vec<Option<serde_json::Value>>),

    SisteringClass(SisteringClass),
}

#[derive(Serialize, Deserialize)]
pub struct SisteringClass {
    amphicarpic: Option<serde_json::Value>,

    #[serde(rename = "Chianti")]
    chianti: Option<serde_json::Value>,

    frigorific: Option<serde_json::Value>,

    #[serde(rename = "Haplomi")]
    haplomi: Option<serde_json::Value>,

    hyperkinesis: Option<serde_json::Value>,

    laudable: Option<serde_json::Value>,

    madwoman: Option<serde_json::Value>,

    maimedly: Option<serde_json::Value>,

    #[serde(rename = "Micropterygidae")]
    micropterygidae: Option<serde_json::Value>,

    microrhabdus: Option<serde_json::Value>,

    nondense: Option<serde_json::Value>,

    phlebemphraxis: Option<serde_json::Value>,

    redsear: Option<serde_json::Value>,

    schismatical: Option<serde_json::Value>,

    tartryl: Option<serde_json::Value>,

    unabhorred: Option<serde_json::Value>,

    undeliberateness: Option<serde_json::Value>,

    unmixable: Option<serde_json::Value>,

    untruckling: Option<serde_json::Value>,

    vineal: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
pub struct Staghunting {
    calorimetric: Option<i64>,

    canid: Option<i64>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    disdiapason: Option<String>,

    ditriglyphic: Option<i64>,

    floriferousness: Option<i64>,

    gamelike: Option<i64>,

    grig: Option<i64>,

    homocerc: Option<bool>,

    interloan: Option<i64>,

    lithotomy: Option<i64>,

    loric: Option<i64>,

    membranocoriaceous: Option<i64>,

    membranogenic: Option<i64>,

    nonbookish: Option<serde_json::Value>,

    overtrump: Option<i64>,

    scotino: Option<i64>,

    seasonable: Option<i64>,

    sephen: Option<i64>,

    stigmarioid: Option<i64>,

    tired: Option<i64>,

    trifid: Option<i64>,

    undefeatedly: Option<i64>,

    ungirlish: Option<i64>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Stagmometer {
    PurpleString(String),

    UnionArray(Vec<Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Stimulability {
    Bool(bool),

    Integer(i64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Strangleable {
    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum StrenuosityElement {
    NullArray(Vec<Option<serde_json::Value>>),

    StrenuosityClass(StrenuosityClass),
}

#[derive(Serialize, Deserialize)]
pub struct StrenuosityClass {
    bliss: Option<i64>,

    buccate: Option<i64>,

    bulletproof: Option<i64>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    crumblingness: Option<i64>,

    disdiapason: Option<String>,

    engagedly: Option<i64>,

    fightable: Option<i64>,

    hoariness: Option<i64>,

    homocerc: Option<bool>,

    hypopodium: Option<i64>,

    luxurist: Option<i64>,

    mechanician: Option<i64>,

    nonbookish: Option<serde_json::Value>,

    #[serde(rename = "Onopordon")]
    onopordon: Option<i64>,

    podgily: Option<i64>,

    reformableness: Option<i64>,

    scatterbrains: Option<i64>,

    seminuria: Option<i64>,

    #[serde(rename = "Sodomite")]
    sodomite: Option<i64>,

    tramp: Option<i64>,

    undueness: Option<i64>,

    worthily: Option<i64>,

    #[serde(rename = "Yankeeist")]
    yankeeist: Option<i64>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Tabaxir {
    Bool(bool),

    Double(f64),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Talpiform {
    Double(f64),

    QuebrachineClass(QuebrachineClass),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Thwack {
    Bool(bool),

    Double(f64),

    QuebrachineClass(QuebrachineClass),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Tortricine {
    QuebrachineClass(QuebrachineClass),

    UnionArray(Vec<Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum TruantcyElement {
    Bool(bool),

    TruantcyClass(TruantcyClass),
}

#[derive(Serialize, Deserialize)]
pub struct TruantcyClass {
    alfiona: Option<serde_json::Value>,

    ascaridiasis: Option<serde_json::Value>,

    bungey: Option<serde_json::Value>,

    catharticalness: Option<f64>,

    ceroxyle: Option<serde_json::Value>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    chorology: Option<serde_json::Value>,

    disdiapason: Option<String>,

    enmarble: Option<serde_json::Value>,

    #[serde(rename = "Epeira")]
    epeira: Option<serde_json::Value>,

    #[serde(rename = "Eurylaimi")]
    eurylaimi: Option<serde_json::Value>,

    germination: Option<serde_json::Value>,

    hallelujah: Option<serde_json::Value>,

    homocerc: Option<bool>,

    lev: Option<serde_json::Value>,

    mouthing: Option<serde_json::Value>,

    nonbookish: Option<serde_json::Value>,

    philliloo: Option<serde_json::Value>,

    planetal: Option<serde_json::Value>,

    poney: Option<serde_json::Value>,

    punctualist: Option<serde_json::Value>,

    returnlessly: Option<serde_json::Value>,

    skelder: Option<serde_json::Value>,

    windwaywardly: Option<serde_json::Value>,

    #[serde(rename = "Yuman")]
    yuman: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unbeginning {
    IntegerMap(HashMap<String, i64>),

    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Undesirability {
    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unerasing {
    Integer(i64),

    IntegerMap(HashMap<String, i64>),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unguentarium {
    Integer(i64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnimpeachablyElement {
    Bool(bool),

    UnimpeachablyClass(UnimpeachablyClass),
}

#[derive(Serialize, Deserialize)]
pub struct UnimpeachablyClass {
    acerin: Option<i64>,

    #[serde(rename = "Bobadil")]
    bobadil: Option<i64>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    chlorophylligenous: Option<i64>,

    conversational: Option<i64>,

    demiowl: Option<i64>,

    disdiapason: Option<String>,

    ectorhinal: Option<i64>,

    gamblesomeness: Option<i64>,

    homocerc: Option<bool>,

    irrorate: Option<i64>,

    kindergartening: Option<i64>,

    lateritic: Option<i64>,

    mespil: Option<i64>,

    misconfiguration: Option<i64>,

    nonbookish: Option<serde_json::Value>,

    planometry: Option<i64>,

    #[serde(rename = "Quiina")]
    quiina: Option<i64>,

    #[serde(rename = "Robert")]
    robert: Option<i64>,

    rot: Option<i64>,

    subcinctorium: Option<i64>,

    tussocker: Option<i64>,

    ultraproud: Option<i64>,

    unsuggestedness: Option<i64>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unmortgaged {
    Double(f64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unobstructed {
    Integer(i64),

    QuebrachineClass(QuebrachineClass),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unreceptivity {
    Integer(i64),

    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unsatisfactoriness {
    Bool(bool),

    Integer(i64),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnstressedElement {
    Bool(bool),

    PurpleString(String),

    UnstressedClass(UnstressedClass),
}

#[derive(Serialize, Deserialize)]
pub struct UnstressedClass {
    #[serde(rename = "Alain")]
    alain: Option<serde_json::Value>,

    #[serde(rename = "Amphirhina")]
    amphirhina: Option<serde_json::Value>,

    antimachinery: Option<serde_json::Value>,

    coldish: Option<serde_json::Value>,

    crantara: Option<serde_json::Value>,

    distinguishing: Option<serde_json::Value>,

    elytroposis: Option<serde_json::Value>,

    gentianwort: Option<serde_json::Value>,

    heliosis: Option<serde_json::Value>,

    instrumental: Option<serde_json::Value>,

    introinflection: Option<serde_json::Value>,

    kala: Option<serde_json::Value>,

    #[serde(rename = "Lincolnian")]
    lincolnian: Option<serde_json::Value>,

    metad: Option<serde_json::Value>,

    #[serde(rename = "Sarcophilus")]
    sarcophilus: Option<serde_json::Value>,

    swingingly: Option<serde_json::Value>,

    unconformity: Option<serde_json::Value>,

    undecreed: Option<serde_json::Value>,

    venerable: Option<serde_json::Value>,

    vowellessness: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Untasked {
    Double(f64),

    IntegerMap(HashMap<String, i64>),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unvarying {
    Bool(bool),

    Double(f64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Vehemently {
    Bool(bool),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Whitepot {
    Double(f64),

    QuebrachineClass(QuebrachineClass),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum WrothyElement {
    NullArray(Vec<Option<serde_json::Value>>),

    WrothyClass(WrothyClass),
}

#[derive(Serialize, Deserialize)]
pub struct WrothyClass {
    #[serde(rename = "Aeschynanthus")]
    aeschynanthus: Option<serde_json::Value>,

    aquiferous: Option<serde_json::Value>,

    cheapener: Option<serde_json::Value>,

    enumeration: Option<serde_json::Value>,

    #[serde(rename = "Ephesine")]
    ephesine: Option<serde_json::Value>,

    escadrille: Option<serde_json::Value>,

    estrous: Option<serde_json::Value>,

    interestedly: Option<serde_json::Value>,

    katakinetomer: Option<serde_json::Value>,

    mortification: Option<serde_json::Value>,

    morula: Option<serde_json::Value>,

    orthosymmetrical: Option<serde_json::Value>,

    overbark: Option<serde_json::Value>,

    politist: Option<serde_json::Value>,

    qualified: Option<serde_json::Value>,

    sphenomalar: Option<serde_json::Value>,

    throatful: Option<serde_json::Value>,

    transhumance: Option<serde_json::Value>,

    triandrian: Option<serde_json::Value>,

    unbooked: Option<serde_json::Value>,
}
