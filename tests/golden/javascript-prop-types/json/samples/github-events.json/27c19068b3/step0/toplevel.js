// Example usage:
//
// import { MyShape } from ./myShape.js;
//
// class MyComponent extends React.Component {
//   //
// }
//
// MyComponent.propTypes = {
//   input: MyShape
// };

import PropTypes from "prop-types";
const Integer = (props, name) => props[name] == null || Number.isInteger(props[name]) ? null : new Error("Expected integer");

let _TopLevel;
let _Actor;
let _Payload;
let _Comment;
let _User;
let _Commit;
let _Author;
let _Issue;
let _Label;
let _Milestone;
let _IssuePullRequest;
let _PayloadPullRequest;
let _Links;
let _Comments;
let _Base;
let _BaseRepo;
let _TopLevelRepo;
const _Type = PropTypes.oneOf(['User', 'Organization']);
_Actor = PropTypes.shape({
    "avatar_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "display_login": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "gravatar_id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "login": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_User = PropTypes.shape({
    "avatar_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "events_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "followers_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "following_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "gists_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "gravatar_id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "html_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "login": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "organizations_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "received_events_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "repos_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "site_admin": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "starred_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "subscriptions_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": _Type,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Comment = PropTypes.shape({
    "body": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "html_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "issue_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "user": _User,
});
_Author = PropTypes.shape({
    "email": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Commit = PropTypes.shape({
    "author": _Author,
    "distinct": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "message": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sha": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Label = PropTypes.shape({
    "color": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "default": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Milestone = PropTypes.shape({
    "closed_at": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "closed_issues": PropTypes.oneOfType([Integer]).isRequired,
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "creator": _User,
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "due_on": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time"), PropTypes.oneOf([null])])])(props, name, ...args),
    "html_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "labels_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "number": PropTypes.oneOfType([Integer]).isRequired,
    "open_issues": PropTypes.oneOfType([Integer]).isRequired,
    "state": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_IssuePullRequest = PropTypes.shape({
    "diff_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "html_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "patch_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Issue = PropTypes.shape({
    "assignee": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "assignees": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "body": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "closed_at": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time"), PropTypes.oneOf([null])])])(props, name, ...args),
    "comments": PropTypes.oneOfType([Integer]).isRequired,
    "comments_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "events_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "html_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "labels": PropTypes.oneOfType([PropTypes.arrayOf(_Label)]).isRequired,
    "labels_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "locked": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "milestone": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_Milestone, PropTypes.oneOf([null])])])(props, name, ...args),
    "number": PropTypes.oneOfType([Integer]).isRequired,
    "pull_request": PropTypes.oneOfType([_IssuePullRequest, PropTypes.oneOf([null])]),
    "repository_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "state": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "user": _User,
});
_Comments = PropTypes.shape({
    "href": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Links = PropTypes.shape({
    "comments": _Comments,
    "commits": _Comments,
    "html": _Comments,
    "issue": _Comments,
    "review_comment": _Comments,
    "review_comments": _Comments,
    "self": _Comments,
    "statuses": _Comments,
});
_BaseRepo = PropTypes.shape({
    "archive_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "assignees_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "blobs_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "branches_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "clone_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "collaborators_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "comments_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "commits_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "compare_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "contents_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "contributors_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "default_branch": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "deployments_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "downloads_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "events_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "fork": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "forks": PropTypes.oneOfType([Integer]).isRequired,
    "forks_count": PropTypes.oneOfType([Integer]).isRequired,
    "forks_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "full_name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "git_commits_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "git_refs_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "git_tags_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "git_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "has_downloads": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "has_issues": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "has_pages": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "has_projects": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "has_wiki": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "homepage": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "hooks_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "html_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "issue_comment_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "issue_events_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "issues_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "keys_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "labels_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "language": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "languages_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "merges_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "milestones_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "mirror_url": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "notifications_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "open_issues": PropTypes.oneOfType([Integer]).isRequired,
    "open_issues_count": PropTypes.oneOfType([Integer]).isRequired,
    "owner": _User,
    "private": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "pulls_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "pushed_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "releases_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "size": PropTypes.oneOfType([Integer]).isRequired,
    "ssh_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "stargazers_count": PropTypes.oneOfType([Integer]).isRequired,
    "stargazers_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "statuses_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "subscribers_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "subscription_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "svn_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tags_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "teams_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "trees_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "watchers": PropTypes.oneOfType([Integer]).isRequired,
    "watchers_count": PropTypes.oneOfType([Integer]).isRequired,
});
_Base = PropTypes.shape({
    "label": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "ref": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "repo": _BaseRepo,
    "sha": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "user": _User,
});
_PayloadPullRequest = PropTypes.shape({
    "_links": _Links,
    "additions": PropTypes.oneOfType([Integer]).isRequired,
    "assignee": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "assignees": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "base": _Base,
    "body": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "changed_files": PropTypes.oneOfType([Integer]).isRequired,
    "closed_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "comments": PropTypes.oneOfType([Integer]).isRequired,
    "comments_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "commits": PropTypes.oneOfType([Integer]).isRequired,
    "commits_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "deletions": PropTypes.oneOfType([Integer]).isRequired,
    "diff_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "head": _Base,
    "html_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "issue_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "locked": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "maintainer_can_modify": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "merge_commit_sha": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "mergeable": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "mergeable_state": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "merged": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "merged_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "merged_by": _User,
    "milestone": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "number": PropTypes.oneOfType([Integer]).isRequired,
    "patch_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "rebaseable": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "requested_reviewers": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "review_comment_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "review_comments": PropTypes.oneOfType([Integer]).isRequired,
    "review_comments_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "state": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "statuses_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "updated_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "user": _User,
});
_Payload = PropTypes.shape({
    "action": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "before": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "comment": PropTypes.oneOfType([_Comment, PropTypes.oneOf([null])]),
    "commits": PropTypes.oneOfType([PropTypes.arrayOf(_Commit), PropTypes.oneOf([null])]),
    "description": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "distinct_size": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "head": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "issue": PropTypes.oneOfType([_Issue, PropTypes.oneOf([null])]),
    "master_branch": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "number": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "pull_request": PropTypes.oneOfType([_PayloadPullRequest, PropTypes.oneOf([null])]),
    "push_id": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "pusher_type": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "ref": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "ref_type": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "size": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
});
_TopLevelRepo = PropTypes.shape({
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "actor": _Actor,
    "created_at": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "org": PropTypes.oneOfType([_Actor, PropTypes.oneOf([null])]),
    "payload": _Payload,
    "public": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "repo": _TopLevelRepo,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
