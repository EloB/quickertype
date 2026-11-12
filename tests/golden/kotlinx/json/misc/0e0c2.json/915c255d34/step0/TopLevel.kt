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
    val count: Long,
    val next: String,
    val previous: JsonElement? = null,
    val results: List<Result>
)

@Serializable
data class Result (
    @SerialName("active_screens")
    val activeScreens: Long,

    val collections: List<Collection>,
    val details: List<Detail>,
    val duration: Long,

    @SerialName("fav_movie")
    val favMovie: FavMovie,

    val id: Long,
    val images: List<Image>,
    val language: ResultLanguage,

    @SerialName("release_date")
    val releaseDate: LocalDate,

    val stars: Long,
    val tags: JsonArray? = null,
    val title: String,
    val videos: List<Video>,

    @SerialName("vote_score")
    val voteScore: VoteScore,

    val watches: Long
)

@Serializable
data class Collection (
    val id: Long,
    val movies: List<Long>,
    val name: String,
    val slug: String
)

@Serializable
data class Detail (
    val cast: String,
    val director: String,
    val id: Long,
    val language: DetailLanguage,
    val storyline: String,
    val tagline: String,
    val title: String
)

@Serializable
enum class DetailLanguage(val value: String) {
    @SerialName("en") En("en"),
    @SerialName("th") Th("th");
}

@Serializable
data class FavMovie (
    val follow: Boolean,
    val star: Boolean,
    val watched: Boolean
)

@Serializable
data class Image (
    val favs: Long,
    val id: Long,
    val thumbnail: String,
    val type: Type,
    val url: String
)

@Serializable
enum class Type(val value: String) {
    @SerialName("Poster") Poster("Poster"),
    @SerialName("Backdrop") Backdrop("Backdrop");
}

@Serializable
enum class ResultLanguage(val value: String) {
    @SerialName("en") En("en"),
    @SerialName("-") Empty("-");
}

@Serializable
data class Video (
    val kind: String,
    val language: ResultLanguage,
    val source: String,
    val url: String
)

@Serializable
data class VoteScore (
    val avg: Long,
    val score: Long,
    val total: Long
)

object LocalDateSerializer : KSerializer<LocalDate> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("LocalDate", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): LocalDate = LocalDate.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: LocalDate) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(value))
    }
}
