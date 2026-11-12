// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime
import java.time.LocalDate
import java.time.OffsetTime

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
    convert(LocalDate::class,      { LocalDate.parse(it.asText()) },      { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    convert(OffsetTime::class,     { OffsetTime.parse(it.asText()) },     { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_TIME.format(it)}\"" })
}

data class TopLevel (
    @get:JsonProperty("optional-date")@field:JsonProperty("optional-date")
    val optionalDate: LocalDate? = null,

    @get:JsonProperty("optional-date-time")@field:JsonProperty("optional-date-time")
    val optionalDateTime: OffsetDateTime? = null,

    @get:JsonProperty("optional-time")@field:JsonProperty("optional-time")
    val optionalTime: OffsetTime? = null,

    @get:JsonProperty("required-date", required=true)@field:JsonProperty("required-date", required=true)
    val requiredDate: LocalDate,

    @get:JsonProperty("required-date-time", required=true)@field:JsonProperty("required-date-time", required=true)
    val requiredDateTime: OffsetDateTime,

    @get:JsonProperty("required-time", required=true)@field:JsonProperty("required-time", required=true)
    val requiredTime: OffsetTime
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}
