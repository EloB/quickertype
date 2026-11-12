// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

@file:UseSerializers(OffsetDateTimeSerializer::class)

package quicktype

import java.time.OffsetDateTime

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = List<TopLevelElement>

@Serializable
data class TopLevelElement (
    val actor: Actor,

    @SerialName("created_at")
    val createdAt: OffsetDateTime,

    val id: String,
    val org: Actor? = null,
    val payload: Payload,
    val public: Boolean,
    val repo: TopLevelRepo,
    val type: String
)

@Serializable
data class Actor (
    @SerialName("avatar_url")
    val avatarURL: String,

    @SerialName("display_login")
    val displayLogin: String? = null,

    @SerialName("gravatar_id")
    val gravatarID: String,

    val id: Long,
    val login: String,
    val url: String
)

@Serializable
data class Payload (
    val action: String? = null,
    val before: String? = null,
    val comment: Comment? = null,
    val commits: List<Commit>? = null,
    val description: String? = null,

    @SerialName("distinct_size")
    val distinctSize: Long? = null,

    val head: String? = null,
    val issue: Issue? = null,

    @SerialName("master_branch")
    val masterBranch: String? = null,

    val number: Long? = null,

    @SerialName("pull_request")
    val pullRequest: PayloadPullRequest? = null,

    @SerialName("push_id")
    val pushID: Long? = null,

    @SerialName("pusher_type")
    val pusherType: String? = null,

    val ref: String? = null,

    @SerialName("ref_type")
    val refType: String? = null,

    val size: Long? = null
)

@Serializable
data class Comment (
    val body: String,

    @SerialName("created_at")
    val createdAt: OffsetDateTime,

    @SerialName("html_url")
    val htmlURL: String,

    val id: Long,

    @SerialName("issue_url")
    val issueURL: String,

    @SerialName("updated_at")
    val updatedAt: OffsetDateTime,

    val url: String,
    val user: User
)

@Serializable
data class User (
    @SerialName("avatar_url")
    val avatarURL: String,

    @SerialName("events_url")
    val eventsURL: String,

    @SerialName("followers_url")
    val followersURL: String,

    @SerialName("following_url")
    val followingURL: String,

    @SerialName("gists_url")
    val gistsURL: String,

    @SerialName("gravatar_id")
    val gravatarID: String,

    @SerialName("html_url")
    val htmlURL: String,

    val id: Long,
    val login: String,

    @SerialName("organizations_url")
    val organizationsURL: String,

    @SerialName("received_events_url")
    val receivedEventsURL: String,

    @SerialName("repos_url")
    val reposURL: String,

    @SerialName("site_admin")
    val siteAdmin: Boolean,

    @SerialName("starred_url")
    val starredURL: String,

    @SerialName("subscriptions_url")
    val subscriptionsURL: String,

    val type: Type,
    val url: String
)

@Serializable
enum class Type(val value: String) {
    @SerialName("User") User("User"),
    @SerialName("Organization") Organization("Organization");
}

@Serializable
data class Commit (
    val author: Author,
    val distinct: Boolean,
    val message: String,
    val sha: String,
    val url: String
)

@Serializable
data class Author (
    val email: String,
    val name: String
)

@Serializable
data class Issue (
    val assignee: JsonElement? = null,
    val assignees: JsonArray,
    val body: String,

    @SerialName("closed_at")
    val closedAt: OffsetDateTime? = null,

    val comments: Long,

    @SerialName("comments_url")
    val commentsURL: String,

    @SerialName("created_at")
    val createdAt: OffsetDateTime,

    @SerialName("events_url")
    val eventsURL: String,

    @SerialName("html_url")
    val htmlURL: String,

    val id: Long,
    val labels: List<Label>,

    @SerialName("labels_url")
    val labelsURL: String,

    val locked: Boolean,
    val milestone: Milestone? = null,
    val number: Long,

    @SerialName("pull_request")
    val pullRequest: IssuePullRequest? = null,

    @SerialName("repository_url")
    val repositoryURL: String,

    val state: String,
    val title: String,

    @SerialName("updated_at")
    val updatedAt: OffsetDateTime,

    val url: String,
    val user: User
)

