// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    @SerialName("Hints")
    val hints: Hints,

    @SerialName("Labels")
    val labels: Labels
)

@Serializable
class Hints()

@Serializable
data class Labels (
    @SerialName("AccountNumber")
    val accountNumber: String,

    @SerialName("Title")
    val title: String
)
