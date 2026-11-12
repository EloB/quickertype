// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

@file:UseSerializers(OffsetDateTimeSerializer::class, LocalDateSerializer::class, OffsetTimeSerializer::class)

package quicktype

import java.time.OffsetDateTime
import java.time.LocalDate
import java.time.OffsetTime

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    @SerialName("complex-union-array")
    val complexUnionArray: JsonArray,

    val date: LocalDate,

    @SerialName("date-time")
    val dateTime: OffsetDateTime,

    @SerialName("local-date-class")
    val localDateClass: LocalDateClassClass? = null,

    @SerialName("offset-date-time-class")
    val offsetDateTimeClass: OffsetDateTimeClassClass? = null,

    @SerialName("offset-time-class")
    val offsetTimeClass: OffsetTimeClassClass? = null,

    val time: OffsetTime,

    @SerialName("union-array")
    val unionArray: JsonArray
)

typealias ComplexUnionArrayElement = JsonElement

@Serializable
enum class ComplexUnionArrayEnum(val value: String) {
    @SerialName("foo") Foo("foo"),
    @SerialName("bar") Bar("bar");
}

@Serializable
class LocalDateClassClass()

@Serializable
class OffsetDateTimeClassClass()

@Serializable
class OffsetTimeClassClass()

typealias UnionArray = JsonElement

object OffsetDateTimeSerializer : KSerializer<OffsetDateTime> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("OffsetDateTime", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): OffsetDateTime = OffsetDateTime.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: OffsetDateTime) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(value))
    }
}

object LocalDateSerializer : KSerializer<LocalDate> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("LocalDate", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): LocalDate = LocalDate.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: LocalDate) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(value))
    }
}

object OffsetTimeSerializer : KSerializer<OffsetTime> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("OffsetTime", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): OffsetTime = OffsetTime.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: OffsetTime) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_OFFSET_TIME.format(value))
    }
}
