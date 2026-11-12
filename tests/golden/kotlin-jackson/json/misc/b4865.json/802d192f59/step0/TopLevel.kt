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
    convert(Fall::class,     { Fall.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(Type::class,     { Type.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(Nametype::class, { Nametype.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
}

class TopLevel(elements: Collection<TopLevelElement> = emptyList()) : ArrayList<TopLevelElement>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelElement (
    @get:JsonProperty(":@computed_region_cbhk_fwbd")@field:JsonProperty(":@computed_region_cbhk_fwbd")
    val computedRegionCbhkFwbd: String? = null,

    @get:JsonProperty(":@computed_region_nnqa_25f4")@field:JsonProperty(":@computed_region_nnqa_25f4")
    val computedRegionNnqa25F4: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fall: Fall,

    val geolocation: Geolocation? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    val mass: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nametype: Nametype,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val recclass: String,

    val reclat: String? = null,
    val reclong: String? = null,
    val year: String? = null
)

enum class Fall(val value: String) {
    Fell("Fell"),
    Found("Found");

    companion object {
        fun fromValue(value: String): Fall = when (value) {
            "Fell"  -> Fell
            "Found" -> Found
            else    -> throw IllegalArgumentException()
        }
    }
}

data class Geolocation (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val coordinates: List<Double>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Type
)

enum class Type(val value: String) {
    Point("Point");

    companion object {
        fun fromValue(value: String): Type = when (value) {
            "Point" -> Point
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Nametype(val value: String) {
    Valid("Valid");

    companion object {
        fun fromValue(value: String): Nametype = when (value) {
            "Valid" -> Valid
            else    -> throw IllegalArgumentException()
        }
    }
}
