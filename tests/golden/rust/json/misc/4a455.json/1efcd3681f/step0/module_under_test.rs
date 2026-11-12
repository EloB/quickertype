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
#[serde(rename_all = "camelCase")]
pub struct TopLevel {
    pub crs: Crs,

    pub features: Vec<Feature>,

    #[serde(rename = "type")]
    pub top_level_type: String,

    pub total_features: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Crs {
    #[serde(rename = "type")]
    pub crs_type: String,

    pub properties: CrsProperties,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CrsProperties {
    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Feature {
    #[serde(rename = "type")]
    pub feature_type: FeatureType,

    pub geometry: Geometry,

    pub geometry_name: GeometryName,

    pub id: String,

    pub properties: FeatureProperties,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum FeatureType {
    Feature,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Geometry {
    pub coordinates: Vec<Vec<f64>>,

    #[serde(rename = "type")]
    pub geometry_type: GeometryType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum GeometryType {
    #[serde(rename = "MultiPoint")]
    MultiPoint,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum GeometryName {
    Geom,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FeatureProperties {
    pub facebookaccount: String,

    pub frequencyfinderurl: String,

    pub name: String,

    pub siteurl: String,

    pub streetaddress: String,

    pub twitteraccount: String,
}
