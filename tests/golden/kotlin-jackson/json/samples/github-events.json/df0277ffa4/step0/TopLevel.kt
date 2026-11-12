// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*


@Suppress("UNCHECKED_CAST")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {
    addSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {
            override fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
    })
    addDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {
            override fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree())
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(OffsetDateTime::class, { OffsetDateTime.parse(it.asText()) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    convert(Type::class,           { Type.fromValue(it.asText()) },       { ObjectMapper().writeValueAsString(it.value) })
}

class TopLevel(elements: Collection<TopLevelElement> = emptyList()) : ArrayList<TopLevelElement>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val actor: Actor,

    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    val org: Actor? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val payload: Payload,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val public: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val repo: TopLevelRepo,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class Actor (
    @get:JsonProperty("avatar_url", required=true)@field:JsonProperty("avatar_url", required=true)
    val avatarURL: String,

    @get:JsonProperty("display_login")@field:JsonProperty("display_login")
    val displayLogin: String? = null,

    @get:JsonProperty("gravatar_id", required=true)@field:JsonProperty("gravatar_id", required=true)
    val gravatarID: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val login: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

data class Payload (
    val action: String? = null,
    val before: String? = null,
    val comment: Comment? = null,
    val commits: List<Commit>? = null,
    val description: String? = null,

    @get:JsonProperty("distinct_size")@field:JsonProperty("distinct_size")
    val distinctSize: Long? = null,

    val head: String? = null,

    @get:JsonProperty("issue")@field:JsonProperty("issue")
    val issue: Issue? = null,

    @get:JsonProperty("master_branch")@field:JsonProperty("master_branch")
    val masterBranch: String? = null,

    val number: Long? = null,

    @get:JsonProperty("pull_request")@field:JsonProperty("pull_request")
    val pullRequest: PayloadPullRequest? = null,

    @get:JsonProperty("push_id")@field:JsonProperty("push_id")
    val pushID: Long? = null,

    @get:JsonProperty("pusher_type")@field:JsonProperty("pusher_type")
    val pusherType: String? = null,

    val ref: String? = null,

    @get:JsonProperty("ref_type")@field:JsonProperty("ref_type")
    val refType: String? = null,

    val size: Long? = null
)

data class Comment (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val body: String,

    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: OffsetDateTime,

    @get:JsonProperty("html_url", required=true)@field:JsonProperty("html_url", required=true)
    val htmlURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty("issue_url", required=true)@field:JsonProperty("issue_url", required=true)
    val issueURL: String,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val user: User
)

data class User (
    @get:JsonProperty("avatar_url", required=true)@field:JsonProperty("avatar_url", required=true)
    val avatarURL: String,

    @get:JsonProperty("events_url", required=true)@field:JsonProperty("events_url", required=true)
    val eventsURL: String,

    @get:JsonProperty("followers_url", required=true)@field:JsonProperty("followers_url", required=true)
    val followersURL: String,

    @get:JsonProperty("following_url", required=true)@field:JsonProperty("following_url", required=true)
    val followingURL: String,

    @get:JsonProperty("gists_url", required=true)@field:JsonProperty("gists_url", required=true)
    val gistsURL: String,

    @get:JsonProperty("gravatar_id", required=true)@field:JsonProperty("gravatar_id", required=true)
    val gravatarID: String,

    @get:JsonProperty("html_url", required=true)@field:JsonProperty("html_url", required=true)
    val htmlURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val login: String,

    @get:JsonProperty("organizations_url", required=true)@field:JsonProperty("organizations_url", required=true)
    val organizationsURL: String,

    @get:JsonProperty("received_events_url", required=true)@field:JsonProperty("received_events_url", required=true)
    val receivedEventsURL: String,

    @get:JsonProperty("repos_url", required=true)@field:JsonProperty("repos_url", required=true)
    val reposURL: String,

    @get:JsonProperty("site_admin", required=true)@field:JsonProperty("site_admin", required=true)
    val siteAdmin: Boolean,

    @get:JsonProperty("starred_url", required=true)@field:JsonProperty("starred_url", required=true)
    val starredURL: String,

    @get:JsonProperty("subscriptions_url", required=true)@field:JsonProperty("subscriptions_url", required=true)
    val subscriptionsURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Type,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

enum class Type(val value: String) {
    User("User"),
    Organization("Organization");

    companion object {
        fun fromValue(value: String): Type = when (value) {
            "User"         -> User
            "Organization" -> Organization
            else           -> throw IllegalArgumentException()
        }
    }
}

data class Commit (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val author: Author,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val distinct: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val message: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sha: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

data class Author (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val email: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String
)

data class Issue (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val assignee: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val assignees: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val body: String,

    @get:JsonProperty("closed_at", required=true)@field:JsonProperty("closed_at", required=true)
    val closedAt: OffsetDateTime?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val comments: Long,

    @get:JsonProperty("comments_url", required=true)@field:JsonProperty("comments_url", required=true)
    val commentsURL: String,

    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: OffsetDateTime,

    @get:JsonProperty("events_url", required=true)@field:JsonProperty("events_url", required=true)
    val eventsURL: String,

    @get:JsonProperty("html_url", required=true)@field:JsonProperty("html_url", required=true)
    val htmlURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val labels: List<Label>,

    @get:JsonProperty("labels_url", required=true)@field:JsonProperty("labels_url", required=true)
    val labelsURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val locked: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val milestone: Milestone?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val number: Long,

    @get:JsonProperty("pull_request")@field:JsonProperty("pull_request")
    val pullRequest: IssuePullRequest? = null,

    @get:JsonProperty("repository_url", required=true)@field:JsonProperty("repository_url", required=true)
    val repositoryURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val state: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val user: User
)

data class Label (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val color: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val default: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

data class Milestone (
    @get:JsonProperty("closed_at", required=true)@field:JsonProperty("closed_at", required=true)
    val closedAt: Any? = null,

    @get:JsonProperty("closed_issues", required=true)@field:JsonProperty("closed_issues", required=true)
    val closedIssues: Long,

    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val creator: User,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty("due_on", required=true)@field:JsonProperty("due_on", required=true)
    val dueOn: OffsetDateTime?,

    @get:JsonProperty("html_url", required=true)@field:JsonProperty("html_url", required=true)
    val htmlURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty("labels_url", required=true)@field:JsonProperty("labels_url", required=true)
    val labelsURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val number: Long,

    @get:JsonProperty("open_issues", required=true)@field:JsonProperty("open_issues", required=true)
    val openIssues: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val state: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

data class IssuePullRequest (
    @get:JsonProperty("diff_url", required=true)@field:JsonProperty("diff_url", required=true)
    val diffURL: String,

    @get:JsonProperty("html_url", required=true)@field:JsonProperty("html_url", required=true)
    val htmlURL: String,

    @get:JsonProperty("patch_url", required=true)@field:JsonProperty("patch_url", required=true)
    val patchURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

data class PayloadPullRequest (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val additions: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val assignee: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val assignees: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val base: Base,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val body: String,

    @get:JsonProperty("changed_files", required=true)@field:JsonProperty("changed_files", required=true)
    val changedFiles: Long,

    @get:JsonProperty("closed_at", required=true)@field:JsonProperty("closed_at", required=true)
    val closedAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val comments: Long,

    @get:JsonProperty("comments_url", required=true)@field:JsonProperty("comments_url", required=true)
    val commentsURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val commits: Long,

    @get:JsonProperty("commits_url", required=true)@field:JsonProperty("commits_url", required=true)
    val commitsURL: String,

    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val deletions: Long,

    @get:JsonProperty("diff_url", required=true)@field:JsonProperty("diff_url", required=true)
    val diffURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val head: Base,

    @get:JsonProperty("html_url", required=true)@field:JsonProperty("html_url", required=true)
    val htmlURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty("issue_url", required=true)@field:JsonProperty("issue_url", required=true)
    val issueURL: String,

    @get:JsonProperty("_links", required=true)@field:JsonProperty("_links", required=true)
    val links: Links,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val locked: Boolean,

    @get:JsonProperty("maintainer_can_modify", required=true)@field:JsonProperty("maintainer_can_modify", required=true)
    val maintainerCanModify: Boolean,

    @get:JsonProperty("merge_commit_sha", required=true)@field:JsonProperty("merge_commit_sha", required=true)
    val mergeCommitSHA: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mergeable: Any? = null,

    @get:JsonProperty("mergeable_state", required=true)@field:JsonProperty("mergeable_state", required=true)
    val mergeableState: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val merged: Boolean,

    @get:JsonProperty("merged_at", required=true)@field:JsonProperty("merged_at", required=true)
    val mergedAt: OffsetDateTime,

    @get:JsonProperty("merged_by", required=true)@field:JsonProperty("merged_by", required=true)
    val mergedBy: User,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val milestone: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val number: Long,

    @get:JsonProperty("patch_url", required=true)@field:JsonProperty("patch_url", required=true)
    val patchURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rebaseable: Any? = null,

    @get:JsonProperty("requested_reviewers", required=true)@field:JsonProperty("requested_reviewers", required=true)
    val requestedReviewers: List<Any?>,

    @get:JsonProperty("review_comment_url", required=true)@field:JsonProperty("review_comment_url", required=true)
    val reviewCommentURL: String,

    @get:JsonProperty("review_comments", required=true)@field:JsonProperty("review_comments", required=true)
    val reviewComments: Long,

    @get:JsonProperty("review_comments_url", required=true)@field:JsonProperty("review_comments_url", required=true)
    val reviewCommentsURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val state: String,

    @get:JsonProperty("statuses_url", required=true)@field:JsonProperty("statuses_url", required=true)
    val statusesURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val user: User
)

data class Base (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val label: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ref: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val repo: BaseRepo,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sha: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val user: User
)

data class BaseRepo (
    @get:JsonProperty("archive_url", required=true)@field:JsonProperty("archive_url", required=true)
    val archiveURL: String,

    @get:JsonProperty("assignees_url", required=true)@field:JsonProperty("assignees_url", required=true)
    val assigneesURL: String,

    @get:JsonProperty("blobs_url", required=true)@field:JsonProperty("blobs_url", required=true)
    val blobsURL: String,

    @get:JsonProperty("branches_url", required=true)@field:JsonProperty("branches_url", required=true)
    val branchesURL: String,

    @get:JsonProperty("clone_url", required=true)@field:JsonProperty("clone_url", required=true)
    val cloneURL: String,

    @get:JsonProperty("collaborators_url", required=true)@field:JsonProperty("collaborators_url", required=true)
    val collaboratorsURL: String,

    @get:JsonProperty("comments_url", required=true)@field:JsonProperty("comments_url", required=true)
    val commentsURL: String,

    @get:JsonProperty("commits_url", required=true)@field:JsonProperty("commits_url", required=true)
    val commitsURL: String,

    @get:JsonProperty("compare_url", required=true)@field:JsonProperty("compare_url", required=true)
    val compareURL: String,

    @get:JsonProperty("contents_url", required=true)@field:JsonProperty("contents_url", required=true)
    val contentsURL: String,

    @get:JsonProperty("contributors_url", required=true)@field:JsonProperty("contributors_url", required=true)
    val contributorsURL: String,

    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: OffsetDateTime,

    @get:JsonProperty("default_branch", required=true)@field:JsonProperty("default_branch", required=true)
    val defaultBranch: String,

    @get:JsonProperty("deployments_url", required=true)@field:JsonProperty("deployments_url", required=true)
    val deploymentsURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty("downloads_url", required=true)@field:JsonProperty("downloads_url", required=true)
    val downloadsURL: String,

    @get:JsonProperty("events_url", required=true)@field:JsonProperty("events_url", required=true)
    val eventsURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fork: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val forks: Long,

    @get:JsonProperty("forks_count", required=true)@field:JsonProperty("forks_count", required=true)
    val forksCount: Long,

    @get:JsonProperty("forks_url", required=true)@field:JsonProperty("forks_url", required=true)
    val forksURL: String,

    @get:JsonProperty("full_name", required=true)@field:JsonProperty("full_name", required=true)
    val fullName: String,

    @get:JsonProperty("git_commits_url", required=true)@field:JsonProperty("git_commits_url", required=true)
    val gitCommitsURL: String,

    @get:JsonProperty("git_refs_url", required=true)@field:JsonProperty("git_refs_url", required=true)
    val gitRefsURL: String,

    @get:JsonProperty("git_tags_url", required=true)@field:JsonProperty("git_tags_url", required=true)
    val gitTagsURL: String,

    @get:JsonProperty("git_url", required=true)@field:JsonProperty("git_url", required=true)
    val gitURL: String,

    @get:JsonProperty("has_downloads", required=true)@field:JsonProperty("has_downloads", required=true)
    val hasDownloads: Boolean,

    @get:JsonProperty("has_issues", required=true)@field:JsonProperty("has_issues", required=true)
    val hasIssues: Boolean,

    @get:JsonProperty("has_pages", required=true)@field:JsonProperty("has_pages", required=true)
    val hasPages: Boolean,

    @get:JsonProperty("has_projects", required=true)@field:JsonProperty("has_projects", required=true)
    val hasProjects: Boolean,

    @get:JsonProperty("has_wiki", required=true)@field:JsonProperty("has_wiki", required=true)
    val hasWiki: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val homepage: String,

    @get:JsonProperty("hooks_url", required=true)@field:JsonProperty("hooks_url", required=true)
    val hooksURL: String,

    @get:JsonProperty("html_url", required=true)@field:JsonProperty("html_url", required=true)
    val htmlURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty("issue_comment_url", required=true)@field:JsonProperty("issue_comment_url", required=true)
    val issueCommentURL: String,

    @get:JsonProperty("issue_events_url", required=true)@field:JsonProperty("issue_events_url", required=true)
    val issueEventsURL: String,

    @get:JsonProperty("issues_url", required=true)@field:JsonProperty("issues_url", required=true)
    val issuesURL: String,

    @get:JsonProperty("keys_url", required=true)@field:JsonProperty("keys_url", required=true)
    val keysURL: String,

    @get:JsonProperty("labels_url", required=true)@field:JsonProperty("labels_url", required=true)
    val labelsURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val language: String,

    @get:JsonProperty("languages_url", required=true)@field:JsonProperty("languages_url", required=true)
    val languagesURL: String,

    @get:JsonProperty("merges_url", required=true)@field:JsonProperty("merges_url", required=true)
    val mergesURL: String,

    @get:JsonProperty("milestones_url", required=true)@field:JsonProperty("milestones_url", required=true)
    val milestonesURL: String,

    @get:JsonProperty("mirror_url", required=true)@field:JsonProperty("mirror_url", required=true)
    val mirrorURL: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty("notifications_url", required=true)@field:JsonProperty("notifications_url", required=true)
    val notificationsURL: String,

    @get:JsonProperty("open_issues", required=true)@field:JsonProperty("open_issues", required=true)
    val openIssues: Long,

    @get:JsonProperty("open_issues_count", required=true)@field:JsonProperty("open_issues_count", required=true)
    val openIssuesCount: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val owner: User,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val private: Boolean,

    @get:JsonProperty("pulls_url", required=true)@field:JsonProperty("pulls_url", required=true)
    val pullsURL: String,

    @get:JsonProperty("pushed_at", required=true)@field:JsonProperty("pushed_at", required=true)
    val pushedAt: OffsetDateTime,

    @get:JsonProperty("releases_url", required=true)@field:JsonProperty("releases_url", required=true)
    val releasesURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val size: Long,

    @get:JsonProperty("ssh_url", required=true)@field:JsonProperty("ssh_url", required=true)
    val sshURL: String,

    @get:JsonProperty("stargazers_count", required=true)@field:JsonProperty("stargazers_count", required=true)
    val stargazersCount: Long,

    @get:JsonProperty("stargazers_url", required=true)@field:JsonProperty("stargazers_url", required=true)
    val stargazersURL: String,

    @get:JsonProperty("statuses_url", required=true)@field:JsonProperty("statuses_url", required=true)
    val statusesURL: String,

    @get:JsonProperty("subscribers_url", required=true)@field:JsonProperty("subscribers_url", required=true)
    val subscribersURL: String,

    @get:JsonProperty("subscription_url", required=true)@field:JsonProperty("subscription_url", required=true)
    val subscriptionURL: String,

    @get:JsonProperty("svn_url", required=true)@field:JsonProperty("svn_url", required=true)
    val svnURL: String,

    @get:JsonProperty("tags_url", required=true)@field:JsonProperty("tags_url", required=true)
    val tagsURL: String,

    @get:JsonProperty("teams_url", required=true)@field:JsonProperty("teams_url", required=true)
    val teamsURL: String,

    @get:JsonProperty("trees_url", required=true)@field:JsonProperty("trees_url", required=true)
    val treesURL: String,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val watchers: Long,

    @get:JsonProperty("watchers_count", required=true)@field:JsonProperty("watchers_count", required=true)
    val watchersCount: Long
)

data class Links (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val comments: Comments,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val commits: Comments,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val html: Comments,

    @get:JsonProperty("issue", required=true)@field:JsonProperty("issue", required=true)
    val issue: Comments,

    @get:JsonProperty("review_comment", required=true)@field:JsonProperty("review_comment", required=true)
    val reviewComment: Comments,

    @get:JsonProperty("review_comments", required=true)@field:JsonProperty("review_comments", required=true)
    val reviewComments: Comments,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val self: Comments,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val statuses: Comments
)

data class Comments (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val href: String
)

data class TopLevelRepo (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)
