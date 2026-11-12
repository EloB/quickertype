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
    pub coordinates: Vec<Vec<Vec<Vec<f64>>>>,

    #[serde(rename = "type")]
    pub geometry_type: GeometryType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum GeometryType {
    #[serde(rename = "MultiPolygon")]
    MultiPolygon,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum GeometryName {
    Geom,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FeatureProperties {
    pub add_improv: Option<AddImprov>,

    #[serde(rename = "area_")]
    pub area: f64,

    pub asset_numb: String,

    pub comments: Option<String>,

    pub condition: i64,

    pub constructi: Option<String>,

    pub createdate: Option<serde_json::Value>,

    pub createuser: Option<serde_json::Value>,

    pub disposal_d: Option<serde_json::Value>,

    pub documents: String,

    pub drawing_nu: Option<String>,

    pub file_numbe: Option<String>,

    pub folder_num: Option<String>,

    pub funding_ba: Option<FundingBa>,

    pub historic_c: i64,

    pub inspection: String,

    pub inspectors: Option<serde_json::Value>,

    pub last_updat: Option<serde_json::Value>,

    pub level_accu: Option<LevelAccu>,

    pub material: Material,

    pub mi_prinx: i64,

    pub mi_symbolo: MiSymbolo,

    pub number_lan: i64,

    pub owner: Option<String>,

    pub positional: Option<LevelAccu>,

    pub project_nu: Option<String>,

    #[serde(rename = "type")]
    pub properties_type: Option<PropertiesType>,

    pub rec_id: i64,

    pub record_cre: Option<String>,

    pub shape_area: f64,

    pub shape_leng: f64,

    pub status: Status,

    pub survey_num: Option<serde_json::Value>,

    pub toe_rl: f64,

    pub top_rl: f64,

    pub update_dat: String,

    pub updatedate: Option<serde_json::Value>,

    pub updateuser: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum AddImprov {
    F,

    #[serde(rename = "F")]
    AddImprovF,

    T,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum FundingBa {
    #[serde(rename = "Non GCCC")]
    NonGccc,

    Capex,

    Initial,

    Contribute,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum LevelAccu {
    #[serde(rename = "GPS Corrected 1.0M")]
    GpsCorrected10M,

    #[serde(rename = "APPROX")]
    Approx,

    #[serde(rename = "GPS COrrected 1.0M")]
    GpsCOrrected10M,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Material {
    Gravel,

    Concrete,

    Bitumen,

    #[serde(rename = "Interlock Conc Block")]
    InterlockConcBlock,

    Other,

    Earth,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum MiSymbolo {
    #[serde(rename = "Pen (2, 2, 65535) Brush (1, 0, 16777215)")]
    Pen2265535Brush1016777215,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum PropertiesType {
    #[serde(rename = "Boat Ramp")]
    BoatRamp,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Status {
    #[serde(rename = "CURRENT")]
    Current,
}
