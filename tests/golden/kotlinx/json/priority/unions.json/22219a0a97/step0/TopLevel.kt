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
    val x: JsonArray,
    val y: List<Long?>,
    val z: JsonArray
)

typealias X = JsonElement

typealias ZElement = JsonElement

@Serializable
data class ZClass (
    val a: Boolean
)
