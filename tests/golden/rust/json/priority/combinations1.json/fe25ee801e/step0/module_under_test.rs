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
    pub centrodesmose: String,

    pub cerograph: Vec<Option<CerographElement>>,

    pub chemotherapeutics: Vec<ChemotherapeuticElement>,

    pub cimelia: Vec<Option<CimeliaElement>>,

    pub citrated: i64,

    pub clinodome: Vec<Clinodome>,

    pub coadjust: Vec<CoadjustElement>,

    pub consilience: Vec<Consilience>,

    pub constructor: Vec<Constructor>,

    pub continuative: Vec<Continuative>,

    pub credulity: Vec<CredulityElement>,

    pub creviced: Vec<Creviced>,

    pub cubiculum: Vec<Vec<Option<i64>>>,

    pub deruralize: Vec<DeruralizeElement>,

    pub diaereses: Vec<DiaereseElement>,

    pub dissolution: Vec<Option<Vec<Option<serde_json::Value>>>>,

    pub downstroke: Vec<Downstroke>,

    pub electrotautomerism: Vec<Option<f64>>,

    pub eleutheromania: Vec<Eleutheromania>,

    pub encrust: Encrust,

    pub entomoid: Vec<Entomoid>,

    pub epipaleolithic: Vec<Epipaleolithic>,

    pub expropriable: Vec<Expropriable>,

    pub faggingly: Vec<FagginglyElement>,

    pub fenks: Vec<FenkElement>,

    pub flagmaking: Vec<FlagmakingElement>,

    pub fluorometer: Vec<Option<Fluorometer>>,

    pub fulsome: Vec<Option<i64>>,

    pub fuzzy: Vec<Fuzzy>,

    pub gardenwards: Vec<Gardenward>,

    pub generalissimo: Vec<Option<Generalissimo>>,

    pub habeas: Vec<Option<HashMap<String, i64>>>,

    pub hemicrystalline: Vec<Hemicrystalline>,

    pub hemocoele: Vec<HemocoeleElement>,

    pub hoister: Vec<Option<Hoister>>,

    pub hyperpiesis: Vec<Option<Hyperpiesi>>,

    pub hyppish: Vec<Option<Hyppish>>,

    pub idealizer: Vec<Idealizer>,

    pub incrustator: Vec<Incrustator>,

    pub intentiveness: Vec<Intentiveness>,

    pub interacinar: Interacinar,

    pub intercorrelation: Vec<Option<Vec<i64>>>,

    pub jacutinga: Vec<Jacutinga>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum CerographElement {
    CerographClass(CerographClass),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CerographClass {
    pub apotropaion: Option<serde_json::Value>,

    pub casuary: Option<serde_json::Value>,

    pub creaker: Option<serde_json::Value>,

    pub disqualification: Option<serde_json::Value>,

    pub imperatorious: Option<serde_json::Value>,

    pub impermeabilize: Option<serde_json::Value>,

    pub metastoma: Option<serde_json::Value>,

    pub noctidiurnal: Option<serde_json::Value>,

    pub nonreserve: Option<serde_json::Value>,

    pub ophthalmotonometry: Option<serde_json::Value>,

    pub pailful: Option<serde_json::Value>,

    pub pigfish: Option<serde_json::Value>,

    pub pongee: Option<serde_json::Value>,

    pub prosodical: Option<serde_json::Value>,

    pub scrofuloderm: Option<serde_json::Value>,

    pub storekeeping: Option<serde_json::Value>,

    pub therologist: Option<serde_json::Value>,

    #[serde(rename = "Tolowa")]
    pub tolowa: Option<serde_json::Value>,

    pub tradeful: Option<serde_json::Value>,

    pub unriveting: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ChemotherapeuticElement {
    ChemotherapeuticClass(ChemotherapeuticClass),

    Integer(i64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ChemotherapeuticClass {
    pub angioneurotic: Option<serde_json::Value>,

    pub availment: Option<serde_json::Value>,

    pub bladelet: Option<serde_json::Value>,

    pub catharticalness: Option<f64>,

    pub caulis: Option<serde_json::Value>,

    pub chalcus: Option<serde_json::Value>,

    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,

    pub disdiapason: Option<String>,

    pub enteradenological: Option<serde_json::Value>,

    pub homocerc: Option<bool>,

    pub imporosity: Option<serde_json::Value>,

    pub insistently: Option<serde_json::Value>,

    pub intraparietal: Option<serde_json::Value>,

    pub ivied: Option<serde_json::Value>,

    #[serde(rename = "Maureen")]
    pub maureen: Option<serde_json::Value>,

    pub nonbookish: Option<serde_json::Value>,

    pub nostochine: Option<serde_json::Value>,

    pub nutcracker: Option<serde_json::Value>,

    pub ofttimes: Option<serde_json::Value>,

    pub phenocryst: Option<serde_json::Value>,

    pub precoincident: Option<serde_json::Value>,

    pub ramiferous: Option<serde_json::Value>,

    pub stagmometer: Option<serde_json::Value>,

    pub tetherball: Option<serde_json::Value>,

    pub unshy: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum CimeliaElement {
    CimeliaClass(CimeliaClass),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CimeliaClass {
    pub catharticalness: f64,

    #[serde(rename = "Chirotherium")]
    pub chirotherium: i64,

    pub disdiapason: String,

    pub homocerc: bool,

    pub nonbookish: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Clinodome {
    Double(f64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum CoadjustElement {
    CoadjustClass(CoadjustClass),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CoadjustClass {
    pub amidosulphonal: Option<serde_json::Value>,

    #[serde(rename = "Benny")]
    pub benny: Option<serde_json::Value>,

    pub catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,

    pub disdiapason: Option<String>,

    pub ensnare: Option<serde_json::Value>,

    pub homocerc: Option<bool>,

    pub hybridizer: Option<serde_json::Value>,

    pub leastwise: Option<serde_json::Value>,

    pub lof: Option<serde_json::Value>,

    pub monkhood: Option<serde_json::Value>,

    #[serde(rename = "Netherlandish")]
    pub netherlandish: Option<serde_json::Value>,

    pub nonbookish: Option<serde_json::Value>,

    pub peonism: Option<serde_json::Value>,

    #[serde(rename = "Phonelescope")]
    pub phonelescope: Option<serde_json::Value>,

    pub porphyrogeniture: Option<serde_json::Value>,

    pub preindemnify: Option<serde_json::Value>,

    pub rosal: Option<serde_json::Value>,

    pub scalenous: Option<serde_json::Value>,

    pub scopine: Option<serde_json::Value>,

    #[serde(rename = "Sedaceae")]
    pub sedaceae: Option<serde_json::Value>,

    pub suberinize: Option<serde_json::Value>,

    pub symbiot: Option<serde_json::Value>,

    pub tablefellow: Option<serde_json::Value>,

    pub unchargeable: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Consilience {
    Double(f64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Constructor {
    Bool(bool),

    UnionMap(HashMap<String, Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Continuative {
    IntegerMap(HashMap<String, i64>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum CredulityElement {
    CredulityClass(CredulityClass),

    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CredulityClass {
    pub ammonolytic: Option<serde_json::Value>,

    pub bushmaster: Option<serde_json::Value>,

    pub considering: Option<serde_json::Value>,

    pub consuetudinary: Option<serde_json::Value>,

    pub embarras: Option<serde_json::Value>,

    pub fineness: Option<serde_json::Value>,

    pub flaithship: Option<serde_json::Value>,

    #[serde(rename = "Flavia")]
    pub flavia: Option<serde_json::Value>,

    pub gruffly: Option<serde_json::Value>,

    #[serde(rename = "Hedychium")]
    pub hedychium: Option<serde_json::Value>,

    pub leadwort: Option<serde_json::Value>,

    pub overseriously: Option<serde_json::Value>,

    pub parabola: Option<serde_json::Value>,

    pub pectinatodenticulate: Option<serde_json::Value>,

    #[serde(rename = "Popean")]
    pub popean: Option<serde_json::Value>,

    pub pornocrat: Option<serde_json::Value>,

    pub quadrisect: Option<serde_json::Value>,

    pub seriality: Option<serde_json::Value>,

    pub vamphorn: Option<serde_json::Value>,

    pub wharp: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Creviced {
    Bool(bool),

    IntegerMap(HashMap<String, i64>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum DeruralizeElement {
    Bool(bool),

    DeruralizeClass(DeruralizeClass),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DeruralizeClass {
    pub bockerel: Option<serde_json::Value>,

    pub boulder: Option<serde_json::Value>,

    pub churrus: Option<serde_json::Value>,

    pub counterdigged: Option<serde_json::Value>,

    pub dialogite: Option<serde_json::Value>,

    pub digenic: Option<serde_json::Value>,

    pub dunbird: Option<serde_json::Value>,

    pub ergatogyne: Option<serde_json::Value>,

    pub fiendful: Option<serde_json::Value>,

    pub jackrod: Option<serde_json::Value>,

    #[serde(rename = "Jehovistic")]
    pub jehovistic: Option<serde_json::Value>,

    #[serde(rename = "Paninean")]
    pub paninean: Option<serde_json::Value>,

    pub panther: Option<serde_json::Value>,

    pub placentigerous: Option<serde_json::Value>,

    #[serde(rename = "Romney")]
    pub romney: Option<serde_json::Value>,

    pub sparm: Option<serde_json::Value>,

    pub tocsin: Option<serde_json::Value>,

    pub unnicked: Option<serde_json::Value>,

    pub unstavable: Option<serde_json::Value>,

    pub windfirm: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum DiaereseElement {
    Bool(bool),

    DiaereseClass(DiaereseClass),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DiaereseClass {
    #[serde(rename = "Amoreuxia")]
    pub amoreuxia: Option<serde_json::Value>,

    pub ani: Option<serde_json::Value>,

    pub bernicle: Option<serde_json::Value>,

    pub blackwasher: Option<serde_json::Value>,

    pub blowhard: Option<serde_json::Value>,

    pub broma: Option<serde_json::Value>,

    pub closecross: Option<serde_json::Value>,

    pub congregationalism: Option<serde_json::Value>,

    pub grayly: Option<serde_json::Value>,

    pub historically: Option<serde_json::Value>,

    pub hoast: Option<serde_json::Value>,

    pub irretentive: Option<serde_json::Value>,

    pub parcener: Option<serde_json::Value>,

    pub pedder: Option<serde_json::Value>,

    pub pseudoanatomic: Option<serde_json::Value>,

    pub rhizocarpian: Option<serde_json::Value>,

    pub samel: Option<serde_json::Value>,

    pub silker: Option<serde_json::Value>,

    pub subdentated: Option<serde_json::Value>,

    pub subobscure: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Downstroke {
    Bool(bool),

    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Eleutheromania {
    Double(f64),

    IntegerMap(HashMap<String, i64>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Encrust {
    pub comradely: Option<serde_json::Value>,

    pub diacanthous: Option<serde_json::Value>,

    pub feminineness: Option<serde_json::Value>,

    pub gossamered: Option<serde_json::Value>,

    #[serde(rename = "Hibernia")]
    pub hibernia: Option<serde_json::Value>,

    #[serde(rename = "Hibiscus")]
    pub hibiscus: Option<serde_json::Value>,

    #[serde(rename = "Lepidosauria")]
    pub lepidosauria: Option<serde_json::Value>,

    pub lollingly: Option<serde_json::Value>,

    pub manager: Option<serde_json::Value>,

    pub mechanic: Option<serde_json::Value>,

    pub overminuteness: Option<serde_json::Value>,

    pub papelonne: Option<serde_json::Value>,

    pub plebification: Option<serde_json::Value>,

    pub pugmiller: Option<serde_json::Value>,

    pub recoveror: Option<serde_json::Value>,

    pub spermatoblastic: Option<serde_json::Value>,

    #[serde(rename = "Syllidae")]
    pub syllidae: Option<serde_json::Value>,

    pub ungyved: Option<serde_json::Value>,

    pub whirlabout: Option<serde_json::Value>,

    pub woodenware: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Entomoid {
    CimeliaClass(CimeliaClass),

    Integer(i64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Epipaleolithic {
    Double(f64),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Expropriable {
    CimeliaClass(CimeliaClass),

    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum FagginglyElement {
    Double(f64),

    FagginglyClass(FagginglyClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FagginglyClass {
    pub abranchian: Option<serde_json::Value>,

    pub aculeiform: Option<serde_json::Value>,

    pub adiaphoristic: Option<serde_json::Value>,

    pub adoptionism: Option<serde_json::Value>,

    #[serde(rename = "Anglic")]
    pub anglic: Option<serde_json::Value>,

    pub antrotomy: Option<serde_json::Value>,

    pub coerciveness: Option<serde_json::Value>,

    pub decorist: Option<serde_json::Value>,

    pub duckhood: Option<serde_json::Value>,

    #[serde(rename = "Heteromeri")]
    pub heteromeri: Option<serde_json::Value>,

    pub hypochnose: Option<serde_json::Value>,

    pub lochage: Option<serde_json::Value>,

    pub melee: Option<serde_json::Value>,

    pub nonconformitant: Option<serde_json::Value>,

    #[serde(rename = "Poinsettia")]
    pub poinsettia: Option<serde_json::Value>,

    pub putatively: Option<serde_json::Value>,

    pub semivolatile: Option<serde_json::Value>,

    pub soleas: Option<serde_json::Value>,

    pub unfastenable: Option<serde_json::Value>,

    pub unmillinered: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum FenkElement {
    FenkClass(FenkClass),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FenkClass {
    pub apoise: Option<serde_json::Value>,

    pub astronomize: Option<serde_json::Value>,

    pub cockhorse: Option<serde_json::Value>,

    pub copular: Option<serde_json::Value>,

    #[serde(rename = "Dagomba")]
    pub dagomba: Option<serde_json::Value>,

    pub draffy: Option<serde_json::Value>,

    pub foreigner: Option<serde_json::Value>,

    #[serde(rename = "Guyandot")]
    pub guyandot: Option<serde_json::Value>,

    pub neurogliosis: Option<serde_json::Value>,

    pub osmious: Option<serde_json::Value>,

    pub palpitate: Option<serde_json::Value>,

    pub rebukeable: Option<serde_json::Value>,

    #[serde(rename = "Reinwardtia")]
    pub reinwardtia: Option<serde_json::Value>,

    pub reservatory: Option<serde_json::Value>,

    pub scalt: Option<serde_json::Value>,

    pub scripturalize: Option<serde_json::Value>,

    pub tintometer: Option<serde_json::Value>,

    #[serde(rename = "Tritoness")]
    pub tritoness: Option<serde_json::Value>,

    pub undergrade: Option<serde_json::Value>,

    pub undermountain: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum FlagmakingElement {
    Bool(bool),

    Double(f64),

    FlagmakingClass(FlagmakingClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FlagmakingClass {
    pub albarco: Option<serde_json::Value>,

    #[serde(rename = "Bunodonta")]
    pub bunodonta: Option<serde_json::Value>,

    pub hornify: Option<serde_json::Value>,

    #[serde(rename = "Hydrocorisae")]
    pub hydrocorisae: Option<serde_json::Value>,

    pub hypoglossus: Option<serde_json::Value>,

    pub inexpiably: Option<serde_json::Value>,

    pub ingratitude: Option<serde_json::Value>,

    pub ladyfly: Option<serde_json::Value>,

    pub medicament: Option<serde_json::Value>,

    pub monogrammatic: Option<serde_json::Value>,

    pub nobbut: Option<serde_json::Value>,

    #[serde(rename = "Notacanthidae")]
    pub notacanthidae: Option<serde_json::Value>,

    pub polyplacophore: Option<serde_json::Value>,

    pub proexercise: Option<serde_json::Value>,

    pub protoplast: Option<serde_json::Value>,

    pub puzzling: Option<serde_json::Value>,

    pub splanchnoskeleton: Option<serde_json::Value>,

    pub unloveliness: Option<serde_json::Value>,

    pub unquarantined: Option<serde_json::Value>,

    pub unrenounceable: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Fluorometer {
    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Fuzzy {
    Integer(i64),

    UnionMap(HashMap<String, Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Gardenward {
    Bool(bool),

    IntegerArray(Vec<i64>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Generalissimo {
    Bool(bool),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Hemicrystalline {
    CimeliaClass(CimeliaClass),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum HemocoeleElement {
    HemocoeleClass(HemocoeleClass),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HemocoeleClass {
    pub acrogamy: Option<serde_json::Value>,

    pub amelification: Option<serde_json::Value>,

    pub autobiographic: Option<serde_json::Value>,

    pub berat: Option<serde_json::Value>,

    pub catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,

    pub disdiapason: Option<String>,

    pub disproportionably: Option<serde_json::Value>,

    pub erythrite: Option<serde_json::Value>,

    pub graphic: Option<serde_json::Value>,

    pub hepatological: Option<serde_json::Value>,

    pub homocerc: Option<bool>,

    pub incommensurably: Option<serde_json::Value>,

    pub misaffirm: Option<serde_json::Value>,

    pub nonbookish: Option<serde_json::Value>,

    pub pocketbook: Option<serde_json::Value>,

    pub sclerometric: Option<serde_json::Value>,

    pub stambouline: Option<serde_json::Value>,

    pub stickpin: Option<serde_json::Value>,

    pub tubulure: Option<serde_json::Value>,

    pub undelated: Option<serde_json::Value>,

    pub unsalt: Option<serde_json::Value>,

    pub untutelar: Option<serde_json::Value>,

    pub vagrant: Option<serde_json::Value>,

    #[serde(rename = "Walt")]
    pub walt: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Hoister {
    CimeliaClass(CimeliaClass),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Hyperpiesi {
    CimeliaClass(CimeliaClass),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Hyppish {
    Bool(bool),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Idealizer {
    CimeliaClass(CimeliaClass),

    Integer(i64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Incrustator {
    Integer(i64),

    IntegerArray(Vec<i64>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Intentiveness {
    CimeliaClass(CimeliaClass),

    Double(f64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Interacinar {
    pub assapan: f64,

    pub benefactorship: bool,

    pub triseriatim: String,

    pub tubbing: i64,

    pub untrimmed: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Jacutinga {
    IntegerArray(Vec<i64>),

    UnionMap(HashMap<String, Option<i64>>),
}
