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
    val comments: Long,

    @SerialName("comments_url")
    val commentsURL: String,

    @SerialName("commits_url")
    val commitsURL: String,

    @SerialName("created_at")
    val createdAt: OffsetDateTime,

    val description: String? = null,
    val files: Map<String, File>,

    @SerialName("forks_url")
    val forksURL: String,

    @SerialName("git_pull_url")
    val gitPullURL: String,

    @SerialName("git_push_url")
    val gitPushURL: String,

    @SerialName("html_url")
    val htmlURL: String,

    val id: String,
    val public: Boolean,
    val truncated: Boolean,

    @SerialName("updated_at")
    val updatedAt: OffsetDateTime,

    val url: String,
    val user: JsonElement? = null
)

@Serializable
data class File (
    val filename: String,
    val language: Language? = null,

    @SerialName("raw_url")
    val rawURL: String,

    val size: Long,
    val type: Type
)

@Serializable
enum class Language(val value: String) {
    @SerialName("Markdown") Markdown("Markdown");
}

@Serializable
enum class Type(val value: String) {
    @SerialName("text/plain") TextPlain("text/plain");
}

object OffsetDateTimeSerializer : KSerializer<OffsetDateTime> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("OffsetDateTime", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): OffsetDateTime = OffsetDateTime.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: OffsetDateTime) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(value))
    }
}
