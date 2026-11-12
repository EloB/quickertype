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
    pub(crate) centrodesmose: String,

    pub(crate) cerograph: Vec<Option<CerographElement>>,

    pub(crate) chemotherapeutics: Vec<ChemotherapeuticElement>,

    pub(crate) cimelia: Vec<Option<CimeliaElement>>,

    pub(crate) citrated: i64,

    pub(crate) clinodome: Vec<Clinodome>,

    pub(crate) coadjust: Vec<CoadjustElement>,

    pub(crate) consilience: Vec<Consilience>,

    pub(crate) constructor: Vec<Constructor>,

    pub(crate) continuative: Vec<Continuative>,

    pub(crate) credulity: Vec<CredulityElement>,

    pub(crate) creviced: Vec<Creviced>,

    pub(crate) cubiculum: Vec<Vec<Option<i64>>>,

    pub(crate) deruralize: Vec<DeruralizeElement>,

    pub(crate) diaereses: Vec<DiaereseElement>,

    pub(crate) dissolution: Vec<Option<Vec<Option<serde_json::Value>>>>,

    pub(crate) downstroke: Vec<Downstroke>,

    pub(crate) electrotautomerism: Vec<Option<f64>>,

    pub(crate) eleutheromania: Vec<Eleutheromania>,

    pub(crate) encrust: Encrust,

    pub(crate) entomoid: Vec<Entomoid>,

    pub(crate) epipaleolithic: Vec<Epipaleolithic>,

    pub(crate) expropriable: Vec<Expropriable>,

    pub(crate) faggingly: Vec<FagginglyElement>,

    pub(crate) fenks: Vec<FenkElement>,

    pub(crate) flagmaking: Vec<FlagmakingElement>,

    pub(crate) fluorometer: Vec<Option<Fluorometer>>,

    pub(crate) fulsome: Vec<Option<i64>>,

    pub(crate) fuzzy: Vec<Fuzzy>,

    pub(crate) gardenwards: Vec<Gardenward>,

    pub(crate) generalissimo: Vec<Option<Generalissimo>>,

    pub(crate) habeas: Vec<Option<HashMap<String, i64>>>,

    pub(crate) hemicrystalline: Vec<Hemicrystalline>,

    pub(crate) hemocoele: Vec<HemocoeleElement>,

    pub(crate) hoister: Vec<Option<Hoister>>,

    pub(crate) hyperpiesis: Vec<Option<Hyperpiesi>>,

    pub(crate) hyppish: Vec<Option<Hyppish>>,

    pub(crate) idealizer: Vec<Idealizer>,

    pub(crate) incrustator: Vec<Incrustator>,

    pub(crate) intentiveness: Vec<Intentiveness>,

    pub(crate) interacinar: Interacinar,

    pub(crate) intercorrelation: Vec<Option<Vec<i64>>>,

    pub(crate) jacutinga: Vec<Jacutinga>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum CerographElement {
    CerographClass(CerographClass),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CerographClass {
    pub(crate) apotropaion: Option<serde_json::Value>,

    pub(crate) casuary: Option<serde_json::Value>,

    pub(crate) creaker: Option<serde_json::Value>,

    pub(crate) disqualification: Option<serde_json::Value>,

    pub(crate) imperatorious: Option<serde_json::Value>,

    pub(crate) impermeabilize: Option<serde_json::Value>,

    pub(crate) metastoma: Option<serde_json::Value>,

    pub(crate) noctidiurnal: Option<serde_json::Value>,

    pub(crate) nonreserve: Option<serde_json::Value>,

    pub(crate) ophthalmotonometry: Option<serde_json::Value>,

    pub(crate) pailful: Option<serde_json::Value>,

    pub(crate) pigfish: Option<serde_json::Value>,

    pub(crate) pongee: Option<serde_json::Value>,

    pub(crate) prosodical: Option<serde_json::Value>,

    pub(crate) scrofuloderm: Option<serde_json::Value>,

    pub(crate) storekeeping: Option<serde_json::Value>,

    pub(crate) therologist: Option<serde_json::Value>,

    #[serde(rename = "Tolowa")]
    pub(crate) tolowa: Option<serde_json::Value>,

    pub(crate) tradeful: Option<serde_json::Value>,

    pub(crate) unriveting: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ChemotherapeuticElement {
    ChemotherapeuticClass(ChemotherapeuticClass),

    Integer(i64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ChemotherapeuticClass {
    pub(crate) angioneurotic: Option<serde_json::Value>,

    pub(crate) availment: Option<serde_json::Value>,

    pub(crate) bladelet: Option<serde_json::Value>,

    pub(crate) catharticalness: Option<f64>,

    pub(crate) caulis: Option<serde_json::Value>,

    pub(crate) chalcus: Option<serde_json::Value>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) enteradenological: Option<serde_json::Value>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) imporosity: Option<serde_json::Value>,

    pub(crate) insistently: Option<serde_json::Value>,

    pub(crate) intraparietal: Option<serde_json::Value>,

    pub(crate) ivied: Option<serde_json::Value>,

    #[serde(rename = "Maureen")]
    pub(crate) maureen: Option<serde_json::Value>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) nostochine: Option<serde_json::Value>,

    pub(crate) nutcracker: Option<serde_json::Value>,

    pub(crate) ofttimes: Option<serde_json::Value>,

    pub(crate) phenocryst: Option<serde_json::Value>,

    pub(crate) precoincident: Option<serde_json::Value>,

    pub(crate) ramiferous: Option<serde_json::Value>,

    pub(crate) stagmometer: Option<serde_json::Value>,

    pub(crate) tetherball: Option<serde_json::Value>,

    pub(crate) unshy: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum CimeliaElement {
    CimeliaClass(CimeliaClass),

    IntegerArray(Vec<i64>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CimeliaClass {
    pub(crate) catharticalness: f64,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: i64,

    pub(crate) disdiapason: String,

    pub(crate) homocerc: bool,

    pub(crate) nonbookish: Option<serde_json::Value>,
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
    pub(crate) amidosulphonal: Option<serde_json::Value>,

    #[serde(rename = "Benny")]
    pub(crate) benny: Option<serde_json::Value>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) ensnare: Option<serde_json::Value>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) hybridizer: Option<serde_json::Value>,

    pub(crate) leastwise: Option<serde_json::Value>,

    pub(crate) lof: Option<serde_json::Value>,

    pub(crate) monkhood: Option<serde_json::Value>,

    #[serde(rename = "Netherlandish")]
    pub(crate) netherlandish: Option<serde_json::Value>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) peonism: Option<serde_json::Value>,

    #[serde(rename = "Phonelescope")]
    pub(crate) phonelescope: Option<serde_json::Value>,

    pub(crate) porphyrogeniture: Option<serde_json::Value>,

    pub(crate) preindemnify: Option<serde_json::Value>,

    pub(crate) rosal: Option<serde_json::Value>,

    pub(crate) scalenous: Option<serde_json::Value>,

    pub(crate) scopine: Option<serde_json::Value>,

    #[serde(rename = "Sedaceae")]
    pub(crate) sedaceae: Option<serde_json::Value>,

    pub(crate) suberinize: Option<serde_json::Value>,

    pub(crate) symbiot: Option<serde_json::Value>,

    pub(crate) tablefellow: Option<serde_json::Value>,

    pub(crate) unchargeable: Option<serde_json::Value>,
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
    pub(crate) ammonolytic: Option<serde_json::Value>,

    pub(crate) bushmaster: Option<serde_json::Value>,

    pub(crate) considering: Option<serde_json::Value>,

    pub(crate) consuetudinary: Option<serde_json::Value>,

    pub(crate) embarras: Option<serde_json::Value>,

    pub(crate) fineness: Option<serde_json::Value>,

    pub(crate) flaithship: Option<serde_json::Value>,

    #[serde(rename = "Flavia")]
    pub(crate) flavia: Option<serde_json::Value>,

    pub(crate) gruffly: Option<serde_json::Value>,

    #[serde(rename = "Hedychium")]
    pub(crate) hedychium: Option<serde_json::Value>,

    pub(crate) leadwort: Option<serde_json::Value>,

    pub(crate) overseriously: Option<serde_json::Value>,

    pub(crate) parabola: Option<serde_json::Value>,

    pub(crate) pectinatodenticulate: Option<serde_json::Value>,

    #[serde(rename = "Popean")]
    pub(crate) popean: Option<serde_json::Value>,

    pub(crate) pornocrat: Option<serde_json::Value>,

    pub(crate) quadrisect: Option<serde_json::Value>,

    pub(crate) seriality: Option<serde_json::Value>,

    pub(crate) vamphorn: Option<serde_json::Value>,

    pub(crate) wharp: Option<serde_json::Value>,
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
    pub(crate) bockerel: Option<serde_json::Value>,

    pub(crate) boulder: Option<serde_json::Value>,

    pub(crate) churrus: Option<serde_json::Value>,

    pub(crate) counterdigged: Option<serde_json::Value>,

    pub(crate) dialogite: Option<serde_json::Value>,

    pub(crate) digenic: Option<serde_json::Value>,

    pub(crate) dunbird: Option<serde_json::Value>,

    pub(crate) ergatogyne: Option<serde_json::Value>,

    pub(crate) fiendful: Option<serde_json::Value>,

    pub(crate) jackrod: Option<serde_json::Value>,

    #[serde(rename = "Jehovistic")]
    pub(crate) jehovistic: Option<serde_json::Value>,

    #[serde(rename = "Paninean")]
    pub(crate) paninean: Option<serde_json::Value>,

    pub(crate) panther: Option<serde_json::Value>,

    pub(crate) placentigerous: Option<serde_json::Value>,

    #[serde(rename = "Romney")]
    pub(crate) romney: Option<serde_json::Value>,

    pub(crate) sparm: Option<serde_json::Value>,

    pub(crate) tocsin: Option<serde_json::Value>,

    pub(crate) unnicked: Option<serde_json::Value>,

    pub(crate) unstavable: Option<serde_json::Value>,

    pub(crate) windfirm: Option<serde_json::Value>,
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
    pub(crate) amoreuxia: Option<serde_json::Value>,

    pub(crate) ani: Option<serde_json::Value>,

    pub(crate) bernicle: Option<serde_json::Value>,

    pub(crate) blackwasher: Option<serde_json::Value>,

    pub(crate) blowhard: Option<serde_json::Value>,

    pub(crate) broma: Option<serde_json::Value>,

    pub(crate) closecross: Option<serde_json::Value>,

    pub(crate) congregationalism: Option<serde_json::Value>,

    pub(crate) grayly: Option<serde_json::Value>,

    pub(crate) historically: Option<serde_json::Value>,

    pub(crate) hoast: Option<serde_json::Value>,

    pub(crate) irretentive: Option<serde_json::Value>,

    pub(crate) parcener: Option<serde_json::Value>,

    pub(crate) pedder: Option<serde_json::Value>,

    pub(crate) pseudoanatomic: Option<serde_json::Value>,

    pub(crate) rhizocarpian: Option<serde_json::Value>,

    pub(crate) samel: Option<serde_json::Value>,

    pub(crate) silker: Option<serde_json::Value>,

    pub(crate) subdentated: Option<serde_json::Value>,

    pub(crate) subobscure: Option<serde_json::Value>,
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
    pub(crate) comradely: Option<serde_json::Value>,

    pub(crate) diacanthous: Option<serde_json::Value>,

    pub(crate) feminineness: Option<serde_json::Value>,

    pub(crate) gossamered: Option<serde_json::Value>,

    #[serde(rename = "Hibernia")]
    pub(crate) hibernia: Option<serde_json::Value>,

    #[serde(rename = "Hibiscus")]
    pub(crate) hibiscus: Option<serde_json::Value>,

    #[serde(rename = "Lepidosauria")]
    pub(crate) lepidosauria: Option<serde_json::Value>,

    pub(crate) lollingly: Option<serde_json::Value>,

    pub(crate) manager: Option<serde_json::Value>,

    pub(crate) mechanic: Option<serde_json::Value>,

    pub(crate) overminuteness: Option<serde_json::Value>,

    pub(crate) papelonne: Option<serde_json::Value>,

    pub(crate) plebification: Option<serde_json::Value>,

    pub(crate) pugmiller: Option<serde_json::Value>,

    pub(crate) recoveror: Option<serde_json::Value>,

    pub(crate) spermatoblastic: Option<serde_json::Value>,

    #[serde(rename = "Syllidae")]
    pub(crate) syllidae: Option<serde_json::Value>,

    pub(crate) ungyved: Option<serde_json::Value>,

    pub(crate) whirlabout: Option<serde_json::Value>,

    pub(crate) woodenware: Option<serde_json::Value>,
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
    pub(crate) abranchian: Option<serde_json::Value>,

    pub(crate) aculeiform: Option<serde_json::Value>,

    pub(crate) adiaphoristic: Option<serde_json::Value>,

    pub(crate) adoptionism: Option<serde_json::Value>,

    #[serde(rename = "Anglic")]
    pub(crate) anglic: Option<serde_json::Value>,

    pub(crate) antrotomy: Option<serde_json::Value>,

    pub(crate) coerciveness: Option<serde_json::Value>,

    pub(crate) decorist: Option<serde_json::Value>,

    pub(crate) duckhood: Option<serde_json::Value>,

    #[serde(rename = "Heteromeri")]
    pub(crate) heteromeri: Option<serde_json::Value>,

    pub(crate) hypochnose: Option<serde_json::Value>,

    pub(crate) lochage: Option<serde_json::Value>,

    pub(crate) melee: Option<serde_json::Value>,

    pub(crate) nonconformitant: Option<serde_json::Value>,

    #[serde(rename = "Poinsettia")]
    pub(crate) poinsettia: Option<serde_json::Value>,

    pub(crate) putatively: Option<serde_json::Value>,

    pub(crate) semivolatile: Option<serde_json::Value>,

    pub(crate) soleas: Option<serde_json::Value>,

    pub(crate) unfastenable: Option<serde_json::Value>,

    pub(crate) unmillinered: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum FenkElement {
    FenkClass(FenkClass),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FenkClass {
    pub(crate) apoise: Option<serde_json::Value>,

    pub(crate) astronomize: Option<serde_json::Value>,

    pub(crate) cockhorse: Option<serde_json::Value>,

    pub(crate) copular: Option<serde_json::Value>,

    #[serde(rename = "Dagomba")]
    pub(crate) dagomba: Option<serde_json::Value>,

    pub(crate) draffy: Option<serde_json::Value>,

    pub(crate) foreigner: Option<serde_json::Value>,

    #[serde(rename = "Guyandot")]
    pub(crate) guyandot: Option<serde_json::Value>,

    pub(crate) neurogliosis: Option<serde_json::Value>,

    pub(crate) osmious: Option<serde_json::Value>,

    pub(crate) palpitate: Option<serde_json::Value>,

    pub(crate) rebukeable: Option<serde_json::Value>,

    #[serde(rename = "Reinwardtia")]
    pub(crate) reinwardtia: Option<serde_json::Value>,

    pub(crate) reservatory: Option<serde_json::Value>,

    pub(crate) scalt: Option<serde_json::Value>,

    pub(crate) scripturalize: Option<serde_json::Value>,

    pub(crate) tintometer: Option<serde_json::Value>,

    #[serde(rename = "Tritoness")]
    pub(crate) tritoness: Option<serde_json::Value>,

    pub(crate) undergrade: Option<serde_json::Value>,

    pub(crate) undermountain: Option<serde_json::Value>,
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
    pub(crate) albarco: Option<serde_json::Value>,

    #[serde(rename = "Bunodonta")]
    pub(crate) bunodonta: Option<serde_json::Value>,

    pub(crate) hornify: Option<serde_json::Value>,

    #[serde(rename = "Hydrocorisae")]
    pub(crate) hydrocorisae: Option<serde_json::Value>,

    pub(crate) hypoglossus: Option<serde_json::Value>,

    pub(crate) inexpiably: Option<serde_json::Value>,

    pub(crate) ingratitude: Option<serde_json::Value>,

    pub(crate) ladyfly: Option<serde_json::Value>,

    pub(crate) medicament: Option<serde_json::Value>,

    pub(crate) monogrammatic: Option<serde_json::Value>,

    pub(crate) nobbut: Option<serde_json::Value>,

    #[serde(rename = "Notacanthidae")]
    pub(crate) notacanthidae: Option<serde_json::Value>,

    pub(crate) polyplacophore: Option<serde_json::Value>,

    pub(crate) proexercise: Option<serde_json::Value>,

    pub(crate) protoplast: Option<serde_json::Value>,

    pub(crate) puzzling: Option<serde_json::Value>,

    pub(crate) splanchnoskeleton: Option<serde_json::Value>,

    pub(crate) unloveliness: Option<serde_json::Value>,

    pub(crate) unquarantined: Option<serde_json::Value>,

    pub(crate) unrenounceable: Option<serde_json::Value>,
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
    pub(crate) acrogamy: Option<serde_json::Value>,

    pub(crate) amelification: Option<serde_json::Value>,

    pub(crate) autobiographic: Option<serde_json::Value>,

    pub(crate) berat: Option<serde_json::Value>,

    pub(crate) catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    pub(crate) chirotherium: Option<i64>,

    pub(crate) disdiapason: Option<String>,

    pub(crate) disproportionably: Option<serde_json::Value>,

    pub(crate) erythrite: Option<serde_json::Value>,

    pub(crate) graphic: Option<serde_json::Value>,

    pub(crate) hepatological: Option<serde_json::Value>,

    pub(crate) homocerc: Option<bool>,

    pub(crate) incommensurably: Option<serde_json::Value>,

    pub(crate) misaffirm: Option<serde_json::Value>,

    pub(crate) nonbookish: Option<serde_json::Value>,

    pub(crate) pocketbook: Option<serde_json::Value>,

    pub(crate) sclerometric: Option<serde_json::Value>,

    pub(crate) stambouline: Option<serde_json::Value>,

    pub(crate) stickpin: Option<serde_json::Value>,

    pub(crate) tubulure: Option<serde_json::Value>,

    pub(crate) undelated: Option<serde_json::Value>,

    pub(crate) unsalt: Option<serde_json::Value>,

    pub(crate) untutelar: Option<serde_json::Value>,

    pub(crate) vagrant: Option<serde_json::Value>,

    #[serde(rename = "Walt")]
    pub(crate) walt: Option<serde_json::Value>,
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
    pub(crate) assapan: f64,

    pub(crate) benefactorship: bool,

    pub(crate) triseriatim: String,

    pub(crate) tubbing: i64,

    pub(crate) untrimmed: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Jacutinga {
    IntegerArray(Vec<i64>),

    UnionMap(HashMap<String, Option<i64>>),
}
