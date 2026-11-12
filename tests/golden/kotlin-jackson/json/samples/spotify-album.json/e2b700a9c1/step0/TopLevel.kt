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

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
}

data class TopLevel (
    @get:JsonProperty("album_type", required=true)@field:JsonProperty("album_type", required=true)
    val albumType: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val artists: List<Artist>,

    @get:JsonProperty("available_markets", required=true)@field:JsonProperty("available_markets", required=true)
    val availableMarkets: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val copyrights: List<Copyright>,

    @get:JsonProperty("external_ids", required=true)@field:JsonProperty("external_ids", required=true)
    val externalIDS: ExternalIDS,

    @get:JsonProperty("external_urls", required=true)@field:JsonProperty("external_urls", required=true)
    val externalUrls: ExternalUrls,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val genres: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val href: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val images: List<Image>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val popularity: Long,

    @get:JsonProperty("release_date", required=true)@field:JsonProperty("release_date", required=true)
    val releaseDate: String,

    @get:JsonProperty("release_date_precision", required=true)@field:JsonProperty("release_date_precision", required=true)
    val releaseDatePrecision: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tracks: Tracks,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uri: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Artist (
    @get:JsonProperty("external_urls", required=true)@field:JsonProperty("external_urls", required=true)
    val externalUrls: ExternalUrls,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val href: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uri: String
)

data class ExternalUrls (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val spotify: String
)

data class Copyright (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val text: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class ExternalIDS (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val upc: String
)

data class Image (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val height: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val width: Long
)

data class Tracks (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val href: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val items: List<Item>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val limit: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val next: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val offset: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val previous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val total: Long
)

data class Item (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val artists: List<Artist>,

    @get:JsonProperty("available_markets", required=true)@field:JsonProperty("available_markets", required=true)
    val availableMarkets: List<String>,

    @get:JsonProperty("disc_number", required=true)@field:JsonProperty("disc_number", required=true)
    val discNumber: Long,

    @get:JsonProperty("duration_ms", required=true)@field:JsonProperty("duration_ms", required=true)
    val durationMS: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val explicit: Boolean,

    @get:JsonProperty("external_urls", required=true)@field:JsonProperty("external_urls", required=true)
    val externalUrls: ExternalUrls,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val href: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty("preview_url", required=true)@field:JsonProperty("preview_url", required=true)
    val previewURL: String,

    @get:JsonProperty("track_number", required=true)@field:JsonProperty("track_number", required=true)
    val trackNumber: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uri: String
)
