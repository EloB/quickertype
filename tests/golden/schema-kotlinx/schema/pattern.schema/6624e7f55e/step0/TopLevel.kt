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
    val pattern1: String,
    val pattern2: String,

    @SerialName("RegExp")
    val regExp: RegExp? = null,

    val union: String
)

@Serializable
data class RegExp (
    val pattern3: String
)
