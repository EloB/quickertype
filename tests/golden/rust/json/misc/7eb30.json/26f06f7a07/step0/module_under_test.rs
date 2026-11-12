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
    pub count: i64,

    pub next: String,

    pub previous: Option<serde_json::Value>,

    pub results: Vec<ResultElement>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ResultElement {
    pub code: String,

    pub english: String,

    pub fav: bool,

    pub group: Group,

    pub location: Location,

    pub min_screens: i64,

    pub num_views: i64,

    pub showtimes: String,

    pub stars: i64,

    pub tel: Tel,

    pub thai: String,

    pub today_screens: i64,

    pub url: String,

    pub website: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Group {
    pub code: Code,

    pub english: English,

    pub thai: Thai,

    pub website: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Code {
    Sf,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum English {
    #[serde(rename = "SF")]
    Sf,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Thai {
    #[serde(rename = "เอสเอฟ")]
    Empty,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Location {
    #[serde(rename = "")]
    Empty,

    #[serde(rename = "5th Fl. Emporium")]
    The5ThFlEmporium,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Tel {
    #[serde(rename = "")]
    Empty,

    #[serde(rename = "02-268-8899")]
    The022688899,
}
