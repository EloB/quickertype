// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(OffsetDateTime::class, { OffsetDateTime.parse(it.string!!) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    .convert(Text::class,           { Text.fromValue(it.string!!) },       { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val query: Query
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Query (
    val count: Long,
    val created: OffsetDateTime,
    val lang: String,
    val results: Results
)

data class Results (
    val channel: Channel
)

data class Channel (
    val astronomy: Astronomy,
    val atmosphere: Atmosphere,
    val description: String,
    val image: Image,
    val item: Item,
    val language: String,
    val lastBuildDate: String,
    val link: String,
    val location: Location,
    val title: String,
    val ttl: String,
    val units: Units,
    val wind: Wind
)

data class Astronomy (
    val sunrise: String,
    val sunset: String
)

data class Atmosphere (
    val humidity: String,
    val pressure: String,
    val rising: String,
    val visibility: String
)

data class Image (
    val height: String,
    val link: String,
    val title: String,
    val url: String,
    val width: String
)

data class Item (
    val condition: Condition,
    val description: String,
    val forecast: List<Forecast>,
    val guid: GUID,
    val lat: String,
    val link: String,
    val long: String,
    val pubDate: String,
    val title: String
)

data class Condition (
    val code: String,
    val date: String,
    val temp: String,
    val text: String
)

data class Forecast (
    val code: String,
    val date: String,
    val day: String,
    val high: String,
    val low: String,
    val text: Text
)

enum class Text(val value: String) {
    Thunderstorms("Thunderstorms");

    companion object {
        public fun fromValue(value: String): Text = when (value) {
            "Thunderstorms" -> Thunderstorms
            else            -> throw IllegalArgumentException()
        }
    }
}

data class GUID (
    val isPermaLink: String
)

data class Location (
    val city: String,
    val country: String,
    val region: String
)

data class Units (
    val distance: String,
    val pressure: String,
    val speed: String,
    val temperature: String
)

data class Wind (
    val chill: String,
    val direction: String,
    val speed: String
)
