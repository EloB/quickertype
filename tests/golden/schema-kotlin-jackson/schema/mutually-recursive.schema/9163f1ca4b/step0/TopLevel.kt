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
    convert(Foo::class, { Foo.fromJson(it) }, { it.toJson() }, true)
}

sealed class Foo {
    class TopLevelArrayValue(val value: List<TopLevel>) : Foo()
    class TopLevelValue(val value: TopLevel)            : Foo()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is TopLevelArrayValue -> this.value
        is TopLevelValue      -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Foo = when (jn) {
            is ArrayNode  -> TopLevelArrayValue(mapper.convertValue(jn))
            is ObjectNode -> TopLevelValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class Bar (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val foo: Foo
)

data class TopLevel (
    val bar: Bar? = null
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}
