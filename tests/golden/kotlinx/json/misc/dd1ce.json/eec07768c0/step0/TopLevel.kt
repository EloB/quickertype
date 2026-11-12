// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

@file:UseSerializers(LocalDateSerializer::class)

package quicktype

import java.time.LocalDate

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val booster: List<Booster>,
    val border: String,
    val cards: List<Card>,
    val code: String,
    val gathererCode: String,
    val magicCardsInfoCode: String,

    @SerialName("mkm_id")
    val mkmID: Long,

    @SerialName("mkm_name")
    val mkmName: String,

    val name: String,
    val releaseDate: LocalDate,
    val type: String
)

@Serializable
enum class Booster(val value: String) {
    @SerialName("rare") Rare("rare"),
    @SerialName("uncommon") Uncommon("uncommon"),
    @SerialName("common") Common("common");
}

@Serializable
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

@Serializable
enum class ColorIdentity(val value: String) {
    @SerialName("U") U("U"),
    @SerialName("B") B("B"),
    @SerialName("W") W("W"),
    @SerialName("G") G("G"),
    @SerialName("R") R("R");
}

@Serializable
enum class Color(val value: String) {
    @SerialName("Blue") Blue("Blue"),
    @SerialName("Black") Black("Black"),
    @SerialName("White") White("White"),
    @SerialName("Green") Green("Green"),
    @SerialName("Red") Red("Red");
}

@Serializable
enum class Layout(val value: String) {
    @SerialName("normal") Normal("normal");
}

@Serializable
data class LegalityElement (
    val format: Format,
    val legality: LegalityEnum
)

@Serializable
enum class Format(val value: String) {
    @SerialName("Commander") Commander("Commander"),
    @SerialName("Legacy") Legacy("Legacy"),
    @SerialName("Modern") Modern("Modern"),
    @SerialName("Vintage") Vintage("Vintage"),
    @SerialName("Time Spiral Block") TimeSpiralBlock("Time Spiral Block"),
    @SerialName("Ravnica Block") RavnicaBlock("Ravnica Block"),
    @SerialName("Ice Age Block") IceAgeBlock("Ice Age Block"),
    @SerialName("Tempest Block") TempestBlock("Tempest Block"),
    @SerialName("Onslaught Block") OnslaughtBlock("Onslaught Block"),
    @SerialName("Masques Block") MasquesBlock("Masques Block"),
    @SerialName("Mirage Block") MirageBlock("Mirage Block"),
    @SerialName("Urza Block") UrzaBlock("Urza Block"),
    @SerialName("Scars of Mirrodin Block") ScarsOfMirrodinBlock("Scars of Mirrodin Block"),
    @SerialName("Mirrodin Block") MirrodinBlock("Mirrodin Block"),
    @SerialName("Amonkhet Block") AmonkhetBlock("Amonkhet Block"),
    @SerialName("Battle for Zendikar Block") BattleForZendikarBlock("Battle for Zendikar Block"),
    @SerialName("Innistrad Block") InnistradBlock("Innistrad Block"),
    @SerialName("Invasion Block") InvasionBlock("Invasion Block"),
    @SerialName("Kaladesh Block") KaladeshBlock("Kaladesh Block"),
    @SerialName("Kamigawa Block") KamigawaBlock("Kamigawa Block"),
    @SerialName("Khans of Tarkir Block") KhansOfTarkirBlock("Khans of Tarkir Block"),
    @SerialName("Lorwyn-Shadowmoor Block") LorwynShadowmoorBlock("Lorwyn-Shadowmoor Block"),
    @SerialName("Odyssey Block") OdysseyBlock("Odyssey Block"),
    @SerialName("Return to Ravnica Block") ReturnToRavnicaBlock("Return to Ravnica Block"),
    @SerialName("Shadows over Innistrad Block") ShadowsOverInnistradBlock("Shadows over Innistrad Block"),
    @SerialName("Shards of Alara Block") ShardsOfAlaraBlock("Shards of Alara Block"),
    @SerialName("Standard") Standard("Standard"),
    @SerialName("Theros Block") TherosBlock("Theros Block"),
    @SerialName("Un-Sets") UnSets("Un-Sets"),
    @SerialName("Zendikar Block") ZendikarBlock("Zendikar Block");
}

@Serializable
enum class LegalityEnum(val value: String) {
    @SerialName("Legal") Legal("Legal"),
    @SerialName("Banned") Banned("Banned"),
    @SerialName("Restricted") Restricted("Restricted");
}

@Serializable
enum class Rarity(val value: String) {
    @SerialName("Uncommon") Uncommon("Uncommon"),
    @SerialName("Rare") Rare("Rare"),
    @SerialName("Common") Common("Common"),
    @SerialName("Basic Land") BasicLand("Basic Land");
}

@Serializable
data class Ruling (
    val date: LocalDate,
    val text: String
)

@Serializable
enum class Supertype(val value: String) {
    @SerialName("Basic") Basic("Basic");
}

@Serializable
enum class Type(val value: String) {
    @SerialName("Creature") Creature("Creature"),
    @SerialName("Instant") Instant("Instant"),
    @SerialName("Enchantment") Enchantment("Enchantment"),
    @SerialName("Artifact") Artifact("Artifact"),
    @SerialName("Sorcery") Sorcery("Sorcery"),
    @SerialName("Land") Land("Land");
}

object LocalDateSerializer : KSerializer<LocalDate> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("LocalDate", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): LocalDate = LocalDate.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: LocalDate) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(value))
    }
}
