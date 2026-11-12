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
    val keywords: List<String>,
    val links: List<Link>,
    val name: String,

    @SerialName("other_names")
    val otherNames: List<OtherName>,

    @SerialName("superseded_by")
    val supersededBy: JsonElement? = null,

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
data class Link (
    val note: String,
    val url: String
)

@Serializable
data class OtherName (
    val name: String,
    val note: String? = null
)

@Serializable
data class Text (
    @SerialName("media_type")
    val mediaType: String,

    val title: String,
    val url: String
)
