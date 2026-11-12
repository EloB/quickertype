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

class TopLevel(elements: Collection<TopLevelElement> = emptyList()) : ArrayList<TopLevelElement>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val category: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val context: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val location: Location,

    @get:JsonProperty("location_subtype", required=true)@field:JsonProperty("location_subtype", required=true)
    val locationSubtype: String,

    @get:JsonProperty("location_type", required=true)@field:JsonProperty("location_type", required=true)
    val locationType: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val month: String,

    @get:JsonProperty("outcome_status", required=true)@field:JsonProperty("outcome_status", required=true)
    val outcomeStatus: OutcomeStatus,

    @get:JsonProperty("persistent_id", required=true)@field:JsonProperty("persistent_id", required=true)
    val persistentID: String
)

data class Location (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val latitude: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val longitude: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val street: Street
)

data class Street (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String
)

data class OutcomeStatus (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val category: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val date: String
)
