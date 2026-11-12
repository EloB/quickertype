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
    val anEasyOne: Long,

    @get:JsonProperty("isMNISTLetter", required=true)@field:JsonProperty("isMNISTLetter", required=true)
    val isMNISTLetter: Boolean,

    @get:JsonProperty("JSONString", required=true)@field:JsonProperty("JSONString", required=true)
    val jsonString: String,

    @get:JsonProperty("PrettyEasyToo", required=true)@field:JsonProperty("PrettyEasyToo", required=true)
    val prettyEasyToo: Boolean,

    @get:JsonProperty("should_know_that_id_is_an_initialism", required=true)@field:JsonProperty("should_know_that_id_is_an_initialism", required=true)
    val shouldKnowThatIDIsAnInitialism: String,

    @get:JsonProperty("   spaces are separators  too  ", required=true)@field:JsonProperty("   spaces are separators  too  ", required=true)
    val spacesAreSeparatorsToo: Boolean,

    @get:JsonProperty("ZSR_HH_DEMO3_DELMATNR", required=true)@field:JsonProperty("ZSR_HH_DEMO3_DELMATNR", required=true)
    val zsrHhDemo3Delmatnr: Boolean
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}
