// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val data: TopLevelData,
    val kind: String
)

@Serializable
data class TopLevelData (
    val after: String,
    val before: JsonElement? = null,
    val children: List<Child>,
    val modhash: String
)

@Serializable
data class Child (
    val data: ChildData,
    val kind: Kind
)

@Serializable
data class ChildData (
    @SerialName("approved_at_utc")
    val approvedAtUTC: JsonElement? = null,

    @SerialName("approved_by")
    val approvedBy: JsonElement? = null,

    val archived: Boolean,
    val author: String,

    @SerialName("author_flair_css_class")
    val authorFlairCSSClass: JsonElement? = null,

    @SerialName("author_flair_text")
    val authorFlairText: JsonElement? = null,

    @SerialName("banned_at_utc")
    val bannedAtUTC: JsonElement? = null,

    @SerialName("banned_by")
    val bannedBy: JsonElement? = null,

    @SerialName("brand_safe")
    val brandSafe: Boolean,

    @SerialName("can_gild")
    val canGild: Boolean,

    @SerialName("can_mod_post")
    val canModPost: Boolean,

    val clicked: Boolean,

    @SerialName("contest_mode")
    val contestMode: Boolean,

    val created: Double,

    @SerialName("created_utc")
    val createdUTC: Double,

    val distinguished: JsonElement? = null,
    val domain: String,
    val downs: Long,
    val edited: Boolean,
    val gilded: Long,
    val hidden: Boolean,

    @SerialName("hide_score")
    val hideScore: Boolean,

    val id: String,

    @SerialName("is_self")
    val isSelf: Boolean,

    @SerialName("is_video")
    val isVideo: Boolean,

    val likes: JsonElement? = null,

    @SerialName("link_flair_css_class")
    val linkFlairCSSClass: JsonElement? = null,

    @SerialName("link_flair_text")
    val linkFlairText: JsonElement? = null,

    val locked: Boolean,
    val media: Media? = null,

    @SerialName("media_embed")
    val mediaEmbed: MediaEmbed,

    @SerialName("mod_reports")
    val modReports: JsonArray,

    val name: String,

    @SerialName("num_comments")
    val numComments: Long,

    @SerialName("num_reports")
    val numReports: JsonElement? = null,

    @SerialName("over_18")
    val over18: Boolean,

    val permalink: String,

    @SerialName("post_hint")
    val postHint: PostHint? = null,

    val preview: Preview? = null,
    val quarantine: Boolean,

    @SerialName("removal_reason")
    val removalReason: JsonElement? = null,

    @SerialName("report_reasons")
    val reportReasons: JsonElement? = null,

    val saved: Boolean,
    val score: Long,

    @SerialName("secure_media")
    val secureMedia: Media? = null,

    @SerialName("secure_media_embed")
    val secureMediaEmbed: MediaEmbed,

    val selftext: String,

    @SerialName("selftext_html")
    val selftextHTML: JsonElement? = null,

    val spoiler: Boolean,
    val stickied: Boolean,
    val subreddit: Subreddit,

    @SerialName("subreddit_id")
    val subredditID: SubredditID,

    @SerialName("subreddit_name_prefixed")
    val subredditNamePrefixed: SubredditNamePrefixed,

    @SerialName("subreddit_type")
    val subredditType: SubredditType,

    @SerialName("suggested_sort")
    val suggestedSort: JsonElement? = null,

    val thumbnail: String,

    @SerialName("thumbnail_height")
    val thumbnailHeight: Long? = null,

    @SerialName("thumbnail_width")
    val thumbnailWidth: Long? = null,

    val title: String,
    val ups: Long,
    val url: String,

    @SerialName("user_reports")
    val userReports: JsonArray,

    @SerialName("view_count")
    val viewCount: JsonElement? = null,

    val visited: Boolean
)

@Serializable
data class Media (
    val oembed: Oembed,
    val type: String
)

@Serializable
data class Oembed (
    @SerialName("author_name")
    val authorName: String,

    @SerialName("author_url")
    val authorURL: String,

    val height: Long,
    val html: String,

    @SerialName("provider_name")
    val providerName: String,

    @SerialName("provider_url")
    val providerURL: String,

    @SerialName("thumbnail_height")
    val thumbnailHeight: Long,

    @SerialName("thumbnail_url")
    val thumbnailURL: String,

    @SerialName("thumbnail_width")
    val thumbnailWidth: Long,

    val title: String,
    val type: String,
    val version: String,
    val width: Long
)

@Serializable
data class MediaEmbed (
    val content: String? = null,
    val height: Long? = null,
    val scrolling: Boolean? = null,
    val width: Long? = null
)

@Serializable
enum class PostHint(val value: String) {
    @SerialName("rich:video") RichVideo("rich:video"),
    @SerialName("link") Link("link");
}

@Serializable
data class Preview (
    val enabled: Boolean,
    val images: List<Image>
)

@Serializable
data class Image (
    val id: String,
    val resolutions: List<Source>,
    val source: Source,
    val variants: Variants
)

@Serializable
data class Source (
    val height: Long,
    val url: String,
    val width: Long
)

@Serializable
class Variants()

@Serializable
enum class Subreddit(val value: String) {
    @SerialName("todayilearned") Todayilearned("todayilearned");
}

@Serializable
enum class SubredditID(val value: String) {
    @SerialName("t5_2qqjc") T52Qqjc("t5_2qqjc");
}

@Serializable
enum class SubredditNamePrefixed(val value: String) {
    @SerialName("r/todayilearned") RTodayilearned("r/todayilearned");
}

@Serializable
enum class SubredditType(val value: String) {
    @SerialName("public") Public("public");
}

@Serializable
enum class Kind(val value: String) {
    @SerialName("t3") T3("t3");
}
