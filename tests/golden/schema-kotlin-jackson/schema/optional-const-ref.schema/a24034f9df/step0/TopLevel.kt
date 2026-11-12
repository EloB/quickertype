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
    val coordinates: List<Coordinate>? = null,
    val count: Long? = null,
    val label: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val requiredCoordinates: List<Coordinate>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val requiredCount: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val requiredLabel: String,

    val weight: Double? = null
) {
    init {
        count?.let { require(it >= 1) }
        count?.let { require(it <= 100) }
        label?.let { require(it.codePointCount(0, it.length) >= 2) }
        label?.let { require(it.codePointCount(0, it.length) <= 16) }
        require(requiredCount >= 1)
        require(requiredCount <= 100)
        require(requiredLabel.codePointCount(0, requiredLabel.length) >= 2)
        require(requiredLabel.codePointCount(0, requiredLabel.length) <= 16)
        weight?.let { require(it >= 0.5) }
        weight?.let { require(it <= 99.5) }
    }
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Coordinate (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val latitude: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val longitude: Double
)
