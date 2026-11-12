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
    @get:JsonProperty("", required=true)@field:JsonProperty("", required=true)
    val empty: String,

    @get:JsonProperty("x'", required=true)@field:JsonProperty("x'", required=true)
    val purpleX: String,

    @get:JsonProperty("{}", required=true)@field:JsonProperty("{}", required=true)
    val topLevel: String,

    @get:JsonProperty("continue", required=true)@field:JsonProperty("continue", required=true)
    val topLevelContinue: String,

    @get:JsonProperty("null", required=true)@field:JsonProperty("null", required=true)
    val topLevelNull: String,

    @get:JsonProperty("x\"", required=true)@field:JsonProperty("x\"", required=true)
    val topLevelX: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val undefined: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val x: String,

    @get:JsonProperty("x y", required=true)@field:JsonProperty("x y", required=true)
    val xY: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}
