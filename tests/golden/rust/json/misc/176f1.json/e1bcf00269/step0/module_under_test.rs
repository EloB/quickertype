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
    pub message: Vec<Option<serde_json::Value>>,

    pub response_time: i64,

    #[serde(rename = "Results")]
    pub results: Results,

    pub status: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Results {
    pub series: Vec<Series>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Series {
    pub data: Vec<Datum>,

    #[serde(rename = "seriesID")]
    pub series_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Datum {
    pub footnotes: Vec<Footnote>,

    pub period: String,

    pub period_name: String,

    pub value: String,

    pub year: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Footnote {
    pub code: Option<String>,

    pub text: Option<String>,
}
