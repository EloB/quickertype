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
    val txs: List<Tx>
)

@Serializable
data class Tx (
    @SerialName("double_spend")
    val doubleSpend: Boolean,

    val hash: String,
    val inputs: List<Input>,

    @SerialName("lock_time")
    val lockTime: Long,

    val out: List<Out>,

    @SerialName("relayed_by")
    val relayedBy: String,

    val size: Long,
    val time: Long,

    @SerialName("tx_index")
    val txIndex: Long,

    val ver: Long,

    @SerialName("vin_sz")
    val vinSz: Long,

    @SerialName("vout_sz")
    val voutSz: Long
)

@Serializable
data class Input (
    @SerialName("prev_out")
    val prevOut: Out,

    val script: String,
    val sequence: Long
)

@Serializable
data class Out (
    val addr: String,
    val n: Long,
    val script: String,
    val spent: Boolean,

    @SerialName("tx_index")
    val txIndex: Long,

    val type: Long,
    val value: Long
)
