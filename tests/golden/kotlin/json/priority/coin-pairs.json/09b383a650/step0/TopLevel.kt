// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val pairs: Map<String, Pair>,

    @Json(name = "server_time")
    val serverTime: Long
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Pair (
    @Json(name = "decimal_places")
    val decimalPlaces: Long,

    val fee: Double,
    val hidden: Long,

    @Json(name = "max_amount")
    val maxAmount: Long,

    @Json(name = "max_price")
    val maxPrice: Long,

    @Json(name = "min_amount")
    val minAmount: Double,

    @Json(name = "min_price")
    val minPrice: Double,

    @Json(name = "min_total")
    val minTotal: Double
)
