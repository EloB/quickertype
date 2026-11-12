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
    convert(MixedElement::class, { MixedElement.fromJson(it) }, { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mixed: List<MixedElement>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class MixedElement {
    class BoolValue(val value: Boolean)          : MixedElement()
    class IntegerValue(val value: Long)          : MixedElement()
    class MixedClassValue(val value: MixedClass) : MixedElement()
    class StringValue(val value: String)         : MixedElement()
    class NullValue()                            : MixedElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is BoolValue       -> this.value
        is IntegerValue    -> this.value
        is MixedClassValue -> this.value
        is StringValue     -> this.value
        is NullValue       -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): MixedElement = when (jn) {
            is BooleanNode          -> BoolValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is ObjectNode           -> MixedClassValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class MixedClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nested: String
)
