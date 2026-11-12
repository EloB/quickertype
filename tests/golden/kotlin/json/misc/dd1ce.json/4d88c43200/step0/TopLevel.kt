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
    .convert(Booster::class,       { Booster.fromValue(it.string!!) },       { Klaxon().toJsonString(it.value) })
    .convert(ColorIdentity::class, { ColorIdentity.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Color::class,         { Color.fromValue(it.string!!) },         { Klaxon().toJsonString(it.value) })
    .convert(Layout::class,        { Layout.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })
    .convert(Format::class,        { Format.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })
    .convert(LegalityEnum::class,  { LegalityEnum.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })
    .convert(Rarity::class,        { Rarity.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })
    .convert(Supertype::class,     { Supertype.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(Type::class,          { Type.fromValue(it.string!!) },          { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val booster: List<Booster>,
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

enum class Booster(val value: String) {
    Rare("rare"),
    Uncommon("uncommon"),
    Common("common");

    companion object {
        public fun fromValue(value: String): Booster = when (value) {
            "rare"     -> Rare
            "uncommon" -> Uncommon
            "common"   -> Common
            else       -> throw IllegalArgumentException()
        }
    }
}

data class Card (
    val artist: String,
    val cmc: Long,
    val colorIdentity: List<ColorIdentity>? = null,
    val colors: List<Color>? = null,
    val flavor: String? = null,
    val id: String,
    val imageName: String,
    val layout: Layout,
    val legalities: List<LegalityElement>,
    val manaCost: String? = null,
    val mciNumber: String? = null,
    val multiverseid: Long,
    val name: String,
    val originalText: String? = null,
    val originalType: String,
    val power: String? = null,
    val printings: List<String>,
    val rarity: Rarity,
    val reserved: Boolean? = null,
    val rulings: List<Ruling>? = null,
    val subtypes: List<String>? = null,
    val supertypes: List<Supertype>? = null,
    val text: String? = null,
    val toughness: String? = null,
    val type: String,
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
        public fun fromValue(value: String): ColorIdentity = when (value) {
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
        public fun fromValue(value: String): Color = when (value) {
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
        public fun fromValue(value: String): Layout = when (value) {
            "normal" -> Normal
            else     -> throw IllegalArgumentException()
        }
    }
}

data class LegalityElement (
    val format: Format,
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
        public fun fromValue(value: String): Format = when (value) {
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

enum class Supertype(val value: String) {
    Basic("Basic");

    companion object {
        public fun fromValue(value: String): Supertype = when (value) {
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
        public fun fromValue(value: String): Type = when (value) {
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
