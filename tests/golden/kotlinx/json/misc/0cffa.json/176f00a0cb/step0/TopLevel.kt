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
    val data: List<Datum>,
    val meta: Meta,
    val pagination: Pagination
)

@Serializable
data class Datum (
    @SerialName("bitly_gif_url")
    val bitlyGIFURL: String,

    @SerialName("bitly_url")
    val bitlyURL: String,

    @SerialName("content_url")
    val contentURL: String,

    @SerialName("embed_url")
    val embedURL: String,

    val id: String,
    val images: Images,

    @SerialName("import_datetime")
    val importDatetime: String,

    @SerialName("is_indexable")
    val isIndexable: Long,

    val rating: Rating,
    val slug: String,
    val source: String,

    @SerialName("source_post_url")
    val sourcePostURL: String,

    @SerialName("source_tld")
    val sourceTLD: String,

    @SerialName("trending_datetime")
    val trendingDatetime: String,

    val type: Type,
    val url: String,
    val user: User? = null,
    val username: Username
)

@Serializable
data class Images (
    val downsized: The480_WStill,

    @SerialName("downsized_large")
    val downsizedLarge: The480_WStill,

    @SerialName("downsized_medium")
    val downsizedMedium: The480_WStill,

    @SerialName("downsized_small")
    val downsizedSmall: DownsizedSmall,

    @SerialName("downsized_still")
    val downsizedStill: The480_WStill,

    @SerialName("fixed_height")
    val fixedHeight: FixedHeight,

    @SerialName("fixed_height_downsampled")
    val fixedHeightDownsampled: FixedHeight,

    @SerialName("fixed_height_small")
    val fixedHeightSmall: FixedHeight,

    @SerialName("fixed_height_small_still")
    val fixedHeightSmallStill: The480_WStill,

    @SerialName("fixed_height_still")
    val fixedHeightStill: The480_WStill,

    @SerialName("fixed_width")
    val fixedWidth: FixedHeight,

    @SerialName("fixed_width_downsampled")
    val fixedWidthDownsampled: FixedHeight,

    @SerialName("fixed_width_small")
    val fixedWidthSmall: FixedHeight,

    @SerialName("fixed_width_small_still")
    val fixedWidthSmallStill: The480_WStill,

    @SerialName("fixed_width_still")
    val fixedWidthStill: The480_WStill,

    val looping: Looping,
    val original: FixedHeight,

    @SerialName("original_mp4")
    val originalMp4: DownsizedSmall,

    @SerialName("original_still")
    val originalStill: The480_WStill,

    val preview: DownsizedSmall,

    @SerialName("preview_gif")
    val previewGIF: The480_WStill,

    @SerialName("preview_webp")
    val previewWebp: The480_WStill,

    @SerialName("480w_still")
    val the480WStill: The480_WStill? = null
)

@Serializable
data class The480_WStill (
    val height: String,
    val size: String? = null,
    val url: String,
    val width: String
)

@Serializable
data class DownsizedSmall (
    val height: String,
    val mp4: String,

    @SerialName("mp4_size")
    val mp4Size: String,

    val width: String
)

@Serializable
data class FixedHeight (
    val frames: String? = null,
    val hash: String? = null,
    val height: String,
    val mp4: String? = null,

    @SerialName("mp4_size")
    val mp4Size: String? = null,

    val size: String,
    val url: String,
    val webp: String,

    @SerialName("webp_size")
    val webpSize: String,

    val width: String
)

@Serializable
data class Looping (
    val mp4: String,

    @SerialName("mp4_size")
    val mp4Size: String
)

@Serializable
enum class Rating(val value: String) {
    @SerialName("g") G("g"),
    @SerialName("pg") PG("pg");
}

@Serializable
enum class Type(val value: String) {
    @SerialName("gif") GIF("gif");
}

@Serializable
data class User (
    @SerialName("avatar_url")
    val avatarURL: String,

    @SerialName("banner_url")
    val bannerURL: String,

    @SerialName("display_name")
    val displayName: String,

    @SerialName("profile_url")
    val profileURL: String,

    val twitter: String,
    val username: Username
)

@Serializable
enum class Username(val value: String) {
    @SerialName("cheezburger") Cheezburger("cheezburger"),
    @SerialName("") Empty(""),
    @SerialName("natgeowild") Natgeowild("natgeowild"),
    @SerialName("nowthis") Nowthis("nowthis");
}

@Serializable
data class Meta (
    val msg: String,

    @SerialName("response_id")
    val responseID: String,

    val status: Long
)

@Serializable
data class Pagination (
    val count: Long,
    val offset: Long,

    @SerialName("total_count")
    val totalCount: Long
)
