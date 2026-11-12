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
    val free: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val intersection: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val max: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val min: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minmax: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minMaxIntersection: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minMaxUnion: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val union: Long
) {
    init {
        require(intersection >= 4)
        require(intersection <= 5)
        require(max <= 5)
        require(min >= 3)
        require(minmax >= 3)
        require(minmax <= 5)
        require(minMaxIntersection >= 3)
        require(minMaxIntersection <= 5)
        require(union >= 3)
        require(union <= 6)
    }
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}
