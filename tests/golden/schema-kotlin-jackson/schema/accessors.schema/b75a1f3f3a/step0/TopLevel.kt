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
    convert(EnumEnum::class, { EnumEnum.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Union::class,    { Union.fromJson(it) },              { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty("bar", required=true)@field:JsonProperty("bar", required=true)
    val barre: String,

    @get:JsonProperty("enum", required=true)@field:JsonProperty("enum", required=true)
    val enumerification: EnumEnum,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val foo: String,

    @get:JsonProperty("union", required=true)@field:JsonProperty("union", required=true)
    val unionization: Union
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

enum class EnumEnum(val value: String) {
    Fire("red"),
    Grass("green"),
    Blue("blue");

    companion object {
        fun fromValue(value: String): EnumEnum = when (value) {
            "red"   -> Fire
            "green" -> Grass
            "blue"  -> Blue
            else    -> throw IllegalArgumentException()
        }
    }
}

sealed class Union {
    class AmountValue(val value: Double)    : Union()
    class PresenceValue(val value: Boolean) : Union()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is AmountValue   -> this.value
        is PresenceValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Union = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> AmountValue(mapper.convertValue(jn))
            is BooleanNode                         -> PresenceValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}
