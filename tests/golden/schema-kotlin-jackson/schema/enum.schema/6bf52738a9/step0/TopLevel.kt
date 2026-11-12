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
    convert(OtherArr::class, { OtherArr.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Gve::class,      { Gve.fromValue(it.asText()) },      { ObjectMapper().writeValueAsString(it.value) })
    convert(Lvc::class,      { Lvc.fromValue(it.asText()) },      { ObjectMapper().writeValueAsString(it.value) })
    convert(Arr::class,      { Arr.fromJson(it) },                { it.toJson() }, true)
}

data class TopLevel (
    val arr: List<Arr>? = null,

    @get:JsonProperty("for")@field:JsonProperty("for")
    val topLevelFor: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gve: Gve,

    val lvc: Lvc? = null,
    val otherArr: List<OtherArr>? = null
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class Arr {
    class EnumValue(val value: OtherArr) : Arr()
    class IntegerValue(val value: Long)  : Arr()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is EnumValue    -> this.value
        is IntegerValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Arr = when (jn) {
            is TextNode             -> EnumValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

enum class OtherArr(val value: String) {
    Foo("foo"),
    Bar("bar"),
    If("if");

    companion object {
        fun fromValue(value: String): OtherArr = when (value) {
            "foo" -> Foo
            "bar" -> Bar
            "if"  -> If
            else  -> throw IllegalArgumentException()
        }
    }
}

enum class Gve(val value: String) {
    Good("good"),
    Neutral("neutral"),
    Evil("evil");

    companion object {
        fun fromValue(value: String): Gve = when (value) {
            "good"    -> Good
            "neutral" -> Neutral
            "evil"    -> Evil
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class Lvc(val value: String) {
    Lawful("lawful"),
    Neutral("neutral"),
    Chaotic("chaotic");

    companion object {
        fun fromValue(value: String): Lvc = when (value) {
            "lawful"  -> Lawful
            "neutral" -> Neutral
            "chaotic" -> Chaotic
            else      -> throw IllegalArgumentException()
        }
    }
}
