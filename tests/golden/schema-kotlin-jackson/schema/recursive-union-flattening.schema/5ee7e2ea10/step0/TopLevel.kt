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
    convert(TopLevel::class,        { TopLevel.fromJson(it) },        { it.toJson() }, true)
    convert(TopLevelElement::class, { TopLevelElement.fromJson(it) }, { it.toJson() }, true)
    convert(XElement::class,        { XElement.fromJson(it) },        { it.toJson() }, true)
    convert(X::class,               { X.fromJson(it) },               { it.toJson() }, true)
}

sealed class TopLevel {
    class AnythingMapValue(val value: Map<String, Any?>)    : TopLevel()
    class BoolValue(val value: Boolean)                     : TopLevel()
    class DoubleValue(val value: Double)                    : TopLevel()
    class IntegerValue(val value: Long)                     : TopLevel()
    class StringValue(val value: String)                    : TopLevel()
    class UnionArrayValue(val value: List<TopLevelElement>) : TopLevel()
    class NullValue()                                       : TopLevel()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is AnythingMapValue -> this.value
        is BoolValue        -> this.value
        is DoubleValue      -> this.value
        is IntegerValue     -> this.value
        is StringValue      -> this.value
        is UnionArrayValue  -> this.value
        is NullValue        -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): TopLevel = when (jn) {
            is ObjectNode                          -> AnythingMapValue(mapper.convertValue(jn))
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is IntNode, is LongNode                -> IntegerValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            is ArrayNode                           -> UnionArrayValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class TopLevelElement {
    class AnythingArrayValue(val value: List<Any?>)    : TopLevelElement()
    class BoolValue(val value: Boolean)                : TopLevelElement()
    class DoubleValue(val value: Double)               : TopLevelElement()
    class IntegerValue(val value: Long)                : TopLevelElement()
    class StringValue(val value: String)               : TopLevelElement()
    class TopLevelClassValue(val value: TopLevelClass) : TopLevelElement()
    class NullValue()                                  : TopLevelElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is AnythingArrayValue -> this.value
        is BoolValue          -> this.value
        is DoubleValue        -> this.value
        is IntegerValue       -> this.value
        is StringValue        -> this.value
        is TopLevelClassValue -> this.value
        is NullValue          -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): TopLevelElement = when (jn) {
            is ArrayNode                           -> AnythingArrayValue(mapper.convertValue(jn))
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is IntNode, is LongNode                -> IntegerValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            is ObjectNode                          -> TopLevelClassValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

data class TopLevelClass (
    val x: X? = null
)

data class XClass (
    val x: X? = null
)

sealed class XElement {
    class AnythingArrayValue(val value: List<Any?>) : XElement()
    class BoolValue(val value: Boolean)             : XElement()
    class DoubleValue(val value: Double)            : XElement()
    class IntegerValue(val value: Long)             : XElement()
    class StringValue(val value: String)            : XElement()
    class XClassValue(val value: XClass)            : XElement()
    class NullValue()                               : XElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is AnythingArrayValue -> this.value
        is BoolValue          -> this.value
        is DoubleValue        -> this.value
        is IntegerValue       -> this.value
        is StringValue        -> this.value
        is XClassValue        -> this.value
        is NullValue          -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): XElement = when (jn) {
            is ArrayNode                           -> AnythingArrayValue(mapper.convertValue(jn))
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is IntNode, is LongNode                -> IntegerValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            is ObjectNode                          -> XClassValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

sealed class X {
    class AnythingMapValue(val value: Map<String, Any?>) : X()
    class BoolValue(val value: Boolean)                  : X()
    class DoubleValue(val value: Double)                 : X()
    class IntegerValue(val value: Long)                  : X()
    class StringValue(val value: String)                 : X()
    class UnionArrayValue(val value: List<XElement>)     : X()
    class NullValue()                                    : X()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is AnythingMapValue -> this.value
        is BoolValue        -> this.value
        is DoubleValue      -> this.value
        is IntegerValue     -> this.value
        is StringValue      -> this.value
        is UnionArrayValue  -> this.value
        is NullValue        -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): X = when (jn) {
            is ObjectNode                          -> AnythingMapValue(mapper.convertValue(jn))
            is BooleanNode                         -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is IntNode, is LongNode                -> IntegerValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            is ArrayNode                           -> UnionArrayValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}
