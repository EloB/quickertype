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
    val intersection: String,
    val inUnion: JsonElement,
    val maxlength: String,
    val minlength: String,
    val minMaxIntersection: String,
    val minmaxlength: String,
    val minMaxUnion: String,
    val union: String
)

typealias InUnion = JsonElement
