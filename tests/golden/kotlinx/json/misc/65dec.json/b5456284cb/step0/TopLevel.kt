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
    val booster: List<String>,
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

@Serializable
enum class ColorIdentity(val value: String) {
    @SerialName("W") W("W"),
    @SerialName("R") R("R"),
    @SerialName("B") B("B"),
    @SerialName("G") G("G"),
    @SerialName("U") U("U");
}

@Serializable
enum class Watermark(val value: String) {
    @SerialName("White") White("White"),
    @SerialName("Red") Red("Red"),
    @SerialName("Black") Black("Black"),
    @SerialName("Green") Green("Green"),
    @SerialName("Blue") Blue("Blue");
}

@Serializable
enum class Layout(val value: String) {
    @SerialName("normal") Normal("normal");
}

@Serializable
data class LegalityElement (
    val format: String,
    val legality: LegalityEnum
)

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
enum class Type(val value: String) {
    @SerialName("Creature") Creature("Creature"),
    @SerialName("Artifact") Artifact("Artifact"),
    @SerialName("Instant") Instant("Instant"),
    @SerialName("Land") Land("Land"),
    @SerialName("Enchantment") Enchantment("Enchantment"),
    @SerialName("Sorcery") Sorcery("Sorcery");
}

object LocalDateSerializer : KSerializer<LocalDate> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("LocalDate", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): LocalDate = LocalDate.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: LocalDate) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(value))
    }
}
