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
    pub booster: Vec<Booster>,

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
#[serde(rename_all = "snake_case")]
pub enum Booster {
    Rare,

    Uncommon,

    Common,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Card {
    pub artist: String,

    #[serde(rename = "type")]
    pub card_type: String,

    pub cmc: i64,

    pub color_identity: Option<Vec<ColorIdentity>>,

    pub colors: Option<Vec<Color>>,

    pub flavor: Option<String>,

    pub id: String,

    pub image_name: String,

    pub layout: Layout,

    pub legalities: Vec<LegalityElement>,

    pub mana_cost: Option<String>,

    pub mci_number: Option<String>,

    pub multiverseid: i64,

    pub name: String,

    pub original_text: Option<String>,

    pub original_type: String,

    pub power: Option<String>,

    pub printings: Vec<String>,

    pub rarity: Rarity,

    pub reserved: Option<bool>,

    pub rulings: Option<Vec<Ruling>>,

    pub subtypes: Option<Vec<String>>,

    pub supertypes: Option<Vec<Supertype>>,

    pub text: Option<String>,

    pub toughness: Option<String>,

    pub types: Vec<Type>,

    pub variations: Option<Vec<i64>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum ColorIdentity {
    U,

    B,

    W,

    G,

    R,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Color {
    Blue,

    Black,

    White,

    Green,

    Red,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Layout {
    Normal,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LegalityElement {
    pub format: Format,

    pub legality: LegalityEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Format {
    Commander,

    Legacy,

    Modern,

    Vintage,

    #[serde(rename = "Time Spiral Block")]
    TimeSpiralBlock,

    #[serde(rename = "Ravnica Block")]
    RavnicaBlock,

    #[serde(rename = "Ice Age Block")]
    IceAgeBlock,

    #[serde(rename = "Tempest Block")]
    TempestBlock,

    #[serde(rename = "Onslaught Block")]
    OnslaughtBlock,

    #[serde(rename = "Masques Block")]
    MasquesBlock,

    #[serde(rename = "Mirage Block")]
    MirageBlock,

    #[serde(rename = "Urza Block")]
    UrzaBlock,

    #[serde(rename = "Scars of Mirrodin Block")]
    ScarsOfMirrodinBlock,

    #[serde(rename = "Mirrodin Block")]
    MirrodinBlock,

    #[serde(rename = "Amonkhet Block")]
    AmonkhetBlock,

    #[serde(rename = "Battle for Zendikar Block")]
    BattleForZendikarBlock,

    #[serde(rename = "Innistrad Block")]
    InnistradBlock,

    #[serde(rename = "Invasion Block")]
    InvasionBlock,

    #[serde(rename = "Kaladesh Block")]
    KaladeshBlock,

    #[serde(rename = "Kamigawa Block")]
    KamigawaBlock,

    #[serde(rename = "Khans of Tarkir Block")]
    KhansOfTarkirBlock,

    #[serde(rename = "Lorwyn-Shadowmoor Block")]
    LorwynShadowmoorBlock,

    #[serde(rename = "Odyssey Block")]
    OdysseyBlock,

    #[serde(rename = "Return to Ravnica Block")]
    ReturnToRavnicaBlock,

    #[serde(rename = "Shadows over Innistrad Block")]
    ShadowsOverInnistradBlock,

    #[serde(rename = "Shards of Alara Block")]
    ShardsOfAlaraBlock,

    Standard,

    #[serde(rename = "Theros Block")]
    TherosBlock,

    #[serde(rename = "Un-Sets")]
    UnSets,

    #[serde(rename = "Zendikar Block")]
    ZendikarBlock,
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
pub enum Supertype {
    Basic,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Type {
    Creature,

    Instant,

    Enchantment,

    Artifact,

    Sorcery,

    Land,
}
