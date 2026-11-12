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

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    pub protrusive: Vec<Protrusive>,
    pub pulpitism: Vec<PulpitismElement>,
    pub pyodermia: Vec<PyodermiaElement>,
    pub quebrachine: Vec<Option<QuebrachineElement>>,
    pub querier: Vec<Querier>,
    pub rebarbative: Vec<Rebarbative>,
    pub reimagine: Vec<Reimagine>,
    pub ressaut: Ressaut,
    pub retrocervical: Vec<Retrocervical>,
    pub revert: Vec<Revert>,
    pub rewrite: Vec<RewriteElement>,
    pub saccoderm: Vec<Option<Saccoderm>>,
    pub santir: Vec<SantirElement>,
    pub saprophilous: Vec<Option<Saprophilous>>,
    pub saxten: Vec<SaxtenElement>,
    pub scatty: Vec<Option<Scatty>>,
    pub scoffer: Vec<Option<Scoffer>>,
    pub scrampum: Vec<Option<Scrampum>>,
    pub semantic: f64,
    pub serpentinic: Vec<Serpentinic>,
    pub shadowable: Vec<Shadowable>,
    pub sistering: Vec<SisteringElement>,
    pub staghunting: Vec<Staghunting>,
    pub stagmometer: Vec<Stagmometer>,
    pub stimulability: Vec<Stimulability>,
    pub strangleable: Vec<Strangleable>,
    pub strenuosity: Vec<StrenuosityElement>,
    pub tabaxir: Vec<Tabaxir>,
    pub talpiform: Vec<Option<Talpiform>>,
    pub thwack: Vec<Thwack>,
    pub to: Vec<Option<f64>>,
    pub tortricine: Vec<Tortricine>,
    pub truantcy: Vec<TruantcyElement>,
    pub turgesce: Vec<String>,
    pub unbeginning: Vec<Unbeginning>,
    pub underdunged: Vec<f64>,
    pub undesirability: Vec<Undesirability>,
    pub unerasing: Vec<Unerasing>,
    pub unguentarium: Vec<Option<Unguentarium>>,
    pub unimpeachably: Vec<UnimpeachablyElement>,
    pub unmortgaged: Vec<Option<Unmortgaged>>,
    pub unobstructed: Vec<Option<Unobstructed>>,
    pub unreceptivity: Vec<Unreceptivity>,
    pub unsatisfactoriness: Vec<Unsatisfactoriness>,
    pub unsecurity: Vec<i64>,
    pub unstressed: Vec<UnstressedElement>,
    pub untasked: Vec<Untasked>,
    pub unvarying: Vec<Unvarying>,
    pub vehemently: Vec<Option<Vehemently>>,
    pub warriorship: HashMap<String, bool>,
    pub whitepot: Vec<Whitepot>,
    pub wrothy: Vec<WrothyElement>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Protrusive {
    Double(f64),
    UnionArray(Vec<Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum PulpitismElement {
    Double(f64),
    IntegerArray(Vec<i64>),
    PulpitismClass(PulpitismClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PulpitismClass {
    pub abnet: Option<serde_json::Value>,
    pub buckhorn: Option<serde_json::Value>,
    pub calciform: Option<serde_json::Value>,
    pub chelophore: Option<serde_json::Value>,
    pub cogitation: Option<serde_json::Value>,
    pub decreeable: Option<serde_json::Value>,
    pub despicable: Option<serde_json::Value>,
    pub isodiazo: Option<serde_json::Value>,
    pub jadedly: Option<serde_json::Value>,
    pub leptochlorite: Option<serde_json::Value>,
    pub nursling: Option<serde_json::Value>,
    pub palamedean: Option<serde_json::Value>,
    pub photoheliograph: Option<serde_json::Value>,
    pub pipewood: Option<serde_json::Value>,
    pub roberd: Option<serde_json::Value>,
    pub statable: Option<serde_json::Value>,
    pub superassume: Option<serde_json::Value>,
    pub syllabe: Option<serde_json::Value>,
    pub toughhead: Option<serde_json::Value>,
    pub underburn: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum PyodermiaElement {
    Integer(i64),
    PyodermiaClass(PyodermiaClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PyodermiaClass {
    pub aphoristically: Option<serde_json::Value>,
    pub apophyllous: Option<serde_json::Value>,
    pub cognize: Option<serde_json::Value>,
    pub dermonosology: Option<serde_json::Value>,
    #[serde(rename = "Gyppo")]
    pub gyppo: Option<serde_json::Value>,
    pub ither: Option<serde_json::Value>,
    pub juglandaceous: Option<serde_json::Value>,
    pub litho: Option<serde_json::Value>,
    pub macropterous: Option<serde_json::Value>,
    pub photographer: Option<serde_json::Value>,
    pub romancing: Option<serde_json::Value>,
    pub rumness: Option<serde_json::Value>,
    pub somniloquist: Option<serde_json::Value>,
    pub stressfully: Option<serde_json::Value>,
    pub tactically: Option<serde_json::Value>,
    pub tracheophony: Option<serde_json::Value>,
    pub unappositely: Option<serde_json::Value>,
    pub unclothedly: Option<serde_json::Value>,
    pub unimplied: Option<serde_json::Value>,
    pub unsyncopated: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum QuebrachineElement {
    Bool(bool),
    QuebrachineClass(QuebrachineClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct QuebrachineClass {
    pub catharticalness: f64,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: i64,
    pub disdiapason: String,
    pub homocerc: bool,
    pub nonbookish: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Querier {
    Bool(bool),
    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Rebarbative {
    Bool(bool),
    Double(f64),
    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Reimagine {
    pub adducible: Option<serde_json::Value>,
    pub anabolin: Option<serde_json::Value>,
    pub brainy: Option<serde_json::Value>,
    pub catharticalness: Option<f64>,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,
    pub chrysamine: Option<serde_json::Value>,
    pub disdiapason: Option<String>,
    pub fluxweed: Option<serde_json::Value>,
    pub glaucine: Option<serde_json::Value>,
    pub grobianism: Option<serde_json::Value>,
    #[serde(rename = "Hermo")]
    pub hermo: Option<serde_json::Value>,
    pub hieroglyphist: Option<serde_json::Value>,
    pub homocerc: Option<bool>,
    pub icteroid: Option<serde_json::Value>,
    pub immortal: Option<serde_json::Value>,
    pub impetulant: Option<serde_json::Value>,
    pub irrigate: Option<serde_json::Value>,
    pub myxedema: Option<serde_json::Value>,
    pub nonbookish: Option<serde_json::Value>,
    pub onyx: Option<serde_json::Value>,
    pub repasser: Option<serde_json::Value>,
    pub septomarginal: Option<serde_json::Value>,
    pub subdie: Option<serde_json::Value>,
    pub tibiometatarsal: Option<serde_json::Value>,
    pub waltzlike: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ressaut {
    pub apperceptive: String,
    pub cuttoo: String,
    pub douser: String,
    pub drinkproof: String,
    pub forementioned: String,
    #[serde(rename = "Freesia")]
    pub freesia: String,
    #[serde(rename = "Genevieve")]
    pub genevieve: String,
    pub hyperdiabolical: String,
    pub hypocone: String,
    pub irreverentially: String,
    pub jumart: String,
    #[serde(rename = "Mimosaceae")]
    pub mimosaceae: String,
    pub mollicrush: String,
    pub nedder: String,
    pub retinasphalt: String,
    pub sough: String,
    pub steading: String,
    #[serde(rename = "Theopaschitism")]
    pub theopaschitism: String,
    pub undurableness: String,
    pub unmingleable: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Retrocervical {
    Integer(i64),
    UnionArray(Vec<Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Revert {
    Bool(bool),
    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum RewriteElement {
    Double(f64),
    NullArray(Vec<Option<serde_json::Value>>),
    RewriteClass(RewriteClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RewriteClass {
    pub accountancy: Option<serde_json::Value>,
    pub cacotrophic: Option<serde_json::Value>,
    pub contest: Option<serde_json::Value>,
    pub couthily: Option<serde_json::Value>,
    pub falculate: Option<serde_json::Value>,
    pub foreseize: Option<serde_json::Value>,
    #[serde(rename = "Hyades")]
    pub hyades: Option<serde_json::Value>,
    pub lemnad: Option<serde_json::Value>,
    pub monotheistically: Option<serde_json::Value>,
    pub nonflying: Option<serde_json::Value>,
    #[serde(rename = "Ptenoglossa")]
    pub ptenoglossa: Option<serde_json::Value>,
    pub repatch: Option<serde_json::Value>,
    pub rodman: Option<serde_json::Value>,
    pub strung: Option<serde_json::Value>,
    pub titmal: Option<serde_json::Value>,
    pub twalpennyworth: Option<serde_json::Value>,
    pub unblamable: Option<serde_json::Value>,
    pub vertical: Option<serde_json::Value>,
    #[serde(rename = "Whiggification")]
    pub whiggification: Option<serde_json::Value>,
    pub yardman: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Saccoderm {
    IntegerArray(Vec<i64>),
    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum SantirElement {
    Double(f64),
    SantirClass(SantirClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SantirClass {
    pub admiredly: Option<serde_json::Value>,
    pub demicaponier: Option<serde_json::Value>,
    pub epitympanic: Option<serde_json::Value>,
    pub investitor: Option<serde_json::Value>,
    pub lupiform: Option<serde_json::Value>,
    pub monoflagellate: Option<serde_json::Value>,
    pub paleoethnic: Option<serde_json::Value>,
    pub prediscountable: Option<serde_json::Value>,
    pub rhetoricals: Option<serde_json::Value>,
    pub roomth: Option<serde_json::Value>,
    pub saccharose: Option<serde_json::Value>,
    pub septonasal: Option<serde_json::Value>,
    pub serpenticide: Option<serde_json::Value>,
    pub setarious: Option<serde_json::Value>,
    pub spaework: Option<serde_json::Value>,
    pub stylite: Option<serde_json::Value>,
    #[serde(rename = "Suessiones")]
    pub suessiones: Option<serde_json::Value>,
    pub timelily: Option<serde_json::Value>,
    pub unprofaned: Option<serde_json::Value>,
    pub vorticular: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Saprophilous {
    IntegerMap(HashMap<String, i64>),
    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum SaxtenElement {
    PurpleString(String),
    SaxtenClass(SaxtenClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SaxtenClass {
    pub algarrobilla: Option<serde_json::Value>,
    pub bowgrace: Option<serde_json::Value>,
    pub catharticalness: Option<f64>,
    #[serde(rename = "Centaurid")]
    pub centaurid: Option<serde_json::Value>,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,
    pub disdiapason: Option<String>,
    pub flix: Option<serde_json::Value>,
    pub germanely: Option<serde_json::Value>,
    pub homocerc: Option<bool>,
    pub inhume: Option<serde_json::Value>,
    pub lepidote: Option<serde_json::Value>,
    pub megalochirous: Option<serde_json::Value>,
    pub ninepenny: Option<serde_json::Value>,
    pub nonbookish: Option<serde_json::Value>,
    pub nondeist: Option<serde_json::Value>,
    pub nymphaeaceous: Option<serde_json::Value>,
    pub parietofrontal: Option<serde_json::Value>,
    pub sancyite: Option<serde_json::Value>,
    pub subjectivist: Option<serde_json::Value>,
    pub tibiad: Option<serde_json::Value>,
    pub transonic: Option<serde_json::Value>,
    pub tripetalous: Option<serde_json::Value>,
    pub trunchman: Option<serde_json::Value>,
    pub urger: Option<serde_json::Value>,
    pub withdrawnness: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Scatty {
    pub aeriferous: Option<serde_json::Value>,
    pub antical: Option<serde_json::Value>,
    pub antighostism: Option<serde_json::Value>,
    pub arcanum: Option<serde_json::Value>,
    pub autotrophy: Option<serde_json::Value>,
    pub baronial: Option<serde_json::Value>,
    pub caffeine: Option<serde_json::Value>,
    pub gorgoniacean: Option<serde_json::Value>,
    pub heroical: Option<serde_json::Value>,
    pub hydropical: Option<serde_json::Value>,
    pub mechanology: Option<serde_json::Value>,
    pub musicopoetic: Option<serde_json::Value>,
    pub officiality: Option<serde_json::Value>,
    pub oftentimes: Option<serde_json::Value>,
    pub ophthalmotonometer: Option<serde_json::Value>,
    pub reflectively: Option<serde_json::Value>,
    pub springer: Option<serde_json::Value>,
    #[serde(rename = "Tabasco")]
    pub tabasco: Option<serde_json::Value>,
    pub teleianthous: Option<serde_json::Value>,
    pub uncombated: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Scoffer {
    IntegerMap(HashMap<String, i64>),
    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Scrampum {
    Bool(bool),
    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Serpentinic {
    Double(f64),
    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Shadowable {
    Bool(bool),
    UnionArray(Vec<Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum SisteringElement {
    Integer(i64),
    NullArray(Vec<Option<serde_json::Value>>),
    SisteringClass(SisteringClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SisteringClass {
    pub amphicarpic: Option<serde_json::Value>,
    #[serde(rename = "Chianti")]
    pub chianti: Option<serde_json::Value>,
    pub frigorific: Option<serde_json::Value>,
    #[serde(rename = "Haplomi")]
    pub haplomi: Option<serde_json::Value>,
    pub hyperkinesis: Option<serde_json::Value>,
    pub laudable: Option<serde_json::Value>,
    pub madwoman: Option<serde_json::Value>,
    pub maimedly: Option<serde_json::Value>,
    #[serde(rename = "Micropterygidae")]
    pub micropterygidae: Option<serde_json::Value>,
    pub microrhabdus: Option<serde_json::Value>,
    pub nondense: Option<serde_json::Value>,
    pub phlebemphraxis: Option<serde_json::Value>,
    pub redsear: Option<serde_json::Value>,
    pub schismatical: Option<serde_json::Value>,
    pub tartryl: Option<serde_json::Value>,
    pub unabhorred: Option<serde_json::Value>,
    pub undeliberateness: Option<serde_json::Value>,
    pub unmixable: Option<serde_json::Value>,
    pub untruckling: Option<serde_json::Value>,
    pub vineal: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Staghunting {
    pub calorimetric: Option<i64>,
    pub canid: Option<i64>,
    pub catharticalness: Option<f64>,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,
    pub disdiapason: Option<String>,
    pub ditriglyphic: Option<i64>,
    pub floriferousness: Option<i64>,
    pub gamelike: Option<i64>,
    pub grig: Option<i64>,
    pub homocerc: Option<bool>,
    pub interloan: Option<i64>,
    pub lithotomy: Option<i64>,
    pub loric: Option<i64>,
    pub membranocoriaceous: Option<i64>,
    pub membranogenic: Option<i64>,
    pub nonbookish: Option<serde_json::Value>,
    pub overtrump: Option<i64>,
    pub scotino: Option<i64>,
    pub seasonable: Option<i64>,
    pub sephen: Option<i64>,
    pub stigmarioid: Option<i64>,
    pub tired: Option<i64>,
    pub trifid: Option<i64>,
    pub undefeatedly: Option<i64>,
    pub ungirlish: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Stagmometer {
    PurpleString(String),
    UnionArray(Vec<Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Stimulability {
    Bool(bool),
    Integer(i64),
    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Strangleable {
    Double(f64),
    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum StrenuosityElement {
    NullArray(Vec<Option<serde_json::Value>>),
    StrenuosityClass(StrenuosityClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StrenuosityClass {
    pub bliss: Option<i64>,
    pub buccate: Option<i64>,
    pub bulletproof: Option<i64>,
    pub catharticalness: Option<f64>,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,
    pub crumblingness: Option<i64>,
    pub disdiapason: Option<String>,
    pub engagedly: Option<i64>,
    pub fightable: Option<i64>,
    pub hoariness: Option<i64>,
    pub homocerc: Option<bool>,
    pub hypopodium: Option<i64>,
    pub luxurist: Option<i64>,
    pub mechanician: Option<i64>,
    pub nonbookish: Option<serde_json::Value>,
    #[serde(rename = "Onopordon")]
    pub onopordon: Option<i64>,
    pub podgily: Option<i64>,
    pub reformableness: Option<i64>,
    pub scatterbrains: Option<i64>,
    pub seminuria: Option<i64>,
    #[serde(rename = "Sodomite")]
    pub sodomite: Option<i64>,
    pub tramp: Option<i64>,
    pub undueness: Option<i64>,
    pub worthily: Option<i64>,
    #[serde(rename = "Yankeeist")]
    pub yankeeist: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Tabaxir {
    Bool(bool),
    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Talpiform {
    Double(f64),
    QuebrachineClass(QuebrachineClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Thwack {
    Bool(bool),
    Double(f64),
    QuebrachineClass(QuebrachineClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Tortricine {
    QuebrachineClass(QuebrachineClass),
    UnionArray(Vec<Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum TruantcyElement {
    Bool(bool),
    TruantcyClass(TruantcyClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TruantcyClass {
    pub alfiona: Option<serde_json::Value>,
    pub ascaridiasis: Option<serde_json::Value>,
    pub bungey: Option<serde_json::Value>,
    pub catharticalness: Option<f64>,
    pub ceroxyle: Option<serde_json::Value>,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,
    pub chorology: Option<serde_json::Value>,
    pub disdiapason: Option<String>,
    pub enmarble: Option<serde_json::Value>,
    #[serde(rename = "Epeira")]
    pub epeira: Option<serde_json::Value>,
    #[serde(rename = "Eurylaimi")]
    pub eurylaimi: Option<serde_json::Value>,
    pub germination: Option<serde_json::Value>,
    pub hallelujah: Option<serde_json::Value>,
    pub homocerc: Option<bool>,
    pub lev: Option<serde_json::Value>,
    pub mouthing: Option<serde_json::Value>,
    pub nonbookish: Option<serde_json::Value>,
    pub philliloo: Option<serde_json::Value>,
    pub planetal: Option<serde_json::Value>,
    pub poney: Option<serde_json::Value>,
    pub punctualist: Option<serde_json::Value>,
    pub returnlessly: Option<serde_json::Value>,
    pub skelder: Option<serde_json::Value>,
    pub windwaywardly: Option<serde_json::Value>,
    #[serde(rename = "Yuman")]
    pub yuman: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unbeginning {
    IntegerMap(HashMap<String, i64>),
    NullArray(Vec<Option<serde_json::Value>>),
    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Undesirability {
    IntegerArray(Vec<i64>),
    IntegerMap(HashMap<String, i64>),
    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unerasing {
    Integer(i64),
    IntegerMap(HashMap<String, i64>),
    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unguentarium {
    Integer(i64),
    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnimpeachablyElement {
    Bool(bool),
    UnimpeachablyClass(UnimpeachablyClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UnimpeachablyClass {
    pub acerin: Option<i64>,
    #[serde(rename = "Bobadil")]
    pub bobadil: Option<i64>,
    pub catharticalness: Option<f64>,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,
    pub chlorophylligenous: Option<i64>,
    pub conversational: Option<i64>,
    pub demiowl: Option<i64>,
    pub disdiapason: Option<String>,
    pub ectorhinal: Option<i64>,
    pub gamblesomeness: Option<i64>,
    pub homocerc: Option<bool>,
    pub irrorate: Option<i64>,
    pub kindergartening: Option<i64>,
    pub lateritic: Option<i64>,
    pub mespil: Option<i64>,
    pub misconfiguration: Option<i64>,
    pub nonbookish: Option<serde_json::Value>,
    pub planometry: Option<i64>,
    #[serde(rename = "Quiina")]
    pub quiina: Option<i64>,
    #[serde(rename = "Robert")]
    pub robert: Option<i64>,
    pub rot: Option<i64>,
    pub subcinctorium: Option<i64>,
    pub tussocker: Option<i64>,
    pub ultraproud: Option<i64>,
    pub unsuggestedness: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unmortgaged {
    Double(f64),
    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unobstructed {
    Integer(i64),
    QuebrachineClass(QuebrachineClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unreceptivity {
    Integer(i64),
    NullArray(Vec<Option<serde_json::Value>>),
    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unsatisfactoriness {
    Bool(bool),
    Integer(i64),
    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnstressedElement {
    Bool(bool),
    PurpleString(String),
    UnstressedClass(UnstressedClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UnstressedClass {
    #[serde(rename = "Alain")]
    pub alain: Option<serde_json::Value>,
    #[serde(rename = "Amphirhina")]
    pub amphirhina: Option<serde_json::Value>,
    pub antimachinery: Option<serde_json::Value>,
    pub coldish: Option<serde_json::Value>,
    pub crantara: Option<serde_json::Value>,
    pub distinguishing: Option<serde_json::Value>,
    pub elytroposis: Option<serde_json::Value>,
    pub gentianwort: Option<serde_json::Value>,
    pub heliosis: Option<serde_json::Value>,
    pub instrumental: Option<serde_json::Value>,
    pub introinflection: Option<serde_json::Value>,
    pub kala: Option<serde_json::Value>,
    #[serde(rename = "Lincolnian")]
    pub lincolnian: Option<serde_json::Value>,
    pub metad: Option<serde_json::Value>,
    #[serde(rename = "Sarcophilus")]
    pub sarcophilus: Option<serde_json::Value>,
    pub swingingly: Option<serde_json::Value>,
    pub unconformity: Option<serde_json::Value>,
    pub undecreed: Option<serde_json::Value>,
    pub venerable: Option<serde_json::Value>,
    pub vowellessness: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Untasked {
    Double(f64),
    IntegerMap(HashMap<String, i64>),
    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Unvarying {
    Bool(bool),
    Double(f64),
    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Vehemently {
    Bool(bool),
    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Whitepot {
    Double(f64),
    QuebrachineClass(QuebrachineClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum WrothyElement {
    NullArray(Vec<Option<serde_json::Value>>),
    WrothyClass(WrothyClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct WrothyClass {
    #[serde(rename = "Aeschynanthus")]
    pub aeschynanthus: Option<serde_json::Value>,
    pub aquiferous: Option<serde_json::Value>,
    pub cheapener: Option<serde_json::Value>,
    pub enumeration: Option<serde_json::Value>,
    #[serde(rename = "Ephesine")]
    pub ephesine: Option<serde_json::Value>,
    pub escadrille: Option<serde_json::Value>,
    pub estrous: Option<serde_json::Value>,
    pub interestedly: Option<serde_json::Value>,
    pub katakinetomer: Option<serde_json::Value>,
    pub mortification: Option<serde_json::Value>,
    pub morula: Option<serde_json::Value>,
    pub orthosymmetrical: Option<serde_json::Value>,
    pub overbark: Option<serde_json::Value>,
    pub politist: Option<serde_json::Value>,
    pub qualified: Option<serde_json::Value>,
    pub sphenomalar: Option<serde_json::Value>,
    pub throatful: Option<serde_json::Value>,
    pub transhumance: Option<serde_json::Value>,
    pub triandrian: Option<serde_json::Value>,
    pub unbooked: Option<serde_json::Value>,
}
