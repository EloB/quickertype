// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(OffsetDateTime::class, { OffsetDateTime.parse(it.string!!) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    .convert(Type::class,           { Type.fromValue(it.string!!) },       { Klaxon().toJsonString(it.value) })

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

data class TopLevelElement (
    val actor: Actor,

    @Json(name = "created_at")
    val createdAt: OffsetDateTime,

    val id: String,
    val org: Actor? = null,
    val payload: Payload,
    val public: Boolean,
    val repo: TopLevelRepo,
    val type: Type
)

data class Actor (
    @Json(name = "avatar_url")
    val avatarURL: String,

    @Json(name = "display_login")
    val displayLogin: String? = null,

    @Json(name = "gravatar_id")
    val gravatarID: String,

    val id: Long,
    val login: String,
    val url: String
)

data class Payload (
    val action: String? = null,
    val before: String? = null,
    val commits: List<Commit>? = null,
    val description: String? = null,

    @Json(name = "distinct_size")
    val distinctSize: Long? = null,

    val head: String? = null,

    @Json(name = "master_branch")
    val masterBranch: String? = null,

    val number: Long? = null,

    @Json(name = "pull_request")
    val pullRequest: PullRequest? = null,

    @Json(name = "push_id")
    val pushID: Long? = null,

    @Json(name = "pusher_type")
    val pusherType: String? = null,

    val ref: String? = null,

    @Json(name = "ref_type")
    val refType: String? = null,

    val size: Long? = null
)

data class Commit (
    val author: Author,
    val distinct: Boolean,
    val message: String,
    val sha: String,
    val url: String
)

data class Author (
    val email: String,
    val name: String
)

data class PullRequest (
    val additions: Long,
    val assignee: Any? = null,
    val assignees: List<Any?>,
    val base: Base,
    val body: String,

    @Json(name = "changed_files")
    val changedFiles: Long,

    @Json(name = "closed_at")
    val closedAt: OffsetDateTime,

    val comments: Long,

    @Json(name = "comments_url")
    val commentsURL: String,

    val commits: Long,

    @Json(name = "commits_url")
    val commitsURL: String,

    @Json(name = "created_at")
    val createdAt: OffsetDateTime,

    val deletions: Long,

    @Json(name = "diff_url")
    val diffURL: String,

    val head: Base,

    @Json(name = "html_url")
    val htmlURL: String,

    val id: Long,

    @Json(name = "issue_url")
    val issueURL: String,

    @Json(name = "_links")
    val links: Links,

    val locked: Boolean,

    @Json(name = "maintainer_can_modify")
    val maintainerCanModify: Boolean,

    @Json(name = "merge_commit_sha")
    val mergeCommitSHA: String,

    val mergeable: Any? = null,

    @Json(name = "mergeable_state")
    val mergeableState: String,

    val merged: Boolean,

    @Json(name = "merged_at")
    val mergedAt: OffsetDateTime,

    @Json(name = "merged_by")
    val mergedBy: MergedBy,

    val milestone: Any? = null,
    val number: Long,

    @Json(name = "patch_url")
    val patchURL: String,

    val rebaseable: Any? = null,

    @Json(name = "requested_reviewers")
    val requestedReviewers: List<Any?>,

    @Json(name = "review_comment_url")
    val reviewCommentURL: String,

    @Json(name = "review_comments")
    val reviewComments: Long,

    @Json(name = "review_comments_url")
    val reviewCommentsURL: String,

    val state: String,

    @Json(name = "statuses_url")
    val statusesURL: String,

    val title: String,

    @Json(name = "updated_at")
    val updatedAt: OffsetDateTime,

    val url: String,
    val user: MergedBy
)

data class Base (
    val label: String,
    val ref: String,
    val repo: BaseRepo,
    val sha: String,
    val user: MergedBy
)

