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
    pub juror: Vec<JurorElement>,

    pub kongoni: Vec<Kongoni>,

    pub ladronism: Vec<LadronismElement>,

    pub landlubberly: Vec<LandlubberlyElement>,

    pub listener: Vec<Listener>,

    pub lupus: Vec<LupusElement>,

    pub maslin: Vec<Maslin>,

    pub monazite: Vec<MonaziteElement>,

    pub monoliteral: Vec<Monoliteral>,

    pub monotheistically: Vec<MonotheisticallyElement>,

    pub montage: Vec<Montage>,

    pub moralness: Vec<Option<Moralness>>,

    pub mowra: Vec<Option<MonaziteClass>>,

    pub mulishly: Vec<Option<Mulishly>>,

    pub myoscope: Vec<Myoscope>,

    pub nach: Vec<Option<Vec<Option<i64>>>>,

    pub neuromastic: Vec<Neuromastic>,

    pub noncontributing: Vec<Noncontributing>,

    pub nonnervous: Vec<Nonnervous>,

    pub nonvaluation: Vec<Nonvaluation>,

    pub occupationalist: Vec<Option<OccupationalistElement>>,

    pub outrival: Vec<Option<OutrivalElement>>,

    pub paleographically: Vec<Paleographically>,

    pub pamphletwise: Vec<Pamphletwise>,

    pub pediatrics: Vec<Option<Pediatric>>,

    pub perceptive: Vec<bool>,

    pub piaculum: Vec<PiaculumElement>,

    pub piccadilly: Vec<Option<Piccadilly>>,

    pub piffler: Vec<Piffler>,

    pub pithful: Vec<Option<Pithful>>,

    pub placuntitis: Vec<Placuntiti>,

    pub plectopterous: Vec<Plectopterous>,

    pub pneumocele: Vec<Option<Pneumocele>>,

    pub poliorcetic: Vec<Poliorcetic>,

    pub poormaster: Vec<Option<Poormaster>>,

    pub potwhisky: Vec<Option<PotwhiskyElement>>,

    pub practicalizer: Vec<Practicalizer>,

    pub prefreshman: Vec<PrefreshmanElement>,

    pub prehensility: Vec<Prehensility>,

    pub prevoidance: Vec<Prevoidance>,

    pub probant: Vec<HashMap<String, Option<i64>>>,

    pub protext: Vec<Protext>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum JurorElement {
    Bool(bool),

    JurorClass(JurorClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JurorClass {
    pub adipsy: Option<serde_json::Value>,

    pub auxiliator: Option<serde_json::Value>,

    pub benda: Option<serde_json::Value>,

    pub benjamin: Option<serde_json::Value>,

    pub brandling: Option<serde_json::Value>,

    pub epicurishly: Option<serde_json::Value>,

    pub eremochaetous: Option<serde_json::Value>,

    pub marten: Option<serde_json::Value>,

    pub monocline: Option<serde_json::Value>,

    #[serde(rename = "Olea")]
    pub olea: Option<serde_json::Value>,

    pub palgat: Option<serde_json::Value>,

    pub pennyworth: Option<serde_json::Value>,

    pub pioury: Option<serde_json::Value>,

    pub pragmatistic: Option<serde_json::Value>,

    pub stylelessness: Option<serde_json::Value>,

    pub systematical: Option<serde_json::Value>,

    pub thready: Option<serde_json::Value>,

    pub uncontemporary: Option<serde_json::Value>,

    pub uncouched: Option<serde_json::Value>,

    pub uninhabitedness: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Kongoni {
    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum LadronismElement {
    Double(f64),

    LadronismClass(LadronismClass),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LadronismClass {
    pub acclaimer: Option<serde_json::Value>,

    pub achree: Option<serde_json::Value>,

    pub base: Option<serde_json::Value>,

    pub conundrumize: Option<serde_json::Value>,

    pub degerminator: Option<serde_json::Value>,

    pub describable: Option<serde_json::Value>,

    pub exasperatedly: Option<serde_json::Value>,

    pub heroine: Option<serde_json::Value>,

    pub indazin: Option<serde_json::Value>,

    pub luteous: Option<serde_json::Value>,

    pub papular: Option<serde_json::Value>,

    pub pritch: Option<serde_json::Value>,

    #[serde(rename = "Prodenia")]
    pub prodenia: Option<serde_json::Value>,

    pub seege: Option<serde_json::Value>,

    pub shopgirl: Option<serde_json::Value>,

    pub tragedietta: Option<serde_json::Value>,

    pub unsparse: Option<serde_json::Value>,

    pub uplook: Option<serde_json::Value>,

    pub vermiformis: Option<serde_json::Value>,

    pub whafabout: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum LandlubberlyElement {
    Bool(bool),

    Integer(i64),

    LandlubberlyClass(LandlubberlyClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LandlubberlyClass {
    pub acropoleis: Option<serde_json::Value>,

    pub aminate: Option<serde_json::Value>,

    #[serde(rename = "Amyraldism")]
    pub amyraldism: Option<serde_json::Value>,

    pub bipenniform: Option<serde_json::Value>,

    pub bugre: Option<serde_json::Value>,

    pub calycule: Option<serde_json::Value>,

    pub caoutchouc: Option<serde_json::Value>,

    pub disprover: Option<serde_json::Value>,

    pub fitroot: Option<serde_json::Value>,

    pub fulgently: Option<serde_json::Value>,

    pub kickup: Option<serde_json::Value>,

    pub laevoversion: Option<serde_json::Value>,

    pub moter: Option<serde_json::Value>,

    pub objectivity: Option<serde_json::Value>,

    pub posterity: Option<serde_json::Value>,

    pub postnuptial: Option<serde_json::Value>,

    pub precedentary: Option<serde_json::Value>,

    pub saddling: Option<serde_json::Value>,

    pub subcurrent: Option<serde_json::Value>,

    pub unrecriminative: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Listener {
    Integer(i64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum LupusElement {
    Integer(i64),

    LupusClass(LupusClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LupusClass {
    pub catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,

    #[serde(rename = "Chlorioninae")]
    pub chlorioninae: Option<i64>,

    #[serde(rename = "Corvinae")]
    pub corvinae: Option<i64>,

    #[serde(rename = "Crassina")]
    pub crassina: Option<i64>,

    pub disdiapason: Option<String>,

    pub exiguity: Option<i64>,

    pub farcist: Option<i64>,

    pub holographical: Option<i64>,

    pub homocerc: Option<bool>,

    pub ichthyophagan: Option<i64>,

    pub implacable: Option<i64>,

    pub nonbookish: Option<serde_json::Value>,

    pub outshiner: Option<i64>,

    pub overweather: Option<i64>,

    pub protonegroid: Option<i64>,

    pub shallowish: Option<i64>,

    pub snoke: Option<i64>,

    pub snout: Option<i64>,

    pub surveillance: Option<i64>,

    pub threshingtime: Option<i64>,

    #[serde(rename = "Thysanocarpus")]
    pub thysanocarpus: Option<i64>,

    pub unsignificantly: Option<i64>,

    pub unsnap: Option<i64>,

    pub vendible: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Maslin {
    #[serde(rename = "Alicant")]
    pub alicant: Option<i64>,

    pub antiatonement: Option<serde_json::Value>,

    pub anticorrosive: Option<i64>,

    pub aphidozer: Option<serde_json::Value>,

    #[serde(rename = "Bakuninist")]
    pub bakuninist: Option<serde_json::Value>,

    pub be: Option<i64>,

    pub catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,

    pub chub: Option<i64>,

    pub cuprosilicon: Option<i64>,

    pub curtailedly: Option<i64>,

    pub dellenite: Option<i64>,

    #[serde(rename = "Dimitry")]
    pub dimitry: Option<i64>,

    pub disdiapason: Option<String>,

    pub edifying: Option<serde_json::Value>,

    pub ethmoiditis: Option<i64>,

    pub gastralgy: Option<serde_json::Value>,

    pub goatherd: Option<i64>,

    pub hammerdress: Option<i64>,

    pub hangfire: Option<serde_json::Value>,

    pub homocerc: Option<bool>,

    pub lacunosity: Option<i64>,

    pub longiloquence: Option<serde_json::Value>,

    pub mameliere: Option<i64>,

    pub motherless: Option<serde_json::Value>,

    pub nonbookish: Option<serde_json::Value>,

    pub noncorrodible: Option<serde_json::Value>,

    pub nonsensicality: Option<serde_json::Value>,

    pub oafishly: Option<i64>,

    pub pfund: Option<serde_json::Value>,

    pub preadvisory: Option<serde_json::Value>,

    pub retroflexed: Option<serde_json::Value>,

    pub saccharulmic: Option<i64>,

    pub scowlful: Option<i64>,

    pub secluded: Option<serde_json::Value>,

    pub slackage: Option<serde_json::Value>,

    pub sphaeridial: Option<i64>,

    pub spondulics: Option<serde_json::Value>,

    pub subsecive: Option<i64>,

    pub swellmobsman: Option<serde_json::Value>,

    pub trachyglossate: Option<i64>,

    pub trialogue: Option<serde_json::Value>,

    pub unassuaged: Option<i64>,

    pub ungross: Option<serde_json::Value>,

    pub unjudiciously: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum MonaziteElement {
    Double(f64),

    MonaziteClass(MonaziteClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MonaziteClass {
    pub catharticalness: f64,

    #[serde(rename = "Chirotherium")]
    pub chirotherium: i64,

    pub disdiapason: String,

    pub homocerc: bool,

    pub nonbookish: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Monoliteral {
    Bool(bool),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum MonotheisticallyElement {
    MonotheisticallyClass(MonotheisticallyClass),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MonotheisticallyClass {
    pub blaspheme: Option<serde_json::Value>,

    pub catharticalness: Option<f64>,

    pub celiosalpingectomy: Option<serde_json::Value>,

    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,

    pub consummativeness: Option<serde_json::Value>,

    pub disdiapason: Option<String>,

    pub egestive: Option<serde_json::Value>,

    pub enchylema: Option<serde_json::Value>,

    pub gasconade: Option<serde_json::Value>,

    pub holidayer: Option<serde_json::Value>,

    pub homocerc: Option<bool>,

    pub intuitionalism: Option<serde_json::Value>,

    pub lophiostomate: Option<serde_json::Value>,

    pub nonbookish: Option<serde_json::Value>,

    pub nonvolition: Option<serde_json::Value>,

    pub palatableness: Option<serde_json::Value>,

    pub pimpery: Option<serde_json::Value>,

    pub previolation: Option<serde_json::Value>,

    pub reconveyance: Option<serde_json::Value>,

    pub registership: Option<serde_json::Value>,

    pub rhyacolite: Option<serde_json::Value>,

    pub smithereens: Option<serde_json::Value>,

    pub superedification: Option<serde_json::Value>,

    pub trust: Option<serde_json::Value>,

    pub whitestone: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Montage {
    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Moralness {
    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Mulishly {
    Double(f64),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Myoscope {
    Bool(bool),

    Integer(i64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Neuromastic {
    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Noncontributing {
    pub estevin: String,

    pub jolterhead: f64,

    pub sauternes: i64,

    pub sparsely: bool,

    pub unrequested: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Nonnervous {
    Bool(bool),

    Integer(i64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Nonvaluation {
    Bool(bool),

    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum OccupationalistElement {
    NullArray(Vec<Option<serde_json::Value>>),

    OccupationalistClass(OccupationalistClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OccupationalistClass {
    pub beholdable: Option<serde_json::Value>,

    pub brotuliform: Option<serde_json::Value>,

    #[serde(rename = "Chimakum")]
    pub chimakum: Option<serde_json::Value>,

    pub doodler: Option<serde_json::Value>,

    pub emulsin: Option<serde_json::Value>,

    #[serde(rename = "Fin")]
    pub fin: Option<serde_json::Value>,

    pub flourishing: Option<serde_json::Value>,

    pub flueless: Option<serde_json::Value>,

    pub furtively: Option<serde_json::Value>,

    pub gritter: Option<serde_json::Value>,

    pub interwish: Option<serde_json::Value>,

    pub monoxylic: Option<serde_json::Value>,

    pub myristic: Option<serde_json::Value>,

    pub nightwear: Option<serde_json::Value>,

    pub peruser: Option<serde_json::Value>,

    pub theoastrological: Option<serde_json::Value>,

    pub thumby: Option<serde_json::Value>,

    pub tingitid: Option<serde_json::Value>,

    pub trailless: Option<serde_json::Value>,

    pub unpocketed: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum OutrivalElement {
    Double(f64),

    OutrivalClass(OutrivalClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OutrivalClass {
    pub adroitly: Option<serde_json::Value>,

    pub bridehood: Option<serde_json::Value>,

    #[serde(rename = "Castoroides")]
    pub castoroides: Option<serde_json::Value>,

    #[serde(rename = "Czechoslovak")]
    pub czechoslovak: Option<serde_json::Value>,

    pub diagenesis: Option<serde_json::Value>,

    pub dihexahedron: Option<serde_json::Value>,

    pub dopester: Option<serde_json::Value>,

    pub eumerism: Option<serde_json::Value>,

    pub flyness: Option<serde_json::Value>,

    pub fouler: Option<serde_json::Value>,

    pub laudanosine: Option<serde_json::Value>,

    #[serde(rename = "Lingulidae")]
    pub lingulidae: Option<serde_json::Value>,

    pub minutary: Option<serde_json::Value>,

    pub mitra: Option<serde_json::Value>,

    pub opisthorchiasis: Option<serde_json::Value>,

    pub pensively: Option<serde_json::Value>,

    pub pubigerous: Option<serde_json::Value>,

    pub rebellious: Option<serde_json::Value>,

    pub recodify: Option<serde_json::Value>,

    pub unpaced: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Paleographically {
    Double(f64),

    UnionMap(HashMap<String, Option<i64>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Pamphletwise {
    Integer(i64),

    IntegerMap(HashMap<String, i64>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Pediatric {
    Bool(bool),

    Double(f64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum PiaculumElement {
    Double(f64),

    PiaculumClass(PiaculumClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PiaculumClass {
    pub alada: Option<i64>,

    pub amphistomous: Option<i64>,

    pub boysenberry: Option<i64>,

    pub catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,

    pub decardinalize: Option<i64>,

    pub discouragement: Option<i64>,

    pub disdiapason: Option<String>,

    pub doitrified: Option<i64>,

    pub hexaspermous: Option<i64>,

    pub homocerc: Option<bool>,

    pub insinking: Option<i64>,

    pub loathfulness: Option<i64>,

    pub miasmatical: Option<i64>,

    pub neurofibril: Option<i64>,

    pub nonbookish: Option<serde_json::Value>,

    pub phonendoscope: Option<i64>,

    pub pilferment: Option<i64>,

    pub predismissory: Option<i64>,

    pub preinscription: Option<i64>,

    pub quotative: Option<i64>,

    pub sienna: Option<i64>,

    pub thorax: Option<i64>,

    pub yachting: Option<i64>,

    #[serde(rename = "Zipper")]
    pub zipper: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Piccadilly {
    Double(f64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Piffler {
    MonaziteClass(MonaziteClass),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Pithful {
    Bool(bool),

    Integer(i64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Placuntiti {
    Integer(i64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Plectopterous {
    Double(f64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Pneumocele {
    #[serde(rename = "Carbonarism")]
    pub carbonarism: Option<serde_json::Value>,

    pub catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub chirotherium: Option<i64>,

    pub cineolic: Option<serde_json::Value>,

    pub cobbly: Option<serde_json::Value>,

    pub conchyliferous: Option<serde_json::Value>,

    pub congregation: Option<serde_json::Value>,

    pub disdiapason: Option<String>,

    pub enterotomy: Option<serde_json::Value>,

    pub entophytal: Option<serde_json::Value>,

    pub fewtrils: Option<serde_json::Value>,

    pub herem: Option<serde_json::Value>,

    pub homocerc: Option<bool>,

    #[serde(rename = "Koniga")]
    pub koniga: Option<serde_json::Value>,

    pub meticulosity: Option<serde_json::Value>,

    #[serde(rename = "Micky")]
    pub micky: Option<serde_json::Value>,

    pub mismarriage: Option<serde_json::Value>,

    pub neurotrophic: Option<serde_json::Value>,

    pub nonbookish: Option<serde_json::Value>,

    pub persuasively: Option<serde_json::Value>,

    pub replaceable: Option<serde_json::Value>,

    pub silex: Option<serde_json::Value>,

    pub taillight: Option<serde_json::Value>,

    pub unjealous: Option<serde_json::Value>,

    pub visitorial: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Poliorcetic {
    Bool(bool),

    MonaziteClass(MonaziteClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Poormaster {
    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum PotwhiskyElement {
    Integer(i64),

    PotwhiskyClass(PotwhiskyClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PotwhiskyClass {
    pub arciform: Option<serde_json::Value>,

    pub cresolin: Option<serde_json::Value>,

    pub disheartener: Option<serde_json::Value>,

    pub disproportionable: Option<serde_json::Value>,

    #[serde(rename = "Euchorda")]
    pub euchorda: Option<serde_json::Value>,

    pub ferryway: Option<serde_json::Value>,

    pub filamentiferous: Option<serde_json::Value>,

    pub flemish: Option<serde_json::Value>,

    pub forgainst: Option<serde_json::Value>,

    pub grainering: Option<serde_json::Value>,

    pub irrevoluble: Option<serde_json::Value>,

    pub kindredship: Option<serde_json::Value>,

    pub pinguitudinous: Option<serde_json::Value>,

    pub simpletonic: Option<serde_json::Value>,

    pub singsong: Option<serde_json::Value>,

    pub submergement: Option<serde_json::Value>,

    pub supraoesophagal: Option<serde_json::Value>,

    pub thrashel: Option<serde_json::Value>,

    pub tyremesis: Option<serde_json::Value>,

    #[serde(rename = "Yoruba")]
    pub yoruba: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Practicalizer {
    MonaziteClass(MonaziteClass),

    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum PrefreshmanElement {
    NullArray(Vec<Option<serde_json::Value>>),

    PrefreshmanClass(PrefreshmanClass),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PrefreshmanClass {
    pub azorubine: Option<serde_json::Value>,

    pub choroiditis: Option<serde_json::Value>,

    pub coagulatory: Option<serde_json::Value>,

    pub cyclorama: Option<serde_json::Value>,

    #[serde(rename = "Dolphus")]
    pub dolphus: Option<serde_json::Value>,

    pub duckhearted: Option<serde_json::Value>,

    #[serde(rename = "Ficus")]
    pub ficus: Option<serde_json::Value>,

    #[serde(rename = "Gemaric")]
    pub gemaric: Option<serde_json::Value>,

    pub jugation: Option<serde_json::Value>,

    pub myoliposis: Option<serde_json::Value>,

    pub nonnomination: Option<serde_json::Value>,

    pub palay: Option<serde_json::Value>,

    pub pentactinal: Option<serde_json::Value>,

    #[serde(rename = "Phaet")]
    pub phaet: Option<serde_json::Value>,

    pub piquant: Option<serde_json::Value>,

    pub registration: Option<serde_json::Value>,

    pub remancipation: Option<serde_json::Value>,

    pub scutatiform: Option<serde_json::Value>,

    pub theodolite: Option<serde_json::Value>,

    pub underward: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Prehensility {
    Bool(bool),

    MonaziteClass(MonaziteClass),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Prevoidance {
    Integer(i64),

    IntegerArray(Vec<i64>),

    MonaziteClass(MonaziteClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Protext {
    Bool(bool),

    IntegerArray(Vec<i64>),

    MonaziteClass(MonaziteClass),
}
