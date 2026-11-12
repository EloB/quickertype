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

    pub created: i64,

    pub created_utc: i64,

    pub distinguished: Option<String>,

    pub domain: Domain,

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

    pub media: Option<serde_json::Value>,

    pub media_embed: MediaEmbed,

    pub mod_reports: Vec<Option<serde_json::Value>>,

    pub name: String,

    pub num_comments: i64,

    pub num_reports: Option<serde_json::Value>,

    pub over_18: bool,

    pub parent_whitelist_status: WhitelistStatus,

    pub permalink: String,

    pub post_hint: PostHint,

    pub preview: Preview,

    pub quarantine: bool,

    pub removal_reason: Option<serde_json::Value>,

    pub report_reasons: Option<serde_json::Value>,

    pub saved: bool,

    pub score: i64,

    pub secure_media: Option<serde_json::Value>,

    pub secure_media_embed: MediaEmbed,

    pub selftext: String,

    pub selftext_html: Option<serde_json::Value>,

    pub spoiler: bool,

    pub stickied: bool,

    pub subreddit: Subreddit,

    pub subreddit_id: SubredditId,

    pub subreddit_name_prefixed: SubredditNamePrefixed,

    pub subreddit_type: SubredditType,

    pub suggested_sort: Option<serde_json::Value>,

    pub thumbnail: String,

    pub thumbnail_height: i64,

    pub thumbnail_width: i64,

    pub title: String,

    pub ups: i64,

    pub url: String,

    pub user_reports: Vec<Option<serde_json::Value>>,

    pub view_count: Option<serde_json::Value>,

    pub visited: bool,

    pub whitelist_status: WhitelistStatus,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Domain {
    #[serde(rename = "reddit.com")]
    RedditCom,

    #[serde(rename = "i.imgur.com")]
    IImgurCom,

    #[serde(rename = "imgur.com")]
    ImgurCom,

    #[serde(rename = "i.redd.it")]
    IReddIt,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MediaEmbed {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum WhitelistStatus {
    #[serde(rename = "all_ads")]
    AllAds,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum PostHint {
    Link,

    Image,
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
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Gif {
    pub resolutions: Vec<Source>,

    pub source: Source,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Subreddit {
    Funny,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum SubredditId {
    #[serde(rename = "t5_2qh33")]
    T52Qh33,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum SubredditNamePrefixed {
    #[serde(rename = "r/funny")]
    RFunny,
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
