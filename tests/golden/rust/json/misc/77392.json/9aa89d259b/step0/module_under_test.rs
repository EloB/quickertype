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

pub type TopLevel = Vec<TopLevelElement>;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelElement {
    pub designation: String,

    pub discovery_date: String,

    pub h_mag: Option<String>,

    pub i_deg: String,

    pub moid_au: String,

    pub orbit_class: OrbitClass,

    pub period_yr: Option<String>,

    pub pha: Pha,

    pub q_au_1: String,

    pub q_au_2: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum OrbitClass {
    Apollo,

    Amor,

    Aten,

    Comet,

    #[serde(rename = "Jupiter-family Comet")]
    JupiterFamilyComet,

    #[serde(rename = "Halley-type Comet*")]
    HalleyTypeComet,

    #[serde(rename = "Parabolic Comet")]
    ParabolicComet,

    #[serde(rename = "Jupiter-family Comet*")]
    OrbitClassJupiterFamilyComet,

    #[serde(rename = "Encke-type Comet")]
    EnckeTypeComet,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Pha {
    Y,

    N,

    #[serde(rename = "n/a")]
    NA,
}
