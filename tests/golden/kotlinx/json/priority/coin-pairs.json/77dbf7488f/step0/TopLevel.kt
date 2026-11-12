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
    val pairs: Map<String, Pair>,

    @SerialName("server_time")
    val serverTime: Long
)

@Serializable
data class Pair (
    @SerialName("decimal_places")
    val decimalPlaces: Long,

    val fee: Double,
    val hidden: Long,

    @SerialName("max_amount")
    val maxAmount: Long,

    @SerialName("max_price")
    val maxPrice: Long,

    @SerialName("min_amount")
    val minAmount: Double,

    @SerialName("min_price")
    val minPrice: Double,

    @SerialName("min_total")
    val minTotal: Double
)
