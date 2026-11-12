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
    pub active_screens: i64,

    pub collections: Vec<Collection>,

    pub details: Vec<Detail>,

    pub duration: i64,

    pub fav_movie: FavMovie,

    pub id: i64,

    pub images: Vec<Image>,

    pub language: ResultLanguage,

    pub release_date: String,

    pub stars: i64,

    pub tags: Option<Vec<Option<serde_json::Value>>>,

    pub title: String,

    pub videos: Vec<Video>,

    pub vote_score: VoteScore,

    pub watches: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Collection {
    pub id: i64,

    pub movies: Vec<i64>,

    pub name: String,

    pub slug: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Detail {
    pub cast: String,

    pub director: String,

    pub id: i64,

    pub language: DetailLanguage,

    pub storyline: String,

    pub tagline: String,

    pub title: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum DetailLanguage {
    En,

    Th,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FavMovie {
    pub follow: bool,

    pub star: bool,

    pub watched: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Image {
    pub favs: i64,

    pub id: i64,

    #[serde(rename = "type")]
    pub image_type: Type,

    pub thumbnail: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Type {
    Poster,

    Backdrop,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum ResultLanguage {
    En,

    #[serde(rename = "-")]
    Empty,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Video {
    pub kind: String,

    pub language: ResultLanguage,

    pub source: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VoteScore {
    pub avg: i64,

    pub score: i64,

    pub total: i64,
}
