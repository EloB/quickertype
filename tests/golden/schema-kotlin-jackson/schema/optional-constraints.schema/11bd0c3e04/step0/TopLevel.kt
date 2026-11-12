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
    val optDouble: Double? = null,
    val optInt: Long? = null,
    val optPattern: String? = null,
    val optString: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val reqZeroMin: Long
) {
    init {
        optDouble?.let { require(it >= 0.5) }
        optDouble?.let { require(it <= 99.5) }
        optInt?.let { require(it >= 0) }
        optInt?.let { require(it <= 100) }
        optPattern?.let { require(Regex("^[a-z]+\$").containsMatchIn(it)) }
        optString?.let { require(it.codePointCount(0, it.length) >= 3) }
        optString?.let { require(it.codePointCount(0, it.length) <= 10) }
        require(reqZeroMin >= 0)
        require(reqZeroMin <= 100)
    }
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}
