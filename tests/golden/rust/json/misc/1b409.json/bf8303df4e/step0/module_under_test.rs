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
    pub meta: Meta,

    pub objects: Vec<Object>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Meta {
    pub limit: i64,

    pub offset: i64,

    pub total_count: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Object {
    pub caucus: Option<serde_json::Value>,

    pub congress_numbers: Vec<i64>,

    pub current: bool,

    pub description: String,

    pub district: i64,

    pub enddate: String,

    pub extra: Extra,

    pub id: i64,

    pub leadership_title: Option<String>,

    pub party: Party,

    pub person: Person,

    pub phone: String,

    pub role_type: RoleType,

    pub role_type_label: RoleTypeLabel,

    pub senator_class: Option<serde_json::Value>,

    pub senator_rank: Option<serde_json::Value>,

    pub startdate: String,

    pub state: String,

    pub title: Title,

    pub title_long: RoleTypeLabel,

    pub website: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Extra {
    pub address: String,

    pub contact_form: Option<String>,

    pub fax: Option<String>,

    pub office: String,

    pub rss_url: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Party {
    Republican,

    Democrat,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Person {
    pub bioguideid: String,

    pub birthday: String,

    pub cspanid: i64,

    pub firstname: String,

    pub gender: Gender,

    pub gender_label: GenderLabel,

    pub id: i64,

    pub lastname: String,

    pub link: String,

    pub middlename: String,

    pub name: String,

    pub namemod: Namemod,

    pub nickname: String,

    pub osid: String,

    pub pvsid: Option<String>,

    pub sortname: String,

    pub twitterid: Option<String>,

    pub youtubeid: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Gender {
    Male,

    Female,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum GenderLabel {
    Male,

    Female,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Namemod {
    #[serde(rename = "")]
    Empty,

    #[serde(rename = "Jr.")]
    Jr,

    #[serde(rename = "II")]
    Ii,

    #[serde(rename = "III")]
    Iii,

    #[serde(rename = "IV")]
    Iv,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum RoleType {
    Representative,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum RoleTypeLabel {
    Representative,

    Delegate,

    #[serde(rename = "Resident Commissioner")]
    ResidentCommissioner,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Title {
    #[serde(rename = "Rep.")]
    Rep,

    #[serde(rename = "Commish.")]
    Commish,
}
