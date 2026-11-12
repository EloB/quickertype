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
    val pattern1: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pattern2: String,

    @get:JsonProperty("RegExp")@field:JsonProperty("RegExp")
    val regExp: RegExp? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val union: String
) {
    init {
        require(Regex("a[.]*").containsMatchIn(pattern1))
        require(Regex("b[.]*").containsMatchIn(pattern2))
        require(Regex("(b[.]*)|(c[.]*)").containsMatchIn(union))
    }
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class RegExp (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pattern3: String
)
