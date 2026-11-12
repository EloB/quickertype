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
    val otherNames: List<OtherName>,

    @Json(name = "superseded_by")
    val supersededBy: String? = null,

    val text: List<Text>
)

data class Identifier (
    val identifier: String,
    val scheme: Scheme
)

enum class Scheme(val value: String) {
    Dep5("DEP5"),
    Spdx("SPDX"),
    Trove("Trove");

    companion object {
        public fun fromValue(value: String): Scheme = when (value) {
            "DEP5"  -> Dep5
            "SPDX"  -> Spdx
            "Trove" -> Trove
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Keyword(val value: String) {
    OSIApproved("osi-approved"),
    Popular("popular"),
    Permissive("permissive"),
    Copyleft("copyleft");

    companion object {
        public fun fromValue(value: String): Keyword = when (value) {
            "osi-approved" -> OSIApproved
            "popular"      -> Popular
            "permissive"   -> Permissive
            "copyleft"     -> Copyleft
            else           -> throw IllegalArgumentException()
        }
    }
}

data class Link (
    val note: Note,
    val url: String
)

enum class Note(val value: String) {
    TlDRLegal("tl;dr legal"),
    WikipediaPage("Wikipedia page"),
    OSIPage("OSI Page"),
    NoteWikipediaPage("Wikipedia Page"),
    MozillaPage("Mozilla Page");

    companion object {
        public fun fromValue(value: String): Note = when (value) {
            "tl;dr legal"    -> TlDRLegal
            "Wikipedia page" -> WikipediaPage
            "OSI Page"       -> OSIPage
            "Wikipedia Page" -> NoteWikipediaPage
            "Mozilla Page"   -> MozillaPage
            else             -> throw IllegalArgumentException()
        }
    }
}

data class OtherName (
    val name: String,
    val note: String? = null
)

data class Text (
    @Json(name = "media_type")
    val mediaType: MediaType,

    val title: Title,
    val url: String
)

enum class MediaType(val value: String) {
    TextHTML("text/html"),
    TextPlain("text/plain");

    companion object {
        public fun fromValue(value: String): MediaType = when (value) {
            "text/html"  -> TextHTML
            "text/plain" -> TextPlain
            else         -> throw IllegalArgumentException()
        }
    }
}

enum class Title(val value: String) {
    HTML("HTML"),
    PlainText("Plain Text");

    companion object {
        public fun fromValue(value: String): Title = when (value) {
            "HTML"       -> HTML
            "Plain Text" -> PlainText
            else         -> throw IllegalArgumentException()
        }
    }
}
