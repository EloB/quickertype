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
    convert(Category::class, { Category.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prizes: List<Prize>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Prize (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val category: Category,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val laureates: List<Laureate>,

    val overallMotivation: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val year: String
)

enum class Category(val value: String) {
    Physics("physics"),
    Chemistry("chemistry"),
    Medicine("medicine"),
    Literature("literature"),
    Peace("peace"),
    Economics("economics");

    companion object {
        fun fromValue(value: String): Category = when (value) {
            "physics"    -> Physics
            "chemistry"  -> Chemistry
            "medicine"   -> Medicine
            "literature" -> Literature
            "peace"      -> Peace
            "economics"  -> Economics
            else         -> throw IllegalArgumentException()
        }
    }
}

data class Laureate (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val firstname: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    val motivation: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val share: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val surname: String
)
