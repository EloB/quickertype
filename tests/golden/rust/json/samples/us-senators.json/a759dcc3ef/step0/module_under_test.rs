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
    pub caucus: Option<Party>,

    pub congress_numbers: Vec<i64>,

    pub current: bool,

    pub description: String,

    pub district: Option<serde_json::Value>,

    pub enddate: String,

    pub extra: Extra,

    pub leadership_title: Option<String>,

    pub party: Party,

    pub person: Person,

    pub phone: String,

    pub role_type: RoleType,

    pub role_type_label: RoleTypeLabel,

    pub senator_class: SenatorClass,

    pub senator_class_label: SenatorClassLabel,

    pub senator_rank: SenatorRank,

    pub senator_rank_label: SenatorRankLabel,

    pub startdate: String,

    pub state: String,

    pub title: Title,

    pub title_long: RoleTypeLabel,

    pub website: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Party {
    Democrat,

    Republican,

    Independent,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Extra {
    pub address: String,

    pub contact_form: String,

    pub fax: Option<String>,

    pub office: String,

    pub rss_url: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Person {
    pub bioguideid: String,

    pub birthday: String,

    pub cspanid: i64,

    pub firstname: String,

    pub gender: Gender,

    pub gender_label: GenderLabel,

    pub lastname: String,

    pub link: String,

    pub middlename: String,

    pub name: String,

    pub namemod: Namemod,

    pub nickname: String,

    pub osid: String,

    pub pvsid: String,

    pub sortname: String,

    pub twitterid: Option<String>,

    pub youtubeid: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Gender {
    Female,

    Male,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum GenderLabel {
    Female,

    Male,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Namemod {
    #[serde(rename = "")]
    Empty,

    #[serde(rename = "Jr.")]
    Jr,

    #[serde(rename = "III")]
    Iii,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum RoleType {
    Senator,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum RoleTypeLabel {
    Senator,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum SenatorClass {
    Class1,

    Class2,

    Class3,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum SenatorClassLabel {
    #[serde(rename = "Class 1")]
    Class1,

    #[serde(rename = "Class 2")]
    Class2,

    #[serde(rename = "Class 3")]
    Class3,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum SenatorRank {
    Junior,

    Senior,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum SenatorRankLabel {
    Junior,

    Senior,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Title {
    #[serde(rename = "Sen.")]
    Sen,
}
