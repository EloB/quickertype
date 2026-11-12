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
    val git: List<String>,

    @get:JsonProperty("github_services_sha", required=true)@field:JsonProperty("github_services_sha", required=true)
    val githubServicesSHA: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hooks: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val importer: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pages: List<String>,

    @get:JsonProperty("verifiable_password_authentication", required=true)@field:JsonProperty("verifiable_password_authentication", required=true)
    val verifiablePasswordAuthentication: Boolean
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}
