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
    pub txs: Vec<Tx>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Tx {
    pub double_spend: bool,

    pub hash: String,

    pub inputs: Vec<Input>,

    pub lock_time: i64,

    pub out: Vec<Out>,

    pub relayed_by: String,

    pub size: i64,

    pub time: i64,

    pub tx_index: i64,

    pub ver: i64,

    pub vin_sz: i64,

    pub vout_sz: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Input {
    pub prev_out: Out,

    pub script: String,

    pub sequence: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Out {
    pub addr: String,

    pub n: i64,

    #[serde(rename = "type")]
    pub out_type: i64,

    pub script: String,

    pub spent: bool,

    pub tx_index: i64,

    pub value: i64,
}
