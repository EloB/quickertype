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
    convert(Booster::class,       { Booster.fromValue(it.asText()) },       { ObjectMapper().writeValueAsString(it.value) })
    convert(ColorIdentity::class, { ColorIdentity.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Color::class,         { Color.fromValue(it.asText()) },         { ObjectMapper().writeValueAsString(it.value) })
    convert(Layout::class,        { Layout.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
    convert(Format::class,        { Format.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
    convert(LegalityEnum::class,  { LegalityEnum.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
    convert(Rarity::class,        { Rarity.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
    convert(Supertype::class,     { Supertype.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(Type::class,          { Type.fromValue(it.asText()) },          { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val booster: List<Booster>,

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

enum class Booster(val value: String) {
    Rare("rare"),
    Uncommon("uncommon"),
    Common("common");

    companion object {
        fun fromValue(value: String): Booster = when (value) {
            "rare"     -> Rare
            "uncommon" -> Uncommon
            "common"   -> Common
            else       -> throw IllegalArgumentException()
        }
    }
}

data class Card (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val artist: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cmc: Long,

    val colorIdentity: List<ColorIdentity>? = null,
    val colors: List<Color>? = null,
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

    val originalText: String? = null,

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
    val supertypes: List<Supertype>? = null,
    val text: String? = null,
    val toughness: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val types: List<Type>,

    val variations: List<Long>? = null
)

enum class ColorIdentity(val value: String) {
    U("U"),
    B("B"),
    W("W"),
    G("G"),
    R("R");

    companion object {
        fun fromValue(value: String): ColorIdentity = when (value) {
            "U"  -> U
            "B"  -> B
            "W"  -> W
            "G"  -> G
            "R"  -> R
            else -> throw IllegalArgumentException()
        }
    }
}

enum class Color(val value: String) {
    Blue("Blue"),
    Black("Black"),
    White("White"),
    Green("Green"),
    Red("Red");

    companion object {
        fun fromValue(value: String): Color = when (value) {
            "Blue"  -> Blue
            "Black" -> Black
            "White" -> White
            "Green" -> Green
            "Red"   -> Red
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
    val format: Format,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val legality: LegalityEnum
)

enum class Format(val value: String) {
    Commander("Commander"),
    Legacy("Legacy"),
    Modern("Modern"),
    Vintage("Vintage"),
    TimeSpiralBlock("Time Spiral Block"),
    RavnicaBlock("Ravnica Block"),
    IceAgeBlock("Ice Age Block"),
    TempestBlock("Tempest Block"),
    OnslaughtBlock("Onslaught Block"),
    MasquesBlock("Masques Block"),
    MirageBlock("Mirage Block"),
    UrzaBlock("Urza Block"),
    ScarsOfMirrodinBlock("Scars of Mirrodin Block"),
    MirrodinBlock("Mirrodin Block"),
    AmonkhetBlock("Amonkhet Block"),
    BattleForZendikarBlock("Battle for Zendikar Block"),
    InnistradBlock("Innistrad Block"),
    InvasionBlock("Invasion Block"),
    KaladeshBlock("Kaladesh Block"),
    KamigawaBlock("Kamigawa Block"),
    KhansOfTarkirBlock("Khans of Tarkir Block"),
    LorwynShadowmoorBlock("Lorwyn-Shadowmoor Block"),
    OdysseyBlock("Odyssey Block"),
    ReturnToRavnicaBlock("Return to Ravnica Block"),
    ShadowsOverInnistradBlock("Shadows over Innistrad Block"),
    ShardsOfAlaraBlock("Shards of Alara Block"),
    Standard("Standard"),
    TherosBlock("Theros Block"),
    UnSets("Un-Sets"),
    ZendikarBlock("Zendikar Block");

    companion object {
        fun fromValue(value: String): Format = when (value) {
            "Commander"                    -> Commander
            "Legacy"                       -> Legacy
            "Modern"                       -> Modern
            "Vintage"                      -> Vintage
            "Time Spiral Block"            -> TimeSpiralBlock
            "Ravnica Block"                -> RavnicaBlock
            "Ice Age Block"                -> IceAgeBlock
            "Tempest Block"                -> TempestBlock
            "Onslaught Block"              -> OnslaughtBlock
            "Masques Block"                -> MasquesBlock
            "Mirage Block"                 -> MirageBlock
            "Urza Block"                   -> UrzaBlock
            "Scars of Mirrodin Block"      -> ScarsOfMirrodinBlock
            "Mirrodin Block"               -> MirrodinBlock
            "Amonkhet Block"               -> AmonkhetBlock
            "Battle for Zendikar Block"    -> BattleForZendikarBlock
            "Innistrad Block"              -> InnistradBlock
            "Invasion Block"               -> InvasionBlock
            "Kaladesh Block"               -> KaladeshBlock
            "Kamigawa Block"               -> KamigawaBlock
            "Khans of Tarkir Block"        -> KhansOfTarkirBlock
            "Lorwyn-Shadowmoor Block"      -> LorwynShadowmoorBlock
            "Odyssey Block"                -> OdysseyBlock
            "Return to Ravnica Block"      -> ReturnToRavnicaBlock
            "Shadows over Innistrad Block" -> ShadowsOverInnistradBlock
            "Shards of Alara Block"        -> ShardsOfAlaraBlock
            "Standard"                     -> Standard
            "Theros Block"                 -> TherosBlock
            "Un-Sets"                      -> UnSets
            "Zendikar Block"               -> ZendikarBlock
            else                           -> throw IllegalArgumentException()
        }
    }
}

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

enum class Supertype(val value: String) {
    Basic("Basic");

    companion object {
        fun fromValue(value: String): Supertype = when (value) {
            "Basic" -> Basic
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Type(val value: String) {
    Creature("Creature"),
    Instant("Instant"),
    Enchantment("Enchantment"),
    Artifact("Artifact"),
    Sorcery("Sorcery"),
    Land("Land");

    companion object {
        fun fromValue(value: String): Type = when (value) {
            "Creature"    -> Creature
            "Instant"     -> Instant
            "Enchantment" -> Enchantment
            "Artifact"    -> Artifact
            "Sorcery"     -> Sorcery
            "Land"        -> Land
            else          -> throw IllegalArgumentException()
        }
    }
}
