// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.LocalDate

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
    convert(LocalDate::class,          { LocalDate.parse(it.asText()) },             { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    convert(EffectiveFromEnum::class,  { EffectiveFromEnum.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(EffectiveFromUnion::class, { EffectiveFromUnion.fromJson(it) },          { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val details: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rates: List<Rate>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val version: Any? = null
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Rate (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: String,

    @get:JsonProperty("country_code", required=true)@field:JsonProperty("country_code", required=true)
    val countryCode: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val periods: List<Period>
)

data class Period (
    @get:JsonProperty("effective_from", required=true)@field:JsonProperty("effective_from", required=true)
    val effectiveFrom: EffectiveFromUnion,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rates: Rates
)

sealed class EffectiveFromUnion {
    class DateValue(val value: LocalDate)         : EffectiveFromUnion()
    class EnumValue(val value: EffectiveFromEnum) : EffectiveFromUnion()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DateValue -> this.value
        is EnumValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): EffectiveFromUnion = when (jn) {
            is TextNode -> try { DateValue(mapper.convertValue(jn)) } catch (e: Exception) { EnumValue(mapper.convertValue(jn)) }
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class EffectiveFromEnum(val value: String) {
    The00000101("0000-01-01");

    companion object {
        fun fromValue(value: String): EffectiveFromEnum = when (value) {
            "0000-01-01" -> The00000101
            else         -> throw IllegalArgumentException()
        }
    }
}

data class Rates (
    val parking: Double? = null,
    val reduced: Double? = null,
    val reduced1: Double? = null,
    val reduced2: Double? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val standard: Double,

    @get:JsonProperty("super_reduced")@field:JsonProperty("super_reduced")
    val superReduced: Double? = null
)
