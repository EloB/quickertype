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
    val arrayNode: ArrayNode? = null,
    val booleanNode: BooleanNode? = null,
    val doubleNode: DoubleNode? = null,
    val intNode: IntNode? = null,
    val longNode: LongNode? = null,
    val nullNode: NullNode? = null,
    val objectNode: ObjectNode? = null,
    val stuff: Map<String, Thing>,
    val textNode: TextNode? = null
)

@Serializable
class ArrayNode()

@Serializable
class BooleanNode()

@Serializable
class DoubleNode()

@Serializable
class IntNode()

@Serializable
class LongNode()

@Serializable
class NullNode()

@Serializable
class ObjectNode()

@Serializable
data class Thing (
    val optional: JsonElement? = null,
    val required: JsonElement
)

typealias Anything = JsonElement

@Serializable
class TextNode()
