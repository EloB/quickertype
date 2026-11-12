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
    val data: Map<String, Datum>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: Description
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Datum (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val anomaly: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val value: String
)

data class Description (
    @get:JsonProperty("base_period", required=true)@field:JsonProperty("base_period", required=true)
    val basePeriod: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val missing: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String
)
