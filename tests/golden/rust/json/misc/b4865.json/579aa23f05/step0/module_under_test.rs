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
    #[serde(rename = ":@computed_region_cbhk_fwbd")]
    pub computed_region_cbhk_fwbd: Option<String>,

    #[serde(rename = ":@computed_region_nnqa_25f4")]
    pub computed_region_nnqa_25_f4: Option<String>,

    pub fall: Fall,

    pub geolocation: Option<Geolocation>,

    pub id: String,

    pub mass: Option<String>,

    pub name: String,

    pub nametype: Nametype,

    pub recclass: String,

    pub reclat: Option<String>,

    pub reclong: Option<String>,

    pub year: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Fall {
    Fell,

    Found,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Geolocation {
    pub coordinates: Vec<f64>,

    #[serde(rename = "type")]
    pub geolocation_type: Type,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Type {
    Point,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Nametype {
    Valid,
}
