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
    convert(X::class,        { X.fromJson(it) },        { it.toJson() }, true)
    convert(ZElement::class, { ZElement.fromJson(it) }, { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val x: List<X>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val y: List<Long?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val z: List<ZElement>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class X {
    class IntegerValue(val value: Long)  : X()
    class StringValue(val value: String) : X()
    class NullValue()                    : X()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue -> this.value
        is StringValue  -> this.value
        is NullValue    -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): X = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

sealed class ZElement {
    class IntegerArrayValue(val value: List<Long>) : ZElement()
    class IntegerValue(val value: Long)            : ZElement()
    class ZClassValue(val value: ZClass)           : ZElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerArrayValue -> this.value
        is IntegerValue      -> this.value
        is ZClassValue       -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): ZElement = when (jn) {
            is ArrayNode            -> IntegerArrayValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> ZClassValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class ZClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val a: Boolean
)
