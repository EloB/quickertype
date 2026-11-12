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
    pub abranchiata: Vec<Option<Abranchiata>>,
    pub academe: Vec<Academe>,
    pub acquirable: Vec<Acquirable>,
    pub aerometry: Vec<Aerometry>,
    pub alexin: Vec<Alexin>,
    pub alleviate: Vec<AlleviateElement>,
    pub amaas: Vec<Amaa>,
    pub ambassage: Vec<Ambassage>,
    pub amphithyron: Vec<Option<Amphithyron>>,
    #[serde(rename = "Andriana")]
    pub andriana: Vec<Option<String>>,
    pub ankee: Vec<AnkeeElement>,
    pub annihilator: Vec<Option<HashMap<String, Option<i64>>>>,
    pub annulose: Option<serde_json::Value>,
    #[serde(rename = "Ansarie")]
    pub ansarie: Vec<Option<AnsarieElement>>,
    pub aphasia: Vec<Aphasia>,
    pub asprawl: Vec<Asprawl>,
    pub attractive: Vec<Option<bool>>,
    pub barksome: HashMap<String, i64>,
    pub bedesman: Vec<Bedesman>,
    pub belard: Vec<Belard>,
    pub bocking: Vec<Bocking>,
    pub brawlingly: Vec<Brawlingly>,
    pub brookie: Vec<Brookie>,
    pub bumboatman: Vec<Option<Bumboatman>>,
    pub bystreet: Vec<Option<serde_json::Value>>,
    pub calaverite: Vec<Calaverite>,
    pub catallactic: Vec<Catallactic>,
    pub cemental: Vec<Cemental>,
    #[serde(rename = "Chytridiaceae")]
    pub chytridiaceae: Vec<Option<ChytridiaceaeElement>>,
    #[serde(rename = "Discordia")]
    pub discordia: Vec<DiscordiaElement>,
    #[serde(rename = "Endomyces")]
    pub endomyces: Vec<Endomyce>,
    #[serde(rename = "Epinephelidae")]
    pub epinephelidae: Vec<Epinephelidae>,
    #[serde(rename = "Eupatorium")]
    pub eupatorium: Vec<Eupatorium>,
    #[serde(rename = "Gryphosaurus")]
    pub gryphosaurus: Vec<GryphosaurusElement>,
    #[serde(rename = "Koryak")]
    pub koryak: Vec<Koryak>,
    #[serde(rename = "Lavinia")]
    pub lavinia: Vec<LaviniaElement>,
    #[serde(rename = "Oskar")]
    pub oskar: Vec<OskarElement>,
    #[serde(rename = "Rebecca")]
    pub rebecca: Vec<RebeccaElement>,
    #[serde(rename = "Rhomboganoidei")]
    pub rhomboganoidei: Vec<Rhomboganoidei>,
    #[serde(rename = "Rigsmal")]
    pub rigsmal: bool,
    #[serde(rename = "Ruellia")]
    pub ruellia: Vec<Ruellia>,
    #[serde(rename = "School")]
    pub school: Vec<Option<School>>,
    #[serde(rename = "Shakespearolater")]
    pub shakespearolater: Vec<Shakespearolater>,
    #[serde(rename = "Svan")]
    pub svan: Vec<f64>,
    #[serde(rename = "Wayao")]
    pub wayao: HashMap<String, f64>,
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
    pub apriori: Option<serde_json::Value>,
    pub beggarer: Option<serde_json::Value>,
    pub brokenheartedly: Option<serde_json::Value>,
    pub debilitation: Option<serde_json::Value>,
    pub frike: Option<serde_json::Value>,
    pub gastrolith: Option<serde_json::Value>,
    #[serde(rename = "Hulsean")]
    pub hulsean: Option<serde_json::Value>,
    pub orthocentric: Option<serde_json::Value>,
    pub petaly: Option<serde_json::Value>,
    pub probudgeting: Option<serde_json::Value>,
    pub reacquire: Option<serde_json::Value>,
    pub scow: Option<serde_json::Value>,
    pub shutoff: Option<serde_json::Value>,
    pub subcontiguous: Option<serde_json::Value>,
    pub suffumigate: Option<serde_json::Value>,
    pub transformable: Option<serde_json::Value>,
    pub uncoroneted: Option<serde_json::Value>,
    pub unparking: Option<serde_json::Value>,
    pub unvarnishedness: Option<serde_json::Value>,
    pub wherewithal: Option<serde_json::Value>,
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
    pub catharticalness: f64,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: i64,
    pub disdiapason: String,
    pub homocerc: bool,
    pub nonbookish: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Ambassage {
    NullArray(Vec<Option<serde_json::Value>>),
    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Amphithyron {
    pub akroasis: Option<i64>,
    pub antiphonical: Option<i64>,
    pub basebred: Option<i64>,
    pub catharticalness: Option<f64>,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,
    pub conductometric: Option<i64>,
    pub disdiapason: Option<String>,
    pub ensilation: Option<i64>,
    pub eyebolt: Option<i64>,
    pub fistulated: Option<i64>,
    pub heteropod: Option<i64>,
    pub homocerc: Option<bool>,
    #[serde(rename = "Juniperus")]
    pub juniperus: Option<i64>,
    pub labyrinthically: Option<i64>,
    pub martyrization: Option<i64>,
    pub mispolicy: Option<i64>,
    pub multipara: Option<i64>,
    #[serde(rename = "Nazirite")]
    pub nazirite: Option<i64>,
    pub nonbookish: Option<serde_json::Value>,
    pub possessorial: Option<i64>,
    pub shamed: Option<i64>,
    pub shelfworn: Option<i64>,
    pub stagnum: Option<i64>,
    #[serde(rename = "Those")]
    pub those: Option<i64>,
    pub undecimal: Option<i64>,
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
    pub anomoean: Option<serde_json::Value>,
    pub barleyhood: Option<serde_json::Value>,
    pub befriender: Option<serde_json::Value>,
    pub brutishness: Option<serde_json::Value>,
    pub cephalalgy: Option<serde_json::Value>,
    pub cirurgian: Option<serde_json::Value>,
    pub conventionally: Option<serde_json::Value>,
    pub jackshay: Option<serde_json::Value>,
    pub milammeter: Option<serde_json::Value>,
    #[serde(rename = "Naja")]
    pub naja: Option<serde_json::Value>,
    pub ombrological: Option<serde_json::Value>,
    pub phonasthenia: Option<serde_json::Value>,
    pub retrievableness: Option<serde_json::Value>,
    pub snakily: Option<serde_json::Value>,
    pub swot: Option<serde_json::Value>,
    pub tartlet: Option<serde_json::Value>,
    pub thiofuran: Option<serde_json::Value>,
    pub tracheophone: Option<serde_json::Value>,
    pub tuglike: Option<serde_json::Value>,
    pub unscratchingly: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum AnsarieElement {
    AnsarieClass(AnsarieClass),
    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AnsarieClass {
    pub accension: Option<serde_json::Value>,
    #[serde(rename = "Alida")]
    pub alida: Option<serde_json::Value>,
    pub asteria: Option<serde_json::Value>,
    pub beriberic: Option<serde_json::Value>,
    pub edgebone: Option<serde_json::Value>,
    pub gastrodialysis: Option<serde_json::Value>,
    pub geographic: Option<serde_json::Value>,
    #[serde(rename = "Ictonyx")]
    pub ictonyx: Option<serde_json::Value>,
    pub metrocele: Option<serde_json::Value>,
    pub misgraft: Option<serde_json::Value>,
    pub monteith: Option<serde_json::Value>,
    pub notcher: Option<serde_json::Value>,
    pub prorestriction: Option<serde_json::Value>,
    #[serde(rename = "Ramist")]
    pub ramist: Option<serde_json::Value>,
    pub throatlet: Option<serde_json::Value>,
    pub unfair: Option<serde_json::Value>,
    pub unsynonymous: Option<serde_json::Value>,
    pub water: Option<serde_json::Value>,
    pub zestfully: Option<serde_json::Value>,
    pub zincic: Option<serde_json::Value>,
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
    pub batidaceae: Option<serde_json::Value>,
    #[serde(rename = "Brechites")]
    pub brechites: Option<serde_json::Value>,
    pub codespairer: Option<serde_json::Value>,
    #[serde(rename = "Emery")]
    pub emery: Option<serde_json::Value>,
    pub enervative: Option<serde_json::Value>,
    pub excriminate: Option<serde_json::Value>,
    pub goshenite: Option<serde_json::Value>,
    pub grime: Option<serde_json::Value>,
    pub gritten: Option<serde_json::Value>,
    pub hectorly: Option<serde_json::Value>,
    pub intermediation: Option<serde_json::Value>,
    pub meeterly: Option<serde_json::Value>,
    #[serde(rename = "Narraganset")]
    pub narraganset: Option<serde_json::Value>,
    pub onymatic: Option<serde_json::Value>,
    pub paddlecock: Option<serde_json::Value>,
    pub thana: Option<serde_json::Value>,
    pub thornily: Option<serde_json::Value>,
    pub uckia: Option<serde_json::Value>,
    pub unmettle: Option<serde_json::Value>,
    pub vorticellid: Option<serde_json::Value>,
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
    pub altaic: Option<i64>,
    pub amoristic: Option<i64>,
    pub blennophthalmia: Option<i64>,
    pub catharticalness: Option<f64>,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,
    pub disciplinability: Option<i64>,
    pub disdiapason: Option<String>,
    pub goofer: Option<i64>,
    pub homocerc: Option<bool>,
    pub laryngograph: Option<i64>,
    pub leucitis: Option<i64>,
    pub lymphocyst: Option<i64>,
    pub microcosmology: Option<i64>,
    pub nauseation: Option<i64>,
    pub nonbookish: Option<serde_json::Value>,
    #[serde(rename = "Patarin")]
    pub patarin: Option<i64>,
    pub preliberal: Option<i64>,
    pub prettifier: Option<i64>,
    pub rangework: Option<i64>,
    pub redient: Option<i64>,
    pub subfusiform: Option<i64>,
    pub suicidical: Option<i64>,
    pub swow: Option<i64>,
    pub wastrel: Option<i64>,
    pub wingle: Option<i64>,
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
    pub amissibility: Option<serde_json::Value>,
    #[serde(rename = "Burushaski")]
    pub burushaski: Option<serde_json::Value>,
    pub citronin: Option<serde_json::Value>,
    pub coplaintiff: Option<serde_json::Value>,
    pub disquisitionary: Option<serde_json::Value>,
    pub enoplan: Option<serde_json::Value>,
    pub faintness: Option<serde_json::Value>,
    pub hebetomy: Option<serde_json::Value>,
    pub islandry: Option<serde_json::Value>,
    pub lameduck: Option<serde_json::Value>,
    pub overbattle: Option<serde_json::Value>,
    pub overinterested: Option<serde_json::Value>,
    pub phrenologic: Option<serde_json::Value>,
    pub rainband: Option<serde_json::Value>,
    pub shiningly: Option<serde_json::Value>,
    pub stamineous: Option<serde_json::Value>,
    pub subscapularis: Option<serde_json::Value>,
    #[serde(rename = "Tahami")]
    pub tahami: Option<serde_json::Value>,
    pub undaubed: Option<serde_json::Value>,
    pub underntime: Option<serde_json::Value>,
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
    pub agitable: Option<i64>,
    pub asininity: Option<i64>,
    pub benefiter: Option<i64>,
    pub bronzelike: Option<i64>,
    pub catharticalness: Option<f64>,
    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,
    pub cholesteatomatous: Option<i64>,
    pub deprivement: Option<i64>,
    pub disdiapason: Option<String>,
    pub flippantness: Option<i64>,
    pub fogproof: Option<i64>,
    pub homocerc: Option<bool>,
    pub merrymeeting: Option<i64>,
    pub nonbookish: Option<serde_json::Value>,
    pub overcareful: Option<i64>,
    pub panaris: Option<i64>,
    pub preacceptance: Option<i64>,
    pub quinoxaline: Option<i64>,
    pub sig: Option<i64>,
    pub superconfusion: Option<i64>,
    #[serde(rename = "Tacana")]
    pub tacana: Option<i64>,
    pub tillotter: Option<i64>,
    pub tranquillize: Option<i64>,
    pub unquestionable: Option<i64>,
    pub uproute: Option<i64>,
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
    pub acrobates: Option<serde_json::Value>,
    pub beanshooter: Option<serde_json::Value>,
    pub bearhound: Option<serde_json::Value>,
    #[serde(rename = "Cayuga")]
    pub cayuga: Option<serde_json::Value>,
    pub guarneri: Option<serde_json::Value>,
    pub hypochondriacism: Option<serde_json::Value>,
    pub indication: Option<serde_json::Value>,
    pub jaculative: Option<serde_json::Value>,
    pub nagana: Option<serde_json::Value>,
    #[serde(rename = "Netherlandish")]
    pub netherlandish: Option<serde_json::Value>,
    pub noctivagous: Option<serde_json::Value>,
    pub nonphysiological: Option<serde_json::Value>,
    pub praxis: Option<serde_json::Value>,
    pub provision: Option<serde_json::Value>,
    pub subterhuman: Option<serde_json::Value>,
    pub sunlit: Option<serde_json::Value>,
    pub syncraniate: Option<serde_json::Value>,
    pub teachment: Option<serde_json::Value>,
    pub unmutinous: Option<serde_json::Value>,
    pub unstoppable: Option<serde_json::Value>,
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
