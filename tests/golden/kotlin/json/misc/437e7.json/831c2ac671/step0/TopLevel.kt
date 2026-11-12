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
    .convert(Rating::class, { Rating.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Type::class,   { Type.fromValue(it.string!!) },   { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val data: List<Datum>,
    val meta: Meta,
    val pagination: Pagination
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Datum (
    @Json(name = "bitly_gif_url")
    val bitlyGIFURL: String,

    @Json(name = "bitly_url")
    val bitlyURL: String,

    @Json(name = "content_url")
    val contentURL: String,

    @Json(name = "embed_url")
    val embedURL: String,

    val id: String,
    val images: Images,

    @Json(name = "import_datetime")
    val importDatetime: String,

    @Json(name = "is_indexable")
    val isIndexable: Long,

    val rating: Rating,
    val slug: String,
    val source: String,

    @Json(name = "source_post_url")
    val sourcePostURL: String,

    @Json(name = "source_tld")
    val sourceTLD: String,

    @Json(name = "trending_datetime")
    val trendingDatetime: String,

    val type: Type,
    val url: String,
    val user: User? = null,
    val username: String
)

data class Images (
    val downsized: Downsized,

    @Json(name = "downsized_large")
    val downsizedLarge: Downsized,

    @Json(name = "downsized_medium")
    val downsizedMedium: Downsized,

    @Json(name = "downsized_small")
    val downsizedSmall: DownsizedSmall,

    @Json(name = "downsized_still")
    val downsizedStill: Downsized,

    @Json(name = "fixed_height")
    val fixedHeight: FixedHeight,

    @Json(name = "fixed_height_downsampled")
    val fixedHeightDownsampled: FixedHeight,

    @Json(name = "fixed_height_small")
    val fixedHeightSmall: FixedHeight,

    @Json(name = "fixed_height_small_still")
    val fixedHeightSmallStill: Downsized,

    @Json(name = "fixed_height_still")
    val fixedHeightStill: Downsized,

    @Json(name = "fixed_width")
    val fixedWidth: FixedHeight,

    @Json(name = "fixed_width_downsampled")
    val fixedWidthDownsampled: FixedHeight,

    @Json(name = "fixed_width_small")
    val fixedWidthSmall: FixedHeight,

    @Json(name = "fixed_width_small_still")
    val fixedWidthSmallStill: Downsized,

    @Json(name = "fixed_width_still")
    val fixedWidthStill: Downsized,

    val looping: Looping,
    val original: FixedHeight,

    @Json(name = "original_mp4")
    val originalMp4: DownsizedSmall,

    @Json(name = "original_still")
    val originalStill: Downsized,

    val preview: DownsizedSmall,

    @Json(name = "preview_gif")
    val previewGIF: Downsized,

    @Json(name = "preview_webp")
    val previewWebp: Downsized
)

data class Downsized (
    val height: String,
    val size: String? = null,
    val url: String,
    val width: String
)

data class DownsizedSmall (
    val height: String,
    val mp4: String,

    @Json(name = "mp4_size")
    val mp4Size: String,

    val width: String
)

data class FixedHeight (
    val frames: String? = null,
    val height: String,
    val mp4: String? = null,

    @Json(name = "mp4_size")
    val mp4Size: String? = null,

    val size: String,
    val url: String,
    val webp: String,

    @Json(name = "webp_size")
    val webpSize: String,

    val width: String
)

data class Looping (
    val mp4: String,

    @Json(name = "mp4_size")
    val mp4Size: String
)

enum class Rating(val value: String) {
    G("g"),
    PG("pg"),
    Y("y"),
    PG13("pg-13");

    companion object {
        public fun fromValue(value: String): Rating = when (value) {
            "g"     -> G
            "pg"    -> PG
            "y"     -> Y
            "pg-13" -> PG13
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Type(val value: String) {
    GIF("gif");

    companion object {
        public fun fromValue(value: String): Type = when (value) {
            "gif" -> GIF
            else  -> throw IllegalArgumentException()
        }
    }
}

data class User (
    @Json(name = "avatar_url")
    val avatarURL: String,

    @Json(name = "banner_url")
    val bannerURL: String,

    @Json(name = "display_name")
    val displayName: String,

    @Json(name = "profile_url")
    val profileURL: String,

    val twitter: String,
    val username: String
)

data class Meta (
    val msg: String,

    @Json(name = "response_id")
    val responseID: String,

    val status: Long
)

data class Pagination (
    val count: Long,
    val offset: Long,

    @Json(name = "total_count")
    val totalCount: Long
)
