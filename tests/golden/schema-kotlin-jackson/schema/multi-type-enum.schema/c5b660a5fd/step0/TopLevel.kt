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
    convert(FooEnum::class,  { FooEnum.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(FooUnion::class, { FooUnion.fromJson(it) },          { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val foo: FooUnion
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class FooUnion {
    class BoolValue(val value: Boolean)  : FooUnion()
    class DoubleValue(val value: Double) : FooUnion()
    class EnumValue(val value: FooEnum)  : FooUnion()
    class IntegerValue(val value: Long)  : FooUnion()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue    -> this.value
        is DoubleValue  -> this.value
        is EnumValue    -> this.value
        is IntegerValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): FooUnion = when (jn) {
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is TextNode                            -> EnumValue(mapper.convertValue(jn))
            is IntNode, is LongNode                -> IntegerValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}

enum class FooEnum(val value: String) {
    A("a"),
    B("b"),
    C("c");

    companion object {
        fun fromValue(value: String): FooEnum = when (value) {
            "a"  -> A
            "b"  -> B
            "c"  -> C
            else -> throw IllegalArgumentException()
        }
    }
}
