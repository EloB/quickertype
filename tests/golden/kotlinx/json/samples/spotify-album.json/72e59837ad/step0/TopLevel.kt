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
    @SerialName("album_type")
    val albumType: String,

    val artists: List<Artist>,

    @SerialName("available_markets")
    val availableMarkets: List<String>,

    val copyrights: List<Copyright>,

    @SerialName("external_ids")
    val externalIDS: ExternalIDS,

    @SerialName("external_urls")
    val externalUrls: ExternalUrls,

    val genres: JsonArray,
    val href: String,
    val id: String,
    val images: List<Image>,
    val name: String,
    val popularity: Long,

    @SerialName("release_date")
    val releaseDate: String,

    @SerialName("release_date_precision")
    val releaseDatePrecision: String,

    val tracks: Tracks,
    val type: String,
    val uri: String
)

@Serializable
data class Artist (
    @SerialName("external_urls")
    val externalUrls: ExternalUrls,

    val href: String,
    val id: String,
    val name: String,
    val type: String,
    val uri: String
)

@Serializable
data class ExternalUrls (
    val spotify: String
)

@Serializable
data class Copyright (
    val text: String,
    val type: String
)

@Serializable
data class ExternalIDS (
    val upc: String
)

@Serializable
data class Image (
    val height: Long,
    val url: String,
    val width: Long
)

@Serializable
data class Tracks (
    val href: String,
    val items: List<Item>,
    val limit: Long,
    val next: JsonElement? = null,
    val offset: Long,
    val previous: JsonElement? = null,
    val total: Long
)

@Serializable
data class Item (
    val artists: List<Artist>,

    @SerialName("available_markets")
    val availableMarkets: List<String>,

    @SerialName("disc_number")
    val discNumber: Long,

    @SerialName("duration_ms")
    val durationMS: Long,

    val explicit: Boolean,

    @SerialName("external_urls")
    val externalUrls: ExternalUrls,

    val href: String,
    val id: String,
    val name: String,

    @SerialName("preview_url")
    val previewURL: String,

    @SerialName("track_number")
    val trackNumber: Long,

    val type: String,
    val uri: String
)
