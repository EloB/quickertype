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

class TopLevel(elements: Collection<TopLevelElement> = emptyList()) : ArrayList<TopLevelElement>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val identifiers: List<Identifier>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val keywords: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val links: List<Link>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty("other_names", required=true)@field:JsonProperty("other_names", required=true)
    val otherNames: List<Any?>,

    @get:JsonProperty("superseded_by", required=true)@field:JsonProperty("superseded_by", required=true)
    val supersededBy: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val text: List<Text>
)

data class Identifier (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val identifier: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scheme: String
)

data class Link (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val note: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

data class Text (
    @get:JsonProperty("media_type", required=true)@field:JsonProperty("media_type", required=true)
    val mediaType: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)
