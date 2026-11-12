// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    @Json(name = "album_type")
    val albumType: String,

    val artists: List<Artist>,

    @Json(name = "available_markets")
    val availableMarkets: List<String>,

    val copyrights: List<Copyright>,

    @Json(name = "external_ids")
    val externalIDS: ExternalIDS,

    @Json(name = "external_urls")
    val externalUrls: ExternalUrls,

    val genres: List<Any?>,
    val href: String,
    val id: String,
    val images: List<Image>,
    val name: String,
    val popularity: Long,

    @Json(name = "release_date")
    val releaseDate: String,

    @Json(name = "release_date_precision")
    val releaseDatePrecision: String,

    val tracks: Tracks,
    val type: String,
    val uri: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Artist (
    @Json(name = "external_urls")
    val externalUrls: ExternalUrls,

    val href: String,
    val id: String,
    val name: String,
    val type: String,
    val uri: String
)

data class ExternalUrls (
    val spotify: String
)

data class Copyright (
    val text: String,
    val type: String
)

data class ExternalIDS (
    val upc: String
)

data class Image (
    val height: Long,
    val url: String,
    val width: Long
)

data class Tracks (
    val href: String,
    val items: List<Item>,
    val limit: Long,
    val next: Any? = null,
    val offset: Long,
    val previous: Any? = null,
    val total: Long
)

data class Item (
    val artists: List<Artist>,

    @Json(name = "available_markets")
    val availableMarkets: List<String>,

    @Json(name = "disc_number")
    val discNumber: Long,

    @Json(name = "duration_ms")
    val durationMS: Long,

    val explicit: Boolean,

    @Json(name = "external_urls")
    val externalUrls: ExternalUrls,

    val href: String,
    val id: String,
    val name: String,

    @Json(name = "preview_url")
    val previewURL: String,

    @Json(name = "track_number")
    val trackNumber: Long,

    val type: String,
    val uri: String
)
