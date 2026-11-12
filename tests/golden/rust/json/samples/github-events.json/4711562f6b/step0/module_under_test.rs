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

pub type TopLevel = Vec<TopLevelElement>;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelElement {
    pub actor: Actor,

    pub created_at: String,

    pub id: String,

    pub org: Option<Actor>,

    pub payload: Payload,

    pub public: bool,

    pub repo: TopLevelRepo,

    #[serde(rename = "type")]
    pub top_level_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Actor {
    pub avatar_url: String,

    pub display_login: Option<String>,

    pub gravatar_id: String,

    pub id: i64,

    pub login: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Payload {
    pub action: Option<String>,

    pub before: Option<String>,

    pub comment: Option<Comment>,

    pub commits: Option<Vec<Commit>>,

    pub description: Option<String>,

    pub distinct_size: Option<i64>,

    pub head: Option<String>,

    pub issue: Option<Issue>,

    pub master_branch: Option<String>,

    pub number: Option<i64>,

    #[serde(rename = "ref")]
    pub payload_ref: Option<String>,

    pub pull_request: Option<PayloadPullRequest>,

    pub push_id: Option<i64>,

    pub pusher_type: Option<String>,

    pub ref_type: Option<String>,

    pub size: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Comment {
    pub body: String,

    pub created_at: String,

    pub html_url: String,

    pub id: i64,

    pub issue_url: String,

    pub updated_at: String,

    pub url: String,

    pub user: User,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct User {
    pub avatar_url: String,

    pub events_url: String,

    pub followers_url: String,

    pub following_url: String,

    pub gists_url: String,

    pub gravatar_id: String,

    pub html_url: String,

    pub id: i64,

    pub login: String,

    pub organizations_url: String,

    pub received_events_url: String,

    pub repos_url: String,

    pub site_admin: bool,

    pub starred_url: String,

    pub subscriptions_url: String,

    pub url: String,

    #[serde(rename = "type")]
    pub user_type: Type,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Type {
    User,

    Organization,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Commit {
    pub author: Author,

    pub distinct: bool,

    pub message: String,

    pub sha: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Author {
    pub email: String,

    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Issue {
    pub assignee: Option<serde_json::Value>,

    pub assignees: Vec<Option<serde_json::Value>>,

    pub body: String,

    pub closed_at: Option<String>,

    pub comments: i64,

    pub comments_url: String,

    pub created_at: String,

    pub events_url: String,

    pub html_url: String,

    pub id: i64,

    pub labels: Vec<Label>,

    pub labels_url: String,

    pub locked: bool,

    pub milestone: Option<Milestone>,

    pub number: i64,

    pub pull_request: Option<IssuePullRequest>,

    pub repository_url: String,

    pub state: String,

    pub title: String,

    pub updated_at: String,

    pub url: String,

    pub user: User,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Label {
    pub color: String,

    pub id: i64,

    #[serde(rename = "default")]
    pub label_default: bool,

    pub name: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Milestone {
    pub closed_at: Option<serde_json::Value>,

    pub closed_issues: i64,

    pub created_at: String,

    pub creator: User,

    pub description: String,

    pub due_on: Option<String>,

    pub html_url: String,

    pub id: i64,

    pub labels_url: String,

    pub number: i64,

    pub open_issues: i64,

    pub state: String,

    pub title: String,

    pub updated_at: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IssuePullRequest {
    pub diff_url: String,

    pub html_url: String,

    pub patch_url: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PayloadPullRequest {
    pub additions: i64,

    pub assignee: Option<serde_json::Value>,

    pub assignees: Vec<Option<serde_json::Value>>,

    pub base: Base,

    pub body: String,

    pub changed_files: i64,

    pub closed_at: String,

    pub comments: i64,

    pub comments_url: String,

    pub commits: i64,

    pub commits_url: String,

    pub created_at: String,

    pub deletions: i64,

    pub diff_url: String,

    pub head: Base,

    pub html_url: String,

    pub id: i64,

    pub issue_url: String,

    #[serde(rename = "_links")]
    pub links: Links,

    pub locked: bool,

    pub maintainer_can_modify: bool,

    pub merge_commit_sha: String,

    pub mergeable: Option<serde_json::Value>,

    pub mergeable_state: String,

    pub merged: bool,

    pub merged_at: String,

    pub merged_by: User,

    pub milestone: Option<serde_json::Value>,

    pub number: i64,

    pub patch_url: String,

    pub rebaseable: Option<serde_json::Value>,

    pub requested_reviewers: Vec<Option<serde_json::Value>>,

    pub review_comment_url: String,

    pub review_comments: i64,

    pub review_comments_url: String,

    pub state: String,

    pub statuses_url: String,

    pub title: String,

    pub updated_at: String,

    pub url: String,

    pub user: User,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Base {
    #[serde(rename = "ref")]
    pub base_ref: String,

    pub label: String,

    pub repo: BaseRepo,

    pub sha: String,

    pub user: User,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BaseRepo {
    pub archive_url: String,

    pub assignees_url: String,

    pub blobs_url: String,

    pub branches_url: String,

    pub clone_url: String,

    pub collaborators_url: String,

    pub comments_url: String,

    pub commits_url: String,

    pub compare_url: String,

    pub contents_url: String,

    pub contributors_url: String,

    pub created_at: String,

    pub default_branch: String,

    pub deployments_url: String,

    pub description: String,

    pub downloads_url: String,

    pub events_url: String,

    pub fork: bool,

    pub forks: i64,

    pub forks_count: i64,

    pub forks_url: String,

    pub full_name: String,

    pub git_commits_url: String,

    pub git_refs_url: String,

    pub git_tags_url: String,

    pub git_url: String,

    pub has_downloads: bool,

    pub has_issues: bool,

    pub has_pages: bool,

    pub has_projects: bool,

    pub has_wiki: bool,

    pub homepage: String,

    pub hooks_url: String,

    pub html_url: String,

    pub id: i64,

    pub issue_comment_url: String,

    pub issue_events_url: String,

    pub issues_url: String,

    pub keys_url: String,

    pub labels_url: String,

    pub language: String,

    pub languages_url: String,

    pub merges_url: String,

    pub milestones_url: String,

    pub mirror_url: Option<serde_json::Value>,

    pub name: String,

    pub notifications_url: String,

    pub open_issues: i64,

    pub open_issues_count: i64,

    pub owner: User,

    pub private: bool,

    pub pulls_url: String,

    pub pushed_at: String,

    pub releases_url: String,

    pub size: i64,

    pub ssh_url: String,

    pub stargazers_count: i64,

    pub stargazers_url: String,

    pub statuses_url: String,

    pub subscribers_url: String,

    pub subscription_url: String,

    pub svn_url: String,

    pub tags_url: String,

    pub teams_url: String,

    pub trees_url: String,

    pub updated_at: String,

    pub url: String,

    pub watchers: i64,

    pub watchers_count: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Links {
    pub comments: Comments,

    pub commits: Comments,

    pub html: Comments,

    pub issue: Comments,

    #[serde(rename = "self")]
    pub links_self: Comments,

    pub review_comment: Comments,

    pub review_comments: Comments,

    pub statuses: Comments,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Comments {
    pub href: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelRepo {
    pub id: i64,

    pub name: String,

    pub url: String,
}
