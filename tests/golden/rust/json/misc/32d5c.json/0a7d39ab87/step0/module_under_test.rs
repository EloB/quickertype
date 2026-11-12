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
#[serde(rename_all = "PascalCase")]
pub struct TopLevelElement {
    pub birth_date: Option<String>,

    pub birth_date_is_protected: bool,

    #[serde(rename = "GenderTypeID")]
    pub gender_type_id: i64,

    pub notes: String,

    pub parliamentary_name: String,

    #[serde(rename = "PersonID")]
    pub person_id: i64,

    #[serde(rename = "PhotoURL")]
    pub photo_url: String,

    pub preferred_name: String,
}
