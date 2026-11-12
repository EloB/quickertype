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
    convert(Rating::class, { Rating.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Type::class,   { Type.fromValue(it.asText()) },   { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val data: List<Datum>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val meta: Meta,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pagination: Pagination
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Datum (
    @get:JsonProperty("bitly_gif_url", required=true)@field:JsonProperty("bitly_gif_url", required=true)
    val bitlyGIFURL: String,

    @get:JsonProperty("bitly_url", required=true)@field:JsonProperty("bitly_url", required=true)
    val bitlyURL: String,

    @get:JsonProperty("content_url", required=true)@field:JsonProperty("content_url", required=true)
    val contentURL: String,

    @get:JsonProperty("embed_url", required=true)@field:JsonProperty("embed_url", required=true)
    val embedURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val images: Images,

    @get:JsonProperty("import_datetime", required=true)@field:JsonProperty("import_datetime", required=true)
    val importDatetime: String,

    @get:JsonProperty("is_indexable", required=true)@field:JsonProperty("is_indexable", required=true)
    val isIndexable: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rating: Rating,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val slug: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val source: String,

    @get:JsonProperty("source_post_url", required=true)@field:JsonProperty("source_post_url", required=true)
    val sourcePostURL: String,

    @get:JsonProperty("source_tld", required=true)@field:JsonProperty("source_tld", required=true)
    val sourceTLD: String,

    @get:JsonProperty("trending_datetime", required=true)@field:JsonProperty("trending_datetime", required=true)
    val trendingDatetime: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Type,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    val user: User? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val username: String
)

data class Images (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val downsized: The480_WStill,

    @get:JsonProperty("downsized_large", required=true)@field:JsonProperty("downsized_large", required=true)
    val downsizedLarge: The480_WStill,

    @get:JsonProperty("downsized_medium", required=true)@field:JsonProperty("downsized_medium", required=true)
    val downsizedMedium: The480_WStill,

    @get:JsonProperty("downsized_small", required=true)@field:JsonProperty("downsized_small", required=true)
    val downsizedSmall: DownsizedSmall,

    @get:JsonProperty("downsized_still", required=true)@field:JsonProperty("downsized_still", required=true)
    val downsizedStill: The480_WStill,

    @get:JsonProperty("fixed_height", required=true)@field:JsonProperty("fixed_height", required=true)
    val fixedHeight: FixedHeight,

    @get:JsonProperty("fixed_height_downsampled", required=true)@field:JsonProperty("fixed_height_downsampled", required=true)
    val fixedHeightDownsampled: FixedHeight,

    @get:JsonProperty("fixed_height_small", required=true)@field:JsonProperty("fixed_height_small", required=true)
    val fixedHeightSmall: FixedHeight,

    @get:JsonProperty("fixed_height_small_still", required=true)@field:JsonProperty("fixed_height_small_still", required=true)
    val fixedHeightSmallStill: The480_WStill,

    @get:JsonProperty("fixed_height_still", required=true)@field:JsonProperty("fixed_height_still", required=true)
    val fixedHeightStill: The480_WStill,

    @get:JsonProperty("fixed_width", required=true)@field:JsonProperty("fixed_width", required=true)
    val fixedWidth: FixedHeight,

    @get:JsonProperty("fixed_width_downsampled", required=true)@field:JsonProperty("fixed_width_downsampled", required=true)
    val fixedWidthDownsampled: FixedHeight,

    @get:JsonProperty("fixed_width_small", required=true)@field:JsonProperty("fixed_width_small", required=true)
    val fixedWidthSmall: FixedHeight,

    @get:JsonProperty("fixed_width_small_still", required=true)@field:JsonProperty("fixed_width_small_still", required=true)
    val fixedWidthSmallStill: The480_WStill,

    @get:JsonProperty("fixed_width_still", required=true)@field:JsonProperty("fixed_width_still", required=true)
    val fixedWidthStill: The480_WStill,

    val hd: DownsizedSmall? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val looping: Looping,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val original: FixedHeight,

    @get:JsonProperty("original_mp4", required=true)@field:JsonProperty("original_mp4", required=true)
    val originalMp4: DownsizedSmall,

    @get:JsonProperty("original_still", required=true)@field:JsonProperty("original_still", required=true)
    val originalStill: The480_WStill,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val preview: DownsizedSmall,

    @get:JsonProperty("preview_gif", required=true)@field:JsonProperty("preview_gif", required=true)
    val previewGIF: The480_WStill,

    @get:JsonProperty("preview_webp", required=true)@field:JsonProperty("preview_webp", required=true)
    val previewWebp: The480_WStill,

    @get:JsonProperty("480w_still")@field:JsonProperty("480w_still")
    val the480WStill: The480_WStill? = null
)

data class The480_WStill (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val height: String,

    val size: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val width: String
)

data class DownsizedSmall (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val height: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mp4: String,

    @get:JsonProperty("mp4_size", required=true)@field:JsonProperty("mp4_size", required=true)
    val mp4Size: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val width: String
)

data class FixedHeight (
    val frames: String? = null,
    val hash: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val height: String,

    val mp4: String? = null,

    @get:JsonProperty("mp4_size")@field:JsonProperty("mp4_size")
    val mp4Size: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val size: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val webp: String,

    @get:JsonProperty("webp_size", required=true)@field:JsonProperty("webp_size", required=true)
    val webpSize: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val width: String
)

data class Looping (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mp4: String,

    @get:JsonProperty("mp4_size", required=true)@field:JsonProperty("mp4_size", required=true)
    val mp4Size: String
)

enum class Rating(val value: String) {
    PG("pg"),
    G("g"),
    PG13("pg-13"),
    Y("y");

    companion object {
        fun fromValue(value: String): Rating = when (value) {
            "pg"    -> PG
            "g"     -> G
            "pg-13" -> PG13
            "y"     -> Y
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Type(val value: String) {
    GIF("gif");

    companion object {
        fun fromValue(value: String): Type = when (value) {
            "gif" -> GIF
            else  -> throw IllegalArgumentException()
        }
    }
}

data class User (
    @get:JsonProperty("avatar_url", required=true)@field:JsonProperty("avatar_url", required=true)
    val avatarURL: String,

    @get:JsonProperty("banner_url", required=true)@field:JsonProperty("banner_url", required=true)
    val bannerURL: String,

    @get:JsonProperty("display_name", required=true)@field:JsonProperty("display_name", required=true)
    val displayName: String,

    @get:JsonProperty("profile_url", required=true)@field:JsonProperty("profile_url", required=true)
    val profileURL: String,

    val twitter: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val username: String
)

data class Meta (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val msg: String,

    @get:JsonProperty("response_id", required=true)@field:JsonProperty("response_id", required=true)
    val responseID: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Long
)

data class Pagination (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val count: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val offset: Long,

    @get:JsonProperty("total_count", required=true)@field:JsonProperty("total_count", required=true)
    val totalCount: Long
)
