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
    pub data: TopLevelData,

    pub kind: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelData {
    pub after: String,

    pub before: Option<serde_json::Value>,

    pub children: Vec<Child>,

    pub modhash: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Child {
    pub data: ChildData,

    pub kind: Kind,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ChildData {
    pub approved_at_utc: Option<serde_json::Value>,

    pub approved_by: Option<serde_json::Value>,

    pub archived: bool,

    pub author: String,

    pub author_flair_css_class: Option<String>,

    pub author_flair_text: Option<String>,

    pub banned_at_utc: Option<serde_json::Value>,

    pub banned_by: Option<serde_json::Value>,

    pub brand_safe: bool,

    pub can_gild: bool,

    pub can_mod_post: bool,

    pub clicked: bool,

    pub contest_mode: bool,

    pub created: f64,

    pub created_utc: f64,

    pub distinguished: Option<serde_json::Value>,

    pub domain: String,

    pub downs: i64,

    pub edited: bool,

    pub gilded: i64,

    pub hidden: bool,

    pub hide_score: bool,

    pub id: String,

    pub is_self: bool,

    pub is_video: bool,

    pub likes: Option<serde_json::Value>,

    pub link_flair_css_class: Option<String>,

    pub link_flair_text: Option<String>,

    pub locked: bool,

    pub media: Option<Media>,

    pub media_embed: MediaEmbed,

    pub mod_reports: Vec<Option<serde_json::Value>>,

    pub name: String,

    pub num_comments: i64,

    pub num_reports: Option<serde_json::Value>,

    pub over_18: bool,

    pub permalink: String,

    pub post_hint: Option<PostHint>,

    pub preview: Option<Preview>,

    pub quarantine: bool,

    pub removal_reason: Option<serde_json::Value>,

    pub report_reasons: Option<serde_json::Value>,

    pub saved: bool,

    pub score: i64,

    pub secure_media: Option<Media>,

    pub secure_media_embed: MediaEmbed,

    pub selftext: String,

    pub selftext_html: Option<String>,

    pub spoiler: bool,

    pub stickied: bool,

    pub subreddit: String,

    pub subreddit_id: String,

    pub subreddit_name_prefixed: String,

    pub subreddit_type: SubredditType,

    pub suggested_sort: Option<String>,

    pub thumbnail: String,

    pub thumbnail_height: Option<i64>,

    pub thumbnail_width: Option<i64>,

    pub title: String,

    pub ups: i64,

    pub url: String,

    pub user_reports: Vec<Option<serde_json::Value>>,

    pub view_count: Option<serde_json::Value>,

    pub visited: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Media {
    #[serde(rename = "type")]
    pub media_type: String,

    pub oembed: Oembed,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Oembed {
    pub description: String,

    pub height: i64,

    pub html: String,

    #[serde(rename = "type")]
    pub oembed_type: String,

    pub provider_name: String,

    pub provider_url: String,

    pub thumbnail_height: i64,

    pub thumbnail_url: String,

    pub thumbnail_width: i64,

    pub title: String,

    pub version: String,

    pub width: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MediaEmbed {
    pub content: Option<String>,

    pub height: Option<i64>,

    pub scrolling: Option<bool>,

    pub width: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum PostHint {
    Link,

    Image,

    #[serde(rename = "rich:video")]
    RichVideo,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Preview {
    pub enabled: bool,

    pub images: Vec<Image>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Image {
    pub id: String,

    pub resolutions: Vec<Source>,

    pub source: Source,

    pub variants: Variants,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Source {
    pub height: i64,

    pub url: String,

    pub width: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Variants {
    pub gif: Option<Gif>,

    pub mp4: Option<Gif>,

    pub nsfw: Option<Gif>,

    pub obfuscated: Option<Gif>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Gif {
    pub resolutions: Vec<Source>,

    pub source: Source,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum SubredditType {
    Public,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Kind {
    T3,
}