@Serializable
data class Label (
    val color: String,
    val default: Boolean,
    val id: Long,
    val name: String,
    val url: String
)

@Serializable
data class Milestone (
    @SerialName("closed_at")
    val closedAt: JsonElement? = null,

    @SerialName("closed_issues")
    val closedIssues: Long,

    @SerialName("created_at")
    val createdAt: OffsetDateTime,

    val creator: User,
    val description: String,

    @SerialName("due_on")
    val dueOn: OffsetDateTime? = null,

    @SerialName("html_url")
    val htmlURL: String,

    val id: Long,

    @SerialName("labels_url")
    val labelsURL: String,

    val number: Long,

    @SerialName("open_issues")
    val openIssues: Long,

    val state: String,
    val title: String,

    @SerialName("updated_at")
    val updatedAt: OffsetDateTime,

    val url: String
)

@Serializable
data class IssuePullRequest (
    @SerialName("diff_url")
    val diffURL: String,

    @SerialName("html_url")
    val htmlURL: String,

    @SerialName("patch_url")
    val patchURL: String,

    val url: String
)

@Serializable
data class PayloadPullRequest (
    val additions: Long,
    val assignee: JsonElement? = null,
    val assignees: JsonArray,
    val base: Base,
    val body: String,

    @SerialName("changed_files")
    val changedFiles: Long,

    @SerialName("closed_at")
    val closedAt: OffsetDateTime,

    val comments: Long,

    @SerialName("comments_url")
    val commentsURL: String,

    val commits: Long,

    @SerialName("commits_url")
    val commitsURL: String,

    @SerialName("created_at")
    val createdAt: OffsetDateTime,

    val deletions: Long,

    @SerialName("diff_url")
    val diffURL: String,

    val head: Base,

    @SerialName("html_url")
    val htmlURL: String,

    val id: Long,

    @SerialName("issue_url")
    val issueURL: String,

    @SerialName("_links")
    val links: Links,

    val locked: Boolean,

    @SerialName("maintainer_can_modify")
    val maintainerCanModify: Boolean,

    @SerialName("merge_commit_sha")
    val mergeCommitSHA: String,

    val mergeable: JsonElement? = null,

    @SerialName("mergeable_state")
    val mergeableState: String,

    val merged: Boolean,

    @SerialName("merged_at")
    val mergedAt: OffsetDateTime,

    @SerialName("merged_by")
    val mergedBy: User,

    val milestone: JsonElement? = null,
    val number: Long,

    @SerialName("patch_url")
    val patchURL: String,

    val rebaseable: JsonElement? = null,

    @SerialName("requested_reviewers")
    val requestedReviewers: JsonArray,

    @SerialName("review_comment_url")
    val reviewCommentURL: String,

    @SerialName("review_comments")
    val reviewComments: Long,

    @SerialName("review_comments_url")
    val reviewCommentsURL: String,

    val state: String,

    @SerialName("statuses_url")
    val statusesURL: String,

    val title: String,

    @SerialName("updated_at")
    val updatedAt: OffsetDateTime,

    val url: String,
    val user: User
)

@Serializable
data class Base (
    val label: String,
    val ref: String,
    val repo: BaseRepo,
    val sha: String,
    val user: User
)

