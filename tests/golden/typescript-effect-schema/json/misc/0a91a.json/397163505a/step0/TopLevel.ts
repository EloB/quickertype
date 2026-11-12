import * as S from "effect/Schema";


export const Type = S.Literal(
    "PushEvent",
    "CreateEvent",
    "WatchEvent",
    "PullRequestEvent",
    "DeleteEvent",
);
export type Type = S.Schema.Type<typeof Type>;

export class TopLevelRepo extends S.Class<TopLevelRepo>("TopLevelRepo")({
    "id": S.Int,
    "name": S.String,
    "url": S.String,
}) {}

export class Comments extends S.Class<Comments>("Comments")({
    "href": S.String,
}) {}

export class Links extends S.Class<Links>("Links")({
    "comments": Comments,
    "commits": Comments,
    "html": Comments,
    "issue": Comments,
    "review_comment": Comments,
    "review_comments": Comments,
    "self": Comments,
    "statuses": Comments,
}) {}

export class MergedBy extends S.Class<MergedBy>("MergedBy")({
    "avatar_url": S.String,
    "events_url": S.String,
    "followers_url": S.String,
    "following_url": S.String,
    "gists_url": S.String,
    "gravatar_id": S.String,
    "html_url": S.String,
    "id": S.Int,
    "login": S.String,
    "organizations_url": S.String,
    "received_events_url": S.String,
    "repos_url": S.String,
    "site_admin": S.Boolean,
    "starred_url": S.String,
    "subscriptions_url": S.String,
    "type": S.String,
    "url": S.String,
}) {}

export class BaseRepo extends S.Class<BaseRepo>("BaseRepo")({
    "archive_url": S.String,
    "assignees_url": S.String,
    "blobs_url": S.String,
    "branches_url": S.String,
    "clone_url": S.String,
    "collaborators_url": S.String,
    "comments_url": S.String,
    "commits_url": S.String,
    "compare_url": S.String,
    "contents_url": S.String,
    "contributors_url": S.String,
    "created_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "default_branch": S.String,
    "deployments_url": S.String,
    "description": S.Null,
    "downloads_url": S.String,
    "events_url": S.String,
    "fork": S.Boolean,
    "forks": S.Int,
    "forks_count": S.Int,
    "forks_url": S.String,
    "full_name": S.String,
    "git_commits_url": S.String,
    "git_refs_url": S.String,
    "git_tags_url": S.String,
    "git_url": S.String,
    "has_downloads": S.Boolean,
    "has_issues": S.Boolean,
    "has_pages": S.Boolean,
    "has_projects": S.Boolean,
    "has_wiki": S.Boolean,
    "homepage": S.Null,
    "hooks_url": S.String,
    "html_url": S.String,
    "id": S.Int,
    "issue_comment_url": S.String,
    "issue_events_url": S.String,
    "issues_url": S.String,
    "keys_url": S.String,
    "labels_url": S.String,
    "language": S.String,
    "languages_url": S.String,
    "merges_url": S.String,
    "milestones_url": S.String,
    "mirror_url": S.Null,
    "name": S.String,
    "notifications_url": S.String,
    "open_issues": S.Int,
    "open_issues_count": S.Int,
    "owner": MergedBy,
    "private": S.Boolean,
    "pulls_url": S.String,
    "pushed_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "releases_url": S.String,
    "size": S.Int,
    "ssh_url": S.String,
    "stargazers_count": S.Int,
    "stargazers_url": S.String,
    "statuses_url": S.String,
    "subscribers_url": S.String,
    "subscription_url": S.String,
    "svn_url": S.String,
    "tags_url": S.String,
    "teams_url": S.String,
    "trees_url": S.String,
    "updated_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "url": S.String,
    "watchers": S.Int,
    "watchers_count": S.Int,
}) {}

export class Base extends S.Class<Base>("Base")({
    "label": S.String,
    "ref": S.String,
    "repo": BaseRepo,
    "sha": S.String,
    "user": MergedBy,
}) {}

export class PullRequest extends S.Class<PullRequest>("PullRequest")({
    "additions": S.Int,
    "assignee": S.Null,
    "assignees": S.Array(S.Any),
    "base": Base,
    "body": S.String,
    "changed_files": S.Int,
    "closed_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "comments": S.Int,
    "comments_url": S.String,
    "commits": S.Int,
    "commits_url": S.String,
    "created_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "deletions": S.Int,
    "diff_url": S.String,
    "head": Base,
    "html_url": S.String,
    "id": S.Int,
    "issue_url": S.String,
    "_links": Links,
    "locked": S.Boolean,
    "maintainer_can_modify": S.Boolean,
    "merge_commit_sha": S.String,
    "mergeable": S.Null,
    "mergeable_state": S.String,
    "merged": S.Boolean,
    "merged_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "merged_by": MergedBy,
    "milestone": S.Null,
    "number": S.Int,
    "patch_url": S.String,
    "rebaseable": S.Null,
    "requested_reviewers": S.Array(S.Any),
    "review_comment_url": S.String,
    "review_comments": S.Int,
    "review_comments_url": S.String,
    "state": S.String,
    "statuses_url": S.String,
    "title": S.String,
    "updated_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "url": S.String,
    "user": MergedBy,
}) {}

export class Author extends S.Class<Author>("Author")({
    "email": S.String,
    "name": S.String,
}) {}

export class Commit extends S.Class<Commit>("Commit")({
    "author": Author,
    "distinct": S.Boolean,
    "message": S.String,
    "sha": S.String,
    "url": S.String,
}) {}

export class Payload extends S.Class<Payload>("Payload")({
    "action": S.optional(S.String),
    "before": S.optional(S.String),
    "commits": S.optional(S.Array(Commit)),
    "description": S.optional(S.NullOr(S.String)),
    "distinct_size": S.optional(S.Int),
    "head": S.optional(S.String),
    "master_branch": S.optional(S.String),
    "number": S.optional(S.Int),
    "pull_request": S.optional(PullRequest),
    "push_id": S.optional(S.Int),
    "pusher_type": S.optional(S.String),
    "ref": S.optional(S.String),
    "ref_type": S.optional(S.String),
    "size": S.optional(S.Int),
}) {}

export class Actor extends S.Class<Actor>("Actor")({
    "avatar_url": S.String,
    "display_login": S.optional(S.String),
    "gravatar_id": S.String,
    "id": S.Int,
    "login": S.String,
    "url": S.String,
}) {}

export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "actor": Actor,
    "created_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "id": S.String,
    "org": S.optional(Actor),
    "payload": Payload,
    "public": S.Boolean,
    "repo": TopLevelRepo,
    "type": Type,
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
