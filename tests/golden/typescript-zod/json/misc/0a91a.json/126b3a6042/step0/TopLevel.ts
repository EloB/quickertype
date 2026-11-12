import * as z from "zod";


export const TypeSchema = z.enum([
    "PushEvent",
    "CreateEvent",
    "WatchEvent",
    "PullRequestEvent",
    "DeleteEvent",
]);
export type Type = z.infer<typeof TypeSchema>;

export const ActorSchema = z.object({
    "avatar_url": z.string(),
    "display_login": z.string().optional(),
    "gravatar_id": z.string(),
    "id": z.number().int(),
    "login": z.string(),
    "url": z.string(),
});
export type Actor = z.infer<typeof ActorSchema>;

export const AuthorSchema = z.object({
    "email": z.string(),
    "name": z.string(),
});
export type Author = z.infer<typeof AuthorSchema>;

export const MergedBySchema = z.object({
    "avatar_url": z.string(),
    "events_url": z.string(),
    "followers_url": z.string(),
    "following_url": z.string(),
    "gists_url": z.string(),
    "gravatar_id": z.string(),
    "html_url": z.string(),
    "id": z.number().int(),
    "login": z.string(),
    "organizations_url": z.string(),
    "received_events_url": z.string(),
    "repos_url": z.string(),
    "site_admin": z.boolean(),
    "starred_url": z.string(),
    "subscriptions_url": z.string(),
    "type": z.string(),
    "url": z.string(),
});
export type MergedBy = z.infer<typeof MergedBySchema>;

export const CommentsSchema = z.object({
    "href": z.string(),
});
export type Comments = z.infer<typeof CommentsSchema>;

export const TopLevelRepoSchema = z.object({
    "id": z.number().int(),
    "name": z.string(),
    "url": z.string(),
});
export type TopLevelRepo = z.infer<typeof TopLevelRepoSchema>;

export const CommitSchema = z.object({
    "author": AuthorSchema,
    "distinct": z.boolean(),
    "message": z.string(),
    "sha": z.string(),
    "url": z.string(),
});
export type Commit = z.infer<typeof CommitSchema>;

export const BaseRepoSchema = z.object({
    "archive_url": z.string(),
    "assignees_url": z.string(),
    "blobs_url": z.string(),
    "branches_url": z.string(),
    "clone_url": z.string(),
    "collaborators_url": z.string(),
    "comments_url": z.string(),
    "commits_url": z.string(),
    "compare_url": z.string(),
    "contents_url": z.string(),
    "contributors_url": z.string(),
    "created_at": z.string().pipe(z.coerce.date()),
    "default_branch": z.string(),
    "deployments_url": z.string(),
    "description": z.null(),
    "downloads_url": z.string(),
    "events_url": z.string(),
    "fork": z.boolean(),
    "forks": z.number().int(),
    "forks_count": z.number().int(),
    "forks_url": z.string(),
    "full_name": z.string(),
    "git_commits_url": z.string(),
    "git_refs_url": z.string(),
    "git_tags_url": z.string(),
    "git_url": z.string(),
    "has_downloads": z.boolean(),
    "has_issues": z.boolean(),
    "has_pages": z.boolean(),
    "has_projects": z.boolean(),
    "has_wiki": z.boolean(),
    "homepage": z.null(),
    "hooks_url": z.string(),
    "html_url": z.string(),
    "id": z.number().int(),
    "issue_comment_url": z.string(),
    "issue_events_url": z.string(),
    "issues_url": z.string(),
    "keys_url": z.string(),
    "labels_url": z.string(),
    "language": z.string(),
    "languages_url": z.string(),
    "merges_url": z.string(),
    "milestones_url": z.string(),
    "mirror_url": z.null(),
    "name": z.string(),
    "notifications_url": z.string(),
    "open_issues": z.number().int(),
    "open_issues_count": z.number().int(),
    "owner": MergedBySchema,
    "private": z.boolean(),
    "pulls_url": z.string(),
    "pushed_at": z.string().pipe(z.coerce.date()),
    "releases_url": z.string(),
    "size": z.number().int(),
    "ssh_url": z.string(),
    "stargazers_count": z.number().int(),
    "stargazers_url": z.string(),
    "statuses_url": z.string(),
    "subscribers_url": z.string(),
    "subscription_url": z.string(),
    "svn_url": z.string(),
    "tags_url": z.string(),
    "teams_url": z.string(),
    "trees_url": z.string(),
    "updated_at": z.string().pipe(z.coerce.date()),
    "url": z.string(),
    "watchers": z.number().int(),
    "watchers_count": z.number().int(),
});
export type BaseRepo = z.infer<typeof BaseRepoSchema>;

