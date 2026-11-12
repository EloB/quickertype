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
    val pairs: Map<String, Pair>,

    @get:JsonProperty("server_time", required=true)@field:JsonProperty("server_time", required=true)
    val serverTime: Long
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Pair (
    @get:JsonProperty("decimal_places", required=true)@field:JsonProperty("decimal_places", required=true)
    val decimalPlaces: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fee: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hidden: Long,

    @get:JsonProperty("max_amount", required=true)@field:JsonProperty("max_amount", required=true)
    val maxAmount: Long,

    @get:JsonProperty("max_price", required=true)@field:JsonProperty("max_price", required=true)
    val maxPrice: Long,

    @get:JsonProperty("min_amount", required=true)@field:JsonProperty("min_amount", required=true)
    val minAmount: Double,

    @get:JsonProperty("min_price", required=true)@field:JsonProperty("min_price", required=true)
    val minPrice: Double,

    @get:JsonProperty("min_total", required=true)@field:JsonProperty("min_total", required=true)
    val minTotal: Double
)
