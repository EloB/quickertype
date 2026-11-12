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
            override fun getNullValue(ctxt: DeserializationContext) = if (isUnion) fromJson(NullNode.instance) else null
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(Closed::class, { Closed.fromJson(it) }, { it.toJson() }, true)
}

data class TopLevel (
    val config: Config? = null
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Config (
    val closed: Closed? = null,
    val name: String? = null,
    val settings: Map<String, List<Item>>? = null
)

sealed class Closed {
    class AnythingArrayValue(val value: List<Any?>) : Closed()
    class BoolValue(val value: Boolean)             : Closed()
    class ClosedClassValue(val value: ClosedClass)  : Closed()
    class DoubleValue(val value: Double)            : Closed()
    class IntegerValue(val value: Long)             : Closed()
    class StringValue(val value: String)            : Closed()
    class NullValue()                               : Closed()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is AnythingArrayValue -> this.value
        is BoolValue          -> this.value
        is ClosedClassValue   -> this.value
        is DoubleValue        -> this.value
        is IntegerValue       -> this.value
        is StringValue        -> this.value
        is NullValue          -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Closed = when (jn) {
            is ArrayNode                           -> AnythingArrayValue(mapper.convertValue(jn))
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is ObjectNode                          -> ClosedClassValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is IntNode, is LongNode                -> IntegerValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

typealias ClosedClass = ObjectNode

data class Item (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val key: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val value: String
)
