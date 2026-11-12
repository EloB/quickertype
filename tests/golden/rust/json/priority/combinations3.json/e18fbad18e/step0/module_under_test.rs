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
    juror: Vec<JurorElement>,

    kongoni: Vec<Kongoni>,

    ladronism: Vec<LadronismElement>,

    landlubberly: Vec<LandlubberlyElement>,

    listener: Vec<Listener>,

    lupus: Vec<LupusElement>,

    maslin: Vec<Maslin>,

    monazite: Vec<MonaziteElement>,

    monoliteral: Vec<Monoliteral>,

    monotheistically: Vec<MonotheisticallyElement>,

    montage: Vec<Montage>,

    moralness: Vec<Option<Moralness>>,

    mowra: Vec<Option<MonaziteClass>>,

    mulishly: Vec<Option<Mulishly>>,

    myoscope: Vec<Myoscope>,

    nach: Vec<Option<Vec<Option<i64>>>>,

    neuromastic: Vec<Neuromastic>,

    noncontributing: Vec<Noncontributing>,

    nonnervous: Vec<Nonnervous>,

    nonvaluation: Vec<Nonvaluation>,

    occupationalist: Vec<Option<OccupationalistElement>>,

    outrival: Vec<Option<OutrivalElement>>,

    paleographically: Vec<Paleographically>,

    pamphletwise: Vec<Pamphletwise>,

    pediatrics: Vec<Option<Pediatric>>,

    perceptive: Vec<bool>,

    piaculum: Vec<PiaculumElement>,

    piccadilly: Vec<Option<Piccadilly>>,

    piffler: Vec<Piffler>,

    pithful: Vec<Option<Pithful>>,

    placuntitis: Vec<Placuntiti>,

    plectopterous: Vec<Plectopterous>,

    pneumocele: Vec<Option<Pneumocele>>,

    poliorcetic: Vec<Poliorcetic>,

    poormaster: Vec<Option<Poormaster>>,

    potwhisky: Vec<Option<PotwhiskyElement>>,

    practicalizer: Vec<Practicalizer>,

    prefreshman: Vec<PrefreshmanElement>,

    prehensility: Vec<Prehensility>,

    prevoidance: Vec<Prevoidance>,

    probant: Vec<HashMap<String, Option<i64>>>,

    protext: Vec<Protext>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum JurorElement {
    Bool(bool),

    JurorClass(JurorClass),
}

#[derive(Serialize, Deserialize)]
pub struct JurorClass {
    adipsy: Option<serde_json::Value>,

    auxiliator: Option<serde_json::Value>,

    benda: Option<serde_json::Value>,

    benjamin: Option<serde_json::Value>,

    brandling: Option<serde_json::Value>,

    epicurishly: Option<serde_json::Value>,

    eremochaetous: Option<serde_json::Value>,

    marten: Option<serde_json::Value>,

    monocline: Option<serde_json::Value>,

    #[serde(rename = "Olea")]
    olea: Option<serde_json::Value>,

    palgat: Option<serde_json::Value>,

    pennyworth: Option<serde_json::Value>,

    pioury: Option<serde_json::Value>,

    pragmatistic: Option<serde_json::Value>,

    stylelessness: Option<serde_json::Value>,

    systematical: Option<serde_json::Value>,

    thready: Option<serde_json::Value>,

    uncontemporary: Option<serde_json::Value>,

    uncouched: Option<serde_json::Value>,

