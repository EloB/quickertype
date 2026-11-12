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
    pub pokemon: Vec<Pokemon>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Pokemon {
    pub avg_spawns: f64,

    pub candy: String,

    pub candy_count: Option<i64>,

    pub egg: Egg,

    pub height: String,

    pub id: i64,

    pub img: String,

    pub multipliers: Option<Vec<f64>>,

    pub name: String,

    pub next_evolution: Option<Vec<Evolution>>,

    pub num: String,

    #[serde(rename = "type")]
    pub pokemon_type: Vec<Type>,

    pub prev_evolution: Option<Vec<Evolution>>,

    pub spawn_chance: f64,

    pub spawn_time: String,

    pub weaknesses: Vec<Type>,

    pub weight: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Egg {
    #[serde(rename = "2 km")]
    The2Km,

    #[serde(rename = "Not in Eggs")]
    NotInEggs,

    #[serde(rename = "5 km")]
    The5Km,

    #[serde(rename = "10 km")]
    The10Km,

    #[serde(rename = "Omanyte Candy")]
    OmanyteCandy,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Evolution {
    pub name: String,

    pub num: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Type {
    Fire,

    Ice,

    Flying,

    Psychic,

    Water,

    Ground,

    Rock,

    Electric,

    Grass,

    Fighting,

    Poison,

    Bug,

    Fairy,

    Ghost,

    Dark,

    Steel,

    Dragon,

    Normal,
}
