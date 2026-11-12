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
    pub an_easy_one: i64,

    #[serde(rename = "isMNISTLetter")]
    pub is_mnist_letter: bool,

    #[serde(rename = "JSONString")]
    pub json_string: String,

    #[serde(rename = "PrettyEasyToo")]
    pub pretty_easy_too: bool,

    #[serde(rename = "should_know_that_id_is_an_initialism")]
    pub should_know_that_id_is_an_initialism: String,

    #[serde(rename = "   spaces are separators  too  ")]
    pub spaces_are_separators_too: bool,

    #[serde(rename = "ZSR_HH_DEMO3_DELMATNR")]
    pub zsr_hh_demo3_delmatnr: bool,
}