    uninhabitedness: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Kongoni {
    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum LadronismElement {
    Double(f64),

    LadronismClass(LadronismClass),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
pub struct LadronismClass {
    acclaimer: Option<serde_json::Value>,

    achree: Option<serde_json::Value>,

    base: Option<serde_json::Value>,

    conundrumize: Option<serde_json::Value>,

    degerminator: Option<serde_json::Value>,

    describable: Option<serde_json::Value>,

    exasperatedly: Option<serde_json::Value>,

    heroine: Option<serde_json::Value>,

    indazin: Option<serde_json::Value>,

    luteous: Option<serde_json::Value>,

    papular: Option<serde_json::Value>,

    pritch: Option<serde_json::Value>,

    #[serde(rename = "Prodenia")]
    prodenia: Option<serde_json::Value>,

    seege: Option<serde_json::Value>,

    shopgirl: Option<serde_json::Value>,

    tragedietta: Option<serde_json::Value>,

    unsparse: Option<serde_json::Value>,

    uplook: Option<serde_json::Value>,

    vermiformis: Option<serde_json::Value>,

    whafabout: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum LandlubberlyElement {
    Bool(bool),

    Integer(i64),

    LandlubberlyClass(LandlubberlyClass),
}

#[derive(Serialize, Deserialize)]
pub struct LandlubberlyClass {
    acropoleis: Option<serde_json::Value>,

    aminate: Option<serde_json::Value>,

    #[serde(rename = "Amyraldism")]
    amyraldism: Option<serde_json::Value>,

    bipenniform: Option<serde_json::Value>,

    bugre: Option<serde_json::Value>,

    calycule: Option<serde_json::Value>,

    caoutchouc: Option<serde_json::Value>,

    disprover: Option<serde_json::Value>,

    fitroot: Option<serde_json::Value>,

    fulgently: Option<serde_json::Value>,

    kickup: Option<serde_json::Value>,

    laevoversion: Option<serde_json::Value>,

    moter: Option<serde_json::Value>,

    objectivity: Option<serde_json::Value>,

    posterity: Option<serde_json::Value>,

    postnuptial: Option<serde_json::Value>,

    precedentary: Option<serde_json::Value>,

    saddling: Option<serde_json::Value>,

    subcurrent: Option<serde_json::Value>,

    unrecriminative: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Listener {
    Integer(i64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum LupusElement {
    Integer(i64),

    LupusClass(LupusClass),
}

#[derive(Serialize, Deserialize)]
pub struct LupusClass {
    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    #[serde(rename = "Chlorioninae")]
    chlorioninae: Option<i64>,

    #[serde(rename = "Corvinae")]
    corvinae: Option<i64>,

    #[serde(rename = "Crassina")]
    crassina: Option<i64>,

    disdiapason: Option<String>,

    exiguity: Option<i64>,

    farcist: Option<i64>,

    holographical: Option<i64>,

    homocerc: Option<bool>,

    ichthyophagan: Option<i64>,

    implacable: Option<i64>,

    nonbookish: Option<serde_json::Value>,

    outshiner: Option<i64>,

    overweather: Option<i64>,

    protonegroid: Option<i64>,

    shallowish: Option<i64>,

    snoke: Option<i64>,

    snout: Option<i64>,

    surveillance: Option<i64>,

    threshingtime: Option<i64>,

    #[serde(rename = "Thysanocarpus")]
    thysanocarpus: Option<i64>,

    unsignificantly: Option<i64>,

    unsnap: Option<i64>,

    vendible: Option<i64>,
}

#[derive(Serialize, Deserialize)]
pub struct Maslin {
    #[serde(rename = "Alicant")]
    alicant: Option<i64>,

    antiatonement: Option<serde_json::Value>,

    anticorrosive: Option<i64>,

    aphidozer: Option<serde_json::Value>,

    #[serde(rename = "Bakuninist")]
    bakuninist: Option<serde_json::Value>,

    be: Option<i64>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    chub: Option<i64>,

    cuprosilicon: Option<i64>,

    curtailedly: Option<i64>,

    dellenite: Option<i64>,

    #[serde(rename = "Dimitry")]
    dimitry: Option<i64>,

    disdiapason: Option<String>,

    edifying: Option<serde_json::Value>,

    ethmoiditis: Option<i64>,

    gastralgy: Option<serde_json::Value>,

    goatherd: Option<i64>,

    hammerdress: Option<i64>,

    hangfire: Option<serde_json::Value>,

    homocerc: Option<bool>,

    lacunosity: Option<i64>,

    longiloquence: Option<serde_json::Value>,

    mameliere: Option<i64>,

    motherless: Option<serde_json::Value>,

    nonbookish: Option<serde_json::Value>,

    noncorrodible: Option<serde_json::Value>,

    nonsensicality: Option<serde_json::Value>,

    oafishly: Option<i64>,

    pfund: Option<serde_json::Value>,

    preadvisory: Option<serde_json::Value>,

    retroflexed: Option<serde_json::Value>,

    saccharulmic: Option<i64>,

    scowlful: Option<i64>,

    secluded: Option<serde_json::Value>,

    slackage: Option<serde_json::Value>,

    sphaeridial: Option<i64>,

    spondulics: Option<serde_json::Value>,

    subsecive: Option<i64>,

    swellmobsman: Option<serde_json::Value>,

    trachyglossate: Option<i64>,

    trialogue: Option<serde_json::Value>,

    unassuaged: Option<i64>,

    ungross: Option<serde_json::Value>,

    unjudiciously: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum MonaziteElement {
    Double(f64),

    MonaziteClass(MonaziteClass),
}

#[derive(Serialize, Deserialize)]
pub struct MonaziteClass {
    catharticalness: f64,

    #[serde(rename = "Chirotherium")]
    chirotherium: i64,

    disdiapason: String,

    homocerc: bool,

    nonbookish: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Monoliteral {
    Bool(bool),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum MonotheisticallyElement {
    MonotheisticallyClass(MonotheisticallyClass),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
pub struct MonotheisticallyClass {
    blaspheme: Option<serde_json::Value>,

    catharticalness: Option<f64>,

    celiosalpingectomy: Option<serde_json::Value>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    consummativeness: Option<serde_json::Value>,

    disdiapason: Option<String>,

    egestive: Option<serde_json::Value>,

    enchylema: Option<serde_json::Value>,

    gasconade: Option<serde_json::Value>,

    holidayer: Option<serde_json::Value>,

    homocerc: Option<bool>,

    intuitionalism: Option<serde_json::Value>,

    lophiostomate: Option<serde_json::Value>,

    nonbookish: Option<serde_json::Value>,

    nonvolition: Option<serde_json::Value>,

    palatableness: Option<serde_json::Value>,

    pimpery: Option<serde_json::Value>,

    previolation: Option<serde_json::Value>,

    reconveyance: Option<serde_json::Value>,

    registership: Option<serde_json::Value>,

    rhyacolite: Option<serde_json::Value>,

    smithereens: Option<serde_json::Value>,

    superedification: Option<serde_json::Value>,

    trust: Option<serde_json::Value>,

    whitestone: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Montage {
    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Moralness {
    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Mulishly {
    Double(f64),

    IntegerArray(Vec<i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Myoscope {
    Bool(bool),

    Integer(i64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Neuromastic {
    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
pub struct Noncontributing {
    estevin: String,

    jolterhead: f64,

    sauternes: i64,

    sparsely: bool,

    unrequested: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Nonnervous {
    Bool(bool),

    Integer(i64),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Nonvaluation {
    Bool(bool),

    Double(f64),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum OccupationalistElement {
    NullArray(Vec<Option<serde_json::Value>>),

    OccupationalistClass(OccupationalistClass),
}

#[derive(Serialize, Deserialize)]
pub struct OccupationalistClass {
    beholdable: Option<serde_json::Value>,

    brotuliform: Option<serde_json::Value>,

    #[serde(rename = "Chimakum")]
    chimakum: Option<serde_json::Value>,

    doodler: Option<serde_json::Value>,

    emulsin: Option<serde_json::Value>,

    #[serde(rename = "Fin")]
    fin: Option<serde_json::Value>,

    flourishing: Option<serde_json::Value>,

    flueless: Option<serde_json::Value>,

    furtively: Option<serde_json::Value>,

    gritter: Option<serde_json::Value>,

    interwish: Option<serde_json::Value>,

    monoxylic: Option<serde_json::Value>,

    myristic: Option<serde_json::Value>,

    nightwear: Option<serde_json::Value>,

    peruser: Option<serde_json::Value>,

    theoastrological: Option<serde_json::Value>,

    thumby: Option<serde_json::Value>,

    tingitid: Option<serde_json::Value>,

    trailless: Option<serde_json::Value>,

    unpocketed: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum OutrivalElement {
    Double(f64),

    OutrivalClass(OutrivalClass),
}

#[derive(Serialize, Deserialize)]
pub struct OutrivalClass {
    adroitly: Option<serde_json::Value>,

    bridehood: Option<serde_json::Value>,

    #[serde(rename = "Castoroides")]
    castoroides: Option<serde_json::Value>,

    #[serde(rename = "Czechoslovak")]
    czechoslovak: Option<serde_json::Value>,

    diagenesis: Option<serde_json::Value>,

    dihexahedron: Option<serde_json::Value>,

    dopester: Option<serde_json::Value>,

    eumerism: Option<serde_json::Value>,

    flyness: Option<serde_json::Value>,

    fouler: Option<serde_json::Value>,

    laudanosine: Option<serde_json::Value>,

    #[serde(rename = "Lingulidae")]
    lingulidae: Option<serde_json::Value>,

    minutary: Option<serde_json::Value>,

    mitra: Option<serde_json::Value>,

    opisthorchiasis: Option<serde_json::Value>,

    pensively: Option<serde_json::Value>,

    pubigerous: Option<serde_json::Value>,

    rebellious: Option<serde_json::Value>,

    recodify: Option<serde_json::Value>,

    unpaced: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Paleographically {
    Double(f64),

    UnionMap(HashMap<String, Option<i64>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Pamphletwise {
    Integer(i64),

    IntegerMap(HashMap<String, i64>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Pediatric {
    Bool(bool),

    Double(f64),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum PiaculumElement {
    Double(f64),

    PiaculumClass(PiaculumClass),
}

#[derive(Serialize, Deserialize)]
pub struct PiaculumClass {
    alada: Option<i64>,

    amphistomous: Option<i64>,

    boysenberry: Option<i64>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    decardinalize: Option<i64>,

    discouragement: Option<i64>,

    disdiapason: Option<String>,

    doitrified: Option<i64>,

    hexaspermous: Option<i64>,

    homocerc: Option<bool>,

    insinking: Option<i64>,

    loathfulness: Option<i64>,

    miasmatical: Option<i64>,

    neurofibril: Option<i64>,

    nonbookish: Option<serde_json::Value>,

    phonendoscope: Option<i64>,

    pilferment: Option<i64>,

    predismissory: Option<i64>,

    preinscription: Option<i64>,

    quotative: Option<i64>,

    sienna: Option<i64>,

    thorax: Option<i64>,

    yachting: Option<i64>,

    #[serde(rename = "Zipper")]
    zipper: Option<i64>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Piccadilly {
    Double(f64),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Piffler {
    MonaziteClass(MonaziteClass),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Pithful {
    Bool(bool),

    Integer(i64),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Placuntiti {
    Integer(i64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Plectopterous {
    Double(f64),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
pub struct Pneumocele {
    #[serde(rename = "Carbonarism")]
    carbonarism: Option<serde_json::Value>,

    catharticalness: Option<f64>,

    #[serde(rename = "Chirotherium")]
    chirotherium: Option<i64>,

    cineolic: Option<serde_json::Value>,

    cobbly: Option<serde_json::Value>,

    conchyliferous: Option<serde_json::Value>,

    congregation: Option<serde_json::Value>,

    disdiapason: Option<String>,

    enterotomy: Option<serde_json::Value>,

    entophytal: Option<serde_json::Value>,

    fewtrils: Option<serde_json::Value>,

    herem: Option<serde_json::Value>,

    homocerc: Option<bool>,

    #[serde(rename = "Koniga")]
    koniga: Option<serde_json::Value>,

    meticulosity: Option<serde_json::Value>,

    #[serde(rename = "Micky")]
    micky: Option<serde_json::Value>,

    mismarriage: Option<serde_json::Value>,

    neurotrophic: Option<serde_json::Value>,

    nonbookish: Option<serde_json::Value>,

    persuasively: Option<serde_json::Value>,

    replaceable: Option<serde_json::Value>,

    silex: Option<serde_json::Value>,

    taillight: Option<serde_json::Value>,

    unjealous: Option<serde_json::Value>,

    visitorial: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Poliorcetic {
    Bool(bool),

    MonaziteClass(MonaziteClass),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Poormaster {
    IntegerArray(Vec<i64>),

    IntegerMap(HashMap<String, i64>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum PotwhiskyElement {
    Integer(i64),

    PotwhiskyClass(PotwhiskyClass),
}

#[derive(Serialize, Deserialize)]
pub struct PotwhiskyClass {
    arciform: Option<serde_json::Value>,

    cresolin: Option<serde_json::Value>,

    disheartener: Option<serde_json::Value>,

    disproportionable: Option<serde_json::Value>,

    #[serde(rename = "Euchorda")]
    euchorda: Option<serde_json::Value>,

    ferryway: Option<serde_json::Value>,

    filamentiferous: Option<serde_json::Value>,

    flemish: Option<serde_json::Value>,

    forgainst: Option<serde_json::Value>,

    grainering: Option<serde_json::Value>,

    irrevoluble: Option<serde_json::Value>,

    kindredship: Option<serde_json::Value>,

    pinguitudinous: Option<serde_json::Value>,

    simpletonic: Option<serde_json::Value>,

    singsong: Option<serde_json::Value>,

    submergement: Option<serde_json::Value>,

    supraoesophagal: Option<serde_json::Value>,

    thrashel: Option<serde_json::Value>,

    tyremesis: Option<serde_json::Value>,

    #[serde(rename = "Yoruba")]
    yoruba: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Practicalizer {
    MonaziteClass(MonaziteClass),

    NullArray(Vec<Option<serde_json::Value>>),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum PrefreshmanElement {
    NullArray(Vec<Option<serde_json::Value>>),

    PrefreshmanClass(PrefreshmanClass),

    PurpleString(String),
}

#[derive(Serialize, Deserialize)]
pub struct PrefreshmanClass {
    azorubine: Option<serde_json::Value>,

    choroiditis: Option<serde_json::Value>,

    coagulatory: Option<serde_json::Value>,

    cyclorama: Option<serde_json::Value>,

    #[serde(rename = "Dolphus")]
    dolphus: Option<serde_json::Value>,

    duckhearted: Option<serde_json::Value>,

    #[serde(rename = "Ficus")]
    ficus: Option<serde_json::Value>,

    #[serde(rename = "Gemaric")]
    gemaric: Option<serde_json::Value>,

    jugation: Option<serde_json::Value>,

    myoliposis: Option<serde_json::Value>,

    nonnomination: Option<serde_json::Value>,

    palay: Option<serde_json::Value>,

    pentactinal: Option<serde_json::Value>,

    #[serde(rename = "Phaet")]
    phaet: Option<serde_json::Value>,

    piquant: Option<serde_json::Value>,

    registration: Option<serde_json::Value>,

    remancipation: Option<serde_json::Value>,

    scutatiform: Option<serde_json::Value>,

    theodolite: Option<serde_json::Value>,

    underward: Option<serde_json::Value>,
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Prehensility {
    Bool(bool),

    MonaziteClass(MonaziteClass),

    NullArray(Vec<Option<serde_json::Value>>),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Prevoidance {
    Integer(i64),

    IntegerArray(Vec<i64>),

    MonaziteClass(MonaziteClass),
}

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum Protext {
    Bool(bool),

    IntegerArray(Vec<i64>),

    MonaziteClass(MonaziteClass),
}
