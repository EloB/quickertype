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
    val exact: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val maximum: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minimum: String
) {
    init {
        require(exact.codePointCount(0, exact.length) >= 2)
        require(exact.codePointCount(0, exact.length) <= 2)
        require(Regex("^[^!]+\$").containsMatchIn(exact))
        require(maximum.codePointCount(0, maximum.length) <= 1)
        require(minimum.codePointCount(0, minimum.length) >= 2)
    }
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}
