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

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    pub features: Vec<Feature>,

    pub name: String,

    #[serde(rename = "type")]
    pub top_level_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Feature {
    #[serde(rename = "type")]
    pub feature_type: FeatureType,

    pub geometry: Geometry,

    pub properties: Properties,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum FeatureType {
    Feature,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Geometry {
    pub coordinates: Vec<f64>,

    #[serde(rename = "type")]
    pub geometry_type: GeometryType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum GeometryType {
    Point,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Properties {
    pub area: String,

    #[serde(rename = "Central Asset ID")]
    pub central_asset_id: String,

    pub class: Class,

    #[serde(rename = "Feature Location")]
    pub feature_location: String,

    #[serde(rename = "lat")]
    pub lat: String,

    #[serde(rename = "long")]
    pub long: String,

    #[serde(rename = "Maintaining Authority")]
    pub maintaining_authority: MaintainingAuthority,

    pub number: String,

    #[serde(rename = "Site Name")]
    pub site_name: String,

    pub ward: Ward,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Class {
    #[serde(rename = "No Code Allocated")]
    NoCodeAllocated,

    #[serde(rename = "OS-District")]
    OsDistrict,

    #[serde(rename = "OS-Neighbourhood")]
    OsNeighbourhood,

    #[serde(rename = "OS-Regional")]
    OsRegional,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum MaintainingAuthority {
    #[serde(rename = "City of Ballarat")]
    CityOfBallarat,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Ward {
    South,

    North,

    Central,
}
