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
    .convert(LocalDate::class,      { LocalDate.parse(it.string!!) },          { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    .convert(DetailLanguage::class, { DetailLanguage.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Type::class,           { Type.fromValue(it.string!!) },           { Klaxon().toJsonString(it.value) })
    .convert(ResultLanguage::class, { ResultLanguage.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val count: Long,
    val next: String,
    val previous: Any? = null,
    val results: List<Result>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Result (
    @Json(name = "active_screens")
    val activeScreens: Long,

    val collections: List<Collection>,
    val details: List<Detail>,
    val duration: Long,

    @Json(name = "fav_movie")
    val favMovie: FavMovie,

    val id: Long,
    val images: List<Image>,
    val language: ResultLanguage,

    @Json(name = "release_date")
    val releaseDate: LocalDate,

    val stars: Long,
    val tags: List<Any?>? = null,
    val title: String,
    val videos: List<Video>,

    @Json(name = "vote_score")
    val voteScore: VoteScore,

    val watches: Long
)

data class Collection (
    val id: Long,
    val movies: List<Long>,
    val name: String,
    val slug: String
)

data class Detail (
    val cast: String,
    val director: String,
    val id: Long,
    val language: DetailLanguage,
    val storyline: String,
    val tagline: String,
    val title: String
)

enum class DetailLanguage(val value: String) {
    En("en"),
    Th("th");

    companion object {
        public fun fromValue(value: String): DetailLanguage = when (value) {
            "en" -> En
            "th" -> Th
            else -> throw IllegalArgumentException()
        }
    }
}

data class FavMovie (
    val follow: Boolean,
    val star: Boolean,
    val watched: Boolean
)

data class Image (
    val favs: Long,
    val id: Long,
    val thumbnail: String,
    val type: Type,
    val url: String
)

enum class Type(val value: String) {
    Poster("Poster"),
    Backdrop("Backdrop");

    companion object {
        public fun fromValue(value: String): Type = when (value) {
            "Poster"   -> Poster
            "Backdrop" -> Backdrop
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class ResultLanguage(val value: String) {
    En("en"),
    Empty("-");

    companion object {
        public fun fromValue(value: String): ResultLanguage = when (value) {
            "en" -> En
            "-"  -> Empty
            else -> throw IllegalArgumentException()
        }
    }
}

data class Video (
    val kind: String,
    val language: ResultLanguage,
    val source: String,
    val url: String
)

data class VoteScore (
    val avg: Long,
    val score: Long,
    val total: Long
)
