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
    pub coordinates: Vec<f64>,

    #[serde(rename = "type")]
    pub geometry_type: GeometryType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum GeometryType {
    Point,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum GeometryName {
    Geom,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FeatureProperties {
    pub division: String,

    pub fax: f64,

    pub fire_ban_r: Option<FireBanR>,

    pub latitude: f64,

    pub local_govt: String,

    pub longitude: f64,

    pub no: Option<String>,

    pub phone: f64,

    pub postcode: i64,

    #[serde(rename = "type")]
    pub properties_type: Option<PropertiesType>,

    pub psa: String,

    pub region: Region,

    pub station: String,

    pub street: String,

    pub suburb: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum FireBanR {
    #[serde(rename = "North Central")]
    NorthCentral,

    Central,

    #[serde(rename = "South West")]
    SouthWest,

    Wimmera,

    #[serde(rename = "Northern Country")]
    NorthernCountry,

    #[serde(rename = "East Gippsland")]
    EastGippsland,

    #[serde(rename = "North East")]
    NorthEast,

    Mallee,

    #[serde(rename = "West &South Gippsland")]
    WestSouthGippsland,

    Ballarat,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum PropertiesType {
    #[serde(rename = "STREET")]
    Street,

    #[serde(rename = "AVENUE")]
    Avenue,

    #[serde(rename = "ROAD")]
    Road,

    #[serde(rename = "HIGHWAY")]
    Highway,

    #[serde(rename = "BOULEVARD")]
    Boulevard,

    #[serde(rename = "COURT")]
    Court,

    #[serde(rename = "WAY")]
    Way,

    #[serde(rename = "DRIVE")]
    Drive,

    #[serde(rename = "SOUTH")]
    South,

    #[serde(rename = "HILL")]
    Hill,

    #[serde(rename = "LANE")]
    Lane,

    #[serde(rename = "CLOSE")]
    Close,

    #[serde(rename = "PARADE")]
    Parade,

    #[serde(rename = "Road")]
    TypeRoad,

    #[serde(rename = "PLACE")]
    Place,

    #[serde(rename = "RD")]
    Rd,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Region {
    Eastern,

    #[serde(rename = "Northern Metro")]
    NorthernMetro,

    Western,

    #[serde(rename = "Southern Metro")]
    SouthernMetro,
}
