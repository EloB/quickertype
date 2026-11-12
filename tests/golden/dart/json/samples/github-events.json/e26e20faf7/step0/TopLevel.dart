// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<TopLevel> topLevelFromJson(String str) => List<TopLevel>.from(json.decode(str).map((x) => TopLevel.fromJson(x)));

String topLevelToJson(List<TopLevel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopLevel {
    final Actor actor;
    final DateTime createdAt;
    final String id;
    final Actor? org;
    final Payload payload;
    final bool public;
    final TopLevelRepo repo;
    final String type;

    TopLevel({
        required this.actor,
        required this.createdAt,
        required this.id,
        this.org,
        required this.payload,
        required this.public,
        required this.repo,
        required this.type,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        actor: Actor.fromJson(json["actor"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        org: json["org"] == null ? null : Actor.fromJson(json["org"]),
        payload: Payload.fromJson(json["payload"]),
        public: json["public"],
        repo: TopLevelRepo.fromJson(json["repo"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "actor": actor.toJson(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "org": org?.toJson(),
        "payload": payload.toJson(),
        "public": public,
        "repo": repo.toJson(),
        "type": type,
    };
}

class Actor {
    final String avatarUrl;
    final String? displayLogin;
    final String gravatarId;
    final int id;
    final String login;
    final String url;

    Actor({
        required this.avatarUrl,
        this.displayLogin,
        required this.gravatarId,
        required this.id,
        required this.login,
        required this.url,
    });

    factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        avatarUrl: json["avatar_url"],
        displayLogin: json["display_login"],
        gravatarId: json["gravatar_id"],
        id: json["id"],
        login: json["login"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "display_login": displayLogin,
        "gravatar_id": gravatarId,
        "id": id,
        "login": login,
        "url": url,
    };
}

class Payload {
    final String? action;
    final String? before;
    final Comment? comment;
    final List<Commit>? commits;
    final String? description;
    final int? distinctSize;
    final String? head;
    final Issue? issue;
    final String? masterBranch;
    final int? number;
    final PayloadPullRequest? pullRequest;
    final int? pushId;
    final String? pusherType;
    final String? ref;
    final String? refType;
    final int? size;

    Payload({
        this.action,
        this.before,
        this.comment,
        this.commits,
        this.description,
        this.distinctSize,
        this.head,
        this.issue,
        this.masterBranch,
        this.number,
        this.pullRequest,
        this.pushId,
        this.pusherType,
        this.ref,
        this.refType,
        this.size,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        action: json["action"],
        before: json["before"],
        comment: json["comment"] == null ? null : Comment.fromJson(json["comment"]),
        commits: json["commits"] == null ? null : List<Commit>.from(json["commits"]!.map((x) => Commit.fromJson(x))),
        description: json["description"],
        distinctSize: json["distinct_size"],
        head: json["head"],
        issue: json["issue"] == null ? null : Issue.fromJson(json["issue"]),
        masterBranch: json["master_branch"],
        number: json["number"],
        pullRequest: json["pull_request"] == null ? null : PayloadPullRequest.fromJson(json["pull_request"]),
        pushId: json["push_id"],
        pusherType: json["pusher_type"],
        ref: json["ref"],
        refType: json["ref_type"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "action": action,
        "before": before,
        "comment": comment?.toJson(),
        "commits": commits == null ? null : List<dynamic>.from(commits!.map((x) => x.toJson())),
        "description": description,
        "distinct_size": distinctSize,
        "head": head,
        "issue": issue?.toJson(),
        "master_branch": masterBranch,
        "number": number,
        "pull_request": pullRequest?.toJson(),
        "push_id": pushId,
        "pusher_type": pusherType,
        "ref": ref,
        "ref_type": refType,
        "size": size,
    };
}

class Comment {
    final String body;
    final DateTime createdAt;
    final String htmlUrl;
    final int id;
    final String issueUrl;
    final DateTime updatedAt;
    final String url;
    final User user;

    Comment({
        required this.body,
        required this.createdAt,
        required this.htmlUrl,
        required this.id,
        required this.issueUrl,
        required this.updatedAt,
        required this.url,
        required this.user,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        htmlUrl: json["html_url"],
        id: json["id"],
        issueUrl: json["issue_url"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "body": body,
        "created_at": createdAt.toIso8601String(),
        "html_url": htmlUrl,
        "id": id,
        "issue_url": issueUrl,
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
        "user": user.toJson(),
    };
}

class User {
    final String avatarUrl;
    final String eventsUrl;
    final String followersUrl;
    final String followingUrl;
    final String gistsUrl;
    final String gravatarId;
    final String htmlUrl;
    final int id;
    final String login;
    final String organizationsUrl;
    final String receivedEventsUrl;
    final String reposUrl;
    final bool siteAdmin;
    final String starredUrl;
    final String subscriptionsUrl;
    final Type type;
    final String url;

    User({
        required this.avatarUrl,
        required this.eventsUrl,
        required this.followersUrl,
        required this.followingUrl,
        required this.gistsUrl,
        required this.gravatarId,
        required this.htmlUrl,
        required this.id,
        required this.login,
        required this.organizationsUrl,
        required this.receivedEventsUrl,
        required this.reposUrl,
        required this.siteAdmin,
        required this.starredUrl,
        required this.subscriptionsUrl,
        required this.type,
        required this.url,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        avatarUrl: json["avatar_url"],
        eventsUrl: json["events_url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        gravatarId: json["gravatar_id"],
        htmlUrl: json["html_url"],
        id: json["id"],
        login: json["login"],
        organizationsUrl: json["organizations_url"],
        receivedEventsUrl: json["received_events_url"],
        reposUrl: json["repos_url"],
        siteAdmin: json["site_admin"],
        starredUrl: json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"],
        type: typeValues.map[json["type"]]!,
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "events_url": eventsUrl,
        "followers_url": followersUrl,
        "following_url": followingUrl,
        "gists_url": gistsUrl,
        "gravatar_id": gravatarId,
        "html_url": htmlUrl,
        "id": id,
        "login": login,
        "organizations_url": organizationsUrl,
        "received_events_url": receivedEventsUrl,
        "repos_url": reposUrl,
        "site_admin": siteAdmin,
        "starred_url": starredUrl,
        "subscriptions_url": subscriptionsUrl,
        "type": typeValues.reverse[type],
        "url": url,
    };
}

enum Type {
    USER,
    ORGANIZATION
}

final typeValues = EnumValues({
    "User": Type.USER,
    "Organization": Type.ORGANIZATION
});

class Commit {
    final Author author;
    final bool distinct;
    final String message;
    final String sha;
    final String url;

    Commit({
        required this.author,
        required this.distinct,
        required this.message,
        required this.sha,
        required this.url,
    });

    factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        author: Author.fromJson(json["author"]),
        distinct: json["distinct"],
        message: json["message"],
        sha: json["sha"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "author": author.toJson(),
        "distinct": distinct,
        "message": message,
        "sha": sha,
        "url": url,
    };
}

class Author {
    final String email;
    final String name;

    Author({
        required this.email,
        required this.name,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        email: json["email"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
    };
}

class Issue {
    final dynamic assignee;
    final List<dynamic> assignees;
    final String body;
    final DateTime? closedAt;
    final int comments;
    final String commentsUrl;
    final DateTime createdAt;
    final String eventsUrl;
    final String htmlUrl;
    final int id;
    final List<Label> labels;
    final String labelsUrl;
    final bool locked;
    final Milestone? milestone;
    final int number;
    final IssuePullRequest? pullRequest;
    final String repositoryUrl;
    final String state;
    final String title;
    final DateTime updatedAt;
    final String url;
    final User user;

    Issue({
        required this.assignee,
        required this.assignees,
        required this.body,
        required this.closedAt,
        required this.comments,
        required this.commentsUrl,
        required this.createdAt,
        required this.eventsUrl,
        required this.htmlUrl,
        required this.id,
        required this.labels,
        required this.labelsUrl,
        required this.locked,
        required this.milestone,
        required this.number,
        this.pullRequest,
        required this.repositoryUrl,
        required this.state,
        required this.title,
        required this.updatedAt,
        required this.url,
        required this.user,
    });

    factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        assignee: (json.containsKey("assignee") ? json["assignee"] : throw FormatException('Missing required property')),
        assignees: List<dynamic>.from(json["assignees"].map((x) => x)),
        body: json["body"],
        closedAt: (json.containsKey("closed_at") ? json["closed_at"] : throw FormatException('Missing required property')) == null ? null : DateTime.parse((json.containsKey("closed_at") ? json["closed_at"] : throw FormatException('Missing required property'))),
        comments: json["comments"],
        commentsUrl: json["comments_url"],
        createdAt: DateTime.parse(json["created_at"]),
        eventsUrl: json["events_url"],
        htmlUrl: json["html_url"],
        id: json["id"],
        labels: List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
        labelsUrl: json["labels_url"],
        locked: json["locked"],
        milestone: (json.containsKey("milestone") ? json["milestone"] : throw FormatException('Missing required property')) == null ? null : Milestone.fromJson((json.containsKey("milestone") ? json["milestone"] : throw FormatException('Missing required property'))),
        number: json["number"],
        pullRequest: json["pull_request"] == null ? null : IssuePullRequest.fromJson(json["pull_request"]),
        repositoryUrl: json["repository_url"],
        state: json["state"],
        title: json["title"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "assignee": assignee,
        "assignees": List<dynamic>.from(assignees.map((x) => x)),
        "body": body,
        "closed_at": closedAt?.toIso8601String(),
        "comments": comments,
        "comments_url": commentsUrl,
        "created_at": createdAt.toIso8601String(),
        "events_url": eventsUrl,
        "html_url": htmlUrl,
        "id": id,
        "labels": List<dynamic>.from(labels.map((x) => x.toJson())),
        "labels_url": labelsUrl,
        "locked": locked,
        "milestone": milestone?.toJson(),
        "number": number,
        "pull_request": pullRequest?.toJson(),
        "repository_url": repositoryUrl,
        "state": state,
        "title": title,
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
        "user": user.toJson(),
    };
}

class Label {
    final String color;
    final int id;
    final bool labelDefault;
    final String name;
    final String url;

    Label({
        required this.color,
        required this.id,
        required this.labelDefault,
        required this.name,
        required this.url,
    });

    factory Label.fromJson(Map<String, dynamic> json) => Label(
        color: json["color"],
        id: json["id"],
        labelDefault: json["default"],
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "color": color,
        "id": id,
        "default": labelDefault,
        "name": name,
        "url": url,
    };
}

class Milestone {
    final dynamic closedAt;
    final int closedIssues;
    final DateTime createdAt;
    final User creator;
    final String description;
    final DateTime? dueOn;
    final String htmlUrl;
    final int id;
    final String labelsUrl;
    final int number;
    final int openIssues;
    final String state;
    final String title;
    final DateTime updatedAt;
    final String url;

    Milestone({
        required this.closedAt,
        required this.closedIssues,
        required this.createdAt,
        required this.creator,
        required this.description,
        required this.dueOn,
        required this.htmlUrl,
        required this.id,
        required this.labelsUrl,
        required this.number,
        required this.openIssues,
        required this.state,
        required this.title,
        required this.updatedAt,
        required this.url,
    });

    factory Milestone.fromJson(Map<String, dynamic> json) => Milestone(
        closedAt: (json.containsKey("closed_at") ? json["closed_at"] : throw FormatException('Missing required property')),
        closedIssues: json["closed_issues"],
        createdAt: DateTime.parse(json["created_at"]),
        creator: User.fromJson(json["creator"]),
        description: json["description"],
        dueOn: (json.containsKey("due_on") ? json["due_on"] : throw FormatException('Missing required property')) == null ? null : DateTime.parse((json.containsKey("due_on") ? json["due_on"] : throw FormatException('Missing required property'))),
        htmlUrl: json["html_url"],
        id: json["id"],
        labelsUrl: json["labels_url"],
        number: json["number"],
        openIssues: json["open_issues"],
        state: json["state"],
        title: json["title"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "closed_at": closedAt,
        "closed_issues": closedIssues,
        "created_at": createdAt.toIso8601String(),
        "creator": creator.toJson(),
        "description": description,
        "due_on": dueOn?.toIso8601String(),
        "html_url": htmlUrl,
        "id": id,
        "labels_url": labelsUrl,
        "number": number,
        "open_issues": openIssues,
        "state": state,
        "title": title,
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
    };
}

class IssuePullRequest {
    final String diffUrl;
    final String htmlUrl;
    final String patchUrl;
    final String url;

    IssuePullRequest({
        required this.diffUrl,
        required this.htmlUrl,
        required this.patchUrl,
        required this.url,
    });

    factory IssuePullRequest.fromJson(Map<String, dynamic> json) => IssuePullRequest(
        diffUrl: json["diff_url"],
        htmlUrl: json["html_url"],
        patchUrl: json["patch_url"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "diff_url": diffUrl,
        "html_url": htmlUrl,
        "patch_url": patchUrl,
        "url": url,
    };
}

class PayloadPullRequest {
    final int additions;
    final dynamic assignee;
    final List<dynamic> assignees;
    final Base base;
    final String body;
    final int changedFiles;
    final DateTime closedAt;
    final int comments;
    final String commentsUrl;
    final int commits;
    final String commitsUrl;
    final DateTime createdAt;
    final int deletions;
    final String diffUrl;
    final Base head;
    final String htmlUrl;
    final int id;
    final String issueUrl;
    final Links links;
    final bool locked;
    final bool maintainerCanModify;
    final String mergeCommitSha;
    final dynamic mergeable;
    final String mergeableState;
    final bool merged;
    final DateTime mergedAt;
    final User mergedBy;
    final dynamic milestone;
    final int number;
    final String patchUrl;
    final dynamic rebaseable;
    final List<dynamic> requestedReviewers;
    final String reviewCommentUrl;
    final int reviewComments;
    final String reviewCommentsUrl;
    final String state;
    final String statusesUrl;
    final String title;
    final DateTime updatedAt;
    final String url;
    final User user;

    PayloadPullRequest({
        required this.additions,
        required this.assignee,
        required this.assignees,
        required this.base,
        required this.body,
        required this.changedFiles,
        required this.closedAt,
        required this.comments,
        required this.commentsUrl,
        required this.commits,
        required this.commitsUrl,
        required this.createdAt,
        required this.deletions,
        required this.diffUrl,
        required this.head,
        required this.htmlUrl,
        required this.id,
        required this.issueUrl,
        required this.links,
        required this.locked,
        required this.maintainerCanModify,
        required this.mergeCommitSha,
        required this.mergeable,
        required this.mergeableState,
        required this.merged,
        required this.mergedAt,
        required this.mergedBy,
        required this.milestone,
        required this.number,
        required this.patchUrl,
        required this.rebaseable,
        required this.requestedReviewers,
        required this.reviewCommentUrl,
        required this.reviewComments,
        required this.reviewCommentsUrl,
        required this.state,
        required this.statusesUrl,
        required this.title,
        required this.updatedAt,
        required this.url,
        required this.user,
    });

    factory PayloadPullRequest.fromJson(Map<String, dynamic> json) => PayloadPullRequest(
        additions: json["additions"],
        assignee: (json.containsKey("assignee") ? json["assignee"] : throw FormatException('Missing required property')),
        assignees: List<dynamic>.from(json["assignees"].map((x) => x)),
        base: Base.fromJson(json["base"]),
        body: json["body"],
        changedFiles: json["changed_files"],
        closedAt: DateTime.parse(json["closed_at"]),
        comments: json["comments"],
        commentsUrl: json["comments_url"],
        commits: json["commits"],
        commitsUrl: json["commits_url"],
        createdAt: DateTime.parse(json["created_at"]),
        deletions: json["deletions"],
        diffUrl: json["diff_url"],
        head: Base.fromJson(json["head"]),
        htmlUrl: json["html_url"],
        id: json["id"],
        issueUrl: json["issue_url"],
        links: Links.fromJson(json["_links"]),
        locked: json["locked"],
        maintainerCanModify: json["maintainer_can_modify"],
        mergeCommitSha: json["merge_commit_sha"],
        mergeable: (json.containsKey("mergeable") ? json["mergeable"] : throw FormatException('Missing required property')),
        mergeableState: json["mergeable_state"],
        merged: json["merged"],
        mergedAt: DateTime.parse(json["merged_at"]),
        mergedBy: User.fromJson(json["merged_by"]),
        milestone: (json.containsKey("milestone") ? json["milestone"] : throw FormatException('Missing required property')),
        number: json["number"],
        patchUrl: json["patch_url"],
        rebaseable: (json.containsKey("rebaseable") ? json["rebaseable"] : throw FormatException('Missing required property')),
        requestedReviewers: List<dynamic>.from(json["requested_reviewers"].map((x) => x)),
        reviewCommentUrl: json["review_comment_url"],
        reviewComments: json["review_comments"],
        reviewCommentsUrl: json["review_comments_url"],
        state: json["state"],
        statusesUrl: json["statuses_url"],
        title: json["title"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "additions": additions,
        "assignee": assignee,
        "assignees": List<dynamic>.from(assignees.map((x) => x)),
        "base": base.toJson(),
        "body": body,
        "changed_files": changedFiles,
        "closed_at": closedAt.toIso8601String(),
        "comments": comments,
        "comments_url": commentsUrl,
        "commits": commits,
        "commits_url": commitsUrl,
        "created_at": createdAt.toIso8601String(),
        "deletions": deletions,
        "diff_url": diffUrl,
        "head": head.toJson(),
        "html_url": htmlUrl,
        "id": id,
        "issue_url": issueUrl,
        "_links": links.toJson(),
        "locked": locked,
        "maintainer_can_modify": maintainerCanModify,
        "merge_commit_sha": mergeCommitSha,
        "mergeable": mergeable,
        "mergeable_state": mergeableState,
        "merged": merged,
        "merged_at": mergedAt.toIso8601String(),
        "merged_by": mergedBy.toJson(),
        "milestone": milestone,
        "number": number,
        "patch_url": patchUrl,
        "rebaseable": rebaseable,
        "requested_reviewers": List<dynamic>.from(requestedReviewers.map((x) => x)),
        "review_comment_url": reviewCommentUrl,
        "review_comments": reviewComments,
        "review_comments_url": reviewCommentsUrl,
        "state": state,
        "statuses_url": statusesUrl,
        "title": title,
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
        "user": user.toJson(),
    };
}

class Base {
    final String label;
    final String ref;
    final BaseRepo repo;
    final String sha;
    final User user;

    Base({
        required this.label,
        required this.ref,
        required this.repo,
        required this.sha,
        required this.user,
    });

    factory Base.fromJson(Map<String, dynamic> json) => Base(
        label: json["label"],
        ref: json["ref"],
        repo: BaseRepo.fromJson(json["repo"]),
        sha: json["sha"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "ref": ref,
        "repo": repo.toJson(),
        "sha": sha,
        "user": user.toJson(),
    };
}

class BaseRepo {
    final String archiveUrl;
    final String assigneesUrl;
    final String blobsUrl;
    final String branchesUrl;
    final String cloneUrl;
    final String collaboratorsUrl;
    final String commentsUrl;
    final String commitsUrl;
    final String compareUrl;
    final String contentsUrl;
    final String contributorsUrl;
    final DateTime createdAt;
    final String defaultBranch;
    final String deploymentsUrl;
    final String description;
    final String downloadsUrl;
    final String eventsUrl;
    final bool fork;
    final int forks;
    final int forksCount;
    final String forksUrl;
    final String fullName;
    final String gitCommitsUrl;
    final String gitRefsUrl;
    final String gitTagsUrl;
    final String gitUrl;
    final bool hasDownloads;
    final bool hasIssues;
    final bool hasPages;
    final bool hasProjects;
    final bool hasWiki;
    final String homepage;
    final String hooksUrl;
    final String htmlUrl;
    final int id;
    final String issueCommentUrl;
    final String issueEventsUrl;
    final String issuesUrl;
    final String keysUrl;
    final String labelsUrl;
    final String language;
    final String languagesUrl;
    final String mergesUrl;
    final String milestonesUrl;
    final dynamic mirrorUrl;
    final String name;
    final String notificationsUrl;
    final int openIssues;
    final int openIssuesCount;
    final User owner;
    final bool private;
    final String pullsUrl;
    final DateTime pushedAt;
    final String releasesUrl;
    final int size;
    final String sshUrl;
    final int stargazersCount;
    final String stargazersUrl;
    final String statusesUrl;
    final String subscribersUrl;
    final String subscriptionUrl;
    final String svnUrl;
    final String tagsUrl;
    final String teamsUrl;
    final String treesUrl;
    final DateTime updatedAt;
    final String url;
    final int watchers;
    final int watchersCount;

    BaseRepo({
        required this.archiveUrl,
        required this.assigneesUrl,
        required this.blobsUrl,
        required this.branchesUrl,
        required this.cloneUrl,
        required this.collaboratorsUrl,
        required this.commentsUrl,
        required this.commitsUrl,
        required this.compareUrl,
        required this.contentsUrl,
        required this.contributorsUrl,
        required this.createdAt,
        required this.defaultBranch,
        required this.deploymentsUrl,
        required this.description,
        required this.downloadsUrl,
        required this.eventsUrl,
        required this.fork,
        required this.forks,
        required this.forksCount,
        required this.forksUrl,
        required this.fullName,
        required this.gitCommitsUrl,
        required this.gitRefsUrl,
        required this.gitTagsUrl,
        required this.gitUrl,
        required this.hasDownloads,
        required this.hasIssues,
        required this.hasPages,
        required this.hasProjects,
        required this.hasWiki,
        required this.homepage,
        required this.hooksUrl,
        required this.htmlUrl,
        required this.id,
        required this.issueCommentUrl,
        required this.issueEventsUrl,
        required this.issuesUrl,
        required this.keysUrl,
        required this.labelsUrl,
        required this.language,
        required this.languagesUrl,
        required this.mergesUrl,
        required this.milestonesUrl,
        required this.mirrorUrl,
        required this.name,
        required this.notificationsUrl,
        required this.openIssues,
        required this.openIssuesCount,
        required this.owner,
        required this.private,
        required this.pullsUrl,
        required this.pushedAt,
        required this.releasesUrl,
        required this.size,
        required this.sshUrl,
        required this.stargazersCount,
        required this.stargazersUrl,
        required this.statusesUrl,
        required this.subscribersUrl,
        required this.subscriptionUrl,
        required this.svnUrl,
        required this.tagsUrl,
        required this.teamsUrl,
        required this.treesUrl,
        required this.updatedAt,
        required this.url,
        required this.watchers,
        required this.watchersCount,
    });

    factory BaseRepo.fromJson(Map<String, dynamic> json) => BaseRepo(
        archiveUrl: json["archive_url"],
        assigneesUrl: json["assignees_url"],
        blobsUrl: json["blobs_url"],
        branchesUrl: json["branches_url"],
        cloneUrl: json["clone_url"],
        collaboratorsUrl: json["collaborators_url"],
        commentsUrl: json["comments_url"],
        commitsUrl: json["commits_url"],
        compareUrl: json["compare_url"],
        contentsUrl: json["contents_url"],
        contributorsUrl: json["contributors_url"],
        createdAt: DateTime.parse(json["created_at"]),
        defaultBranch: json["default_branch"],
        deploymentsUrl: json["deployments_url"],
        description: json["description"],
        downloadsUrl: json["downloads_url"],
        eventsUrl: json["events_url"],
        fork: json["fork"],
        forks: json["forks"],
        forksCount: json["forks_count"],
        forksUrl: json["forks_url"],
        fullName: json["full_name"],
        gitCommitsUrl: json["git_commits_url"],
        gitRefsUrl: json["git_refs_url"],
        gitTagsUrl: json["git_tags_url"],
        gitUrl: json["git_url"],
        hasDownloads: json["has_downloads"],
        hasIssues: json["has_issues"],
        hasPages: json["has_pages"],
        hasProjects: json["has_projects"],
        hasWiki: json["has_wiki"],
        homepage: json["homepage"],
        hooksUrl: json["hooks_url"],
        htmlUrl: json["html_url"],
        id: json["id"],
        issueCommentUrl: json["issue_comment_url"],
        issueEventsUrl: json["issue_events_url"],
        issuesUrl: json["issues_url"],
        keysUrl: json["keys_url"],
        labelsUrl: json["labels_url"],
        language: json["language"],
        languagesUrl: json["languages_url"],
        mergesUrl: json["merges_url"],
        milestonesUrl: json["milestones_url"],
        mirrorUrl: (json.containsKey("mirror_url") ? json["mirror_url"] : throw FormatException('Missing required property')),
        name: json["name"],
        notificationsUrl: json["notifications_url"],
        openIssues: json["open_issues"],
        openIssuesCount: json["open_issues_count"],
        owner: User.fromJson(json["owner"]),
        private: json["private"],
        pullsUrl: json["pulls_url"],
        pushedAt: DateTime.parse(json["pushed_at"]),
        releasesUrl: json["releases_url"],
        size: json["size"],
        sshUrl: json["ssh_url"],
        stargazersCount: json["stargazers_count"],
        stargazersUrl: json["stargazers_url"],
        statusesUrl: json["statuses_url"],
        subscribersUrl: json["subscribers_url"],
        subscriptionUrl: json["subscription_url"],
        svnUrl: json["svn_url"],
        tagsUrl: json["tags_url"],
        teamsUrl: json["teams_url"],
        treesUrl: json["trees_url"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        watchers: json["watchers"],
        watchersCount: json["watchers_count"],
    );

    Map<String, dynamic> toJson() => {
        "archive_url": archiveUrl,
        "assignees_url": assigneesUrl,
        "blobs_url": blobsUrl,
        "branches_url": branchesUrl,
        "clone_url": cloneUrl,
        "collaborators_url": collaboratorsUrl,
        "comments_url": commentsUrl,
        "commits_url": commitsUrl,
        "compare_url": compareUrl,
        "contents_url": contentsUrl,
        "contributors_url": contributorsUrl,
        "created_at": createdAt.toIso8601String(),
        "default_branch": defaultBranch,
        "deployments_url": deploymentsUrl,
        "description": description,
        "downloads_url": downloadsUrl,
        "events_url": eventsUrl,
        "fork": fork,
        "forks": forks,
        "forks_count": forksCount,
        "forks_url": forksUrl,
        "full_name": fullName,
        "git_commits_url": gitCommitsUrl,
        "git_refs_url": gitRefsUrl,
        "git_tags_url": gitTagsUrl,
        "git_url": gitUrl,
        "has_downloads": hasDownloads,
        "has_issues": hasIssues,
        "has_pages": hasPages,
        "has_projects": hasProjects,
        "has_wiki": hasWiki,
        "homepage": homepage,
        "hooks_url": hooksUrl,
        "html_url": htmlUrl,
        "id": id,
        "issue_comment_url": issueCommentUrl,
        "issue_events_url": issueEventsUrl,
        "issues_url": issuesUrl,
        "keys_url": keysUrl,
        "labels_url": labelsUrl,
        "language": language,
        "languages_url": languagesUrl,
        "merges_url": mergesUrl,
        "milestones_url": milestonesUrl,
        "mirror_url": mirrorUrl,
        "name": name,
        "notifications_url": notificationsUrl,
        "open_issues": openIssues,
        "open_issues_count": openIssuesCount,
        "owner": owner.toJson(),
        "private": private,
        "pulls_url": pullsUrl,
        "pushed_at": pushedAt.toIso8601String(),
        "releases_url": releasesUrl,
        "size": size,
        "ssh_url": sshUrl,
        "stargazers_count": stargazersCount,
        "stargazers_url": stargazersUrl,
        "statuses_url": statusesUrl,
        "subscribers_url": subscribersUrl,
        "subscription_url": subscriptionUrl,
        "svn_url": svnUrl,
        "tags_url": tagsUrl,
        "teams_url": teamsUrl,
        "trees_url": treesUrl,
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
        "watchers": watchers,
        "watchers_count": watchersCount,
    };
}

class Links {
    final Comments comments;
    final Comments commits;
    final Comments html;
    final Comments issue;
    final Comments reviewComment;
    final Comments reviewComments;
    final Comments self;
    final Comments statuses;

    Links({
        required this.comments,
        required this.commits,
        required this.html,
        required this.issue,
        required this.reviewComment,
        required this.reviewComments,
        required this.self,
        required this.statuses,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        comments: Comments.fromJson(json["comments"]),
        commits: Comments.fromJson(json["commits"]),
        html: Comments.fromJson(json["html"]),
        issue: Comments.fromJson(json["issue"]),
        reviewComment: Comments.fromJson(json["review_comment"]),
        reviewComments: Comments.fromJson(json["review_comments"]),
        self: Comments.fromJson(json["self"]),
        statuses: Comments.fromJson(json["statuses"]),
    );

    Map<String, dynamic> toJson() => {
        "comments": comments.toJson(),
        "commits": commits.toJson(),
        "html": html.toJson(),
        "issue": issue.toJson(),
        "review_comment": reviewComment.toJson(),
        "review_comments": reviewComments.toJson(),
        "self": self.toJson(),
        "statuses": statuses.toJson(),
    };
}

class Comments {
    final String href;

    Comments({
        required this.href,
    });

    factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
    };
}

class TopLevelRepo {
    final int id;
    final String name;
    final String url;

    TopLevelRepo({
        required this.id,
        required this.name,
        required this.url,
    });

    factory TopLevelRepo.fromJson(Map<String, dynamic> json) => TopLevelRepo(
        id: json["id"],
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
