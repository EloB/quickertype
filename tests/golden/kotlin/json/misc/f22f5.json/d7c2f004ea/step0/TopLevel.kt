// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(JsonObject::class,            { it.obj!! },                                     { it.toJsonString() })
    .convert(Subreddit::class,             { Subreddit.fromValue(it.string!!) },             { Klaxon().toJsonString(it.value) })
    .convert(SubredditID::class,           { SubredditID.fromValue(it.string!!) },           { Klaxon().toJsonString(it.value) })
    .convert(SubredditNamePrefixed::class, { SubredditNamePrefixed.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(SubredditType::class,         { SubredditType.fromValue(it.string!!) },         { Klaxon().toJsonString(it.value) })
    .convert(Kind::class,                  { Kind.fromValue(it.string!!) },                  { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val data: TopLevelData,
    val kind: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class TopLevelData (
    val after: String,
    val before: Any? = null,
    val children: List<Child>,
    val modhash: String
)

data class Child (
    val data: ChildData,
    val kind: Kind
)

data class ChildData (
    @Json(name = "approved_at_utc")
    val approvedAtUTC: Any? = null,

    @Json(name = "approved_by")
    val approvedBy: Any? = null,

    val archived: Boolean,
    val author: String,

    @Json(name = "author_flair_css_class")
    val authorFlairCSSClass: Any? = null,

    @Json(name = "author_flair_text")
    val authorFlairText: Any? = null,

    @Json(name = "banned_at_utc")
    val bannedAtUTC: Any? = null,

    @Json(name = "banned_by")
    val bannedBy: Any? = null,

    @Json(name = "brand_safe")
    val brandSafe: Boolean,

    @Json(name = "can_gild")
    val canGild: Boolean,

    @Json(name = "can_mod_post")
    val canModPost: Boolean,

    val clicked: Boolean,

    @Json(name = "contest_mode")
    val contestMode: Boolean,

    val created: Double,

    @Json(name = "created_utc")
    val createdUTC: Double,

    val distinguished: Any? = null,
    val domain: String,
    val downs: Long,
    val edited: Boolean,
    val gilded: Long,
    val hidden: Boolean,

    @Json(name = "hide_score")
    val hideScore: Boolean,

    val id: String,

    @Json(name = "is_self")
    val isSelf: Boolean,

    @Json(name = "is_video")
    val isVideo: Boolean,

    val likes: Any? = null,

    @Json(name = "link_flair_css_class")
    val linkFlairCSSClass: String? = null,

    @Json(name = "link_flair_text")
    val linkFlairText: String? = null,

    val locked: Boolean,
    val media: Any? = null,

    @Json(name = "media_embed")
    val mediaEmbed: MediaEmbed,

    @Json(name = "mod_reports")
    val modReports: List<Any?>,

    val name: String,

    @Json(name = "num_comments")
    val numComments: Long,

    @Json(name = "num_reports")
    val numReports: Any? = null,

    @Json(name = "over_18")
    val over18: Boolean,

    val permalink: String,
    val quarantine: Boolean,

    @Json(name = "removal_reason")
    val removalReason: Any? = null,

    @Json(name = "report_reasons")
    val reportReasons: Any? = null,

    val saved: Boolean,
    val score: Long,

    @Json(name = "secure_media")
    val secureMedia: Any? = null,

    @Json(name = "secure_media_embed")
    val secureMediaEmbed: MediaEmbed,

    val selftext: String,

    @Json(name = "selftext_html")
    val selftextHTML: Any? = null,

    val spoiler: Boolean,
    val stickied: Boolean,
    val subreddit: Subreddit,

    @Json(name = "subreddit_id")
    val subredditID: SubredditID,

    @Json(name = "subreddit_name_prefixed")
    val subredditNamePrefixed: SubredditNamePrefixed,

    @Json(name = "subreddit_type")
    val subredditType: SubredditType,

    @Json(name = "suggested_sort")
    val suggestedSort: Any? = null,

    val thumbnail: String,
    val title: String,
    val ups: Long,
    val url: String,

    @Json(name = "user_reports")
    val userReports: List<Any?>,

    @Json(name = "view_count")
    val viewCount: Any? = null,

    val visited: Boolean
)

typealias MediaEmbed = JsonObject

enum class Subreddit(val value: String) {
    Worldnews("worldnews");

    companion object {
        public fun fromValue(value: String): Subreddit = when (value) {
            "worldnews" -> Worldnews
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class SubredditID(val value: String) {
    T52Qh13("t5_2qh13");

    companion object {
        public fun fromValue(value: String): SubredditID = when (value) {
            "t5_2qh13" -> T52Qh13
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class SubredditNamePrefixed(val value: String) {
    RWorldnews("r/worldnews");

    companion object {
        public fun fromValue(value: String): SubredditNamePrefixed = when (value) {
            "r/worldnews" -> RWorldnews
            else          -> throw IllegalArgumentException()
        }
    }
}

enum class SubredditType(val value: String) {
    Public("public");

    companion object {
        public fun fromValue(value: String): SubredditType = when (value) {
            "public" -> Public
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class Kind(val value: String) {
    T3("t3");

    companion object {
        public fun fromValue(value: String): Kind = when (value) {
            "t3" -> T3
            else -> throw IllegalArgumentException()
        }
    }
}
