// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

@file:UseSerializers(OffsetDateTimeSerializer::class)

package quicktype

import java.time.OffsetDateTime

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val query: Query
)

@Serializable
data class Query (
    val count: Long,
    val created: OffsetDateTime,
    val lang: String,
    val results: Results
)

@Serializable
data class Results (
    val channel: Channel
)

@Serializable
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

@Serializable
data class Astronomy (
    val sunrise: String,
    val sunset: String
)

@Serializable
data class Atmosphere (
    val humidity: String,
    val pressure: String,
    val rising: String,
    val visibility: String
)

@Serializable
data class Image (
    val height: String,
    val link: String,
    val title: String,
    val url: String,
    val width: String
)

@Serializable
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

@Serializable
data class Condition (
    val code: String,
    val date: String,
    val temp: String,
    val text: String
)

@Serializable
data class Forecast (
    val code: String,
    val date: String,
    val day: String,
    val high: String,
    val low: String,
    val text: Text
)

@Serializable
enum class Text(val value: String) {
    @SerialName("Thunderstorms") Thunderstorms("Thunderstorms");
}

@Serializable
data class GUID (
    val isPermaLink: String
)

@Serializable
data class Location (
    val city: String,
    val country: String,
    val region: String
)

@Serializable
data class Units (
    val distance: String,
    val pressure: String,
    val speed: String,
    val temperature: String
)

@Serializable
data class Wind (
    val chill: String,
    val direction: String,
    val speed: String
)

object OffsetDateTimeSerializer : KSerializer<OffsetDateTime> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("OffsetDateTime", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): OffsetDateTime = OffsetDateTime.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: OffsetDateTime) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(value))
    }
}
