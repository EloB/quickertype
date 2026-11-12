// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = List<TopLevelElement>

@Serializable
data class TopLevelElement (
    val id: String,
    val identifiers: List<Identifier>,
    val keywords: List<Keyword>,
    val links: List<Link>,
    val name: String,

    @SerialName("other_names")
    val otherNames: List<OtherName>,

    @SerialName("superseded_by")
    val supersededBy: String? = null,

    val text: List<Text>
)

@Serializable
data class Identifier (
    val identifier: String,
    val scheme: Scheme
)

@Serializable
enum class Scheme(val value: String) {
    @SerialName("DEP5") Dep5("DEP5"),
    @SerialName("SPDX") Spdx("SPDX"),
    @SerialName("Trove") Trove("Trove");
}

@Serializable
enum class Keyword(val value: String) {
    @SerialName("osi-approved") OSIApproved("osi-approved"),
    @SerialName("popular") Popular("popular"),
    @SerialName("permissive") Permissive("permissive"),
    @SerialName("copyleft") Copyleft("copyleft");
}

@Serializable
data class Link (
    val note: Note,
    val url: String
)

@Serializable
enum class Note(val value: String) {
    @SerialName("tl;dr legal") TlDRLegal("tl;dr legal"),
    @SerialName("Wikipedia page") WikipediaPage("Wikipedia page"),
    @SerialName("OSI Page") OSIPage("OSI Page"),
    @SerialName("Wikipedia Page") NoteWikipediaPage("Wikipedia Page"),
    @SerialName("Mozilla Page") MozillaPage("Mozilla Page");
}

@Serializable
data class OtherName (
    val name: String,
    val note: String? = null
)

@Serializable
data class Text (
    @SerialName("media_type")
    val mediaType: MediaType,

    val title: Title,
    val url: String
)

@Serializable
enum class MediaType(val value: String) {
    @SerialName("text/html") TextHTML("text/html"),
    @SerialName("text/plain") TextPlain("text/plain");
}

@Serializable
enum class Title(val value: String) {
    @SerialName("HTML") HTML("HTML"),
    @SerialName("Plain Text") PlainText("Plain Text");
}
