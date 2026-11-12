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
    pub booster: Vec<String>,

    pub border: String,

    pub cards: Vec<Card>,

    pub code: String,

    pub gatherer_code: String,

    pub magic_cards_info_code: String,

    #[serde(rename = "mkm_id")]
    pub mkm_id: i64,

    #[serde(rename = "mkm_name")]
    pub mkm_name: String,

    pub name: String,

    pub release_date: String,

    #[serde(rename = "type")]
    pub top_level_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Card {
    pub artist: String,

    #[serde(rename = "type")]
    pub card_type: String,

    pub cmc: i64,

    pub color_identity: Option<Vec<ColorIdentity>>,

    pub colors: Option<Vec<Watermark>>,

    pub flavor: Option<String>,

    pub id: String,

    pub image_name: String,

    pub layout: Layout,

    pub legalities: Vec<LegalityElement>,

    pub mana_cost: Option<String>,

    pub mci_number: Option<String>,

    pub multiverseid: i64,

    pub name: String,

    pub original_text: String,

    pub original_type: String,

    pub power: Option<String>,

    pub printings: Vec<String>,

    pub rarity: Rarity,

    pub reserved: Option<bool>,

    pub rulings: Option<Vec<Ruling>>,

    pub subtypes: Option<Vec<String>>,

    pub supertypes: Option<Vec<String>>,

    pub text: Option<String>,

    pub toughness: Option<String>,

    pub types: Vec<Type>,

    pub variations: Option<Vec<i64>>,

    pub watermark: Option<Watermark>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum ColorIdentity {
    W,

    R,

    B,

    G,

    U,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Watermark {
    White,

    Red,

    Black,

    Green,

    Blue,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Layout {
    Normal,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LegalityElement {
    pub format: String,

    pub legality: LegalityEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum LegalityEnum {
    Legal,

    Banned,

    Restricted,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Rarity {
    Uncommon,

    Rare,

    Common,

    #[serde(rename = "Basic Land")]
    BasicLand,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ruling {
    pub date: String,

    pub text: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Type {
    Creature,

    Artifact,

    Instant,

    Land,

    Enchantment,

    Sorcery,
}