data class BaseRepo (
    @Json(name = "archive_url")
    val archiveURL: String,

    @Json(name = "assignees_url")
    val assigneesURL: String,

    @Json(name = "blobs_url")
    val blobsURL: String,

    @Json(name = "branches_url")
    val branchesURL: String,

    @Json(name = "clone_url")
    val cloneURL: String,

    @Json(name = "collaborators_url")
    val collaboratorsURL: String,

    @Json(name = "comments_url")
    val commentsURL: String,

    @Json(name = "commits_url")
    val commitsURL: String,

    @Json(name = "compare_url")
    val compareURL: String,

    @Json(name = "contents_url")
    val contentsURL: String,

    @Json(name = "contributors_url")
    val contributorsURL: String,

    @Json(name = "created_at")
    val createdAt: OffsetDateTime,

    @Json(name = "default_branch")
    val defaultBranch: String,

    @Json(name = "deployments_url")
    val deploymentsURL: String,

    val description: Any? = null,

    @Json(name = "downloads_url")
    val downloadsURL: String,

    @Json(name = "events_url")
    val eventsURL: String,

    val fork: Boolean,
    val forks: Long,

    @Json(name = "forks_count")
    val forksCount: Long,

    @Json(name = "forks_url")
    val forksURL: String,

    @Json(name = "full_name")
    val fullName: String,

    @Json(name = "git_commits_url")
    val gitCommitsURL: String,

    @Json(name = "git_refs_url")
    val gitRefsURL: String,

    @Json(name = "git_tags_url")
    val gitTagsURL: String,

    @Json(name = "git_url")
    val gitURL: String,

    @Json(name = "has_downloads")
    val hasDownloads: Boolean,

    @Json(name = "has_issues")
    val hasIssues: Boolean,

    @Json(name = "has_pages")
    val hasPages: Boolean,

    @Json(name = "has_projects")
    val hasProjects: Boolean,

    @Json(name = "has_wiki")
    val hasWiki: Boolean,

    val homepage: Any? = null,

    @Json(name = "hooks_url")
    val hooksURL: String,

    @Json(name = "html_url")
    val htmlURL: String,

    val id: Long,

    @Json(name = "issue_comment_url")
    val issueCommentURL: String,

    @Json(name = "issue_events_url")
    val issueEventsURL: String,

    @Json(name = "issues_url")
    val issuesURL: String,

    @Json(name = "keys_url")
    val keysURL: String,

    @Json(name = "labels_url")
    val labelsURL: String,

    val language: String,

    @Json(name = "languages_url")
    val languagesURL: String,

    @Json(name = "merges_url")
    val mergesURL: String,

    @Json(name = "milestones_url")
    val milestonesURL: String,

    @Json(name = "mirror_url")
    val mirrorURL: Any? = null,

    val name: String,

    @Json(name = "notifications_url")
    val notificationsURL: String,

    @Json(name = "open_issues")
    val openIssues: Long,

    @Json(name = "open_issues_count")
    val openIssuesCount: Long,

    val owner: MergedBy,
    val private: Boolean,

    @Json(name = "pulls_url")
    val pullsURL: String,

    @Json(name = "pushed_at")
    val pushedAt: OffsetDateTime,

    @Json(name = "releases_url")
    val releasesURL: String,

    val size: Long,

    @Json(name = "ssh_url")
    val sshURL: String,

    @Json(name = "stargazers_count")
    val stargazersCount: Long,

    @Json(name = "stargazers_url")
    val stargazersURL: String,

    @Json(name = "statuses_url")
    val statusesURL: String,

    @Json(name = "subscribers_url")
    val subscribersURL: String,

    @Json(name = "subscription_url")
    val subscriptionURL: String,

    @Json(name = "svn_url")
    val svnURL: String,

    @Json(name = "tags_url")
    val tagsURL: String,

    @Json(name = "teams_url")
    val teamsURL: String,

    @Json(name = "trees_url")
    val treesURL: String,

    @Json(name = "updated_at")
    val updatedAt: OffsetDateTime,

    val url: String,
    val watchers: Long,

    @Json(name = "watchers_count")
    val watchersCount: Long
)

data class MergedBy (
    @Json(name = "avatar_url")
    val avatarURL: String,

    @Json(name = "events_url")
    val eventsURL: String,

    @Json(name = "followers_url")
    val followersURL: String,

    @Json(name = "following_url")
    val followingURL: String,

    @Json(name = "gists_url")
    val gistsURL: String,

    @Json(name = "gravatar_id")
    val gravatarID: String,

    @Json(name = "html_url")
    val htmlURL: String,

    val id: Long,
    val login: String,

    @Json(name = "organizations_url")
    val organizationsURL: String,

    @Json(name = "received_events_url")
    val receivedEventsURL: String,

    @Json(name = "repos_url")
    val reposURL: String,

    @Json(name = "site_admin")
    val siteAdmin: Boolean,

    @Json(name = "starred_url")
    val starredURL: String,

    @Json(name = "subscriptions_url")
    val subscriptionsURL: String,

    val type: String,
    val url: String
)

data class Links (
    val comments: Comments,
    val commits: Comments,
    val html: Comments,
    val issue: Comments,

    @Json(name = "review_comment")
    val reviewComment: Comments,

    @Json(name = "review_comments")
    val reviewComments: Comments,

    val self: Comments,
    val statuses: Comments
)

data class Comments (
    val href: String
)

data class TopLevelRepo (
    val id: Long,
    val name: String,
    val url: String
)

enum class Type(val value: String) {
    PushEvent("PushEvent"),
    CreateEvent("CreateEvent"),
    WatchEvent("WatchEvent"),
    PullRequestEvent("PullRequestEvent"),
    DeleteEvent("DeleteEvent");

    companion object {
        public fun fromValue(value: String): Type = when (value) {
            "PushEvent"        -> PushEvent
            "CreateEvent"      -> CreateEvent
            "WatchEvent"       -> WatchEvent
            "PullRequestEvent" -> PullRequestEvent
            "DeleteEvent"      -> DeleteEvent
            else               -> throw IllegalArgumentException()
        }
    }
}
