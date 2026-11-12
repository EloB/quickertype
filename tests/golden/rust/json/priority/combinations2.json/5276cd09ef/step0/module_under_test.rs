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
    #[serde(rename = "Abranchiata")]
    pub(crate) abranchiata: Vec<Option<Abranchiata>>,

    pub(crate) academe: Vec<Academe>,

    pub(crate) acquirable: Vec<Acquirable>,

    pub(crate) aerometry: Vec<Aerometry>,

    pub(crate) alexin: Vec<Alexin>,

    pub(crate) alleviate: Vec<AlleviateElement>,

    pub(crate) amaas: Vec<Amaa>,

    pub(crate) ambassage: Vec<Ambassage>,

    pub(crate) amphithyron: Vec<Option<Amphithyron>>,

    #[serde(rename = "Andriana")]
    pub(crate) andriana: Vec<Option<String>>,

    pub(crate) ankee: Vec<AnkeeElement>,

    pub(crate) annihilator: Vec<Option<HashMap<String, Option<i64>>>>,

    pub(crate) annulose: Option<serde_json::Value>,

    #[serde(rename = "Ansarie")]
    pub(crate) ansarie: Vec<Option<AnsarieElement>>,

    pub(crate) aphasia: Vec<Aphasia>,

    pub(crate) asprawl: Vec<Asprawl>,

    pub(crate) attractive: Vec<Option<bool>>,

    pub(crate) barksome: HashMap<String, i64>,

    pub(crate) bedesman: Vec<Bedesman>,

    pub(crate) belard: Vec<Belard>,

    pub(crate) bocking: Vec<Bocking>,

    pub(crate) brawlingly: Vec<Brawlingly>,

    pub(crate) brookie: Vec<Brookie>,

    pub(crate) bumboatman: Vec<Option<Bumboatman>>,

    pub(crate) bystreet: Vec<Option<serde_json::Value>>,

    pub(crate) calaverite: Vec<Calaverite>,

    pub(crate) catallactic: Vec<Catallactic>,

    pub(crate) cemental: Vec<Cemental>,

    #[serde(rename = "Chytridiaceae")]
    pub(crate) chytridiaceae: Vec<Option<ChytridiaceaeElement>>,

    #[serde(rename = "Discordia")]
    pub(crate) discordia: Vec<DiscordiaElement>,

    #[serde(rename = "Endomyces")]
    pub(crate) endomyces: Vec<Endomyce>,

    #[serde(rename = "Epinephelidae")]
    pub(crate) epinephelidae: Vec<Epinephelidae>,

    #[serde(rename = "Eupatorium")]
    pub(crate) eupatorium: Vec<Eupatorium>,

    #[serde(rename = "Gryphosaurus")]
    pub(crate) gryphosaurus: Vec<GryphosaurusElement>,

    #[serde(rename = "Koryak")]
    pub(crate) koryak: Vec<Koryak>,

    #[serde(rename = "Lavinia")]
    pub(crate) lavinia: Vec<LaviniaElement>,

    #[serde(rename = "Oskar")]
    pub(crate) oskar: Vec<OskarElement>,

    #[serde(rename = "Rebecca")]
    pub(crate) rebecca: Vec<RebeccaElement>,

    #[serde(rename = "Rhomboganoidei")]
    pub(crate) rhomboganoidei: Vec<Rhomboganoidei>,

    #[serde(rename = "Rigsmal")]
    pub(crate) rigsmal: bool,

    #[serde(rename = "Ruellia")]
    pub(crate) ruellia: Vec<Ruellia>,

    #[serde(rename = "School")]
    pub(crate) school: Vec<Option<School>>,

    #[serde(rename = "Shakespearolater")]
    pub(crate) shakespearolater: Vec<Shakespearolater>,

    #[serde(rename = "Svan")]
    pub(crate) svan: Vec<f64>,

    #[serde(rename = "Wayao")]
    pub(crate) wayao: HashMap<String, f64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Abranchiata {
    Integer(i64),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Academe {
    Integer(i64),

    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Acquirable {
    IntegerMap(HashMap<String, i64>),

    UnionArray(Vec<Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Aerometry {
    Bool(bool),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Alexin {
    Bool(bool),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum AlleviateElement {
    AlleviateClass(AlleviateClass),

    UnionArray(Vec<Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AlleviateClass {
    pub(crate) apriori: Option<serde_json::Value>,

    pub(crate) beggarer: Option<serde_json::Value>,

    pub(crate) brokenheartedly: Option<serde_json::Value>,

    pub(crate) debilitation: Option<serde_json::Value>,

    pub(crate) frike: Option<serde_json::Value>,

    pub(crate) gastrolith: Option<serde_json::Value>,

    #[serde(rename = "Hulsean")]
    pub(crate) hulsean: Option<serde_json::Value>,

    pub(crate) orthocentric: Option<serde_json::Value>,

    pub(crate) petaly: Option<serde_json::Value>,

    pub(crate) probudgeting: Option<serde_json::Value>,

    pub(crate) reacquire: Option<serde_json::Value>,

    pub(crate) scow: Option<serde_json::Value>,

    pub(crate) shutoff: Option<serde_json::Value>,

    pub(crate) subcontiguous: Option<serde_json::Value>,

    pub(crate) suffumigate: Option<serde_json::Value>,

    pub(crate) transformable: Option<serde_json::Value>,

    pub(crate) uncoroneted: Option<serde_json::Value>,

    pub(crate) unparking: Option<serde_json::Value>,

    pub(crate) unvarnishedness: Option<serde_json::Value>,

    pub(crate) wherewithal: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Amaa {
    Bool(bool),

    Integer(i64),

    Rebecca(Rebecca),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Rebecca {
    pub(crate) catharticalness: f64,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: i64,

    pub(crate) disdiapason: String,

    pub(crate) homocerc: bool,

    pub(crate) nonbookish: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Ambassage {
    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Amphithyron {
    pub(crate) akroasis: Option<i64>,

    pub(crate) antiphonical: Option<i64>,

    pub(crate) basebred: Option<i64>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) conductometric: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) ensilation: Option<i64>,

    pub(crate) eyebolt: Option<i64>,

    pub(crate) fistulated: Option<i64>,

    pub(crate) heteropod: Option<i64>,

    pub(crate) homocerc: Option<bool>,

    #[serde(rename = "Juniperus")]
    pub(crate) juniperus: Option<i64>,

    pub(crate) labyrinthically: Option<i64>,

    pub(crate) martyrization: Option<i64>,

    pub(crate) mispolicy: Option<i64>,

    pub(crate) multipara: Option<i64>,

    #[serde(rename = "Nazirite")]
    pub(crate) nazirite: Option<i64>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) possessorial: Option<i64>,

    pub(crate) shamed: Option<i64>,

    pub(crate) shelfworn: Option<i64>,

    pub(crate) stagnum: Option<i64>,

    #[serde(rename = "Those")]
    pub(crate) those: Option<i64>,

    pub(crate) undecimal: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum AnkeeElement {
    AnkeeClass(AnkeeClass),

    Integer(i64),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AnkeeClass {
    #[serde(rename = "Anomoean")]
    pub(crate) anomoean: Option<serde_json::Value>,

    pub(crate) barleyhood: Option<serde_json::Value>,

    pub(crate) befriender: Option<serde_json::Value>,

    pub(crate) brutishness: Option<serde_json::Value>,

    pub(crate) cephalalgy: Option<serde_json::Value>,

    pub(crate) cirurgian: Option<serde_json::Value>,

    pub(crate) conventionally: Option<serde_json::Value>,

    pub(crate) jackshay: Option<serde_json::Value>,

    pub(crate) milammeter: Option<serde_json::Value>,

    #[serde(rename = "Naja")]
    pub(crate) naja: Option<serde_json::Value>,

    pub(crate) ombrological: Option<serde_json::Value>,

    pub(crate) phonasthenia: Option<serde_json::Value>,

    pub(crate) retrievableness: Option<serde_json::Value>,

    pub(crate) snakily: Option<serde_json::Value>,

    pub(crate) swot: Option<serde_json::Value>,

    pub(crate) tartlet: Option<serde_json::Value>,

    pub(crate) thiofuran: Option<serde_json::Value>,

    pub(crate) tracheophone: Option<serde_json::Value>,

    pub(crate) tuglike: Option<serde_json::Value>,

    pub(crate) unscratchingly: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum AnsarieElement {
    AnsarieClass(AnsarieClass),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AnsarieClass {
    pub(crate) accension: Option<serde_json::Value>,

    #[serde(rename = "Alida")]
    pub(crate) alida: Option<serde_json::Value>,

    pub(crate) asteria: Option<serde_json::Value>,

    pub(crate) beriberic: Option<serde_json::Value>,

    pub(crate) edgebone: Option<serde_json::Value>,

    pub(crate) gastrodialysis: Option<serde_json::Value>,

    pub(crate) geographic: Option<serde_json::Value>,

    #[serde(rename = "Ictonyx")]
    pub(crate) ictonyx: Option<serde_json::Value>,

    pub(crate) metrocele: Option<serde_json::Value>,

    pub(crate) misgraft: Option<serde_json::Value>,

    pub(crate) monteith: Option<serde_json::Value>,

    pub(crate) notcher: Option<serde_json::Value>,

    pub(crate) prorestriction: Option<serde_json::Value>,

    #[serde(rename = "Ramist")]
    pub(crate) ramist: Option<serde_json::Value>,

    pub(crate) throatlet: Option<serde_json::Value>,

    pub(crate) unfair: Option<serde_json::Value>,

    pub(crate) unsynonymous: Option<serde_json::Value>,

    pub(crate) water: Option<serde_json::Value>,

    pub(crate) zestfully: Option<serde_json::Value>,

    pub(crate) zincic: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Aphasia {
    Integer(i64),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Asprawl {
    Double(f64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Bedesman {
    Bool(bool),

    Double(f64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Belard {
    Double(f64),

    IntegerArray(Vec<i64>),

    Rebecca(Rebecca),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Bocking {
    Bool(bool),

    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Brawlingly {
    NullArray(Vec<Option<serde_json::Value>>),

    UnionMap(HashMap<String, Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Brookie {
    IntegerArray(Vec<i64>),

    Rebecca(Rebecca),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Bumboatman {
    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Calaverite {
    IntegerArray(Vec<i64>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Catallactic {
    Bool(bool),

    IntegerMap(HashMap<String, i64>),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Cemental {
    Double(f64),

    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ChytridiaceaeElement {
    Bool(bool),

    ChytridiaceaeClass(ChytridiaceaeClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ChytridiaceaeClass {
    #[serde(rename = "Batidaceae")]
    pub(crate) batidaceae: Option<serde_json::Value>,

    #[serde(rename = "Brechites")]
    pub(crate) brechites: Option<serde_json::Value>,

    pub(crate) codespairer: Option<serde_json::Value>,

    #[serde(rename = "Emery")]
    pub(crate) emery: Option<serde_json::Value>,

    pub(crate) enervative: Option<serde_json::Value>,

    pub(crate) excriminate: Option<serde_json::Value>,

    pub(crate) goshenite: Option<serde_json::Value>,

    pub(crate) grime: Option<serde_json::Value>,

    pub(crate) gritten: Option<serde_json::Value>,

    pub(crate) hectorly: Option<serde_json::Value>,

    pub(crate) intermediation: Option<serde_json::Value>,

    pub(crate) meeterly: Option<serde_json::Value>,

    #[serde(rename = "Narraganset")]
    pub(crate) narraganset: Option<serde_json::Value>,

    pub(crate) onymatic: Option<serde_json::Value>,

    pub(crate) paddlecock: Option<serde_json::Value>,

    pub(crate) thana: Option<serde_json::Value>,

    pub(crate) thornily: Option<serde_json::Value>,

    pub(crate) uckia: Option<serde_json::Value>,

    pub(crate) unmettle: Option<serde_json::Value>,

    pub(crate) vorticellid: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum DiscordiaElement {
    DiscordiaClass(DiscordiaClass),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DiscordiaClass {
    #[serde(rename = "Altaic")]
    pub(crate) altaic: Option<i64>,

    pub(crate) amoristic: Option<i64>,

    pub(crate) blennophthalmia: Option<i64>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) disciplinability: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) goofer: Option<i64>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) laryngograph: Option<i64>,

    pub(crate) leucitis: Option<i64>,

    pub(crate) lymphocyst: Option<i64>,

    pub(crate) microcosmology: Option<i64>,

    pub(crate) nauseation: Option<i64>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    #[serde(rename = "Patarin")]
    pub(crate) patarin: Option<i64>,

    pub(crate) preliberal: Option<i64>,

    pub(crate) prettifier: Option<i64>,

    pub(crate) rangework: Option<i64>,

    pub(crate) redient: Option<i64>,

    pub(crate) subfusiform: Option<i64>,

    pub(crate) suicidical: Option<i64>,

    pub(crate) swow: Option<i64>,

    pub(crate) wastrel: Option<i64>,

    pub(crate) wingle: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Endomyce {
    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Epinephelidae {
    Bool(bool),

    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Eupatorium {
    IntegerMap(HashMap<String, i64>),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum GryphosaurusElement {
    GryphosaurusClass(GryphosaurusClass),

    IntegerArray(Vec<i64>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GryphosaurusClass {
    pub(crate) amissibility: Option<serde_json::Value>,

    #[serde(rename = "Burushaski")]
    pub(crate) burushaski: Option<serde_json::Value>,

    pub(crate) citronin: Option<serde_json::Value>,

    pub(crate) coplaintiff: Option<serde_json::Value>,

    pub(crate) disquisitionary: Option<serde_json::Value>,

    pub(crate) enoplan: Option<serde_json::Value>,

    pub(crate) faintness: Option<serde_json::Value>,

    pub(crate) hebetomy: Option<serde_json::Value>,

    pub(crate) islandry: Option<serde_json::Value>,

    pub(crate) lameduck: Option<serde_json::Value>,

    pub(crate) overbattle: Option<serde_json::Value>,

    pub(crate) overinterested: Option<serde_json::Value>,

    pub(crate) phrenologic: Option<serde_json::Value>,

    pub(crate) rainband: Option<serde_json::Value>,

    pub(crate) shiningly: Option<serde_json::Value>,

    pub(crate) stamineous: Option<serde_json::Value>,

    pub(crate) subscapularis: Option<serde_json::Value>,

    #[serde(rename = "Tahami")]
    pub(crate) tahami: Option<serde_json::Value>,

    pub(crate) undaubed: Option<serde_json::Value>,

    pub(crate) underntime: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Koryak {
    PurpleString(String),

    UnionMap(HashMap<String, Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum LaviniaElement {
    LaviniaClass(LaviniaClass),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LaviniaClass {
    pub(crate) agitable: Option<i64>,

    pub(crate) asininity: Option<i64>,

    pub(crate) benefiter: Option<i64>,

    pub(crate) bronzelike: Option<i64>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) cholesteatomatous: Option<i64>,

    pub(crate) deprivement: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) flippantness: Option<i64>,

    pub(crate) fogproof: Option<i64>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) merrymeeting: Option<i64>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) overcareful: Option<i64>,

    pub(crate) panaris: Option<i64>,

    pub(crate) preacceptance: Option<i64>,

    pub(crate) quinoxaline: Option<i64>,

    pub(crate) sig: Option<i64>,

    pub(crate) superconfusion: Option<i64>,

    #[serde(rename = "Tacana")]
    pub(crate) tacana: Option<i64>,

    pub(crate) tillotter: Option<i64>,

    pub(crate) tranquillize: Option<i64>,

    pub(crate) unquestionable: Option<i64>,

    pub(crate) uproute: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum OskarElement {
    IntegerArray(Vec<i64>),

    OskarClass(OskarClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OskarClass {
    #[serde(rename = "Acrobates")]
    pub(crate) acrobates: Option<serde_json::Value>,

    pub(crate) beanshooter: Option<serde_json::Value>,

    pub(crate) bearhound: Option<serde_json::Value>,

    #[serde(rename = "Cayuga")]
    pub(crate) cayuga: Option<serde_json::Value>,

    pub(crate) guarneri: Option<serde_json::Value>,

    pub(crate) hypochondriacism: Option<serde_json::Value>,

    pub(crate) indication: Option<serde_json::Value>,

    pub(crate) jaculative: Option<serde_json::Value>,

    pub(crate) nagana: Option<serde_json::Value>,

    #[serde(rename = "Netherlandish")]
    pub(crate) netherlandish: Option<serde_json::Value>,

    pub(crate) noctivagous: Option<serde_json::Value>,

    pub(crate) nonphysiological: Option<serde_json::Value>,

    pub(crate) praxis: Option<serde_json::Value>,

    pub(crate) provision: Option<serde_json::Value>,

    pub(crate) subterhuman: Option<serde_json::Value>,

    pub(crate) sunlit: Option<serde_json::Value>,

    pub(crate) syncraniate: Option<serde_json::Value>,

    pub(crate) teachment: Option<serde_json::Value>,

    pub(crate) unmutinous: Option<serde_json::Value>,

    pub(crate) unstoppable: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum RebeccaElement {
    Integer(i64),

    PurpleString(String),

    Rebecca(Rebecca),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Rhomboganoidei {
    IntegerArray(Vec<i64>),

    PurpleString(String),

    Rebecca(Rebecca),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Ruellia {
    Bool(bool),

    PurpleString(String),

    Rebecca(Rebecca),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum School {
    Integer(i64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Shakespearolater {
    Double(f64),

    IntegerArray(Vec<i64>),

    PurpleString(String),
}
