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
    val message: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val responseTime: Long,

    @get:JsonProperty("Results", required=true)@field:JsonProperty("Results", required=true)
    val results: Results,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Results (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val series: List<Series>
)

data class Series (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val data: List<Datum>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val seriesID: String
)

data class Datum (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val footnotes: List<Footnote>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val period: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val periodName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val value: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val year: String
)

data class Footnote (
    val code: String? = null,
    val text: String? = null
)
