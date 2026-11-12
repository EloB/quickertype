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
    pub bbox: Vec<f64>,

    pub features: Vec<Feature>,

    pub metadata: Metadata,

    #[serde(rename = "type")]
    pub top_level_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Feature {
    #[serde(rename = "type")]
    pub feature_type: FeatureType,

    pub geometry: Geometry,

    pub id: String,

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
#[serde(rename_all = "camelCase")]
pub struct Properties {
    pub alert: Option<serde_json::Value>,

    pub cdi: Option<serde_json::Value>,

    pub code: String,

    pub detail: String,

    pub dmin: Option<f64>,

    pub felt: Option<serde_json::Value>,

    pub gap: Option<i64>,

    pub ids: String,

    pub mag: f64,

    pub mag_type: MagType,

    pub mmi: Option<serde_json::Value>,

    pub net: String,

    pub nst: Option<i64>,

    pub place: String,

    #[serde(rename = "type")]
    pub properties_type: PropertiesType,

    pub rms: f64,

    pub sig: i64,

    pub sources: String,

    pub status: Status,

    pub time: i64,

    pub title: String,

    pub tsunami: i64,

    pub types: String,

    pub tz: i64,

    pub updated: i64,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum MagType {
    Md,

    Ml,

    Mb,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum PropertiesType {
    Earthquake,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Status {
    Automatic,

    Reviewed,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Metadata {
    pub api: String,

    pub count: i64,

    pub generated: i64,

    pub status: i64,

    pub title: String,

    pub url: String,
}
