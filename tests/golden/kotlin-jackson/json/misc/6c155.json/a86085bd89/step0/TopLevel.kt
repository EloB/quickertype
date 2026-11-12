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
    val metadata: Metadata,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val results: List<Result>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Metadata (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val executionTime: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val responseInfo: ResponseInfo,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val resultset: Resultset
)

data class ResponseInfo (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val developerMessage: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Long
)

data class Resultset (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val count: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val page: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pagesize: Long
)

data class Result (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val attachment: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val body: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val changed: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val component: List<Component>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val created: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val date: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val image: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val location: Location,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val teaser: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val topic: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uuid: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val vuuid: String
)

data class Component (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uuid: String
)

data class Location (
    @get:JsonProperty("administrative_area", required=true)@field:JsonProperty("administrative_area", required=true)
    val administrativeArea: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val country: String,

    @get:JsonProperty("fax_number", required=true)@field:JsonProperty("fax_number", required=true)
    val faxNumber: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val locality: String,

    @get:JsonProperty("mobile_number", required=true)@field:JsonProperty("mobile_number", required=true)
    val mobileNumber: String,

    @get:JsonProperty("phone_number", required=true)@field:JsonProperty("phone_number", required=true)
    val phoneNumber: String,

    @get:JsonProperty("phone_number_extension", required=true)@field:JsonProperty("phone_number_extension", required=true)
    val phoneNumberExtension: String,

    @get:JsonProperty("postal_code", required=true)@field:JsonProperty("postal_code", required=true)
    val postalCode: String,

    @get:JsonProperty("sub_premise", required=true)@field:JsonProperty("sub_premise", required=true)
    val subPremise: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thoroughfare: String
)
