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
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(LocalDate::class,     { LocalDate.parse(it.asText()) },         { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    convert(ColorIdentity::class, { ColorIdentity.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Watermark::class,     { Watermark.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(Layout::class,        { Layout.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
    convert(LegalityEnum::class,  { LegalityEnum.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
    convert(Rarity::class,        { Rarity.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
    convert(Type::class,          { Type.fromValue(it.asText()) },          { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val booster: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val border: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cards: List<Card>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gathererCode: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val magicCardsInfoCode: String,

    @get:JsonProperty("mkm_id", required=true)@field:JsonProperty("mkm_id", required=true)
    val mkmID: Long,

    @get:JsonProperty("mkm_name", required=true)@field:JsonProperty("mkm_name", required=true)
    val mkmName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val releaseDate: LocalDate,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Card (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val artist: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cmc: Long,

    val colorIdentity: List<ColorIdentity>? = null,
    val colors: List<Watermark>? = null,
    val flavor: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val imageName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val layout: Layout,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val legalities: List<LegalityElement>,

    val manaCost: String? = null,
    val mciNumber: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val multiverseid: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val originalText: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val originalType: String,

    val power: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val printings: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rarity: Rarity,

    val reserved: Boolean? = null,
    val rulings: List<Ruling>? = null,
    val subtypes: List<String>? = null,
    val supertypes: List<String>? = null,
    val text: String? = null,
    val toughness: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val types: List<Type>,

    val variations: List<Long>? = null,
    val watermark: Watermark? = null
)

enum class ColorIdentity(val value: String) {
    W("W"),
    R("R"),
    B("B"),
    G("G"),
    U("U");

    companion object {
        fun fromValue(value: String): ColorIdentity = when (value) {
            "W"  -> W
            "R"  -> R
            "B"  -> B
            "G"  -> G
            "U"  -> U
            else -> throw IllegalArgumentException()
        }
    }
}

enum class Watermark(val value: String) {
    White("White"),
    Red("Red"),
    Black("Black"),
    Green("Green"),
    Blue("Blue");

    companion object {
        fun fromValue(value: String): Watermark = when (value) {
            "White" -> White
            "Red"   -> Red
            "Black" -> Black
            "Green" -> Green
            "Blue"  -> Blue
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Layout(val value: String) {
    Normal("normal");

    companion object {
        fun fromValue(value: String): Layout = when (value) {
            "normal" -> Normal
            else     -> throw IllegalArgumentException()
        }
    }
}

data class LegalityElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val format: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val legality: LegalityEnum
)

enum class LegalityEnum(val value: String) {
    Legal("Legal"),
    Banned("Banned"),
    Restricted("Restricted");

    companion object {
        fun fromValue(value: String): LegalityEnum = when (value) {
            "Legal"      -> Legal
            "Banned"     -> Banned
            "Restricted" -> Restricted
            else         -> throw IllegalArgumentException()
        }
    }
}

enum class Rarity(val value: String) {
    Uncommon("Uncommon"),
    Rare("Rare"),
    Common("Common"),
    BasicLand("Basic Land");

    companion object {
        fun fromValue(value: String): Rarity = when (value) {
            "Uncommon"   -> Uncommon
            "Rare"       -> Rare
            "Common"     -> Common
            "Basic Land" -> BasicLand
            else         -> throw IllegalArgumentException()
        }
    }
}

data class Ruling (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val date: LocalDate,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val text: String
)

enum class Type(val value: String) {
    Creature("Creature"),
    Artifact("Artifact"),
    Instant("Instant"),
    Land("Land"),
    Enchantment("Enchantment"),
    Sorcery("Sorcery");

    companion object {
        fun fromValue(value: String): Type = when (value) {
            "Creature"    -> Creature
            "Artifact"    -> Artifact
            "Instant"     -> Instant
            "Land"        -> Land
            "Enchantment" -> Enchantment
            "Sorcery"     -> Sorcery
            else          -> throw IllegalArgumentException()
        }
    }
}
