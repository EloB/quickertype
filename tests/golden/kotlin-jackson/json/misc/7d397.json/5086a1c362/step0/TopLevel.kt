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
    convert(Type::class, { Type.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(In::class,   { In.fromValue(it.asText()) },   { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val basePath: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val definitions: Definitions,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val host: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val info: Info,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val paths: Paths,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val produces: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val schemes: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val swagger: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Definitions (
    @get:JsonProperty("List", required=true)@field:JsonProperty("List", required=true)
    val list: ListClass
)

data class ListClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val properties: Map<String, Property>
)

data class Property (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Type
)

enum class Type(val value: String) {
    TypeString("string");

    companion object {
        fun fromValue(value: String): Type = when (value) {
            "string" -> TypeString
            else     -> throw IllegalArgumentException()
        }
    }
}

data class Info (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val version: String
)

data class Paths (
    @get:JsonProperty("/consolidated_screening_list/search", required=true)@field:JsonProperty("/consolidated_screening_list/search", required=true)
    val consolidatedScreeningListSearch: ConsolidatedScreeningListSearch
)

data class ConsolidatedScreeningListSearch (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val get: Get
)

data class Get (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val parameters: List<Parameter>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val responses: Responses,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val summary: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tags: List<String>
)

data class Parameter (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val format: Type,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty("in", required=true)@field:JsonProperty("in", required=true)
    val parameterIn: In,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val required: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Type
)

enum class In(val value: String) {
    Query("query");

    companion object {
        fun fromValue(value: String): In = when (value) {
            "query" -> Query
            else    -> throw IllegalArgumentException()
        }
    }
}

data class Responses (
    @get:JsonProperty("200", required=true)@field:JsonProperty("200", required=true)
    val the200: The200
)

data class The200 (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val schema: Schema
)

data class Schema (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val items: Items,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class Items (
    @get:JsonProperty("\$ref", required=true)@field:JsonProperty("\$ref", required=true)
    val ref: String
)
