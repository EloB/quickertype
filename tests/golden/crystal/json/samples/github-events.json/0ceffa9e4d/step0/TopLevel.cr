require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  property actor : Actor

  property created_at : String

  property id : String

  property org : Actor?

  property payload : Payload

  property public : Bool

  property repo : TopLevelRepo

  @[JSON::Field(key: "type")]
  property top_level_type : String
end

class Actor
  include JSON::Serializable

  property avatar_url : String

  property display_login : String?

  property gravatar_id : String

  property id : Int64

  property login : String

  property url : String
end

class Payload
  include JSON::Serializable

  property action : String?

  property before : String?

  property comment : Comment?

  property commits : Array(Commit)?

  property description : String?

  property distinct_size : Int64?

  property head : String?

  property issue : Issue?

  property master_branch : String?

  property number : Int64?

  property pull_request : PayloadPullRequest?

  property push_id : Int64?

  property pusher_type : String?

  property ref : String?

  property ref_type : String?

  property size : Int64?
end

class Comment
  include JSON::Serializable

  property body : String

  property created_at : String

  property html_url : String

  property id : Int64

  property issue_url : String

  property updated_at : String

  property url : String

  property user : User
end

class User
  include JSON::Serializable

  property avatar_url : String

  property events_url : String

  property followers_url : String

  property following_url : String

  property gists_url : String

  property gravatar_id : String

  property html_url : String

  property id : Int64

  property login : String

  property organizations_url : String

  property received_events_url : String

  property repos_url : String

  property site_admin : Bool

  property starred_url : String

  property subscriptions_url : String

  property url : String

  @[JSON::Field(key: "type")]
  property user_type : String
end

class Commit
  include JSON::Serializable

  property author : Author

  property distinct : Bool

  property message : String

  property sha : String

  property url : String
end

class Author
  include JSON::Serializable

  property email : String

  property name : String
end

class Issue
  include JSON::Serializable

  property assignee : Nil

  property assignees : Array(JSON::Any?)

  property body : String

  property closed_at : String?

  property comments : Int64

  property comments_url : String

  property created_at : String

  property events_url : String

  property html_url : String

  property id : Int64

  property labels : Array(Label)

  property labels_url : String

  property locked : Bool

  property milestone : Milestone?

  property number : Int64

  property pull_request : IssuePullRequest?

  property repository_url : String

  property state : String

  property title : String

  property updated_at : String

  property url : String

  property user : User
end

class Label
  include JSON::Serializable

  property color : String

  property default : Bool

  property id : Int64

  property name : String

  property url : String
end

class Milestone
  include JSON::Serializable

  property closed_at : Nil

  property closed_issues : Int64

  property created_at : String

  property creator : User

  property description : String

  property due_on : String?

  property html_url : String

  property id : Int64

  property labels_url : String

  property number : Int64

  property open_issues : Int64

  property state : String

  property title : String

  property updated_at : String

  property url : String
end

class IssuePullRequest
  include JSON::Serializable

  property diff_url : String

  property html_url : String

  property patch_url : String

  property url : String
end

class PayloadPullRequest
  include JSON::Serializable

  property additions : Int64

  property assignee : Nil

  property assignees : Array(JSON::Any?)

  property base : Base

  property body : String

  property changed_files : Int64

  property closed_at : String

  property comments : Int64

  property comments_url : String

  property commits : Int64

  property commits_url : String

  property created_at : String

  property deletions : Int64

  property diff_url : String

  property head : Base

  property html_url : String

  property id : Int64

  property issue_url : String

  @[JSON::Field(key: "_links")]
  property links : Links

  property locked : Bool

  property maintainer_can_modify : Bool

  property merge_commit_sha : String

  property mergeable : Nil

  property mergeable_state : String

  property merged : Bool

  property merged_at : String

  property merged_by : User

  property milestone : Nil

  property number : Int64

  property patch_url : String

  property rebaseable : Nil

  property requested_reviewers : Array(JSON::Any?)

  property review_comment_url : String

  property review_comments : Int64

  property review_comments_url : String

  property state : String

  property statuses_url : String

  property title : String

  property updated_at : String

  property url : String

  property user : User
end

class Base
  include JSON::Serializable

  property label : String

  property ref : String

  property repo : BaseRepo

  property sha : String

  property user : User
end

class BaseRepo
  include JSON::Serializable

  property archive_url : String

  property assignees_url : String

  property blobs_url : String

  property branches_url : String

  property clone_url : String

  property collaborators_url : String

  property comments_url : String

  property commits_url : String

  property compare_url : String

  property contents_url : String

  property contributors_url : String

  property created_at : String

  property default_branch : String

  property deployments_url : String

  property description : String

  property downloads_url : String

  property events_url : String

  property fork : Bool

  property forks : Int64

  property forks_count : Int64

  property forks_url : String

  property full_name : String

  property git_commits_url : String

  property git_refs_url : String

  property git_tags_url : String

  property git_url : String

  property has_downloads : Bool

  property has_issues : Bool

  property has_pages : Bool

  property has_projects : Bool

  property has_wiki : Bool

  property homepage : String

  property hooks_url : String

  property html_url : String

  property id : Int64

  property issue_comment_url : String

  property issue_events_url : String

  property issues_url : String

  property keys_url : String

  property labels_url : String

  property language : String

  property languages_url : String

  property merges_url : String

  property milestones_url : String

  property mirror_url : Nil

  property name : String

  property notifications_url : String

  property open_issues : Int64

  property open_issues_count : Int64

  property owner : User

  property pulls_url : String

  property pushed_at : String

  property releases_url : String

  @[JSON::Field(key: "private")]
  property repo_private : Bool

  property size : Int64

  property ssh_url : String

  property stargazers_count : Int64

  property stargazers_url : String

  property statuses_url : String

  property subscribers_url : String

  property subscription_url : String

  property svn_url : String

  property tags_url : String

  property teams_url : String

  property trees_url : String

  property updated_at : String

  property url : String

  property watchers : Int64

  property watchers_count : Int64
end

class Links
  include JSON::Serializable

  property comments : Comments

  property commits : Comments

  property html : Comments

  property issue : Comments

  @[JSON::Field(key: "self")]
  property links_self : Comments

  property review_comment : Comments

  property review_comments : Comments

  property statuses : Comments
end

class Comments
  include JSON::Serializable

  property href : String
end

class TopLevelRepo
  include JSON::Serializable

  property id : Int64

  property name : String

  property url : String
end
