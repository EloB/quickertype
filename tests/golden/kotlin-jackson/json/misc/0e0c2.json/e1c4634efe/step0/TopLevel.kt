// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.LocalDate

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
    convert(LocalDate::class,      { LocalDate.parse(it.asText()) },          { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    convert(DetailLanguage::class, { DetailLanguage.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Type::class,           { Type.fromValue(it.asText()) },           { ObjectMapper().writeValueAsString(it.value) })
    convert(ResultLanguage::class, { ResultLanguage.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val count: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val next: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val previous: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val results: List<Result>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Result (
    @get:JsonProperty("active_screens", required=true)@field:JsonProperty("active_screens", required=true)
    val activeScreens: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val collections: List<Collection>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val details: List<Detail>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val duration: Long,

    @get:JsonProperty("fav_movie", required=true)@field:JsonProperty("fav_movie", required=true)
    val favMovie: FavMovie,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val images: List<Image>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val language: ResultLanguage,

    @get:JsonProperty("release_date", required=true)@field:JsonProperty("release_date", required=true)
    val releaseDate: LocalDate,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stars: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tags: List<Any?>?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val videos: List<Video>,

    @get:JsonProperty("vote_score", required=true)@field:JsonProperty("vote_score", required=true)
    val voteScore: VoteScore,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val watches: Long
)

data class Collection (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val movies: List<Long>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val slug: String
)

data class Detail (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cast: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val director: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val language: DetailLanguage,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val storyline: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tagline: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String
)

enum class DetailLanguage(val value: String) {
    En("en"),
    Th("th");

    companion object {
        fun fromValue(value: String): DetailLanguage = when (value) {
            "en" -> En
            "th" -> Th
            else -> throw IllegalArgumentException()
        }
    }
}

data class FavMovie (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val follow: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val star: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val watched: Boolean
)

data class Image (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val favs: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thumbnail: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Type,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

enum class Type(val value: String) {
    Poster("Poster"),
    Backdrop("Backdrop");

    companion object {
        fun fromValue(value: String): Type = when (value) {
            "Poster"   -> Poster
            "Backdrop" -> Backdrop
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class ResultLanguage(val value: String) {
    En("en"),
    Empty("-");

    companion object {
        fun fromValue(value: String): ResultLanguage = when (value) {
            "en" -> En
            "-"  -> Empty
            else -> throw IllegalArgumentException()
        }
    }
}

data class Video (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val language: ResultLanguage,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val source: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

data class VoteScore (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val avg: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val score: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val total: Long
)
