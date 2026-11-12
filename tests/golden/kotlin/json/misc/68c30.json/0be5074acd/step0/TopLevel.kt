// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val txs: List<Tx>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Tx (
    @Json(name = "double_spend")
    val doubleSpend: Boolean,

    val hash: String,
    val inputs: List<Input>,

    @Json(name = "lock_time")
    val lockTime: Long,

    val out: List<Out>,

    @Json(name = "relayed_by")
    val relayedBy: String,

    val size: Long,
    val time: Long,

    @Json(name = "tx_index")
    val txIndex: Long,

    val ver: Long,

    @Json(name = "vin_sz")
    val vinSz: Long,

    @Json(name = "vout_sz")
    val voutSz: Long
)

data class Input (
    @Json(name = "prev_out")
    val prevOut: Out,

    val script: String,
    val sequence: Long
)

data class Out (
    val addr: String,
    val n: Long,
    val script: String,
    val spent: Boolean,

    @Json(name = "tx_index")
    val txIndex: Long,

    val type: Long,
    val value: Long
)
