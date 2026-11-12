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
    val arrNullable: List<String?>? = null,
    val arrOne: List<String>? = null,
    val nullable: String? = null,
    val one: String,
    val optional: String? = null,
    val unionWithInt: JsonElement,
    val unionWithIntAndEnum: JsonElement
)

typealias UnionWithInt = JsonElement
