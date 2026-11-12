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
    val amount: Long,
    val enabled: Boolean,
    val kind: Kind,
    val ratio: Double,
    val version: Double
)

@Serializable
enum class Kind(val value: String) {
    @SerialName("widget") Widget("widget");
}
