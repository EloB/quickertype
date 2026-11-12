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
    convert(Code::class,     { Code.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(English::class,  { English.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
    convert(Thai::class,     { Thai.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(Location::class, { Location.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Tel::class,      { Tel.fromValue(it.asText()) },      { ObjectMapper().writeValueAsString(it.value) })
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
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val english: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fav: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val group: Group,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val location: Location,

    @get:JsonProperty("min_screens", required=true)@field:JsonProperty("min_screens", required=true)
    val minScreens: Long,

    @get:JsonProperty("num_views", required=true)@field:JsonProperty("num_views", required=true)
    val numViews: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val showtimes: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val stars: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tel: Tel,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thai: String,

    @get:JsonProperty("today_screens", required=true)@field:JsonProperty("today_screens", required=true)
    val todayScreens: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val website: String
)

data class Group (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: Code,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val english: English,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thai: Thai,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val website: String
)

enum class Code(val value: String) {
    Sf("sf");

    companion object {
        fun fromValue(value: String): Code = when (value) {
            "sf" -> Sf
            else -> throw IllegalArgumentException()
        }
    }
}

enum class English(val value: String) {
    Sf("SF");

    companion object {
        fun fromValue(value: String): English = when (value) {
            "SF" -> Sf
            else -> throw IllegalArgumentException()
        }
    }
}

enum class Thai(val value: String) {
    เอสเอฟ("เอสเอฟ");

    companion object {
        fun fromValue(value: String): Thai = when (value) {
            "เอสเอฟ" -> เอสเอฟ
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class Location(val value: String) {
    Empty(""),
    The5ThFLEmporium("5th Fl. Emporium");

    companion object {
        fun fromValue(value: String): Location = when (value) {
            ""                 -> Empty
            "5th Fl. Emporium" -> The5ThFLEmporium
            else               -> throw IllegalArgumentException()
        }
    }
}

enum class Tel(val value: String) {
    Empty(""),
    The022688899("02-268-8899");

    companion object {
        fun fromValue(value: String): Tel = when (value) {
            ""            -> Empty
            "02-268-8899" -> The022688899
            else          -> throw IllegalArgumentException()
        }
    }
}
