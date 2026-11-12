// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

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
    convert(OffsetDateTime::class, { OffsetDateTime.parse(it.asText()) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    convert(BarEnum::class,        { BarEnum.fromValue(it.asText()) },    { ObjectMapper().writeValueAsString(it.value) })
    convert(BarUnion::class,       { BarUnion.fromJson(it) },             { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bar: BarUnion,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val foo: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class BarUnion {
    class DateTimeValue(val value: OffsetDateTime) : BarUnion()
    class EnumValue(val value: BarEnum)            : BarUnion()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DateTimeValue -> this.value
        is EnumValue     -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): BarUnion = when (jn) {
            is TextNode -> try { DateTimeValue(mapper.convertValue(jn)) } catch (e: Exception) { EnumValue(mapper.convertValue(jn)) }
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class BarEnum(val value: String) {
    Quux("quux");

    companion object {
        fun fromValue(value: String): BarEnum = when (value) {
            "quux" -> Quux
            else   -> throw IllegalArgumentException()
        }
    }
}
