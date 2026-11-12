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
    convert(Frequency::class, { Frequency.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Type::class,      { Type.fromValue(it.asText()) },      { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val amount: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val frequency: Frequency,

    val description: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Type
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

enum class Frequency(val value: String) {
    Weekly("Weekly"),
    Monthly("Monthly"),
    Annually("Annually");

    companion object {
        fun fromValue(value: String): Frequency = when (value) {
            "Weekly"   -> Weekly
            "Monthly"  -> Monthly
            "Annually" -> Annually
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class Type(val value: String) {
    GrossSalaryAmount("GrossSalaryAmount"),
    Overtime("Overtime");

    companion object {
        fun fromValue(value: String): Type = when (value) {
            "GrossSalaryAmount" -> GrossSalaryAmount
            "Overtime"          -> Overtime
            else                -> throw IllegalArgumentException()
        }
    }
}
