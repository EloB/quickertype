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
    val config: Config? = null
)

@Serializable
data class Config (
    val closed: JsonElement? = null,
    val name: String? = null,
    val settings: Map<String, List<Item>>? = null
)

typealias Closed = JsonElement

@Serializable
class ClosedClass()

@Serializable
data class Item (
    val key: String,
    val value: String
)
