// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(Scheme::class,    { Scheme.fromValue(it.string!!) },    { Klaxon().toJsonString(it.value) })
    .convert(Keyword::class,   { Keyword.fromValue(it.string!!) },   { Klaxon().toJsonString(it.value) })
    .convert(Note::class,      { Note.fromValue(it.string!!) },      { Klaxon().toJsonString(it.value) })
    .convert(MediaType::class, { MediaType.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Title::class,     { Title.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

data class TopLevelElement (
    val id: String,
    val identifiers: List<Identifier>,
    val keywords: List<Keyword>,
    val links: List<Link>,
    val name: String,

    @Json(name = "other_names")
    val otherNames: List<Any?>,

    @Json(name = "superseded_by")
    val supersededBy: String? = null,

    val text: List<Text>
)

data class Identifier (
    val identifier: String,
    val scheme: Scheme
)

enum class Scheme(val value: String) {
    Spdx("SPDX"),
    Trove("Trove"),
    Dep5("DEP5");

    companion object {
        public fun fromValue(value: String): Scheme = when (value) {
            "SPDX"  -> Spdx
            "Trove" -> Trove
            "DEP5"  -> Dep5
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Keyword(val value: String) {
    OSIApproved("osi-approved"),
    Discouraged("discouraged"),
    Redundant("redundant");

    companion object {
        public fun fromValue(value: String): Keyword = when (value) {
            "osi-approved" -> OSIApproved
            "discouraged"  -> Discouraged
            "redundant"    -> Redundant
            else           -> throw IllegalArgumentException()
        }
    }
}

data class Link (
    val note: Note,
    val url: String
)

enum class Note(val value: String) {
    OSIPage("OSI Page");

    companion object {
        public fun fromValue(value: String): Note = when (value) {
            "OSI Page" -> OSIPage
            else       -> throw IllegalArgumentException()
        }
    }
}

data class Text (
    @Json(name = "media_type")
    val mediaType: MediaType,

    val title: Title,
    val url: String
)

enum class MediaType(val value: String) {
    TextHTML("text/html");

    companion object {
        public fun fromValue(value: String): MediaType = when (value) {
            "text/html" -> TextHTML
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class Title(val value: String) {
    HTML("HTML");

    companion object {
        public fun fromValue(value: String): Title = when (value) {
            "HTML" -> HTML
            else   -> throw IllegalArgumentException()
        }
    }
}
