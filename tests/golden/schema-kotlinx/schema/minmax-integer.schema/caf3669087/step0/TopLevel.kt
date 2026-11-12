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
    val free: Long,
    val intersection: Long,
    val max: Long,
    val min: Long,
    val minmax: Long,
    val minMaxIntersection: Long,
    val minMaxUnion: Long,
    val union: Long
)