export const LinksSchema = z.object({
    "comments": CommentsSchema,
    "commits": CommentsSchema,
    "html": CommentsSchema,
    "issue": CommentsSchema,
    "review_comment": CommentsSchema,
    "review_comments": CommentsSchema,
    "self": CommentsSchema,
    "statuses": CommentsSchema,
});
export type Links = z.infer<typeof LinksSchema>;

export const BaseSchema = z.object({
    "label": z.string(),
    "ref": z.string(),
    "repo": BaseRepoSchema,
    "sha": z.string(),
    "user": MergedBySchema,
});
export type Base = z.infer<typeof BaseSchema>;

export const PullRequestSchema = z.object({
    "additions": z.number().int(),
    "assignee": z.null(),
    "assignees": z.array(z.any()),
    "base": BaseSchema,
    "body": z.string(),
    "changed_files": z.number().int(),
    "closed_at": z.string().pipe(z.coerce.date()),
    "comments": z.number().int(),
    "comments_url": z.string(),
    "commits": z.number().int(),
    "commits_url": z.string(),
    "created_at": z.string().pipe(z.coerce.date()),
    "deletions": z.number().int(),
    "diff_url": z.string(),
    "head": BaseSchema,
    "html_url": z.string(),
    "id": z.number().int(),
    "issue_url": z.string(),
    "_links": LinksSchema,
    "locked": z.boolean(),
    "maintainer_can_modify": z.boolean(),
    "merge_commit_sha": z.string(),
    "mergeable": z.null(),
    "mergeable_state": z.string(),
    "merged": z.boolean(),
    "merged_at": z.string().pipe(z.coerce.date()),
    "merged_by": MergedBySchema,
    "milestone": z.null(),
    "number": z.number().int(),
    "patch_url": z.string(),
    "rebaseable": z.null(),
    "requested_reviewers": z.array(z.any()),
    "review_comment_url": z.string(),
    "review_comments": z.number().int(),
    "review_comments_url": z.string(),
    "state": z.string(),
    "statuses_url": z.string(),
    "title": z.string(),
    "updated_at": z.string().pipe(z.coerce.date()),
    "url": z.string(),
    "user": MergedBySchema,
});
export type PullRequest = z.infer<typeof PullRequestSchema>;

export const PayloadSchema = z.object({
    "action": z.string().optional(),
    "before": z.string().optional(),
    "commits": z.array(CommitSchema).optional(),
    "description": z.union([z.null(), z.string()]).optional(),
    "distinct_size": z.number().int().optional(),
    "head": z.string().optional(),
    "master_branch": z.string().optional(),
    "number": z.number().int().optional(),
    "pull_request": PullRequestSchema.optional(),
    "push_id": z.number().int().optional(),
    "pusher_type": z.string().optional(),
    "ref": z.string().optional(),
    "ref_type": z.string().optional(),
    "size": z.number().int().optional(),
});
export type Payload = z.infer<typeof PayloadSchema>;

export const TopLevelElementSchema = z.object({
    "actor": ActorSchema,
    "created_at": z.string().pipe(z.coerce.date()),
    "id": z.string(),
    "org": ActorSchema.optional(),
    "payload": PayloadSchema,
    "public": z.boolean(),
    "repo": TopLevelRepoSchema,
    "type": TypeSchema,
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
