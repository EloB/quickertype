// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.LocalDate

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(LocalDate::class,     { LocalDate.parse(it.string!!) },         { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    .convert(ColorIdentity::class, { ColorIdentity.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Watermark::class,     { Watermark.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(Layout::class,        { Layout.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })
    .convert(LegalityEnum::class,  { LegalityEnum.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })
    .convert(Rarity::class,        { Rarity.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })
    .convert(Type::class,          { Type.fromValue(it.string!!) },          { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val booster: List<String>,
    val border: String,
    val cards: List<Card>,
    val code: String,
    val gathererCode: String,
    val magicCardsInfoCode: String,

    @Json(name = "mkm_id")
    val mkmID: Long,

    @Json(name = "mkm_name")
    val mkmName: String,

    val name: String,
    val releaseDate: LocalDate,
    val type: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Card (
    val artist: String,
    val cmc: Long,
    val colorIdentity: List<ColorIdentity>? = null,
    val colors: List<Watermark>? = null,
    val flavor: String? = null,
    val id: String,
    val imageName: String,
    val layout: Layout,
    val legalities: List<LegalityElement>,
    val manaCost: String? = null,
    val mciNumber: String? = null,
    val multiverseid: Long,
    val name: String,
    val originalText: String,
    val originalType: String,
    val power: String? = null,
    val printings: List<String>,
    val rarity: Rarity,
    val reserved: Boolean? = null,
    val rulings: List<Ruling>? = null,
    val subtypes: List<String>? = null,
    val supertypes: List<String>? = null,
    val text: String? = null,
    val toughness: String? = null,
    val type: String,
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
        public fun fromValue(value: String): ColorIdentity = when (value) {
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
        public fun fromValue(value: String): Watermark = when (value) {
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
        public fun fromValue(value: String): Layout = when (value) {
            "normal" -> Normal
            else     -> throw IllegalArgumentException()
        }
    }
}

data class LegalityElement (
    val format: String,
    val legality: LegalityEnum
)

enum class LegalityEnum(val value: String) {
    Legal("Legal"),
    Banned("Banned"),
    Restricted("Restricted");

    companion object {
        public fun fromValue(value: String): LegalityEnum = when (value) {
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
        public fun fromValue(value: String): Rarity = when (value) {
            "Uncommon"   -> Uncommon
            "Rare"       -> Rare
            "Common"     -> Common
            "Basic Land" -> BasicLand
            else         -> throw IllegalArgumentException()
        }
    }
}

data class Ruling (
    val date: LocalDate,
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
        public fun fromValue(value: String): Type = when (value) {
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
