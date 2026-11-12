// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

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
    convert(OffsetDateTime::class, { OffsetDateTime.parse(it.asText()) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    convert(Text::class,           { Text.fromValue(it.asText()) },       { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val query: Query
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Query (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val count: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val created: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lang: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val results: Results
)

data class Results (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val channel: Channel
)

data class Channel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val astronomy: Astronomy,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val atmosphere: Atmosphere,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val image: Image,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val item: Item,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val language: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lastBuildDate: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val link: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val location: Location,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ttl: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val units: Units,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val wind: Wind
)

data class Astronomy (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sunrise: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sunset: String
)

data class Atmosphere (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val humidity: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pressure: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rising: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val visibility: String
)

data class Image (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val height: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val link: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val width: String
)

data class Item (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val condition: Condition,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val forecast: List<Forecast>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val guid: GUID,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lat: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val link: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val long: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pubDate: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String
)

data class Condition (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val date: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val temp: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val text: String
)

data class Forecast (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val date: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val day: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val high: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val low: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val text: Text
)

enum class Text(val value: String) {
    Thunderstorms("Thunderstorms");

    companion object {
        fun fromValue(value: String): Text = when (value) {
            "Thunderstorms" -> Thunderstorms
            else            -> throw IllegalArgumentException()
        }
    }
}

data class GUID (
    @get:JsonProperty("isPermaLink", required=true)@field:JsonProperty("isPermaLink", required=true)
    val isPermaLink: String
)

data class Location (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val city: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val country: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val region: String
)

data class Units (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val distance: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pressure: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val speed: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val temperature: String
)

data class Wind (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val chill: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val direction: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val speed: String
)
