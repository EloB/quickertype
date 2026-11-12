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
#[serde(rename_all = "PascalCase")]
pub struct TopLevel {
    pub light_params: LightParams,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LightParams {
    pub app_id: String,

    pub outlet_id: String,

    pub rgba: String,
}
