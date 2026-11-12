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
    convert(Status::class, { Status.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val count: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val facets: Facets,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val limit: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val next: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val offset: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val previous: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val results: List<Result>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

typealias Facets = ObjectNode

data class Result (
    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty("person_id", required=true)@field:JsonProperty("person_id", required=true)
    val personID: String,

    @get:JsonProperty("representative_id", required=true)@field:JsonProperty("representative_id", required=true)
    val representativeID: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Status,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: String
)

enum class Status(val value: String) {
    Inactive("inactive"),
    Active("active");

    companion object {
        fun fromValue(value: String): Status = when (value) {
            "inactive" -> Inactive
            "active"   -> Active
            else       -> throw IllegalArgumentException()
        }
    }
}
