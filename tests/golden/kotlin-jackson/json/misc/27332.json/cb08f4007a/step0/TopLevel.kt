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
    convert(Domain::class,                { Domain.fromValue(it.asText()) },                { ObjectMapper().writeValueAsString(it.value) })
    convert(PostHint::class,              { PostHint.fromValue(it.asText()) },              { ObjectMapper().writeValueAsString(it.value) })
    convert(Subreddit::class,             { Subreddit.fromValue(it.asText()) },             { ObjectMapper().writeValueAsString(it.value) })
    convert(SubredditID::class,           { SubredditID.fromValue(it.asText()) },           { ObjectMapper().writeValueAsString(it.value) })
    convert(SubredditNamePrefixed::class, { SubredditNamePrefixed.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(SubredditType::class,         { SubredditType.fromValue(it.asText()) },         { ObjectMapper().writeValueAsString(it.value) })
    convert(Kind::class,                  { Kind.fromValue(it.asText()) },                  { ObjectMapper().writeValueAsString(it.value) })
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
    val authorFlairCSSClass: String?,

    @get:JsonProperty("author_flair_text", required=true)@field:JsonProperty("author_flair_text", required=true)
    val authorFlairText: String?,

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
    val distinguished: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val domain: Domain,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val downs: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val edited: Boolean,

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
    val linkFlairCSSClass: String?,

    @get:JsonProperty("link_flair_text", required=true)@field:JsonProperty("link_flair_text", required=true)
    val linkFlairText: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val locked: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val media: Media?,

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
    val secureMedia: Media?,

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
    val suggestedSort: Any? = null,

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

enum class Domain(val value: String) {
    SelfPics("self.pics"),
    ImgurCOM("imgur.com"),
    IImgurCOM("i.imgur.com"),
    IReddIt("i.redd.it");

    companion object {
        fun fromValue(value: String): Domain = when (value) {
            "self.pics"   -> SelfPics
            "imgur.com"   -> ImgurCOM
            "i.imgur.com" -> IImgurCOM
            "i.redd.it"   -> IReddIt
            else          -> throw IllegalArgumentException()
        }
    }
}

data class Media (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val oembed: Oembed,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Domain
)

data class Oembed (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val height: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val html: String,

    @get:JsonProperty("provider_name", required=true)@field:JsonProperty("provider_name", required=true)
    val providerName: String,

    @get:JsonProperty("provider_url", required=true)@field:JsonProperty("provider_url", required=true)
    val providerURL: String,

    @get:JsonProperty("thumbnail_height", required=true)@field:JsonProperty("thumbnail_height", required=true)
    val thumbnailHeight: Long,

    @get:JsonProperty("thumbnail_url", required=true)@field:JsonProperty("thumbnail_url", required=true)
    val thumbnailURL: String,

    @get:JsonProperty("thumbnail_width", required=true)@field:JsonProperty("thumbnail_width", required=true)
    val thumbnailWidth: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val version: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val width: Long
)

data class MediaEmbed (
    val content: String? = null,
    val height: Long? = null,
    val scrolling: Boolean? = null,
    val width: Long? = null
)

enum class PostHint(val value: String) {
    Link("link"),
    Image("image");

    companion object {
        fun fromValue(value: String): PostHint = when (value) {
            "link"  -> Link
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

typealias Variants = ObjectNode

enum class Subreddit(val value: String) {
    Pics("pics");

    companion object {
        fun fromValue(value: String): Subreddit = when (value) {
            "pics" -> Pics
            else   -> throw IllegalArgumentException()
        }
    }
}

enum class SubredditID(val value: String) {
    T52Qh0U("t5_2qh0u");

    companion object {
        fun fromValue(value: String): SubredditID = when (value) {
            "t5_2qh0u" -> T52Qh0U
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class SubredditNamePrefixed(val value: String) {
    RPics("r/pics");

    companion object {
        fun fromValue(value: String): SubredditNamePrefixed = when (value) {
            "r/pics" -> RPics
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class SubredditType(val value: String) {
    Public("public");

    companion object {
        fun fromValue(value: String): SubredditType = when (value) {
            "public" -> Public
            else     -> throw IllegalArgumentException()
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
