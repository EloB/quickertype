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
    convert(EnumEnum::class,            { EnumEnum.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
    convert(ObjectOrStringUnion::class, { ObjectOrStringUnion.fromJson(it) }, { it.toJson() }, true)
    convert(Union::class,               { Union.fromJson(it) },               { it.toJson() }, true)
}

/**
 * The top-level class.
 * Its description has two lines.
 */
data class TopLevel (
    /**
     * A pretty boolean
     */
    val bar: Boolean? = null,

    /**
     * An enumeration
     */
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val enum: EnumEnum,

    val foo: Double? = null,

    @get:JsonProperty("object-or-string", required=true)@field:JsonProperty("object-or-string", required=true)
    val objectOrString: ObjectOrStringUnion,

    /**
     * Either a number or a string
     */
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val union: Union
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

/**
 * An enumeration
 */
enum class EnumEnum(val value: String) {
    Foo("foo"),
    Bar("bar");

    companion object {
        fun fromValue(value: String): EnumEnum = when (value) {
            "foo" -> Foo
            "bar" -> Bar
            else  -> throw IllegalArgumentException()
        }
    }
}

sealed class ObjectOrStringUnion {
    class ObjectOrStringClassValue(val value: ObjectOrStringClass) : ObjectOrStringUnion()
    class StringValue(val value: String)                           : ObjectOrStringUnion()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is ObjectOrStringClassValue -> this.value
        is StringValue              -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): ObjectOrStringUnion = when (jn) {
            is ObjectNode -> ObjectOrStringClassValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class ObjectOrStringClass (
    /**
     * This must not get lost
     */
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prop: Double
)

/**
 * Either a number or a string
 */
sealed class Union {
    class DoubleValue(val value: Double) : Union()
    class StringValue(val value: String) : Union()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DoubleValue -> this.value
        is StringValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Union = when (jn) {
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is TextNode                            -> StringValue(mapper.convertValue(jn))
            else                                   -> throw IllegalArgumentException()
        }
    }
}
