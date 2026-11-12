# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.repo.id.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
  Type    = Strict::String.enum("PushEvent", "CreateEvent", "WatchEvent", "PullRequestEvent", "DeleteEvent")
end

class Actor < Dry::Struct
  attribute :avatar_url,    Types::String
  attribute :display_login, Types::String.optional
  attribute :gravatar_id,   Types::String
  attribute :id,            Types::Integer
  attribute :login,         Types::String
  attribute :url,           Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      avatar_url:    d.fetch("avatar_url"),
      display_login: d.key?("display_login") ? Types::String[d["display_login"]] : nil,
      gravatar_id:   d.fetch("gravatar_id"),
      id:            d.fetch("id"),
      login:         d.fetch("login"),
      url:           d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "avatar_url"    => avatar_url,
      "display_login" => display_login,
      "gravatar_id"   => gravatar_id,
      "id"            => id,
      "login"         => login,
      "url"           => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Author < Dry::Struct
  attribute :author_name, Types::String
  attribute :email,       Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      author_name: d.fetch("name"),
      email:       d.fetch("email"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"  => author_name,
      "email" => email,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Commit < Dry::Struct
  attribute :author,   Author
  attribute :distinct, Types::Bool
  attribute :message,  Types::String
  attribute :sha,      Types::String
  attribute :url,      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      author:   Author.from_dynamic!(d.fetch("author")),
      distinct: d.fetch("distinct"),
      message:  d.fetch("message"),
      sha:      d.fetch("sha"),
      url:      d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "author"   => author.to_dynamic,
      "distinct" => distinct,
      "message"  => message,
      "sha"      => sha,
      "url"      => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MergedBy < Dry::Struct
  attribute :avatar_url,          Types::String
  attribute :events_url,          Types::String
  attribute :followers_url,       Types::String
  attribute :following_url,       Types::String
  attribute :gists_url,           Types::String
  attribute :gravatar_id,         Types::String
  attribute :html_url,            Types::String
  attribute :id,                  Types::Integer
  attribute :login,               Types::String
  attribute :merged_by_type,      Types::String
  attribute :organizations_url,   Types::String
  attribute :received_events_url, Types::String
  attribute :repos_url,           Types::String
  attribute :site_admin,          Types::Bool
  attribute :starred_url,         Types::String
  attribute :subscriptions_url,   Types::String
  attribute :url,                 Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      avatar_url:          d.fetch("avatar_url"),
      events_url:          d.fetch("events_url"),
      followers_url:       d.fetch("followers_url"),
      following_url:       d.fetch("following_url"),
      gists_url:           d.fetch("gists_url"),
      gravatar_id:         d.fetch("gravatar_id"),
      html_url:            d.fetch("html_url"),
      id:                  d.fetch("id"),
      login:               d.fetch("login"),
      merged_by_type:      d.fetch("type"),
      organizations_url:   d.fetch("organizations_url"),
      received_events_url: d.fetch("received_events_url"),
      repos_url:           d.fetch("repos_url"),
      site_admin:          d.fetch("site_admin"),
      starred_url:         d.fetch("starred_url"),
      subscriptions_url:   d.fetch("subscriptions_url"),
      url:                 d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "avatar_url"          => avatar_url,
      "events_url"          => events_url,
      "followers_url"       => followers_url,
      "following_url"       => following_url,
      "gists_url"           => gists_url,
      "gravatar_id"         => gravatar_id,
      "html_url"            => html_url,
      "id"                  => id,
      "login"               => login,
      "type"                => merged_by_type,
      "organizations_url"   => organizations_url,
      "received_events_url" => received_events_url,
      "repos_url"           => repos_url,
      "site_admin"          => site_admin,
      "starred_url"         => starred_url,
      "subscriptions_url"   => subscriptions_url,
      "url"                 => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class BaseRepo < Dry::Struct
  attribute :archive_url,       Types::String
  attribute :assignees_url,     Types::String
  attribute :blobs_url,         Types::String
  attribute :branches_url,      Types::String
  attribute :clone_url,         Types::String
  attribute :collaborators_url, Types::String
  attribute :comments_url,      Types::String
  attribute :commits_url,       Types::String
  attribute :compare_url,       Types::String
  attribute :contents_url,      Types::String
  attribute :contributors_url,  Types::String
  attribute :created_at,        Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :default_branch,    Types::String
  attribute :deployments_url,   Types::String
  attribute :description,       Types::Nil
  attribute :downloads_url,     Types::String
  attribute :events_url,        Types::String
  attribute :forks,             Types::Integer
  attribute :forks_count,       Types::Integer
  attribute :forks_url,         Types::String
  attribute :full_name,         Types::String
  attribute :git_commits_url,   Types::String
  attribute :git_refs_url,      Types::String
  attribute :git_tags_url,      Types::String
  attribute :git_url,           Types::String
  attribute :has_downloads,     Types::Bool
  attribute :has_issues,        Types::Bool
  attribute :has_pages,         Types::Bool
  attribute :has_projects,      Types::Bool
  attribute :has_wiki,          Types::Bool
  attribute :homepage,          Types::Nil
  attribute :hooks_url,         Types::String
  attribute :html_url,          Types::String
  attribute :id,                Types::Integer
  attribute :issue_comment_url, Types::String
  attribute :issue_events_url,  Types::String
  attribute :issues_url,        Types::String
  attribute :keys_url,          Types::String
  attribute :labels_url,        Types::String
  attribute :language,          Types::String
  attribute :languages_url,     Types::String
  attribute :merges_url,        Types::String
  attribute :milestones_url,    Types::String
  attribute :mirror_url,        Types::Nil
  attribute :notifications_url, Types::String
  attribute :open_issues,       Types::Integer
  attribute :open_issues_count, Types::Integer
  attribute :owner,             MergedBy
  attribute :private,           Types::Bool
  attribute :pulls_url,         Types::String
  attribute :pushed_at,         Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :releases_url,      Types::String
  attribute :repo_fork,         Types::Bool
  attribute :repo_name,         Types::String
  attribute :size,              Types::Integer
  attribute :ssh_url,           Types::String
  attribute :stargazers_count,  Types::Integer
  attribute :stargazers_url,    Types::String
  attribute :statuses_url,      Types::String
  attribute :subscribers_url,   Types::String
  attribute :subscription_url,  Types::String
  attribute :svn_url,           Types::String
  attribute :tags_url,          Types::String
  attribute :teams_url,         Types::String
  attribute :trees_url,         Types::String
  attribute :updated_at,        Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :url,               Types::String
  attribute :watchers,          Types::Integer
  attribute :watchers_count,    Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      archive_url:       d.fetch("archive_url"),
      assignees_url:     d.fetch("assignees_url"),
      blobs_url:         d.fetch("blobs_url"),
      branches_url:      d.fetch("branches_url"),
      clone_url:         d.fetch("clone_url"),
      collaborators_url: d.fetch("collaborators_url"),
      comments_url:      d.fetch("comments_url"),
      commits_url:       d.fetch("commits_url"),
      compare_url:       d.fetch("compare_url"),
      contents_url:      d.fetch("contents_url"),
      contributors_url:  d.fetch("contributors_url"),
      created_at:        d.fetch("created_at"),
      default_branch:    d.fetch("default_branch"),
      deployments_url:   d.fetch("deployments_url"),
      description:       d.fetch("description"),
      downloads_url:     d.fetch("downloads_url"),
      events_url:        d.fetch("events_url"),
      forks:             d.fetch("forks"),
      forks_count:       d.fetch("forks_count"),
      forks_url:         d.fetch("forks_url"),
      full_name:         d.fetch("full_name"),
      git_commits_url:   d.fetch("git_commits_url"),
      git_refs_url:      d.fetch("git_refs_url"),
      git_tags_url:      d.fetch("git_tags_url"),
      git_url:           d.fetch("git_url"),
      has_downloads:     d.fetch("has_downloads"),
      has_issues:        d.fetch("has_issues"),
      has_pages:         d.fetch("has_pages"),
      has_projects:      d.fetch("has_projects"),
      has_wiki:          d.fetch("has_wiki"),
      homepage:          d.fetch("homepage"),
      hooks_url:         d.fetch("hooks_url"),
      html_url:          d.fetch("html_url"),
      id:                d.fetch("id"),
      issue_comment_url: d.fetch("issue_comment_url"),
      issue_events_url:  d.fetch("issue_events_url"),
      issues_url:        d.fetch("issues_url"),
      keys_url:          d.fetch("keys_url"),
      labels_url:        d.fetch("labels_url"),
      language:          d.fetch("language"),
      languages_url:     d.fetch("languages_url"),
      merges_url:        d.fetch("merges_url"),
      milestones_url:    d.fetch("milestones_url"),
      mirror_url:        d.fetch("mirror_url"),
      notifications_url: d.fetch("notifications_url"),
      open_issues:       d.fetch("open_issues"),
      open_issues_count: d.fetch("open_issues_count"),
      owner:             MergedBy.from_dynamic!(d.fetch("owner")),
      private:           d.fetch("private"),
      pulls_url:         d.fetch("pulls_url"),
      pushed_at:         d.fetch("pushed_at"),
      releases_url:      d.fetch("releases_url"),
      repo_fork:         d.fetch("fork"),
      repo_name:         d.fetch("name"),
      size:              d.fetch("size"),
      ssh_url:           d.fetch("ssh_url"),
      stargazers_count:  d.fetch("stargazers_count"),
      stargazers_url:    d.fetch("stargazers_url"),
      statuses_url:      d.fetch("statuses_url"),
      subscribers_url:   d.fetch("subscribers_url"),
      subscription_url:  d.fetch("subscription_url"),
      svn_url:           d.fetch("svn_url"),
      tags_url:          d.fetch("tags_url"),
      teams_url:         d.fetch("teams_url"),
      trees_url:         d.fetch("trees_url"),
      updated_at:        d.fetch("updated_at"),
      url:               d.fetch("url"),
      watchers:          d.fetch("watchers"),
      watchers_count:    d.fetch("watchers_count"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "archive_url"       => archive_url,
      "assignees_url"     => assignees_url,
      "blobs_url"         => blobs_url,
      "branches_url"      => branches_url,
      "clone_url"         => clone_url,
      "collaborators_url" => collaborators_url,
      "comments_url"      => comments_url,
      "commits_url"       => commits_url,
      "compare_url"       => compare_url,
      "contents_url"      => contents_url,
      "contributors_url"  => contributors_url,
      "created_at"        => created_at,
      "default_branch"    => default_branch,
      "deployments_url"   => deployments_url,
      "description"       => description,
      "downloads_url"     => downloads_url,
      "events_url"        => events_url,
      "forks"             => forks,
      "forks_count"       => forks_count,
      "forks_url"         => forks_url,
      "full_name"         => full_name,
      "git_commits_url"   => git_commits_url,
      "git_refs_url"      => git_refs_url,
      "git_tags_url"      => git_tags_url,
      "git_url"           => git_url,
      "has_downloads"     => has_downloads,
      "has_issues"        => has_issues,
      "has_pages"         => has_pages,
      "has_projects"      => has_projects,
      "has_wiki"          => has_wiki,
      "homepage"          => homepage,
      "hooks_url"         => hooks_url,
      "html_url"          => html_url,
      "id"                => id,
      "issue_comment_url" => issue_comment_url,
      "issue_events_url"  => issue_events_url,
      "issues_url"        => issues_url,
      "keys_url"          => keys_url,
      "labels_url"        => labels_url,
      "language"          => language,
      "languages_url"     => languages_url,
      "merges_url"        => merges_url,
      "milestones_url"    => milestones_url,
      "mirror_url"        => mirror_url,
      "notifications_url" => notifications_url,
      "open_issues"       => open_issues,
      "open_issues_count" => open_issues_count,
      "owner"             => owner.to_dynamic,
      "private"           => private,
      "pulls_url"         => pulls_url,
      "pushed_at"         => pushed_at,
      "releases_url"      => releases_url,
      "fork"              => repo_fork,
      "name"              => repo_name,
      "size"              => size,
      "ssh_url"           => ssh_url,
      "stargazers_count"  => stargazers_count,
      "stargazers_url"    => stargazers_url,
      "statuses_url"      => statuses_url,
      "subscribers_url"   => subscribers_url,
      "subscription_url"  => subscription_url,
      "svn_url"           => svn_url,
      "tags_url"          => tags_url,
      "teams_url"         => teams_url,
      "trees_url"         => trees_url,
      "updated_at"        => updated_at,
      "url"               => url,
      "watchers"          => watchers,
      "watchers_count"    => watchers_count,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Base < Dry::Struct
  attribute :label, Types::String
  attribute :ref,   Types::String
  attribute :repo,  BaseRepo
  attribute :sha,   Types::String
  attribute :user,  MergedBy

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      label: d.fetch("label"),
      ref:   d.fetch("ref"),
      repo:  BaseRepo.from_dynamic!(d.fetch("repo")),
      sha:   d.fetch("sha"),
      user:  MergedBy.from_dynamic!(d.fetch("user")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "label" => label,
      "ref"   => ref,
      "repo"  => repo.to_dynamic,
      "sha"   => sha,
      "user"  => user.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Comments < Dry::Struct
  attribute :href, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      href: d.fetch("href"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "href" => href,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Links < Dry::Struct
  attribute :comments,        Comments
  attribute :commits,         Comments
  attribute :html,            Comments
  attribute :issue,           Comments
  attribute :links_self,      Comments
  attribute :review_comment,  Comments
  attribute :review_comments, Comments
  attribute :statuses,        Comments

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comments:        Comments.from_dynamic!(d.fetch("comments")),
      commits:         Comments.from_dynamic!(d.fetch("commits")),
      html:            Comments.from_dynamic!(d.fetch("html")),
      issue:           Comments.from_dynamic!(d.fetch("issue")),
      links_self:      Comments.from_dynamic!(d.fetch("self")),
      review_comment:  Comments.from_dynamic!(d.fetch("review_comment")),
      review_comments: Comments.from_dynamic!(d.fetch("review_comments")),
      statuses:        Comments.from_dynamic!(d.fetch("statuses")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comments"        => comments.to_dynamic,
      "commits"         => commits.to_dynamic,
      "html"            => html.to_dynamic,
      "issue"           => issue.to_dynamic,
      "self"            => links_self.to_dynamic,
      "review_comment"  => review_comment.to_dynamic,
      "review_comments" => review_comments.to_dynamic,
      "statuses"        => statuses.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PullRequest < Dry::Struct
  attribute :additions,             Types::Integer
  attribute :assignee,              Types::Nil
  attribute :assignees,             Types.Array(Types::Any)
  attribute :base,                  Base
  attribute :body,                  Types::String
  attribute :changed_files,         Types::Integer
  attribute :closed_at,             Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :comments,              Types::Integer
  attribute :comments_url,          Types::String
  attribute :commits,               Types::Integer
  attribute :commits_url,           Types::String
  attribute :created_at,            Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :deletions,             Types::Integer
  attribute :diff_url,              Types::String
  attribute :head,                  Base
  attribute :html_url,              Types::String
  attribute :id,                    Types::Integer
  attribute :issue_url,             Types::String
  attribute :links,                 Links
  attribute :locked,                Types::Bool
  attribute :maintainer_can_modify, Types::Bool
  attribute :merge_commit_sha,      Types::String
  attribute :mergeable,             Types::Nil
  attribute :mergeable_state,       Types::String
  attribute :merged,                Types::Bool
  attribute :merged_at,             Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :merged_by,             MergedBy
  attribute :milestone,             Types::Nil
  attribute :number,                Types::Integer
  attribute :patch_url,             Types::String
  attribute :rebaseable,            Types::Nil
  attribute :requested_reviewers,   Types.Array(Types::Any)
  attribute :review_comment_url,    Types::String
  attribute :review_comments,       Types::Integer
  attribute :review_comments_url,   Types::String
  attribute :state,                 Types::String
  attribute :statuses_url,          Types::String
  attribute :title,                 Types::String
  attribute :updated_at,            Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :url,                   Types::String
  attribute :user,                  MergedBy

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      additions:             d.fetch("additions"),
      assignee:              d.fetch("assignee"),
      assignees:             d.fetch("assignees"),
      base:                  Base.from_dynamic!(d.fetch("base")),
      body:                  d.fetch("body"),
      changed_files:         d.fetch("changed_files"),
      closed_at:             d.fetch("closed_at"),
      comments:              d.fetch("comments"),
      comments_url:          d.fetch("comments_url"),
      commits:               d.fetch("commits"),
      commits_url:           d.fetch("commits_url"),
      created_at:            d.fetch("created_at"),
      deletions:             d.fetch("deletions"),
      diff_url:              d.fetch("diff_url"),
      head:                  Base.from_dynamic!(d.fetch("head")),
      html_url:              d.fetch("html_url"),
      id:                    d.fetch("id"),
      issue_url:             d.fetch("issue_url"),
      links:                 Links.from_dynamic!(d.fetch("_links")),
      locked:                d.fetch("locked"),
      maintainer_can_modify: d.fetch("maintainer_can_modify"),
      merge_commit_sha:      d.fetch("merge_commit_sha"),
      mergeable:             d.fetch("mergeable"),
      mergeable_state:       d.fetch("mergeable_state"),
      merged:                d.fetch("merged"),
      merged_at:             d.fetch("merged_at"),
      merged_by:             MergedBy.from_dynamic!(d.fetch("merged_by")),
      milestone:             d.fetch("milestone"),
      number:                d.fetch("number"),
      patch_url:             d.fetch("patch_url"),
      rebaseable:            d.fetch("rebaseable"),
      requested_reviewers:   d.fetch("requested_reviewers"),
      review_comment_url:    d.fetch("review_comment_url"),
      review_comments:       d.fetch("review_comments"),
      review_comments_url:   d.fetch("review_comments_url"),
      state:                 d.fetch("state"),
      statuses_url:          d.fetch("statuses_url"),
      title:                 d.fetch("title"),
      updated_at:            d.fetch("updated_at"),
      url:                   d.fetch("url"),
      user:                  MergedBy.from_dynamic!(d.fetch("user")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "additions"             => additions,
      "assignee"              => assignee,
      "assignees"             => assignees,
      "base"                  => base.to_dynamic,
      "body"                  => body,
      "changed_files"         => changed_files,
      "closed_at"             => closed_at,
      "comments"              => comments,
      "comments_url"          => comments_url,
      "commits"               => commits,
      "commits_url"           => commits_url,
      "created_at"            => created_at,
      "deletions"             => deletions,
      "diff_url"              => diff_url,
      "head"                  => head.to_dynamic,
      "html_url"              => html_url,
      "id"                    => id,
      "issue_url"             => issue_url,
      "_links"                => links.to_dynamic,
      "locked"                => locked,
      "maintainer_can_modify" => maintainer_can_modify,
      "merge_commit_sha"      => merge_commit_sha,
      "mergeable"             => mergeable,
      "mergeable_state"       => mergeable_state,
      "merged"                => merged,
      "merged_at"             => merged_at,
      "merged_by"             => merged_by.to_dynamic,
      "milestone"             => milestone,
      "number"                => number,
      "patch_url"             => patch_url,
      "rebaseable"            => rebaseable,
      "requested_reviewers"   => requested_reviewers,
      "review_comment_url"    => review_comment_url,
      "review_comments"       => review_comments,
      "review_comments_url"   => review_comments_url,
      "state"                 => state,
      "statuses_url"          => statuses_url,
      "title"                 => title,
      "updated_at"            => updated_at,
      "url"                   => url,
      "user"                  => user.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Payload < Dry::Struct
  attribute :action,        Types::String.optional
  attribute :before,        Types::String.optional
  attribute :commits,       Types.Array(Commit).optional
  attribute :description,   Types::String.optional.optional
  attribute :distinct_size, Types::Integer.optional
  attribute :head,          Types::String.optional
  attribute :master_branch, Types::String.optional
  attribute :number,        Types::Integer.optional
  attribute :pull_request,  PullRequest.optional
  attribute :push_id,       Types::Integer.optional
  attribute :pusher_type,   Types::String.optional
  attribute :ref,           Types::String.optional
  attribute :ref_type,      Types::String.optional
  attribute :size,          Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      action:        d.key?("action") ? Types::String[d["action"]] : nil,
      before:        d.key?("before") ? Types::String[d["before"]] : nil,
      commits:       d.key?("commits") ? d["commits"].map { |x| Commit.from_dynamic!(x) } : nil,
      description:   d["description"],
      distinct_size: d.key?("distinct_size") ? Types::Integer[d["distinct_size"]] : nil,
      head:          d.key?("head") ? Types::String[d["head"]] : nil,
      master_branch: d.key?("master_branch") ? Types::String[d["master_branch"]] : nil,
      number:        d.key?("number") ? Types::Integer[d["number"]] : nil,
      pull_request:  d.key?("pull_request") ? PullRequest.from_dynamic!(d["pull_request"]) : nil,
      push_id:       d.key?("push_id") ? Types::Integer[d["push_id"]] : nil,
      pusher_type:   d.key?("pusher_type") ? Types::String[d["pusher_type"]] : nil,
      ref:           d.key?("ref") ? Types::String[d["ref"]] : nil,
      ref_type:      d.key?("ref_type") ? Types::String[d["ref_type"]] : nil,
      size:          d.key?("size") ? Types::Integer[d["size"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "action"        => action,
      "before"        => before,
      "commits"       => commits&.map { |x| x.to_dynamic },
      "description"   => description,
      "distinct_size" => distinct_size,
      "head"          => head,
      "master_branch" => master_branch,
      "number"        => number,
      "pull_request"  => pull_request&.to_dynamic,
      "push_id"       => push_id,
      "pusher_type"   => pusher_type,
      "ref"           => ref,
      "ref_type"      => ref_type,
      "size"          => size,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelRepo < Dry::Struct
  attribute :id,        Types::Integer
  attribute :repo_name, Types::String
  attribute :url,       Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      id:        d.fetch("id"),
      repo_name: d.fetch("name"),
      url:       d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "id"   => id,
      "name" => repo_name,
      "url"  => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Type
  PushEvent        = "PushEvent"
  CreateEvent      = "CreateEvent"
  WatchEvent       = "WatchEvent"
  PullRequestEvent = "PullRequestEvent"
  DeleteEvent      = "DeleteEvent"
end

class TopLevelElement < Dry::Struct
  attribute :actor,          Actor
  attribute :created_at,     Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :id,             Types::String
  attribute :org,            Actor.optional
  attribute :payload,        Payload
  attribute :public,         Types::Bool
  attribute :repo,           TopLevelRepo
  attribute :top_level_type, Types::Type

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      actor:          Actor.from_dynamic!(d.fetch("actor")),
      created_at:     d.fetch("created_at"),
      id:             d.fetch("id"),
      org:            d.key?("org") ? Actor.from_dynamic!(d["org"]) : nil,
      payload:        Payload.from_dynamic!(d.fetch("payload")),
      public:         d.fetch("public"),
      repo:           TopLevelRepo.from_dynamic!(d.fetch("repo")),
      top_level_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "actor"      => actor.to_dynamic,
      "created_at" => created_at,
      "id"         => id,
      "org"        => org&.to_dynamic,
      "payload"    => payload.to_dynamic,
      "public"     => public,
      "repo"       => repo.to_dynamic,
      "type"       => top_level_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel
  def self.from_json!(json)
    top_level = JSON.parse(json, quirks_mode: true).map { |x| TopLevelElement.from_dynamic!(x) }
    top_level.define_singleton_method(:to_json) do
      JSON.generate(self.map { |x| x.to_dynamic })
    end
    top_level
  end
end
