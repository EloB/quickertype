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

class TopLevel(elements: Map<String, TopLevelValue>) : HashMap<String, TopLevelValue>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelValue (
    @get:JsonProperty("channel_id", required=true)@field:JsonProperty("channel_id", required=true)
    val channelID: String,

    @get:JsonProperty("channel_name", required=true)@field:JsonProperty("channel_name", required=true)
    val channelName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: String,

    @get:JsonProperty("emoticon_set", required=true)@field:JsonProperty("emoticon_set", required=true)
    val emoticonSet: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long
)
