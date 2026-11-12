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
    pub data: Vec<Datum>,

    pub meta: Meta,

    pub pagination: Pagination,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Datum {
    pub bitly_gif_url: String,

    pub bitly_url: String,

    pub content_url: String,

    #[serde(rename = "type")]
    pub datum_type: Type,

    pub embed_url: String,

    pub id: String,

    pub images: Images,

    pub import_datetime: String,

    pub is_indexable: i64,

    pub rating: Rating,

    pub slug: String,

    pub source: String,

    pub source_post_url: String,

    pub source_tld: String,

    pub trending_datetime: String,

    pub url: String,

    pub user: Option<User>,

    pub username: Username,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Type {
    Gif,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Images {
    pub downsized: Downsized,

    pub downsized_large: Downsized,

    pub downsized_medium: Downsized,

    pub downsized_small: DownsizedSmall,

    pub downsized_still: Downsized,

    pub fixed_height: FixedHeight,

    pub fixed_height_downsampled: FixedHeight,

    pub fixed_height_small: FixedHeight,

    pub fixed_height_small_still: Downsized,

    pub fixed_height_still: Downsized,

    pub fixed_width: FixedHeight,

    pub fixed_width_downsampled: FixedHeight,

    pub fixed_width_small: FixedHeight,

    pub fixed_width_small_still: Downsized,

    pub fixed_width_still: Downsized,

    pub looping: Looping,

    pub original: FixedHeight,

    pub original_mp4: DownsizedSmall,

    pub original_still: Downsized,

    pub preview: DownsizedSmall,

    pub preview_gif: Downsized,

    pub preview_webp: Downsized,

    #[serde(rename = "480w_still")]
    pub the_480_w_still: Option<Downsized>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Downsized {
    pub height: String,

    pub size: Option<String>,

    pub url: String,

    pub width: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DownsizedSmall {
    pub height: String,

    pub mp4: String,

    pub mp4_size: String,

    pub width: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FixedHeight {
    pub frames: Option<String>,

    pub hash: Option<String>,

    pub height: String,

    pub mp4: Option<String>,

    pub mp4_size: Option<String>,

    pub size: String,

    pub url: String,

    pub webp: String,

    pub webp_size: String,

    pub width: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Looping {
    pub mp4: String,

    pub mp4_size: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Rating {
    G,

    Pg,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct User {
    pub avatar_url: String,

    pub banner_url: String,

    pub display_name: String,

    pub profile_url: String,

    pub twitter: String,

    pub username: Username,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Username {
    Cheezburger,

    #[serde(rename = "")]
    Empty,

    Natgeowild,

    Nowthis,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Meta {
    pub msg: String,

    pub response_id: String,

    pub status: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Pagination {
    pub count: i64,

    pub offset: i64,

    pub total_count: i64,
}