@Serializable
data class BaseRepo (
    @SerialName("archive_url")
    val archiveURL: String,

    @SerialName("assignees_url")
    val assigneesURL: String,

    @SerialName("blobs_url")
    val blobsURL: String,

    @SerialName("branches_url")
    val branchesURL: String,

    @SerialName("clone_url")
    val cloneURL: String,

    @SerialName("collaborators_url")
    val collaboratorsURL: String,

    @SerialName("comments_url")
    val commentsURL: String,

    @SerialName("commits_url")
    val commitsURL: String,

    @SerialName("compare_url")
    val compareURL: String,

    @SerialName("contents_url")
    val contentsURL: String,

    @SerialName("contributors_url")
    val contributorsURL: String,

    @SerialName("created_at")
    val createdAt: OffsetDateTime,

    @SerialName("default_branch")
    val defaultBranch: String,

    @SerialName("deployments_url")
    val deploymentsURL: String,

    val description: String,

    @SerialName("downloads_url")
    val downloadsURL: String,

    @SerialName("events_url")
    val eventsURL: String,

    val fork: Boolean,
    val forks: Long,

    @SerialName("forks_count")
    val forksCount: Long,

    @SerialName("forks_url")
    val forksURL: String,

    @SerialName("full_name")
    val fullName: String,

    @SerialName("git_commits_url")
    val gitCommitsURL: String,

    @SerialName("git_refs_url")
    val gitRefsURL: String,

    @SerialName("git_tags_url")
    val gitTagsURL: String,

    @SerialName("git_url")
    val gitURL: String,

    @SerialName("has_downloads")
    val hasDownloads: Boolean,

    @SerialName("has_issues")
    val hasIssues: Boolean,

    @SerialName("has_pages")
    val hasPages: Boolean,

    @SerialName("has_projects")
    val hasProjects: Boolean,

    @SerialName("has_wiki")
    val hasWiki: Boolean,

    val homepage: String,

    @SerialName("hooks_url")
    val hooksURL: String,

    @SerialName("html_url")
    val htmlURL: String,

    val id: Long,

    @SerialName("issue_comment_url")
    val issueCommentURL: String,

    @SerialName("issue_events_url")
    val issueEventsURL: String,

    @SerialName("issues_url")
    val issuesURL: String,

    @SerialName("keys_url")
    val keysURL: String,

    @SerialName("labels_url")
    val labelsURL: String,

    val language: String,

    @SerialName("languages_url")
    val languagesURL: String,

    @SerialName("merges_url")
    val mergesURL: String,

    @SerialName("milestones_url")
    val milestonesURL: String,

    @SerialName("mirror_url")
    val mirrorURL: JsonElement? = null,

    val name: String,

    @SerialName("notifications_url")
    val notificationsURL: String,

    @SerialName("open_issues")
    val openIssues: Long,

    @SerialName("open_issues_count")
    val openIssuesCount: Long,

    val owner: User,
    val private: Boolean,

    @SerialName("pulls_url")
    val pullsURL: String,

    @SerialName("pushed_at")
    val pushedAt: OffsetDateTime,

    @SerialName("releases_url")
    val releasesURL: String,

    val size: Long,

    @SerialName("ssh_url")
    val sshURL: String,

    @SerialName("stargazers_count")
    val stargazersCount: Long,

    @SerialName("stargazers_url")
    val stargazersURL: String,

    @SerialName("statuses_url")
    val statusesURL: String,

    @SerialName("subscribers_url")
    val subscribersURL: String,

    @SerialName("subscription_url")
    val subscriptionURL: String,

    @SerialName("svn_url")
    val svnURL: String,

    @SerialName("tags_url")
    val tagsURL: String,

    @SerialName("teams_url")
    val teamsURL: String,

    @SerialName("trees_url")
    val treesURL: String,

    @SerialName("updated_at")
    val updatedAt: OffsetDateTime,

    val url: String,
    val watchers: Long,

    @SerialName("watchers_count")
    val watchersCount: Long
)

@Serializable
data class Links (
    val comments: Comments,
    val commits: Comments,
    val html: Comments,
    val issue: Comments,

    @SerialName("review_comment")
    val reviewComment: Comments,

    @SerialName("review_comments")
    val reviewComments: Comments,

    val self: Comments,
    val statuses: Comments
)

@Serializable
data class Comments (
    val href: String
)

@Serializable
data class TopLevelRepo (
    val id: Long,
    val name: String,
    val url: String
)

object OffsetDateTimeSerializer : KSerializer<OffsetDateTime> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("OffsetDateTime", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): OffsetDateTime = OffsetDateTime.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: OffsetDateTime) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(value))
    }
}
