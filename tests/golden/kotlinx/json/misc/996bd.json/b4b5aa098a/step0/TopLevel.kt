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
    val otherNames: JsonArray,

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
    @SerialName("copyleft") Copyleft("copyleft"),
    @SerialName("international") International("international");
}

@Serializable
data class Link (
    val note: String,
    val url: String
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
    @SerialName("text/plain") TextPlain("text/plain"),
    @SerialName("text/html") TextHTML("text/html");
}

@Serializable
enum class Title(val value: String) {
    @SerialName("Plain Text") PlainText("Plain Text"),
    @SerialName("HTML") HTML("HTML");
}
