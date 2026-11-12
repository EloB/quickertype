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
    convert(Name::class, { Name.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val metadata: Metadata,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val results: List<Result>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Metadata (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val executionTime: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val responseInfo: ResponseInfo,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val resultset: Resultset
)

data class ResponseInfo (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val developerMessage: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Long
)

data class Resultset (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val count: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val page: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pagesize: Long
)

data class Result (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val attachments: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val body: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val changed: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val component: List<Component>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val created: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val date: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val image: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val teaser: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val topic: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uuid: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val vuuid: String
)

data class Component (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: Name,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uuid: String
)

enum class Name(val value: String) {
    OfficeOnViolenceAgainstWomen("Office on Violence Against Women");

    companion object {
        fun fromValue(value: String): Name = when (value) {
            "Office on Violence Against Women" -> OfficeOnViolenceAgainstWomen
            else                               -> throw IllegalArgumentException()
        }
    }
}
