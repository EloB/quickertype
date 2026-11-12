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
    @get:JsonProperty("above_i32_max", required=true)@field:JsonProperty("above_i32_max", required=true)
    val aboveI32Max: Long,

    @get:JsonProperty("below_i32_min", required=true)@field:JsonProperty("below_i32_min", required=true)
    val belowI32Min: Long,

    @get:JsonProperty("i32_range", required=true)@field:JsonProperty("i32_range", required=true)
    val i32Range: Long,

    @get:JsonProperty("large_bounds", required=true)@field:JsonProperty("large_bounds", required=true)
    val largeBounds: Long,

    @get:JsonProperty("only_maximum", required=true)@field:JsonProperty("only_maximum", required=true)
    val onlyMaximum: Long,

    @get:JsonProperty("only_minimum", required=true)@field:JsonProperty("only_minimum", required=true)
    val onlyMinimum: Long,

    @get:JsonProperty("small_negative", required=true)@field:JsonProperty("small_negative", required=true)
    val smallNegative: Long,

    @get:JsonProperty("small_positive", required=true)@field:JsonProperty("small_positive", required=true)
    val smallPositive: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val unbounded: Long
) {
    init {
        require(aboveI32Max >= 0)
        require(aboveI32Max <= 2147483648)
        require(belowI32Min >= -2147483649)
        require(belowI32Min <= 0)
        require(i32Range >= -2147483648)
        require(i32Range <= 2147483647)
        require(largeBounds >= -9007199254740991)
        require(largeBounds <= 9007199254740991)
        require(onlyMaximum <= 0)
        require(onlyMinimum >= 0)
        require(smallNegative >= -100)
        require(smallNegative <= 0)
        require(smallPositive >= 0)
        require(smallPositive <= 100)
    }
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}
