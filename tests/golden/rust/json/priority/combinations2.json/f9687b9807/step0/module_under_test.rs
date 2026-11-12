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
    #[serde(rename = "Abranchiata")]
    abranchiata: Vec<Option<Abranchiata>>,

    academe: Vec<Academe>,

    acquirable: Vec<Acquirable>,

    aerometry: Vec<Aerometry>,

    alexin: Vec<Alexin>,

    alleviate: Vec<AlleviateElement>,

    amaas: Vec<Amaa>,

    ambassage: Vec<Ambassage>,

    amphithyron: Vec<Option<Amphithyron>>,

    #[serde(rename = "Andriana")]
    andriana: Vec<Option<String>>,

    ankee: Vec<AnkeeElement>,

    annihilator: Vec<Option<HashMap<String, Option<i64>>>>,

    annulose: Option<serde_json::Value>,

    #[serde(rename = "Ansarie")]
    ansarie: Vec<Option<AnsarieElement>>,

    aphasia: Vec<Aphasia>,

    asprawl: Vec<Asprawl>,

    attractive: Vec<Option<bool>>,

    barksome: HashMap<String, i64>,

    bedesman: Vec<Bedesman>,

    belard: Vec<Belard>,

    bocking: Vec<Bocking>,

    brawlingly: Vec<Brawlingly>,

    brookie: Vec<Brookie>,

    bumboatman: Vec<Option<Bumboatman>>,

    bystreet: Vec<Option<serde_json::Value>>,

    calaverite: Vec<Calaverite>,

    catallactic: Vec<Catallactic>,

    cemental: Vec<Cemental>,

    #[serde(rename = "Chytridiaceae")]
    chytridiaceae: Vec<Option<ChytridiaceaeElement>>,

    #[serde(rename = "Discordia")]
    discordia: Vec<DiscordiaElement>,

    #[serde(rename = "Endomyces")]
    endomyces: Vec<Endomyce>,

    #[serde(rename = "Epinephelidae")]
    epinephelidae: Vec<Epinephelidae>,

    #[serde(rename = "Eupatorium")]
    eupatorium: Vec<Eupatorium>,

    #[serde(rename = "Gryphosaurus")]
    gryphosaurus: Vec<GryphosaurusElement>,

    #[serde(rename = "Koryak")]
    koryak: Vec<Koryak>,

    #[serde(rename = "Lavinia")]
    lavinia: Vec<LaviniaElement>,

    #[serde(rename = "Oskar")]
    oskar: Vec<OskarElement>,

    #[serde(rename = "Rebecca")]
    rebecca: Vec<RebeccaElement>,

    #[serde(rename = "Rhomboganoidei")]
    rhomboganoidei: Vec<Rhomboganoidei>,

    #[serde(rename = "Rigsmal")]
    rigsmal: bool,

    #[serde(rename = "Ruellia")]
    ruellia: Vec<Ruellia>,

    #[serde(rename = "School")]
    school: Vec<Option<School>>,

    #[serde(rename = "Shakespearolater")]
    shakespearolater: Vec<Shakespearolater>,

    #[serde(rename = "Svan")]
    svan: Vec<f64>,

    #[serde(rename = "Wayao")]
    wayao: HashMap<String, f64>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Abranchiata {
    Integer(i64),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Academe {
    Integer(i64),

    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Acquirable {
    IntegerMap(HashMap<String, i64>),

    UnionArray(Vec<Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Aerometry {
    Bool(bool),

    Double(f64),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Alexin {
    Bool(bool),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum AlleviateElement {
    AlleviateClass(AlleviateClass),

    UnionArray(Vec<Option<i64>>),
}

#[derive(Serialize, Deserialize)]
pub struct AlleviateClass {
    apriori: Option<serde_json::Value>,

    beggarer: Option<serde_json::Value>,

    brokenheartedly: Option<serde_json::Value>,

    debilitation: Option<serde_json::Value>,

    frike: Option<serde_json::Value>,

    gastrolith: Option<serde_json::Value>,

    #[serde(rename = "Hulsean")]
    hulsean: Option<serde_json::Value>,

    orthocentric: Option<serde_json::Value>,

    petaly: Option<serde_json::Value>,

    probudgeting: Option<serde_json::Value>,

    reacquire: Option<serde_json::Value>,

    scow: Option<serde_json::Value>,

    shutoff: Option<serde_json::Value>,

    subcontiguous: Option<serde_json::Value>,

    suffumigate: Option<serde_json::Value>,

    transformable: Option<serde_json::Value>,

    uncoroneted: Option<serde_json::Value>,

    unparking: Option<serde_json::Value>,

    unvarnishedness: Option<serde_json::Value>,

    wherewithal: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Amaa {
    Bool(bool),

    Integer(i64),

    Rebecca(Rebecca),
}

#[derive(Serialize, Deserialize)]
pub struct Rebecca {
    catharticalness: f64,

    #[serde(rename = "Chirotherium")]
    chirotherium: i64,

    disdiapason: String,

    homocerc: bool,

    nonbookish: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Ambassage {
    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
pub struct Amphithyron {
    akroasis: Option<i64>,

    antiphonical: Option<i64>,

    basebred: Option<i64>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    conductometric: Option<i64>,

    disdiapason: Option<String>,

    ensilation: Option<i64>,

    eyebolt: Option<i64>,

    fistulated: Option<i64>,

    heteropod: Option<i64>,

    homocerc: Option<bool>,

    #[serde(rename = "Juniperus")]
    juniperus: Option<i64>,

    labyrinthically: Option<i64>,

    martyrization: Option<i64>,

    mispolicy: Option<i64>,

    multipara: Option<i64>,

    #[serde(rename = "Nazirite")]
    nazirite: Option<i64>,

    nonbookish: Option<serde_json::Value>,

    possessorial: Option<i64>,

    shamed: Option<i64>,

    shelfworn: Option<i64>,

    stagnum: Option<i64>,

    #[serde(rename = "Those")]
    those: Option<i64>,

    undecimal: Option<i64>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum AnkeeElement {
    AnkeeClass(AnkeeClass),

    Integer(i64),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
pub struct AnkeeClass {
    #[serde(rename = "Anomoean")]
    anomoean: Option<serde_json::Value>,

    barleyhood: Option<serde_json::Value>,

    befriender: Option<serde_json::Value>,

    brutishness: Option<serde_json::Value>,

    cephalalgy: Option<serde_json::Value>,

    cirurgian: Option<serde_json::Value>,

    conventionally: Option<serde_json::Value>,

    jackshay: Option<serde_json::Value>,

    milammeter: Option<serde_json::Value>,

    #[serde(rename = "Naja")]
    naja: Option<serde_json::Value>,

    ombrological: Option<serde_json::Value>,

    phonasthenia: Option<serde_json::Value>,

    retrievableness: Option<serde_json::Value>,

    snakily: Option<serde_json::Value>,

    swot: Option<serde_json::Value>,

    tartlet: Option<serde_json::Value>,

    thiofuran: Option<serde_json::Value>,

    tracheophone: Option<serde_json::Value>,

    tuglike: Option<serde_json::Value>,

    unscratchingly: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum AnsarieElement {
    AnsarieClass(AnsarieClass),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
pub struct AnsarieClass {
    accension: Option<serde_json::Value>,

    #[serde(rename = "Alida")]
    alida: Option<serde_json::Value>,

    asteria: Option<serde_json::Value>,

    beriberic: Option<serde_json::Value>,

    edgebone: Option<serde_json::Value>,

    gastrodialysis: Option<serde_json::Value>,

    geographic: Option<serde_json::Value>,

    #[serde(rename = "Ictonyx")]
    ictonyx: Option<serde_json::Value>,

    metrocele: Option<serde_json::Value>,

    misgraft: Option<serde_json::Value>,

    monteith: Option<serde_json::Value>,

    notcher: Option<serde_json::Value>,

    prorestriction: Option<serde_json::Value>,

    #[serde(rename = "Ramist")]
    ramist: Option<serde_json::Value>,

    throatlet: Option<serde_json::Value>,

    unfair: Option<serde_json::Value>,

    unsynonymous: Option<serde_json::Value>,

    water: Option<serde_json::Value>,

    zestfully: Option<serde_json::Value>,

    zincic: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Aphasia {
    Integer(i64),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Asprawl {
    Double(f64),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Bedesman {
    Bool(bool),

    Double(f64),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Belard {
    Double(f64),

    IntegerArray(Vec<i64>),

    Rebecca(Rebecca),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Bocking {
    Bool(bool),

    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Brawlingly {
    NullArray(Vec<Option<serde_json::Value>>),

    UnionMap(HashMap<String, Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Brookie {
    IntegerArray(Vec<i64>),

    Rebecca(Rebecca),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Bumboatman {
    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Calaverite {
    IntegerArray(Vec<i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Catallactic {
    Bool(bool),

    IntegerMap(HashMap<String, i64>),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Cemental {
    Double(f64),

    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum ChytridiaceaeElement {
    Bool(bool),

    ChytridiaceaeClass(ChytridiaceaeClass),
}

#[derive(Serialize, Deserialize)]
pub struct ChytridiaceaeClass {
    #[serde(rename = "Batidaceae")]
    batidaceae: Option<serde_json::Value>,

    #[serde(rename = "Brechites")]
    brechites: Option<serde_json::Value>,

    codespairer: Option<serde_json::Value>,

    #[serde(rename = "Emery")]
    emery: Option<serde_json::Value>,

    enervative: Option<serde_json::Value>,

    excriminate: Option<serde_json::Value>,

    goshenite: Option<serde_json::Value>,

    grime: Option<serde_json::Value>,

    gritten: Option<serde_json::Value>,

    hectorly: Option<serde_json::Value>,

    intermediation: Option<serde_json::Value>,

    meeterly: Option<serde_json::Value>,

    #[serde(rename = "Narraganset")]
    narraganset: Option<serde_json::Value>,

    onymatic: Option<serde_json::Value>,

    paddlecock: Option<serde_json::Value>,

    thana: Option<serde_json::Value>,

    thornily: Option<serde_json::Value>,

    uckia: Option<serde_json::Value>,

    unmettle: Option<serde_json::Value>,

    vorticellid: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum DiscordiaElement {
    DiscordiaClass(DiscordiaClass),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
pub struct DiscordiaClass {
    #[serde(rename = "Altaic")]
    altaic: Option<i64>,

    amoristic: Option<i64>,

    blennophthalmia: Option<i64>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    disciplinability: Option<i64>,

    disdiapason: Option<String>,

    goofer: Option<i64>,

    homocerc: Option<bool>,

    laryngograph: Option<i64>,

    leucitis: Option<i64>,

    lymphocyst: Option<i64>,

    microcosmology: Option<i64>,

    nauseation: Option<i64>,

    nonbookish: Option<serde_json::Value>,

    #[serde(rename = "Patarin")]
    patarin: Option<i64>,

    preliberal: Option<i64>,

    prettifier: Option<i64>,

    rangework: Option<i64>,

    redient: Option<i64>,

    subfusiform: Option<i64>,

    suicidical: Option<i64>,

    swow: Option<i64>,

    wastrel: Option<i64>,

    wingle: Option<i64>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Endomyce {
    Integer(i64),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Epinephelidae {
    Bool(bool),

    Integer(i64),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Eupatorium {
    IntegerMap(HashMap<String, i64>),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum GryphosaurusElement {
    GryphosaurusClass(GryphosaurusClass),

    IntegerArray(Vec<i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
pub struct GryphosaurusClass {
    amissibility: Option<serde_json::Value>,

    #[serde(rename = "Burushaski")]
    burushaski: Option<serde_json::Value>,

    citronin: Option<serde_json::Value>,

    coplaintiff: Option<serde_json::Value>,

    disquisitionary: Option<serde_json::Value>,

    enoplan: Option<serde_json::Value>,

    faintness: Option<serde_json::Value>,

    hebetomy: Option<serde_json::Value>,

    islandry: Option<serde_json::Value>,

    lameduck: Option<serde_json::Value>,

    overbattle: Option<serde_json::Value>,

    overinterested: Option<serde_json::Value>,

    phrenologic: Option<serde_json::Value>,

    rainband: Option<serde_json::Value>,

    shiningly: Option<serde_json::Value>,

    stamineous: Option<serde_json::Value>,

    subscapularis: Option<serde_json::Value>,

    #[serde(rename = "Tahami")]
    tahami: Option<serde_json::Value>,

    undaubed: Option<serde_json::Value>,

    underntime: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Koryak {
    PurpleString(String),

    UnionMap(HashMap<String, Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum LaviniaElement {
    LaviniaClass(LaviniaClass),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
pub struct LaviniaClass {
    agitable: Option<i64>,

    asininity: Option<i64>,

    benefiter: Option<i64>,

    bronzelike: Option<i64>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    cholesteatomatous: Option<i64>,

    deprivement: Option<i64>,

    disdiapason: Option<String>,

    flippantness: Option<i64>,

    fogproof: Option<i64>,

    homocerc: Option<bool>,

    merrymeeting: Option<i64>,

    nonbookish: Option<serde_json::Value>,

    overcareful: Option<i64>,

    panaris: Option<i64>,

    preacceptance: Option<i64>,

    quinoxaline: Option<i64>,

    sig: Option<i64>,

    superconfusion: Option<i64>,

    #[serde(rename = "Tacana")]
    tacana: Option<i64>,

    tillotter: Option<i64>,

    tranquillize: Option<i64>,

    unquestionable: Option<i64>,

    uproute: Option<i64>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum OskarElement {
    IntegerArray(Vec<i64>),

    OskarClass(OskarClass),
}

#[derive(Serialize, Deserialize)]
pub struct OskarClass {
    #[serde(rename = "Acrobates")]
    acrobates: Option<serde_json::Value>,

    beanshooter: Option<serde_json::Value>,

    bearhound: Option<serde_json::Value>,

    #[serde(rename = "Cayuga")]
    cayuga: Option<serde_json::Value>,

    guarneri: Option<serde_json::Value>,

    hypochondriacism: Option<serde_json::Value>,

    indication: Option<serde_json::Value>,

    jaculative: Option<serde_json::Value>,

    nagana: Option<serde_json::Value>,

    #[serde(rename = "Netherlandish")]
    netherlandish: Option<serde_json::Value>,

    noctivagous: Option<serde_json::Value>,

    nonphysiological: Option<serde_json::Value>,

    praxis: Option<serde_json::Value>,

    provision: Option<serde_json::Value>,

    subterhuman: Option<serde_json::Value>,

    sunlit: Option<serde_json::Value>,

    syncraniate: Option<serde_json::Value>,

    teachment: Option<serde_json::Value>,

    unmutinous: Option<serde_json::Value>,

    unstoppable: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum RebeccaElement {
    Integer(i64),

    PurpleString(String),

    Rebecca(Rebecca),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Rhomboganoidei {
    IntegerArray(Vec<i64>),

    PurpleString(String),

    Rebecca(Rebecca),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Ruellia {
    Bool(bool),

    PurpleString(String),

    Rebecca(Rebecca),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum School {
    Integer(i64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Shakespearolater {
    Double(f64),

    IntegerArray(Vec<i64>),

    PurpleString(String),
}
