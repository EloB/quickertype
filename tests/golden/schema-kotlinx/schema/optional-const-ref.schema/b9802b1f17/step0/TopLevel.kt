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
    val coordinates: List<Coordinate>? = null,
    val count: Long? = null,
    val label: String? = null,
    val requiredCoordinates: List<Coordinate>,
    val requiredCount: Long,
    val requiredLabel: String,
    val weight: Double? = null
)

@Serializable
data class Coordinate (
    val latitude: Double,
    val longitude: Double
)
