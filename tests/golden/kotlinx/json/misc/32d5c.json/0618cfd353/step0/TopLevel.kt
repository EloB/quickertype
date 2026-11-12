// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

@file:UseSerializers(OffsetDateTimeSerializer::class)

package quicktype

import java.time.OffsetDateTime

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = List<TopLevelElement>

@Serializable
data class TopLevelElement (
    @SerialName("BirthDate")
    val birthDate: OffsetDateTime? = null,

    @SerialName("BirthDateIsProtected")
    val birthDateIsProtected: Boolean,

    @SerialName("GenderTypeID")
    val genderTypeID: Long,

    @SerialName("Notes")
    val notes: String,

    @SerialName("ParliamentaryName")
    val parliamentaryName: String,

    @SerialName("PersonID")
    val personID: Long,

    @SerialName("PhotoURL")
    val photoURL: String,

    @SerialName("PreferredName")
    val preferredName: String
)

object OffsetDateTimeSerializer : KSerializer<OffsetDateTime> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("OffsetDateTime", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): OffsetDateTime = OffsetDateTime.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: OffsetDateTime) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(value))
    }
}
