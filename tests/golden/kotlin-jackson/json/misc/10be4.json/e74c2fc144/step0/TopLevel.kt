// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*


@Suppress("UNCHECKED_CAST")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {
    addSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {
            override fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
    })
    addDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {
            override fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree())
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    convert(Scheme::class,    { Scheme.fromValue(it.asText()) },    { ObjectMapper().writeValueAsString(it.value) })
    convert(Keyword::class,   { Keyword.fromValue(it.asText()) },   { ObjectMapper().writeValueAsString(it.value) })
    convert(Note::class,      { Note.fromValue(it.asText()) },      { ObjectMapper().writeValueAsString(it.value) })
    convert(MediaType::class, { MediaType.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Title::class,     { Title.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
}

class TopLevel(elements: Collection<TopLevelElement> = emptyList()) : ArrayList<TopLevelElement>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val identifiers: List<Identifier>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val keywords: List<Keyword>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val links: List<Link>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty("other_names", required=true)@field:JsonProperty("other_names", required=true)
    val otherNames: List<OtherName>,

    @get:JsonProperty("superseded_by", required=true)@field:JsonProperty("superseded_by", required=true)
    val supersededBy: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val text: List<Text>
)

data class Identifier (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val identifier: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scheme: Scheme
)

enum class Scheme(val value: String) {
    Spdx("SPDX"),
    Trove("Trove"),
    Dep5("DEP5");

    companion object {
        fun fromValue(value: String): Scheme = when (value) {
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
    Redundant("redundant"),
    Miscellaneous("miscellaneous"),
    NonReusable("non-reusable"),
    Obsolete("obsolete"),
    Popular("popular"),
    Permissive("permissive"),
    Retired("retired"),
    SpecialPurpose("special-purpose"),
    Copyleft("copyleft"),
    International("international");

    companion object {
        fun fromValue(value: String): Keyword = when (value) {
            "osi-approved"    -> OSIApproved
            "discouraged"     -> Discouraged
            "redundant"       -> Redundant
            "miscellaneous"   -> Miscellaneous
            "non-reusable"    -> NonReusable
            "obsolete"        -> Obsolete
            "popular"         -> Popular
            "permissive"      -> Permissive
            "retired"         -> Retired
            "special-purpose" -> SpecialPurpose
            "copyleft"        -> Copyleft
            "international"   -> International
            else              -> throw IllegalArgumentException()
        }
    }
}

data class Link (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val note: Note,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

enum class Note(val value: String) {
    OSIPage("OSI Page"),
    TlDRLegal("tl;dr legal"),
    WikipediaPage("Wikipedia page"),
    NoteWikipediaPage("Wikipedia Page"),
    MozillaPage("Mozilla Page"),
    OSETFoundationPage("OSET Foundation Page");

    companion object {
        fun fromValue(value: String): Note = when (value) {
            "OSI Page"             -> OSIPage
            "tl;dr legal"          -> TlDRLegal
            "Wikipedia page"       -> WikipediaPage
            "Wikipedia Page"       -> NoteWikipediaPage
            "Mozilla Page"         -> MozillaPage
            "OSET Foundation Page" -> OSETFoundationPage
            else                   -> throw IllegalArgumentException()
        }
    }
}

data class OtherName (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val note: String?
)

data class Text (
    @get:JsonProperty("media_type", required=true)@field:JsonProperty("media_type", required=true)
    val mediaType: MediaType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: Title,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

enum class MediaType(val value: String) {
    TextHTML("text/html"),
    TextPlain("text/plain"),
    ApplicationPDF("application/pdf");

    companion object {
        fun fromValue(value: String): MediaType = when (value) {
            "text/html"       -> TextHTML
            "text/plain"      -> TextPlain
            "application/pdf" -> ApplicationPDF
            else              -> throw IllegalArgumentException()
        }
    }
}

enum class Title(val value: String) {
    HTML("HTML"),
    PlainText("Plain Text"),
    PDF("PDF");

    companion object {
        fun fromValue(value: String): Title = when (value) {
            "HTML"       -> HTML
            "Plain Text" -> PlainText
            "PDF"        -> PDF
            else         -> throw IllegalArgumentException()
        }
    }
}
