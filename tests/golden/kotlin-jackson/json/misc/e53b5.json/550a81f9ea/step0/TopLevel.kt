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
    convert(ID::class,            { ID.fromValue(it.asText()) },    { ObjectMapper().writeValueAsString(it.value) })
    convert(Value::class,         { Value.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(TopLevelUnion::class, { TopLevelUnion.fromJson(it) },   { it.toJson() }, true)
}

class TopLevel(elements: Collection<TopLevelUnion> = emptyList()) : ArrayList<TopLevelUnion>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class TopLevelUnion {
    class FluffyTopLevelValue(val value: FluffyTopLevel)            : TopLevelUnion()
    class PurpleTopLevelArrayValue(val value: List<PurpleTopLevel>) : TopLevelUnion()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is FluffyTopLevelValue      -> this.value
        is PurpleTopLevelArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): TopLevelUnion = when (jn) {
            is ObjectNode -> FluffyTopLevelValue(mapper.convertValue(jn))
            is ArrayNode  -> PurpleTopLevelArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class PurpleTopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val country: Country,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val date: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val decimal: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val indicator: Country,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val value: String
)

data class Country (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: ID,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val value: Value
)

enum class ID(val value: String) {
    In("IN"),
    SPPopTotl("SP.POP.TOTL");

    companion object {
        fun fromValue(value: String): ID = when (value) {
            "IN"          -> In
            "SP.POP.TOTL" -> SPPopTotl
            else          -> throw IllegalArgumentException()
        }
    }
}

enum class Value(val value: String) {
    India("India"),
    PopulationTotal("Population, total");

    companion object {
        fun fromValue(value: String): Value = when (value) {
            "India"             -> India
            "Population, total" -> PopulationTotal
            else                -> throw IllegalArgumentException()
        }
    }
}

data class FluffyTopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val page: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pages: Long,

    @get:JsonProperty("per_page", required=true)@field:JsonProperty("per_page", required=true)
    val perPage: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val total: Long
)
