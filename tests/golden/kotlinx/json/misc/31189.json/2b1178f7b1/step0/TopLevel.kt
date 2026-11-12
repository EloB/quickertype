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
    val details: String,
    val rates: List<Rate>,
    val version: JsonElement? = null
)

@Serializable
data class Rate (
    val code: String,

    @SerialName("country_code")
    val countryCode: String,

    val name: String,
    val periods: List<Period>
)

@Serializable
data class Period (
    @SerialName("effective_from")
    val effectiveFrom: JsonElement,

    val rates: Rates
)

typealias EffectiveFromUnion = JsonElement

@Serializable
enum class EffectiveFromEnum(val value: String) {
    @SerialName("0000-01-01") The00000101("0000-01-01");
}

@Serializable
data class Rates (
    val parking: Double? = null,
    val reduced: Double? = null,
    val reduced1: Double? = null,
    val reduced2: Double? = null,
    val standard: Double,

    @SerialName("super_reduced")
    val superReduced: Double? = null
)

object LocalDateSerializer : KSerializer<LocalDate> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("LocalDate", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): LocalDate = LocalDate.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: LocalDate) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(value))
    }
}
