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
    pub city: String,

    pub delay: String,

    #[serde(rename = "IATA")]
    pub iata: String,

    #[serde(rename = "ICAO")]
    pub icao: String,

    pub name: String,

    pub state: String,

    pub status: Status,

    pub weather: Weather,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Status {
    pub avg_delay: String,

    pub closure_begin: String,

    pub closure_end: String,

    pub end_time: String,

    pub max_delay: String,

    pub min_delay: String,

    pub reason: String,

    #[serde(rename = "type")]
    pub status_type: String,

    pub trend: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Weather {
    pub meta: Meta,

    pub temp: String,

    pub visibility: f64,

    pub weather: String,

    pub wind: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Meta {
    pub credit: String,

    pub updated: String,

    pub url: String,
}
