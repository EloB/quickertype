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
    convert(LocalDate::class,          { LocalDate.parse(it.asText()) },    { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    convert(BornEnum::class,           { BornEnum.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Gender::class,             { Gender.fromValue(it.asText()) },   { ObjectMapper().writeValueAsString(it.value) })
    convert(Category::class,           { Category.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(BornUnion::class,          { BornUnion.fromJson(it) },          { it.toJson() }, true)
    convert(AffiliationElement::class, { AffiliationElement.fromJson(it) }, { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val laureates: List<Laureate>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Laureate (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val born: BornUnion,

    val bornCity: String? = null,
    val bornCountry: String? = null,
    val bornCountryCode: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val died: BornUnion,

    val diedCity: String? = null,
    val diedCountry: String? = null,
    val diedCountryCode: String? = null,
    val firstname: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gender: Gender,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prizes: List<Prize>,

    val surname: String? = null
)

sealed class BornUnion {
    class DateValue(val value: LocalDate) : BornUnion()
    class EnumValue(val value: BornEnum)  : BornUnion()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is DateValue -> this.value
        is EnumValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): BornUnion = when (jn) {
            is TextNode -> try { DateValue(mapper.convertValue(jn)) } catch (e: Exception) { EnumValue(mapper.convertValue(jn)) }
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class BornEnum(val value: String) {
    The00000000("0000-00-00"),
    The18980000("1898-00-00"),
    The19430000("1943-00-00");

    companion object {
        fun fromValue(value: String): BornEnum = when (value) {
            "0000-00-00" -> The00000000
            "1898-00-00" -> The18980000
            "1943-00-00" -> The19430000
            else         -> throw IllegalArgumentException()
        }
    }
}

enum class Gender(val value: String) {
    Male("male"),
    Female("female"),
    Org("org");

    companion object {
        fun fromValue(value: String): Gender = when (value) {
            "male"   -> Male
            "female" -> Female
            "org"    -> Org
            else     -> throw IllegalArgumentException()
        }
    }
}

data class Prize (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val affiliations: List<AffiliationElement>,

    val category: Category? = null,
    val motivation: String? = null,
    val overallMotivation: String? = null,
    val share: String? = null,
    val year: String? = null
)

sealed class AffiliationElement {
    class AffiliationClassValue(val value: AffiliationClass) : AffiliationElement()
    class AnythingArrayValue(val value: List<Any?>)          : AffiliationElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is AffiliationClassValue -> this.value
        is AnythingArrayValue    -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): AffiliationElement = when (jn) {
            is ObjectNode -> AffiliationClassValue(mapper.convertValue(jn))
            is ArrayNode  -> AnythingArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class AffiliationClass (
    val city: String? = null,
    val country: String? = null,
    val name: String? = null
)

enum class Category(val value: String) {
    Physics("physics"),
    Chemistry("chemistry"),
    Peace("peace"),
    Medicine("medicine"),
    Literature("literature"),
    Economics("economics");

    companion object {
        fun fromValue(value: String): Category = when (value) {
            "physics"    -> Physics
            "chemistry"  -> Chemistry
            "peace"      -> Peace
            "medicine"   -> Medicine
            "literature" -> Literature
            "economics"  -> Economics
            else         -> throw IllegalArgumentException()
        }
    }
}
