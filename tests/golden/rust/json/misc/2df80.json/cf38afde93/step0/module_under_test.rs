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

pub type TopLevel = Vec<TopLevelUnion>;

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum TopLevelUnion {
    FluffyTopLevel(FluffyTopLevel),

    PurpleTopLevelArray(Vec<PurpleTopLevel>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PurpleTopLevel {
    pub adminregion: Adminregion,

    pub capital_city: String,

    pub id: String,

    pub income_level: Adminregion,

    pub iso2_code: String,

    pub latitude: String,

    pub lending_type: Adminregion,

    pub longitude: String,

    pub name: String,

    pub region: Adminregion,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Adminregion {
    pub id: Id,

    pub value: Value,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Id {
    #[serde(rename = "")]
    Empty,

    #[serde(rename = "SAS")]
    Sas,

    #[serde(rename = "SSA")]
    Ssa,

    #[serde(rename = "ECA")]
    Eca,

    #[serde(rename = "LAC")]
    Lac,

    #[serde(rename = "EAP")]
    Eap,

    #[serde(rename = "MNA")]
    Mna,

    #[serde(rename = "HIC")]
    Hic,

    #[serde(rename = "LIC")]
    Lic,

    #[serde(rename = "NA")]
    Na,

    #[serde(rename = "LMC")]
    Lmc,

    #[serde(rename = "UMC")]
    Umc,

    #[serde(rename = "LNX")]
    Lnx,

    #[serde(rename = "IDX")]
    Idx,

    #[serde(rename = "IBD")]
    Ibd,

    #[serde(rename = "IDB")]
    Idb,

    #[serde(rename = "LCN")]
    Lcn,

    #[serde(rename = "SSF")]
    Ssf,

    #[serde(rename = "ECS")]
    Ecs,

    #[serde(rename = "MEA")]
    Mea,

    #[serde(rename = "EAS")]
    Eas,

    #[serde(rename = "NAC")]
    Nac,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Value {
    #[serde(rename = "")]
    Empty,

    #[serde(rename = "South Asia")]
    SouthAsia,

    #[serde(rename = "Sub-Saharan Africa (excluding high income)")]
    SubSaharanAfricaExcludingHighIncome,

    #[serde(rename = "Europe & Central Asia (excluding high income)")]
    EuropeCentralAsiaExcludingHighIncome,

    #[serde(rename = "Latin America & Caribbean (excluding high income)")]
    LatinAmericaCaribbeanExcludingHighIncome,

    #[serde(rename = "East Asia & Pacific (excluding high income)")]
    EastAsiaPacificExcludingHighIncome,

    #[serde(rename = "Middle East & North Africa (excluding high income)")]
    MiddleEastNorthAfricaExcludingHighIncome,

    #[serde(rename = "High income")]
    HighIncome,

    #[serde(rename = "Low income")]
    LowIncome,

    Aggregates,

    #[serde(rename = "Lower middle income")]
    LowerMiddleIncome,

    #[serde(rename = "Upper middle income")]
    UpperMiddleIncome,

    #[serde(rename = "Not classified")]
    NotClassified,

    #[serde(rename = "IDA")]
    Ida,

    #[serde(rename = "IBRD")]
    Ibrd,

    Blend,

    #[serde(rename = "Latin America & Caribbean ")]
    LatinAmericaCaribbean,

    #[serde(rename = "Sub-Saharan Africa ")]
    SubSaharanAfrica,

    #[serde(rename = "Europe & Central Asia")]
    EuropeCentralAsia,

    #[serde(rename = "Middle East & North Africa")]
    MiddleEastNorthAfrica,

    #[serde(rename = "East Asia & Pacific")]
    EastAsiaPacific,

    #[serde(rename = "North America")]
    NorthAmerica,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FluffyTopLevel {
    pub page: i64,

    pub pages: i64,

    pub per_page: String,

    pub total: i64,
}
