// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(OffsetDateTime::class, { OffsetDateTime.parse(it.string!!) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    .convert(Language::class,       { Language.fromValue(it.string!!) },   { Klaxon().toJsonString(it.value) })
    .convert(Type::class,           { Type.fromValue(it.string!!) },       { Klaxon().toJsonString(it.value) })

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

data class TopLevelElement (
    val comments: Long,

    @Json(name = "comments_url")
    val commentsURL: String,

    @Json(name = "commits_url")
    val commitsURL: String,

    @Json(name = "created_at")
    val createdAt: OffsetDateTime,

    val description: String? = null,
    val files: Map<String, File>,

    @Json(name = "forks_url")
    val forksURL: String,

    @Json(name = "git_pull_url")
    val gitPullURL: String,

    @Json(name = "git_push_url")
    val gitPushURL: String,

    @Json(name = "html_url")
    val htmlURL: String,

    val id: String,
    val public: Boolean,
    val truncated: Boolean,

    @Json(name = "updated_at")
    val updatedAt: OffsetDateTime,

    val url: String,
    val user: Any? = null
)

data class File (
    val filename: String,
    val language: Language? = null,

    @Json(name = "raw_url")
    val rawURL: String,

    val size: Long,
    val type: Type
)

enum class Language(val value: String) {
    Markdown("Markdown");

    companion object {
        public fun fromValue(value: String): Language = when (value) {
            "Markdown" -> Markdown
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class Type(val value: String) {
    TextPlain("text/plain");

    companion object {
        public fun fromValue(value: String): Type = when (value) {
            "text/plain" -> TextPlain
            else         -> throw IllegalArgumentException()
        }
    }
}
