// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime
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
            override fun getNullValue(ctxt: DeserializationContext) = if (isUnion) fromJson(NullNode.instance) else null
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(OffsetDateTime::class, { OffsetDateTime.parse(it.asText()) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    convert(LocalDate::class,      { LocalDate.parse(it.asText()) },      { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    convert(Datum::class,          { Datum.fromJson(it) },                { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: String,

    @get:JsonProperty("column_names", required=true)@field:JsonProperty("column_names", required=true)
    val columnNames: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val data: List<List<Datum>>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty("display_url", required=true)@field:JsonProperty("display_url", required=true)
    val displayURL: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val errors: Errors,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val frequency: String,

    @get:JsonProperty("from_date", required=true)@field:JsonProperty("from_date", required=true)
    val fromDate: LocalDate,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val premium: Boolean,

    @get:JsonProperty("source_code", required=true)@field:JsonProperty("source_code", required=true)
    val sourceCode: String,

    @get:JsonProperty("source_name", required=true)@field:JsonProperty("source_name", required=true)
    val sourceName: String,

    @get:JsonProperty("to_date", required=true)@field:JsonProperty("to_date", required=true)
    val toDate: LocalDate,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: OffsetDateTime,

    @get:JsonProperty("urlize_name", required=true)@field:JsonProperty("urlize_name", required=true)
    val urlizeName: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class Datum {
    class DateValue(val value: LocalDate) : Datum()
    class DoubleValue(val value: Double)  : Datum()
    class NullValue()                     : Datum()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DateValue   -> this.value
        is DoubleValue -> this.value
        is NullValue   -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Datum = when (jn) {
            is TextNode                            -> DateValue(mapper.convertValue(jn))
            is IntNode, is LongNode, is DoubleNode -> DoubleValue(mapper.convertValue(jn))
            is NullNode                            -> NullValue()
            else                                   -> throw IllegalArgumentException()
        }
    }
}

typealias Errors = ObjectNode
