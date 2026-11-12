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

    PurpleString(String),

    PurpleTopLevelArray(Vec<PurpleTopLevel>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct PurpleTopLevel {
    pub alienlevel: i64,

    pub breed: Breed,

    pub char_dimension: i64,

    pub char_instance: i64,

    pub defender_rank_title: String,

    pub firstname: Firstname,

    pub headid: i64,

    pub lastname: Lastname,

    pub levelx: i64,

    pub name: String,

    pub prof: String,

    pub prof_title: String,

    pub pvprating: i64,

    pub pvptitle: Pvptitle,

    pub rank: i64,

    pub rank_title: RankTitle,

    pub sex: Sex,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Breed {
    Atrox,

    Solitus,

    Opifex,

    Nano,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Firstname {
    #[serde(rename = "")]
    Empty,

    Chi,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Lastname {
    #[serde(rename = "")]
    Empty,

    Washko,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Pvptitle {
    Freshman,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum RankTitle {
    President,

    Advisor,

    Veteran,

    Applicant,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Sex {
    Neuter,

    Male,

    Female,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct FluffyTopLevel {
    pub adventurercount: i64,

    pub agentcount: i64,

    pub atroxcount: i64,

    pub avglvl: f64,

    pub btcount: i64,

    pub description: String,

    pub doctorcount: i64,

    pub enfcount: i64,

    pub engineeercount: i64,

    pub femalecount: i64,

    pub fixercount: i64,

    pub governingname: String,

    pub history: String,

    pub keepercount: i64,

    pub macount: i64,

    pub malecount: i64,

    pub maxlvl: i64,

    pub metacount: i64,

    pub minlvl: i64,

    pub monstercount: i64,

    pub name: String,

    pub nanocount: i64,

    pub nanoracecount: i64,

    pub neutercount: i64,

    pub nummembers: i64,

    pub objective: String,

    pub opifexcount: i64,

    pub org_dimension: i64,

    pub org_instance: i64,

    pub shadecount: i64,

    pub side: i64,

    pub side_name: String,

    pub solidercount: i64,

    pub solituscount: i64,

    pub tradercount: i64,
}
