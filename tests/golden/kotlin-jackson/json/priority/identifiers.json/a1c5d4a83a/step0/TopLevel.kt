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
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bla: TopLevelBla,

    @get:JsonProperty("", required=true)@field:JsonProperty("", required=true)
    val empty: Empty,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val foo: Foo,

    @get:JsonProperty("ThisIsA\ud83d\ude1cTough\"\n\nOne", required=true)@field:JsonProperty("ThisIsA\ud83d\ude1cTough\"\n\nOne", required=true)
    val thisIsAToughOne: ThisIsAToughOne,

    @get:JsonProperty("!", required=true)@field:JsonProperty("!", required=true)
    val topLevel: Long,

    @get:JsonProperty("Empty", required=true)@field:JsonProperty("Empty", required=true)
    val topLevelEmpty: EmptyClass
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelBla (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bar: Long
)

data class Empty (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val x: Long
)

data class Foo (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bla: FooBla,

    @get:JsonProperty("_", required=true)@field:JsonProperty("_", required=true)
    val empty: Long,

    @get:JsonProperty("__", required=true)@field:JsonProperty("__", required=true)
    val foo: Long
)

typealias FooBla = ObjectNode

data class ThisIsAToughOne (
    @get:JsonProperty("\n\n\n", required=true)@field:JsonProperty("\n\n\n", required=true)
    val empty: Long,

    @get:JsonProperty("\"", required=true)@field:JsonProperty("\"", required=true)
    val thisIsAToughOne: Long
)

data class EmptyClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val y: Long
)
