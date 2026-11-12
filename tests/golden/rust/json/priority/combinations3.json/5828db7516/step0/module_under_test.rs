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
    pub(crate) juror: Vec<JurorElement>,

    pub(crate) kongoni: Vec<Kongoni>,

    pub(crate) ladronism: Vec<LadronismElement>,

    pub(crate) landlubberly: Vec<LandlubberlyElement>,

    pub(crate) listener: Vec<Listener>,

    pub(crate) lupus: Vec<LupusElement>,

    pub(crate) maslin: Vec<Maslin>,

    pub(crate) monazite: Vec<MonaziteElement>,

    pub(crate) monoliteral: Vec<Monoliteral>,

    pub(crate) monotheistically: Vec<MonotheisticallyElement>,

    pub(crate) montage: Vec<Montage>,

    pub(crate) moralness: Vec<Option<Moralness>>,

    pub(crate) mowra: Vec<Option<MonaziteClass>>,

    pub(crate) mulishly: Vec<Option<Mulishly>>,

    pub(crate) myoscope: Vec<Myoscope>,

    pub(crate) nach: Vec<Option<Vec<Option<i64>>>>,

    pub(crate) neuromastic: Vec<Neuromastic>,

    pub(crate) noncontributing: Vec<Noncontributing>,

    pub(crate) nonnervous: Vec<Nonnervous>,

    pub(crate) nonvaluation: Vec<Nonvaluation>,

    pub(crate) occupationalist: Vec<Option<OccupationalistElement>>,

    pub(crate) outrival: Vec<Option<OutrivalElement>>,

    pub(crate) paleographically: Vec<Paleographically>,

    pub(crate) pamphletwise: Vec<Pamphletwise>,

    pub(crate) pediatrics: Vec<Option<Pediatric>>,

    pub(crate) perceptive: Vec<bool>,

    pub(crate) piaculum: Vec<PiaculumElement>,

    pub(crate) piccadilly: Vec<Option<Piccadilly>>,

    pub(crate) piffler: Vec<Piffler>,

    pub(crate) pithful: Vec<Option<Pithful>>,

    pub(crate) placuntitis: Vec<Placuntiti>,

    pub(crate) plectopterous: Vec<Plectopterous>,

    pub(crate) pneumocele: Vec<Option<Pneumocele>>,

    pub(crate) poliorcetic: Vec<Poliorcetic>,

    pub(crate) poormaster: Vec<Option<Poormaster>>,

    pub(crate) potwhisky: Vec<Option<PotwhiskyElement>>,

    pub(crate) practicalizer: Vec<Practicalizer>,

    pub(crate) prefreshman: Vec<PrefreshmanElement>,

    pub(crate) prehensility: Vec<Prehensility>,

    pub(crate) prevoidance: Vec<Prevoidance>,

    pub(crate) probant: Vec<HashMap<String, Option<i64>>>,

    pub(crate) protext: Vec<Protext>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum JurorElement {
    Bool(bool),

    JurorClass(JurorClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JurorClass {
    pub(crate) adipsy: Option<serde_json::Value>,

    pub(crate) auxiliator: Option<serde_json::Value>,

    pub(crate) benda: Option<serde_json::Value>,

    pub(crate) benjamin: Option<serde_json::Value>,

    pub(crate) brandling: Option<serde_json::Value>,

    pub(crate) epicurishly: Option<serde_json::Value>,

    pub(crate) eremochaetous: Option<serde_json::Value>,

    pub(crate) marten: Option<serde_json::Value>,

    pub(crate) monocline: Option<serde_json::Value>,

    #[serde(rename = "Olea")]
    pub(crate) olea: Option<serde_json::Value>,

    pub(crate) palgat: Option<serde_json::Value>,

    pub(crate) pennyworth: Option<serde_json::Value>,

    pub(crate) pioury: Option<serde_json::Value>,

    pub(crate) pragmatistic: Option<serde_json::Value>,

    pub(crate) stylelessness: Option<serde_json::Value>,

    pub(crate) systematical: Option<serde_json::Value>,

    pub(crate) thready: Option<serde_json::Value>,

    pub(crate) uncontemporary: Option<serde_json::Value>,

    pub(crate) uncouched: Option<serde_json::Value>,

    pub(crate) uninhabitedness: Option<serde_json::Value>,
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
    pub(crate) acclaimer: Option<serde_json::Value>,

    pub(crate) achree: Option<serde_json::Value>,

    pub(crate) base: Option<serde_json::Value>,

    pub(crate) conundrumize: Option<serde_json::Value>,

    pub(crate) degerminator: Option<serde_json::Value>,

    pub(crate) describable: Option<serde_json::Value>,

    pub(crate) exasperatedly: Option<serde_json::Value>,

    pub(crate) heroine: Option<serde_json::Value>,

    pub(crate) indazin: Option<serde_json::Value>,

    pub(crate) luteous: Option<serde_json::Value>,

    pub(crate) papular: Option<serde_json::Value>,

    pub(crate) pritch: Option<serde_json::Value>,

    #[serde(rename = "Prodenia")]
    pub(crate) prodenia: Option<serde_json::Value>,

    pub(crate) seege: Option<serde_json::Value>,

    pub(crate) shopgirl: Option<serde_json::Value>,

    pub(crate) tragedietta: Option<serde_json::Value>,

    pub(crate) unsparse: Option<serde_json::Value>,

    pub(crate) uplook: Option<serde_json::Value>,

    pub(crate) vermiformis: Option<serde_json::Value>,

    pub(crate) whafabout: Option<serde_json::Value>,
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
    pub(crate) acropoleis: Option<serde_json::Value>,

    pub(crate) aminate: Option<serde_json::Value>,

    #[serde(rename = "Amyraldism")]
    pub(crate) amyraldism: Option<serde_json::Value>,

    pub(crate) bipenniform: Option<serde_json::Value>,

    pub(crate) bugre: Option<serde_json::Value>,

    pub(crate) calycule: Option<serde_json::Value>,

    pub(crate) caoutchouc: Option<serde_json::Value>,

    pub(crate) disprover: Option<serde_json::Value>,

    pub(crate) fitroot: Option<serde_json::Value>,

    pub(crate) fulgently: Option<serde_json::Value>,

    pub(crate) kickup: Option<serde_json::Value>,

    pub(crate) laevoversion: Option<serde_json::Value>,

    pub(crate) moter: Option<serde_json::Value>,

    pub(crate) objectivity: Option<serde_json::Value>,

    pub(crate) posterity: Option<serde_json::Value>,

    pub(crate) postnuptial: Option<serde_json::Value>,

    pub(crate) precedentary: Option<serde_json::Value>,

    pub(crate) saddling: Option<serde_json::Value>,

    pub(crate) subcurrent: Option<serde_json::Value>,

    pub(crate) unrecriminative: Option<serde_json::Value>,
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
    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    #[serde(rename = "Chlorioninae")]
    pub(crate) chlorioninae: Option<i64>,

    #[serde(rename = "Corvinae")]
    pub(crate) corvinae: Option<i64>,

    #[serde(rename = "Crassina")]
    pub(crate) crassina: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) exiguity: Option<i64>,

    pub(crate) farcist: Option<i64>,

    pub(crate) holographical: Option<i64>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) ichthyophagan: Option<i64>,

    pub(crate) implacable: Option<i64>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) outshiner: Option<i64>,

    pub(crate) overweather: Option<i64>,

    pub(crate) protonegroid: Option<i64>,

    pub(crate) shallowish: Option<i64>,

    pub(crate) snoke: Option<i64>,

    pub(crate) snout: Option<i64>,

    pub(crate) surveillance: Option<i64>,

    pub(crate) threshingtime: Option<i64>,

    #[serde(rename = "Thysanocarpus")]
    pub(crate) thysanocarpus: Option<i64>,

    pub(crate) unsignificantly: Option<i64>,

    pub(crate) unsnap: Option<i64>,

    pub(crate) vendible: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Maslin {
    #[serde(rename = "Alicant")]
    pub(crate) alicant: Option<i64>,

    pub(crate) antiatonement: Option<serde_json::Value>,

    pub(crate) anticorrosive: Option<i64>,

    pub(crate) aphidozer: Option<serde_json::Value>,

    #[serde(rename = "Bakuninist")]
    pub(crate) bakuninist: Option<serde_json::Value>,

    pub(crate) be: Option<i64>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) chub: Option<i64>,

    pub(crate) cuprosilicon: Option<i64>,

    pub(crate) curtailedly: Option<i64>,

    pub(crate) dellenite: Option<i64>,

    #[serde(rename = "Dimitry")]
    pub(crate) dimitry: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) edifying: Option<serde_json::Value>,

    pub(crate) ethmoiditis: Option<i64>,

    pub(crate) gastralgy: Option<serde_json::Value>,

    pub(crate) goatherd: Option<i64>,

    pub(crate) hammerdress: Option<i64>,

    pub(crate) hangfire: Option<serde_json::Value>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) lacunosity: Option<i64>,

    pub(crate) longiloquence: Option<serde_json::Value>,

    pub(crate) mameliere: Option<i64>,

    pub(crate) motherless: Option<serde_json::Value>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) noncorrodible: Option<serde_json::Value>,

    pub(crate) nonsensicality: Option<serde_json::Value>,

    pub(crate) oafishly: Option<i64>,

    pub(crate) pfund: Option<serde_json::Value>,

    pub(crate) preadvisory: Option<serde_json::Value>,

    pub(crate) retroflexed: Option<serde_json::Value>,

    pub(crate) saccharulmic: Option<i64>,

    pub(crate) scowlful: Option<i64>,

    pub(crate) secluded: Option<serde_json::Value>,

    pub(crate) slackage: Option<serde_json::Value>,

    pub(crate) sphaeridial: Option<i64>,

    pub(crate) spondulics: Option<serde_json::Value>,

    pub(crate) subsecive: Option<i64>,

    pub(crate) swellmobsman: Option<serde_json::Value>,

    pub(crate) trachyglossate: Option<i64>,

    pub(crate) trialogue: Option<serde_json::Value>,

    pub(crate) unassuaged: Option<i64>,

    pub(crate) ungross: Option<serde_json::Value>,

    pub(crate) unjudiciously: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum MonaziteElement {
    Double(f64),

    MonaziteClass(MonaziteClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MonaziteClass {
    pub(crate) catharticalness: f64,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: i64,

    pub(crate) disdiapason: String,

    pub(crate) homocerc: bool,

    pub(crate) nonbookish: Option<serde_json::Value>,
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
    pub(crate) blaspheme: Option<serde_json::Value>,

    pub(crate) catharticalness: Option<f64>,

    pub(crate) celiosalpingectomy: Option<serde_json::Value>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) consummativeness: Option<serde_json::Value>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) egestive: Option<serde_json::Value>,

    pub(crate) enchylema: Option<serde_json::Value>,

    pub(crate) gasconade: Option<serde_json::Value>,

    pub(crate) holidayer: Option<serde_json::Value>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) intuitionalism: Option<serde_json::Value>,

    pub(crate) lophiostomate: Option<serde_json::Value>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) nonvolition: Option<serde_json::Value>,

    pub(crate) palatableness: Option<serde_json::Value>,

    pub(crate) pimpery: Option<serde_json::Value>,

    pub(crate) previolation: Option<serde_json::Value>,

    pub(crate) reconveyance: Option<serde_json::Value>,

    pub(crate) registership: Option<serde_json::Value>,

    pub(crate) rhyacolite: Option<serde_json::Value>,

    pub(crate) smithereens: Option<serde_json::Value>,

    pub(crate) superedification: Option<serde_json::Value>,

    pub(crate) trust: Option<serde_json::Value>,

    pub(crate) whitestone: Option<serde_json::Value>,
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
    pub(crate) estevin: String,

    pub(crate) jolterhead: f64,

    pub(crate) sauternes: i64,

    pub(crate) sparsely: bool,

    pub(crate) unrequested: Option<serde_json::Value>,
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
    pub(crate) beholdable: Option<serde_json::Value>,

    pub(crate) brotuliform: Option<serde_json::Value>,

    #[serde(rename = "Chimakum")]
    pub(crate) chimakum: Option<serde_json::Value>,

    pub(crate) doodler: Option<serde_json::Value>,

    pub(crate) emulsin: Option<serde_json::Value>,

    #[serde(rename = "Fin")]
    pub(crate) fin: Option<serde_json::Value>,

    pub(crate) flourishing: Option<serde_json::Value>,

    pub(crate) flueless: Option<serde_json::Value>,

    pub(crate) furtively: Option<serde_json::Value>,

    pub(crate) gritter: Option<serde_json::Value>,

    pub(crate) interwish: Option<serde_json::Value>,

    pub(crate) monoxylic: Option<serde_json::Value>,

    pub(crate) myristic: Option<serde_json::Value>,

    pub(crate) nightwear: Option<serde_json::Value>,

    pub(crate) peruser: Option<serde_json::Value>,

    pub(crate) theoastrological: Option<serde_json::Value>,

    pub(crate) thumby: Option<serde_json::Value>,

    pub(crate) tingitid: Option<serde_json::Value>,

    pub(crate) trailless: Option<serde_json::Value>,

    pub(crate) unpocketed: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum OutrivalElement {
    Double(f64),

    OutrivalClass(OutrivalClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OutrivalClass {
    pub(crate) adroitly: Option<serde_json::Value>,

    pub(crate) bridehood: Option<serde_json::Value>,

    #[serde(rename = "Castoroides")]
    pub(crate) castoroides: Option<serde_json::Value>,

    #[serde(rename = "Czechoslovak")]
    pub(crate) czechoslovak: Option<serde_json::Value>,

    pub(crate) diagenesis: Option<serde_json::Value>,

    pub(crate) dihexahedron: Option<serde_json::Value>,

    pub(crate) dopester: Option<serde_json::Value>,

    pub(crate) eumerism: Option<serde_json::Value>,

    pub(crate) flyness: Option<serde_json::Value>,

    pub(crate) fouler: Option<serde_json::Value>,

    pub(crate) laudanosine: Option<serde_json::Value>,

    #[serde(rename = "Lingulidae")]
    pub(crate) lingulidae: Option<serde_json::Value>,

    pub(crate) minutary: Option<serde_json::Value>,

    pub(crate) mitra: Option<serde_json::Value>,

    pub(crate) opisthorchiasis: Option<serde_json::Value>,

    pub(crate) pensively: Option<serde_json::Value>,

    pub(crate) pubigerous: Option<serde_json::Value>,

    pub(crate) rebellious: Option<serde_json::Value>,

    pub(crate) recodify: Option<serde_json::Value>,

    pub(crate) unpaced: Option<serde_json::Value>,
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
    pub(crate) alada: Option<i64>,

    pub(crate) amphistomous: Option<i64>,

    pub(crate) boysenberry: Option<i64>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) decardinalize: Option<i64>,

    pub(crate) discouragement: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) doitrified: Option<i64>,

    pub(crate) hexaspermous: Option<i64>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) insinking: Option<i64>,

    pub(crate) loathfulness: Option<i64>,

    pub(crate) miasmatical: Option<i64>,

    pub(crate) neurofibril: Option<i64>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) phonendoscope: Option<i64>,

    pub(crate) pilferment: Option<i64>,

    pub(crate) predismissory: Option<i64>,

    pub(crate) preinscription: Option<i64>,

    pub(crate) quotative: Option<i64>,

    pub(crate) sienna: Option<i64>,

    pub(crate) thorax: Option<i64>,

    pub(crate) yachting: Option<i64>,

    #[serde(rename = "Zipper")]
    pub(crate) zipper: Option<i64>,
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
    pub(crate) carbonarism: Option<serde_json::Value>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) cineolic: Option<serde_json::Value>,

    pub(crate) cobbly: Option<serde_json::Value>,

    pub(crate) conchyliferous: Option<serde_json::Value>,

    pub(crate) congregation: Option<serde_json::Value>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) enterotomy: Option<serde_json::Value>,

    pub(crate) entophytal: Option<serde_json::Value>,

    pub(crate) fewtrils: Option<serde_json::Value>,

    pub(crate) herem: Option<serde_json::Value>,

    pub(crate) homocerc: Option<bool>,

    #[serde(rename = "Koniga")]
    pub(crate) koniga: Option<serde_json::Value>,

    pub(crate) meticulosity: Option<serde_json::Value>,

    #[serde(rename = "Micky")]
    pub(crate) micky: Option<serde_json::Value>,

    pub(crate) mismarriage: Option<serde_json::Value>,

    pub(crate) neurotrophic: Option<serde_json::Value>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) persuasively: Option<serde_json::Value>,

    pub(crate) replaceable: Option<serde_json::Value>,

    pub(crate) silex: Option<serde_json::Value>,

    pub(crate) taillight: Option<serde_json::Value>,

    pub(crate) unjealous: Option<serde_json::Value>,

    pub(crate) visitorial: Option<serde_json::Value>,
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
    pub(crate) arciform: Option<serde_json::Value>,

    pub(crate) cresolin: Option<serde_json::Value>,

    pub(crate) disheartener: Option<serde_json::Value>,

    pub(crate) disproportionable: Option<serde_json::Value>,

    #[serde(rename = "Euchorda")]
    pub(crate) euchorda: Option<serde_json::Value>,

    pub(crate) ferryway: Option<serde_json::Value>,

    pub(crate) filamentiferous: Option<serde_json::Value>,

    pub(crate) flemish: Option<serde_json::Value>,

    pub(crate) forgainst: Option<serde_json::Value>,

    pub(crate) grainering: Option<serde_json::Value>,

    pub(crate) irrevoluble: Option<serde_json::Value>,

    pub(crate) kindredship: Option<serde_json::Value>,

    pub(crate) pinguitudinous: Option<serde_json::Value>,

    pub(crate) simpletonic: Option<serde_json::Value>,

    pub(crate) singsong: Option<serde_json::Value>,

    pub(crate) submergement: Option<serde_json::Value>,

    pub(crate) supraoesophagal: Option<serde_json::Value>,

    pub(crate) thrashel: Option<serde_json::Value>,

    pub(crate) tyremesis: Option<serde_json::Value>,

    #[serde(rename = "Yoruba")]
    pub(crate) yoruba: Option<serde_json::Value>,
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
    pub(crate) azorubine: Option<serde_json::Value>,

    pub(crate) choroiditis: Option<serde_json::Value>,

    pub(crate) coagulatory: Option<serde_json::Value>,

    pub(crate) cyclorama: Option<serde_json::Value>,

    #[serde(rename = "Dolphus")]
    pub(crate) dolphus: Option<serde_json::Value>,

    pub(crate) duckhearted: Option<serde_json::Value>,

    #[serde(rename = "Ficus")]
    pub(crate) ficus: Option<serde_json::Value>,

    #[serde(rename = "Gemaric")]
    pub(crate) gemaric: Option<serde_json::Value>,

    pub(crate) jugation: Option<serde_json::Value>,

    pub(crate) myoliposis: Option<serde_json::Value>,

    pub(crate) nonnomination: Option<serde_json::Value>,

    pub(crate) palay: Option<serde_json::Value>,

    pub(crate) pentactinal: Option<serde_json::Value>,

    #[serde(rename = "Phaet")]
    pub(crate) phaet: Option<serde_json::Value>,

    pub(crate) piquant: Option<serde_json::Value>,

    pub(crate) registration: Option<serde_json::Value>,

    pub(crate) remancipation: Option<serde_json::Value>,

    pub(crate) scutatiform: Option<serde_json::Value>,

    pub(crate) theodolite: Option<serde_json::Value>,

    pub(crate) underward: Option<serde_json::Value>,
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
