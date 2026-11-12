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
    val supersededBy: JsonElement? = null,

    val text: List<Text>
)

@Serializable
data class Identifier (
    val identifier: String,
    val scheme: String
)

@Serializable
enum class Keyword(val value: String) {
    @SerialName("special-purpose") SpecialPurpose("special-purpose"),
    @SerialName("osi-approved") OSIApproved("osi-approved");
}

@Serializable
data class Link (
    val note: String,
    val url: String
)

@Serializable
data class Text (
    @SerialName("media_type")
    val mediaType: String,

    val title: String,
    val url: String
)
