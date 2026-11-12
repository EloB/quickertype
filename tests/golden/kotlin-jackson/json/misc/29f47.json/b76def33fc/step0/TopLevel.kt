// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

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
    convert(Distinguished::class,         { Distinguished.fromValue(it.asText()) },         { ObjectMapper().writeValueAsString(it.value) })
    convert(Domain::class,                { Domain.fromValue(it.asText()) },                { ObjectMapper().writeValueAsString(it.value) })
    convert(PostHint::class,              { PostHint.fromValue(it.asText()) },              { ObjectMapper().writeValueAsString(it.value) })
    convert(Subreddit::class,             { Subreddit.fromValue(it.asText()) },             { ObjectMapper().writeValueAsString(it.value) })
    convert(SubredditID::class,           { SubredditID.fromValue(it.asText()) },           { ObjectMapper().writeValueAsString(it.value) })
    convert(SubredditNamePrefixed::class, { SubredditNamePrefixed.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(SubredditType::class,         { SubredditType.fromValue(it.asText()) },         { ObjectMapper().writeValueAsString(it.value) })
    convert(Kind::class,                  { Kind.fromValue(it.asText()) },                  { ObjectMapper().writeValueAsString(it.value) })
    convert(Edited::class,                { Edited.fromJson(it) },                          { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val data: TopLevelData,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelData (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val after: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val before: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val children: List<Child>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val modhash: String
)

data class Child (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val data: ChildData,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Kind
)

data class ChildData (
    @get:JsonProperty("approved_at_utc", required=true)@field:JsonProperty("approved_at_utc", required=true)
    val approvedAtUTC: Any? = null,

    @get:JsonProperty("approved_by", required=true)@field:JsonProperty("approved_by", required=true)
    val approvedBy: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val archived: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val author: String,

    @get:JsonProperty("author_flair_css_class", required=true)@field:JsonProperty("author_flair_css_class", required=true)
    val authorFlairCSSClass: Any? = null,

    @get:JsonProperty("author_flair_text", required=true)@field:JsonProperty("author_flair_text", required=true)
    val authorFlairText: Any? = null,

    @get:JsonProperty("banned_at_utc", required=true)@field:JsonProperty("banned_at_utc", required=true)
    val bannedAtUTC: Any? = null,

    @get:JsonProperty("banned_by", required=true)@field:JsonProperty("banned_by", required=true)
    val bannedBy: Any? = null,

    @get:JsonProperty("brand_safe", required=true)@field:JsonProperty("brand_safe", required=true)
    val brandSafe: Boolean,

    @get:JsonProperty("can_gild", required=true)@field:JsonProperty("can_gild", required=true)
    val canGild: Boolean,

    @get:JsonProperty("can_mod_post", required=true)@field:JsonProperty("can_mod_post", required=true)
    val canModPost: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val clicked: Boolean,

    @get:JsonProperty("contest_mode", required=true)@field:JsonProperty("contest_mode", required=true)
    val contestMode: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val created: Double,

    @get:JsonProperty("created_utc", required=true)@field:JsonProperty("created_utc", required=true)
    val createdUTC: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val distinguished: Distinguished,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val domain: Domain,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val downs: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val edited: Edited,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gilded: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hidden: Boolean,

    @get:JsonProperty("hide_score", required=true)@field:JsonProperty("hide_score", required=true)
    val hideScore: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty("is_self", required=true)@field:JsonProperty("is_self", required=true)
    val isSelf: Boolean,

    @get:JsonProperty("is_video", required=true)@field:JsonProperty("is_video", required=true)
    val isVideo: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val likes: Any? = null,

    @get:JsonProperty("link_flair_css_class", required=true)@field:JsonProperty("link_flair_css_class", required=true)
    val linkFlairCSSClass: Any? = null,

    @get:JsonProperty("link_flair_text", required=true)@field:JsonProperty("link_flair_text", required=true)
    val linkFlairText: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val locked: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val media: Any? = null,

    @get:JsonProperty("media_embed", required=true)@field:JsonProperty("media_embed", required=true)
    val mediaEmbed: MediaEmbed,

    @get:JsonProperty("mod_reports", required=true)@field:JsonProperty("mod_reports", required=true)
    val modReports: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty("num_comments", required=true)@field:JsonProperty("num_comments", required=true)
    val numComments: Long,

    @get:JsonProperty("num_reports", required=true)@field:JsonProperty("num_reports", required=true)
    val numReports: Any? = null,

    @get:JsonProperty("over_18", required=true)@field:JsonProperty("over_18", required=true)
    val over18: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val permalink: String,

    @get:JsonProperty("post_hint")@field:JsonProperty("post_hint")
    val postHint: PostHint? = null,

    val preview: Preview? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val quarantine: Boolean,

    @get:JsonProperty("removal_reason", required=true)@field:JsonProperty("removal_reason", required=true)
    val removalReason: Any? = null,

    @get:JsonProperty("report_reasons", required=true)@field:JsonProperty("report_reasons", required=true)
    val reportReasons: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val saved: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val score: Long,

    @get:JsonProperty("secure_media", required=true)@field:JsonProperty("secure_media", required=true)
    val secureMedia: Any? = null,

    @get:JsonProperty("secure_media_embed", required=true)@field:JsonProperty("secure_media_embed", required=true)
    val secureMediaEmbed: MediaEmbed,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val selftext: String,

    @get:JsonProperty("selftext_html", required=true)@field:JsonProperty("selftext_html", required=true)
    val selftextHTML: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val spoiler: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stickied: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subreddit: Subreddit,

    @get:JsonProperty("subreddit_id", required=true)@field:JsonProperty("subreddit_id", required=true)
    val subredditID: SubredditID,

    @get:JsonProperty("subreddit_name_prefixed", required=true)@field:JsonProperty("subreddit_name_prefixed", required=true)
    val subredditNamePrefixed: SubredditNamePrefixed,

    @get:JsonProperty("subreddit_type", required=true)@field:JsonProperty("subreddit_type", required=true)
    val subredditType: SubredditType,

    @get:JsonProperty("suggested_sort", required=true)@field:JsonProperty("suggested_sort", required=true)
    val suggestedSort: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thumbnail: String,

    @get:JsonProperty("thumbnail_height", required=true)@field:JsonProperty("thumbnail_height", required=true)
    val thumbnailHeight: Long?,

    @get:JsonProperty("thumbnail_width", required=true)@field:JsonProperty("thumbnail_width", required=true)
    val thumbnailWidth: Long?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ups: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty("user_reports", required=true)@field:JsonProperty("user_reports", required=true)
    val userReports: List<Any?>,

    @get:JsonProperty("view_count", required=true)@field:JsonProperty("view_count", required=true)
    val viewCount: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val visited: Boolean
)

enum class Distinguished(val value: String) {
    Admin("admin");

    companion object {
        fun fromValue(value: String): Distinguished = when (value) {
            "admin" -> Admin
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Domain(val value: String) {
    SelfAnnouncements("self.announcements"),
    IReddIt("i.redd.it");

    companion object {
        fun fromValue(value: String): Domain = when (value) {
            "self.announcements" -> SelfAnnouncements
            "i.redd.it"          -> IReddIt
            else                 -> throw IllegalArgumentException()
        }
    }
}

sealed class Edited {
    class BoolValue(val value: Boolean)  : Edited()
    class DoubleValue(val value: Double) : Edited()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue   -> this.value
        is DoubleValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Edited = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

typealias MediaEmbed = ObjectNode

enum class PostHint(val value: String) {
    Self("self"),
    Image("image");

    companion object {
        fun fromValue(value: String): PostHint = when (value) {
            "self"  -> Self
            "image" -> Image
            else    -> throw IllegalArgumentException()
        }
    }
}

data class Preview (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val enabled: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val images: List<Image>
)

data class Image (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val resolutions: List<Source>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val source: Source,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val variants: Variants
)

data class Source (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val height: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val width: Long
)

data class Variants (
    val gif: GIF? = null,
    val mp4: GIF? = null
)

data class GIF (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val resolutions: List<Source>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val source: Source
)

enum class Subreddit(val value: String) {
    Announcements("announcements");

    companion object {
        fun fromValue(value: String): Subreddit = when (value) {
            "announcements" -> Announcements
            else            -> throw IllegalArgumentException()
        }
    }
}

enum class SubredditID(val value: String) {
    T52R0Ij("t5_2r0ij");

    companion object {
        fun fromValue(value: String): SubredditID = when (value) {
            "t5_2r0ij" -> T52R0Ij
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class SubredditNamePrefixed(val value: String) {
    RAnnouncements("r/announcements");

    companion object {
        fun fromValue(value: String): SubredditNamePrefixed = when (value) {
            "r/announcements" -> RAnnouncements
            else              -> throw IllegalArgumentException()
        }
    }
}

enum class SubredditType(val value: String) {
    Restricted("restricted");

    companion object {
        fun fromValue(value: String): SubredditType = when (value) {
            "restricted" -> Restricted
            else         -> throw IllegalArgumentException()
        }
    }
}

enum class Kind(val value: String) {
    T3("t3");

    companion object {
        fun fromValue(value: String): Kind = when (value) {
            "t3" -> T3
            else -> throw IllegalArgumentException()
        }
    }
}
