// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val txs: List<Tx>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Tx (
    @get:JsonProperty("double_spend", required=true)@field:JsonProperty("double_spend", required=true)
    val doubleSpend: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hash: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inputs: List<Input>,

    @get:JsonProperty("lock_time", required=true)@field:JsonProperty("lock_time", required=true)
    val lockTime: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val out: List<Out>,

    @get:JsonProperty("relayed_by", required=true)@field:JsonProperty("relayed_by", required=true)
    val relayedBy: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val size: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val time: Long,

    @get:JsonProperty("tx_index", required=true)@field:JsonProperty("tx_index", required=true)
    val txIndex: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ver: Long,

    @get:JsonProperty("vin_sz", required=true)@field:JsonProperty("vin_sz", required=true)
    val vinSz: Long,

    @get:JsonProperty("vout_sz", required=true)@field:JsonProperty("vout_sz", required=true)
    val voutSz: Long
)

data class Input (
    @get:JsonProperty("prev_out", required=true)@field:JsonProperty("prev_out", required=true)
    val prevOut: Out,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val script: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sequence: Long
)

data class Out (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val addr: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val n: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val script: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val spent: Boolean,

    @get:JsonProperty("tx_index", required=true)@field:JsonProperty("tx_index", required=true)
    val txIndex: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val value: Long
)
