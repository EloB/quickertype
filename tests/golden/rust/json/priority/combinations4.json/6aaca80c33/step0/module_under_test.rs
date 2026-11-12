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
    pub(crate) protrusive: Vec<Protrusive>,

    pub(crate) pulpitism: Vec<PulpitismElement>,

    pub(crate) pyodermia: Vec<PyodermiaElement>,

    pub(crate) quebrachine: Vec<Option<QuebrachineElement>>,

    pub(crate) querier: Vec<Querier>,

    pub(crate) rebarbative: Vec<Rebarbative>,

    pub(crate) reimagine: Vec<Reimagine>,

    pub(crate) ressaut: Ressaut,

    pub(crate) retrocervical: Vec<Retrocervical>,

    pub(crate) revert: Vec<Revert>,

    pub(crate) rewrite: Vec<RewriteElement>,

    pub(crate) saccoderm: Vec<Option<Saccoderm>>,

    pub(crate) santir: Vec<SantirElement>,

    pub(crate) saprophilous: Vec<Option<Saprophilous>>,

    pub(crate) saxten: Vec<SaxtenElement>,

    pub(crate) scatty: Vec<Option<Scatty>>,

    pub(crate) scoffer: Vec<Option<Scoffer>>,

    pub(crate) scrampum: Vec<Option<Scrampum>>,

    pub(crate) semantic: f64,

    pub(crate) serpentinic: Vec<Serpentinic>,

    pub(crate) shadowable: Vec<Shadowable>,

    pub(crate) sistering: Vec<SisteringElement>,

    pub(crate) staghunting: Vec<Staghunting>,

    pub(crate) stagmometer: Vec<Stagmometer>,

    pub(crate) stimulability: Vec<Stimulability>,

    pub(crate) strangleable: Vec<Strangleable>,

    pub(crate) strenuosity: Vec<StrenuosityElement>,

    pub(crate) tabaxir: Vec<Tabaxir>,

    pub(crate) talpiform: Vec<Option<Talpiform>>,

    pub(crate) thwack: Vec<Thwack>,

    pub(crate) to: Vec<Option<f64>>,

    pub(crate) tortricine: Vec<Tortricine>,

    pub(crate) truantcy: Vec<TruantcyElement>,

    pub(crate) turgesce: Vec<String>,

    pub(crate) unbeginning: Vec<Unbeginning>,

    pub(crate) underdunged: Vec<f64>,

    pub(crate) undesirability: Vec<Undesirability>,

    pub(crate) unerasing: Vec<Unerasing>,

    pub(crate) unguentarium: Vec<Option<Unguentarium>>,

    pub(crate) unimpeachably: Vec<UnimpeachablyElement>,

    pub(crate) unmortgaged: Vec<Option<Unmortgaged>>,

    pub(crate) unobstructed: Vec<Option<Unobstructed>>,

    pub(crate) unreceptivity: Vec<Unreceptivity>,

    pub(crate) unsatisfactoriness: Vec<Unsatisfactoriness>,

    pub(crate) unsecurity: Vec<i64>,

    pub(crate) unstressed: Vec<UnstressedElement>,

    pub(crate) untasked: Vec<Untasked>,

    pub(crate) unvarying: Vec<Unvarying>,

    pub(crate) vehemently: Vec<Option<Vehemently>>,

    pub(crate) warriorship: HashMap<String, bool>,

    pub(crate) whitepot: Vec<Whitepot>,

    pub(crate) wrothy: Vec<WrothyElement>,
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
    pub(crate) abnet: Option<serde_json::Value>,

    pub(crate) buckhorn: Option<serde_json::Value>,

    pub(crate) calciform: Option<serde_json::Value>,

    pub(crate) chelophore: Option<serde_json::Value>,

    pub(crate) cogitation: Option<serde_json::Value>,

    pub(crate) decreeable: Option<serde_json::Value>,

    pub(crate) despicable: Option<serde_json::Value>,

    pub(crate) isodiazo: Option<serde_json::Value>,

    pub(crate) jadedly: Option<serde_json::Value>,

    pub(crate) leptochlorite: Option<serde_json::Value>,

    pub(crate) nursling: Option<serde_json::Value>,

    pub(crate) palamedean: Option<serde_json::Value>,

    pub(crate) photoheliograph: Option<serde_json::Value>,

    pub(crate) pipewood: Option<serde_json::Value>,

    pub(crate) roberd: Option<serde_json::Value>,

    pub(crate) statable: Option<serde_json::Value>,

    pub(crate) superassume: Option<serde_json::Value>,

    pub(crate) syllabe: Option<serde_json::Value>,

    pub(crate) toughhead: Option<serde_json::Value>,

    pub(crate) underburn: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum PyodermiaElement {
    Integer(i64),

    PyodermiaClass(PyodermiaClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PyodermiaClass {
    pub(crate) aphoristically: Option<serde_json::Value>,

    pub(crate) apophyllous: Option<serde_json::Value>,

    pub(crate) cognize: Option<serde_json::Value>,

    pub(crate) dermonosology: Option<serde_json::Value>,

    #[serde(rename = "Gyppo")]
    pub(crate) gyppo: Option<serde_json::Value>,

    pub(crate) ither: Option<serde_json::Value>,

    pub(crate) juglandaceous: Option<serde_json::Value>,

    pub(crate) litho: Option<serde_json::Value>,

    pub(crate) macropterous: Option<serde_json::Value>,

    pub(crate) photographer: Option<serde_json::Value>,

    pub(crate) romancing: Option<serde_json::Value>,

    pub(crate) rumness: Option<serde_json::Value>,

    pub(crate) somniloquist: Option<serde_json::Value>,

    pub(crate) stressfully: Option<serde_json::Value>,

    pub(crate) tactically: Option<serde_json::Value>,

    pub(crate) tracheophony: Option<serde_json::Value>,

    pub(crate) unappositely: Option<serde_json::Value>,

    pub(crate) unclothedly: Option<serde_json::Value>,

    pub(crate) unimplied: Option<serde_json::Value>,

    pub(crate) unsyncopated: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum QuebrachineElement {
    Bool(bool),

    QuebrachineClass(QuebrachineClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct QuebrachineClass {
    pub(crate) catharticalness: f64,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: i64,

    pub(crate) disdiapason: String,

    pub(crate) homocerc: bool,

    pub(crate) nonbookish: Option<serde_json::Value>,
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
    pub(crate) adducible: Option<serde_json::Value>,

    pub(crate) anabolin: Option<serde_json::Value>,

    pub(crate) brainy: Option<serde_json::Value>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) chrysamine: Option<serde_json::Value>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) fluxweed: Option<serde_json::Value>,

    pub(crate) glaucine: Option<serde_json::Value>,

    pub(crate) grobianism: Option<serde_json::Value>,

    #[serde(rename = "Hermo")]
    pub(crate) hermo: Option<serde_json::Value>,

    pub(crate) hieroglyphist: Option<serde_json::Value>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) icteroid: Option<serde_json::Value>,

    pub(crate) immortal: Option<serde_json::Value>,

    pub(crate) impetulant: Option<serde_json::Value>,

    pub(crate) irrigate: Option<serde_json::Value>,

    pub(crate) myxedema: Option<serde_json::Value>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) onyx: Option<serde_json::Value>,

    pub(crate) repasser: Option<serde_json::Value>,

    pub(crate) septomarginal: Option<serde_json::Value>,

    pub(crate) subdie: Option<serde_json::Value>,

    pub(crate) tibiometatarsal: Option<serde_json::Value>,

    pub(crate) waltzlike: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ressaut {
    pub(crate) apperceptive: String,

    pub(crate) cuttoo: String,

    pub(crate) douser: String,

    pub(crate) drinkproof: String,

    pub(crate) forementioned: String,

    #[serde(rename = "Freesia")]
    pub(crate) freesia: String,

    #[serde(rename = "Genevieve")]
    pub(crate) genevieve: String,

    pub(crate) hyperdiabolical: String,

    pub(crate) hypocone: String,

    pub(crate) irreverentially: String,

    pub(crate) jumart: String,

    #[serde(rename = "Mimosaceae")]
    pub(crate) mimosaceae: String,

    pub(crate) mollicrush: String,

    pub(crate) nedder: String,

    pub(crate) retinasphalt: String,

    pub(crate) sough: String,

    pub(crate) steading: String,

    #[serde(rename = "Theopaschitism")]
    pub(crate) theopaschitism: String,

    pub(crate) undurableness: String,

    pub(crate) unmingleable: String,
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
    pub(crate) accountancy: Option<serde_json::Value>,

    pub(crate) cacotrophic: Option<serde_json::Value>,

    pub(crate) contest: Option<serde_json::Value>,

    pub(crate) couthily: Option<serde_json::Value>,

    pub(crate) falculate: Option<serde_json::Value>,

    pub(crate) foreseize: Option<serde_json::Value>,

    #[serde(rename = "Hyades")]
    pub(crate) hyades: Option<serde_json::Value>,

    pub(crate) lemnad: Option<serde_json::Value>,

    pub(crate) monotheistically: Option<serde_json::Value>,

    pub(crate) nonflying: Option<serde_json::Value>,

    #[serde(rename = "Ptenoglossa")]
    pub(crate) ptenoglossa: Option<serde_json::Value>,

    pub(crate) repatch: Option<serde_json::Value>,

    pub(crate) rodman: Option<serde_json::Value>,

    pub(crate) strung: Option<serde_json::Value>,

    pub(crate) titmal: Option<serde_json::Value>,

    pub(crate) twalpennyworth: Option<serde_json::Value>,

    pub(crate) unblamable: Option<serde_json::Value>,

    pub(crate) vertical: Option<serde_json::Value>,

    #[serde(rename = "Whiggification")]
    pub(crate) whiggification: Option<serde_json::Value>,

    pub(crate) yardman: Option<serde_json::Value>,
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
    pub(crate) admiredly: Option<serde_json::Value>,

    pub(crate) demicaponier: Option<serde_json::Value>,

    pub(crate) epitympanic: Option<serde_json::Value>,

    pub(crate) investitor: Option<serde_json::Value>,

    pub(crate) lupiform: Option<serde_json::Value>,

    pub(crate) monoflagellate: Option<serde_json::Value>,

    pub(crate) paleoethnic: Option<serde_json::Value>,

    pub(crate) prediscountable: Option<serde_json::Value>,

    pub(crate) rhetoricals: Option<serde_json::Value>,

    pub(crate) roomth: Option<serde_json::Value>,

    pub(crate) saccharose: Option<serde_json::Value>,

    pub(crate) septonasal: Option<serde_json::Value>,

    pub(crate) serpenticide: Option<serde_json::Value>,

    pub(crate) setarious: Option<serde_json::Value>,

    pub(crate) spaework: Option<serde_json::Value>,

    pub(crate) stylite: Option<serde_json::Value>,

    #[serde(rename = "Suessiones")]
    pub(crate) suessiones: Option<serde_json::Value>,

    pub(crate) timelily: Option<serde_json::Value>,

    pub(crate) unprofaned: Option<serde_json::Value>,

    pub(crate) vorticular: Option<serde_json::Value>,
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
    pub(crate) algarrobilla: Option<serde_json::Value>,

    pub(crate) bowgrace: Option<serde_json::Value>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Centaurid")]
    pub(crate) centaurid: Option<serde_json::Value>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) flix: Option<serde_json::Value>,

    pub(crate) germanely: Option<serde_json::Value>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) inhume: Option<serde_json::Value>,

    pub(crate) lepidote: Option<serde_json::Value>,

    pub(crate) megalochirous: Option<serde_json::Value>,

    pub(crate) ninepenny: Option<serde_json::Value>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) nondeist: Option<serde_json::Value>,

    pub(crate) nymphaeaceous: Option<serde_json::Value>,

    pub(crate) parietofrontal: Option<serde_json::Value>,

    pub(crate) sancyite: Option<serde_json::Value>,

    pub(crate) subjectivist: Option<serde_json::Value>,

    pub(crate) tibiad: Option<serde_json::Value>,

    pub(crate) transonic: Option<serde_json::Value>,

    pub(crate) tripetalous: Option<serde_json::Value>,

    pub(crate) trunchman: Option<serde_json::Value>,

    pub(crate) urger: Option<serde_json::Value>,

    pub(crate) withdrawnness: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Scatty {
    pub(crate) aeriferous: Option<serde_json::Value>,

    pub(crate) antical: Option<serde_json::Value>,

    pub(crate) antighostism: Option<serde_json::Value>,

    pub(crate) arcanum: Option<serde_json::Value>,

    pub(crate) autotrophy: Option<serde_json::Value>,

    pub(crate) baronial: Option<serde_json::Value>,

    pub(crate) caffeine: Option<serde_json::Value>,

    pub(crate) gorgoniacean: Option<serde_json::Value>,

    pub(crate) heroical: Option<serde_json::Value>,

    pub(crate) hydropical: Option<serde_json::Value>,

    pub(crate) mechanology: Option<serde_json::Value>,

    pub(crate) musicopoetic: Option<serde_json::Value>,

    pub(crate) officiality: Option<serde_json::Value>,

    pub(crate) oftentimes: Option<serde_json::Value>,

    pub(crate) ophthalmotonometer: Option<serde_json::Value>,

    pub(crate) reflectively: Option<serde_json::Value>,

    pub(crate) springer: Option<serde_json::Value>,

    #[serde(rename = "Tabasco")]
    pub(crate) tabasco: Option<serde_json::Value>,

    pub(crate) teleianthous: Option<serde_json::Value>,

    pub(crate) uncombated: Option<serde_json::Value>,
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
    pub(crate) amphicarpic: Option<serde_json::Value>,

    #[serde(rename = "Chianti")]
    pub(crate) chianti: Option<serde_json::Value>,

    pub(crate) frigorific: Option<serde_json::Value>,

    #[serde(rename = "Haplomi")]
    pub(crate) haplomi: Option<serde_json::Value>,

    pub(crate) hyperkinesis: Option<serde_json::Value>,

    pub(crate) laudable: Option<serde_json::Value>,

    pub(crate) madwoman: Option<serde_json::Value>,

    pub(crate) maimedly: Option<serde_json::Value>,

    #[serde(rename = "Micropterygidae")]
    pub(crate) micropterygidae: Option<serde_json::Value>,

    pub(crate) microrhabdus: Option<serde_json::Value>,

    pub(crate) nondense: Option<serde_json::Value>,

    pub(crate) phlebemphraxis: Option<serde_json::Value>,

    pub(crate) redsear: Option<serde_json::Value>,

    pub(crate) schismatical: Option<serde_json::Value>,

    pub(crate) tartryl: Option<serde_json::Value>,

    pub(crate) unabhorred: Option<serde_json::Value>,

    pub(crate) undeliberateness: Option<serde_json::Value>,

    pub(crate) unmixable: Option<serde_json::Value>,

    pub(crate) untruckling: Option<serde_json::Value>,

    pub(crate) vineal: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Staghunting {
    pub(crate) calorimetric: Option<i64>,

    pub(crate) canid: Option<i64>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) ditriglyphic: Option<i64>,

    pub(crate) floriferousness: Option<i64>,

    pub(crate) gamelike: Option<i64>,

    pub(crate) grig: Option<i64>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) interloan: Option<i64>,

    pub(crate) lithotomy: Option<i64>,

    pub(crate) loric: Option<i64>,

    pub(crate) membranocoriaceous: Option<i64>,

    pub(crate) membranogenic: Option<i64>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) overtrump: Option<i64>,

    pub(crate) scotino: Option<i64>,

    pub(crate) seasonable: Option<i64>,

    pub(crate) sephen: Option<i64>,

    pub(crate) stigmarioid: Option<i64>,

    pub(crate) tired: Option<i64>,

    pub(crate) trifid: Option<i64>,

    pub(crate) undefeatedly: Option<i64>,

    pub(crate) ungirlish: Option<i64>,
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
    pub(crate) bliss: Option<i64>,

    pub(crate) buccate: Option<i64>,

    pub(crate) bulletproof: Option<i64>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) crumblingness: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) engagedly: Option<i64>,

    pub(crate) fightable: Option<i64>,

    pub(crate) hoariness: Option<i64>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) hypopodium: Option<i64>,

    pub(crate) luxurist: Option<i64>,

    pub(crate) mechanician: Option<i64>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    #[serde(rename = "Onopordon")]
    pub(crate) onopordon: Option<i64>,

    pub(crate) podgily: Option<i64>,

    pub(crate) reformableness: Option<i64>,

    pub(crate) scatterbrains: Option<i64>,

    pub(crate) seminuria: Option<i64>,

    #[serde(rename = "Sodomite")]
    pub(crate) sodomite: Option<i64>,

    pub(crate) tramp: Option<i64>,

    pub(crate) undueness: Option<i64>,

    pub(crate) worthily: Option<i64>,

    #[serde(rename = "Yankeeist")]
    pub(crate) yankeeist: Option<i64>,
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
    pub(crate) alfiona: Option<serde_json::Value>,

    pub(crate) ascaridiasis: Option<serde_json::Value>,

    pub(crate) bungey: Option<serde_json::Value>,

    pub(crate) catharticalness: Option<f64>,

    pub(crate) ceroxyle: Option<serde_json::Value>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) chorology: Option<serde_json::Value>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) enmarble: Option<serde_json::Value>,

    #[serde(rename = "Epeira")]
    pub(crate) epeira: Option<serde_json::Value>,

    #[serde(rename = "Eurylaimi")]
    pub(crate) eurylaimi: Option<serde_json::Value>,

    pub(crate) germination: Option<serde_json::Value>,

    pub(crate) hallelujah: Option<serde_json::Value>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) lev: Option<serde_json::Value>,

    pub(crate) mouthing: Option<serde_json::Value>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) philliloo: Option<serde_json::Value>,

    pub(crate) planetal: Option<serde_json::Value>,

    pub(crate) poney: Option<serde_json::Value>,

    pub(crate) punctualist: Option<serde_json::Value>,

    pub(crate) returnlessly: Option<serde_json::Value>,

    pub(crate) skelder: Option<serde_json::Value>,

    pub(crate) windwaywardly: Option<serde_json::Value>,

    #[serde(rename = "Yuman")]
    pub(crate) yuman: Option<serde_json::Value>,
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
    pub(crate) acerin: Option<i64>,

    #[serde(rename = "Bobadil")]
    pub(crate) bobadil: Option<i64>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) chlorophylligenous: Option<i64>,

    pub(crate) conversational: Option<i64>,

    pub(crate) demiowl: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) ectorhinal: Option<i64>,

    pub(crate) gamblesomeness: Option<i64>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) irrorate: Option<i64>,

    pub(crate) kindergartening: Option<i64>,

    pub(crate) lateritic: Option<i64>,

    pub(crate) mespil: Option<i64>,

    pub(crate) misconfiguration: Option<i64>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) planometry: Option<i64>,

    #[serde(rename = "Quiina")]
    pub(crate) quiina: Option<i64>,

    #[serde(rename = "Robert")]
    pub(crate) robert: Option<i64>,

    pub(crate) rot: Option<i64>,

    pub(crate) subcinctorium: Option<i64>,

    pub(crate) tussocker: Option<i64>,

    pub(crate) ultraproud: Option<i64>,

    pub(crate) unsuggestedness: Option<i64>,
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
    pub(crate) alain: Option<serde_json::Value>,

    #[serde(rename = "Amphirhina")]
    pub(crate) amphirhina: Option<serde_json::Value>,

    pub(crate) antimachinery: Option<serde_json::Value>,

    pub(crate) coldish: Option<serde_json::Value>,

    pub(crate) crantara: Option<serde_json::Value>,

    pub(crate) distinguishing: Option<serde_json::Value>,

    pub(crate) elytroposis: Option<serde_json::Value>,

    pub(crate) gentianwort: Option<serde_json::Value>,

    pub(crate) heliosis: Option<serde_json::Value>,

    pub(crate) instrumental: Option<serde_json::Value>,

    pub(crate) introinflection: Option<serde_json::Value>,

    pub(crate) kala: Option<serde_json::Value>,

    #[serde(rename = "Lincolnian")]
    pub(crate) lincolnian: Option<serde_json::Value>,

    pub(crate) metad: Option<serde_json::Value>,

    #[serde(rename = "Sarcophilus")]
    pub(crate) sarcophilus: Option<serde_json::Value>,

    pub(crate) swingingly: Option<serde_json::Value>,

    pub(crate) unconformity: Option<serde_json::Value>,

    pub(crate) undecreed: Option<serde_json::Value>,

    pub(crate) venerable: Option<serde_json::Value>,

    pub(crate) vowellessness: Option<serde_json::Value>,
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
    pub(crate) aeschynanthus: Option<serde_json::Value>,

    pub(crate) aquiferous: Option<serde_json::Value>,

    pub(crate) cheapener: Option<serde_json::Value>,

    pub(crate) enumeration: Option<serde_json::Value>,

    #[serde(rename = "Ephesine")]
    pub(crate) ephesine: Option<serde_json::Value>,

    pub(crate) escadrille: Option<serde_json::Value>,

    pub(crate) estrous: Option<serde_json::Value>,

    pub(crate) interestedly: Option<serde_json::Value>,

    pub(crate) katakinetomer: Option<serde_json::Value>,

    pub(crate) mortification: Option<serde_json::Value>,

    pub(crate) morula: Option<serde_json::Value>,

    pub(crate) orthosymmetrical: Option<serde_json::Value>,

    pub(crate) overbark: Option<serde_json::Value>,

    pub(crate) politist: Option<serde_json::Value>,

    pub(crate) qualified: Option<serde_json::Value>,

    pub(crate) sphenomalar: Option<serde_json::Value>,

    pub(crate) throatful: Option<serde_json::Value>,

    pub(crate) transhumance: Option<serde_json::Value>,

    pub(crate) triandrian: Option<serde_json::Value>,

    pub(crate) unbooked: Option<serde_json::Value>,
}
