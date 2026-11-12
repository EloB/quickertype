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
    @SerialName("")
    val empty: String,

    @SerialName("x'")
    val purpleX: String,

    @SerialName("{}")
    val topLevel: String,

    @SerialName("continue")
    val topLevelContinue: String,

    @SerialName("null")
    val topLevelNull: String,

    @SerialName("x\"")
    val topLevelX: String,

    val undefined: String,
    val x: String,

    @SerialName("x y")
    val xY: String
)
