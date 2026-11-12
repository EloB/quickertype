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
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(OffsetDateTime::class, { OffsetDateTime.parse(it.asText()) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
}

class TopLevel(elements: Collection<TopLevelElement> = emptyList()) : ArrayList<TopLevelElement>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelElement (
    @get:JsonProperty("BirthDate", required=true)@field:JsonProperty("BirthDate", required=true)
    val birthDate: OffsetDateTime?,

    @get:JsonProperty("BirthDateIsProtected", required=true)@field:JsonProperty("BirthDateIsProtected", required=true)
    val birthDateIsProtected: Boolean,

    @get:JsonProperty("GenderTypeID", required=true)@field:JsonProperty("GenderTypeID", required=true)
    val genderTypeID: Long,

    @get:JsonProperty("Notes", required=true)@field:JsonProperty("Notes", required=true)
    val notes: String,

    @get:JsonProperty("ParliamentaryName", required=true)@field:JsonProperty("ParliamentaryName", required=true)
    val parliamentaryName: String,

    @get:JsonProperty("PersonID", required=true)@field:JsonProperty("PersonID", required=true)
    val personID: Long,

    @get:JsonProperty("PhotoURL", required=true)@field:JsonProperty("PhotoURL", required=true)
    val photoURL: String,

    @get:JsonProperty("PreferredName", required=true)@field:JsonProperty("PreferredName", required=true)
    val preferredName: String
)
