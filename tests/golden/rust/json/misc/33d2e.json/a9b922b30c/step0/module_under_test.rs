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
    pub laureates: Vec<Laureate>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Laureate {
    pub born: String,

    pub born_city: Option<String>,

    pub born_country: Option<String>,

    pub born_country_code: Option<String>,

    pub died: String,

    pub died_city: Option<String>,

    pub died_country: Option<String>,

    pub died_country_code: Option<String>,

    pub firstname: Option<String>,

    pub gender: Gender,

    pub id: String,

    pub prizes: Vec<Prize>,

    pub surname: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Gender {
    Male,

    Female,

    Org,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Prize {
    pub affiliations: Vec<AffiliationElement>,

    pub category: Option<Category>,

    pub motivation: Option<String>,

    pub overall_motivation: Option<String>,

    pub share: Option<String>,

    pub year: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum AffiliationElement {
    AffiliationClass(AffiliationClass),

    AnythingArray(Vec<Option<serde_json::Value>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AffiliationClass {
    pub city: Option<String>,

    pub country: Option<String>,

    pub name: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Category {
    Physics,

    Chemistry,

    Peace,

    Medicine,

    Literature,

    Economics,
}
