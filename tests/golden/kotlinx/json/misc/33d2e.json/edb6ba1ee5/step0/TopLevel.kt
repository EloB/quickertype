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
    val laureates: List<Laureate>
)

@Serializable
data class Laureate (
    val born: JsonElement,
    val bornCity: String? = null,
    val bornCountry: String? = null,
    val bornCountryCode: String? = null,
    val died: JsonElement,
    val diedCity: String? = null,
    val diedCountry: String? = null,
    val diedCountryCode: String? = null,
    val firstname: String? = null,
    val gender: Gender,
    val id: String,
    val prizes: List<Prize>,
    val surname: String? = null
)

typealias BornUnion = JsonElement

@Serializable
enum class BornEnum(val value: String) {
    @SerialName("0000-00-00") The00000000("0000-00-00"),
    @SerialName("1898-00-00") The18980000("1898-00-00"),
    @SerialName("1943-00-00") The19430000("1943-00-00");
}

@Serializable
enum class Gender(val value: String) {
    @SerialName("male") Male("male"),
    @SerialName("female") Female("female"),
    @SerialName("org") Org("org");
}

@Serializable
data class Prize (
    val affiliations: JsonArray,
    val category: Category? = null,
    val motivation: String? = null,
    val overallMotivation: String? = null,
    val share: String? = null,
    val year: String? = null
)

typealias AffiliationElement = JsonElement

@Serializable
data class AffiliationClass (
    val city: String? = null,
    val country: String? = null,
    val name: String? = null
)

@Serializable
enum class Category(val value: String) {
    @SerialName("physics") Physics("physics"),
    @SerialName("chemistry") Chemistry("chemistry"),
    @SerialName("peace") Peace("peace"),
    @SerialName("medicine") Medicine("medicine"),
    @SerialName("literature") Literature("literature"),
    @SerialName("economics") Economics("economics");
}

object LocalDateSerializer : KSerializer<LocalDate> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("LocalDate", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): LocalDate = LocalDate.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: LocalDate) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(value))
    }
}
