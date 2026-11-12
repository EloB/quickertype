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
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val city: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val delay: String,

    @get:JsonProperty("IATA", required=true)@field:JsonProperty("IATA", required=true)
    val iata: String,

    @get:JsonProperty("ICAO", required=true)@field:JsonProperty("ICAO", required=true)
    val icao: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val state: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Status,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val weather: Weather
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Status (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val avgDelay: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val closureBegin: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val closureEnd: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val endTime: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val maxDelay: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minDelay: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val reason: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val trend: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class Weather (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val meta: Meta,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val temp: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val visibility: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val weather: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val wind: String
)

data class Meta (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val credit: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val updated: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)
