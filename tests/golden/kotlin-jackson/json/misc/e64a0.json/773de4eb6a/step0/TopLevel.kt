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
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val args: Args,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val headers: Headers,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val origin: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

typealias Args = ObjectNode

data class Headers (
    @get:JsonProperty("Accept-Encoding", required=true)@field:JsonProperty("Accept-Encoding", required=true)
    val acceptEncoding: String,

    @get:JsonProperty("Connection", required=true)@field:JsonProperty("Connection", required=true)
    val connection: String,

    @get:JsonProperty("Host", required=true)@field:JsonProperty("Host", required=true)
    val host: String,

    @get:JsonProperty("User-Agent", required=true)@field:JsonProperty("User-Agent", required=true)
    val userAgent: String
)
