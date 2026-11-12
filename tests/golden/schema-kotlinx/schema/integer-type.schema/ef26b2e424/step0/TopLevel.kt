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
    @SerialName("above_i32_max")
    val aboveI32Max: Long,

    @SerialName("below_i32_min")
    val belowI32Min: Long,

    @SerialName("i32_range")
    val i32Range: Long,

    @SerialName("large_bounds")
    val largeBounds: Long,

    @SerialName("only_maximum")
    val onlyMaximum: Long,

    @SerialName("only_minimum")
    val onlyMinimum: Long,

    @SerialName("small_negative")
    val smallNegative: Long,

    @SerialName("small_positive")
    val smallPositive: Long,

    val unbounded: Long
)
