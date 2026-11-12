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
    val basePath: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val definitions: Definitions,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val host: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val info: Info,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val paths: Paths,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val produces: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val schemes: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val swagger: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Definitions (
    @get:JsonProperty("Taxonomy", required=true)@field:JsonProperty("Taxonomy", required=true)
    val taxonomy: Taxonomy
)

data class Taxonomy (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val properties: Properties
)

data class Properties (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val annotations: Annotations,

    @get:JsonProperty("datatype_properties", required=true)@field:JsonProperty("datatype_properties", required=true)
    val datatypeProperties: Annotations,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Annotations,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val label: Annotations,

    @get:JsonProperty("sub_class_of", required=true)@field:JsonProperty("sub_class_of", required=true)
    val subClassOf: Annotations,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Annotations
)

data class Annotations (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class Info (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val version: String
)

data class Paths (
    @get:JsonProperty("/ita_taxonomies/search", required=true)@field:JsonProperty("/ita_taxonomies/search", required=true)
    val itaTaxonomiesSearch: ItaTaxonomiesSearch
)

data class ItaTaxonomiesSearch (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val get: Get
)

data class Get (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val parameters: List<Parameter>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val responses: Responses,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val summary: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tags: List<String>
)

data class Parameter (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val format: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty("in", required=true)@field:JsonProperty("in", required=true)
    val parameterIn: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val required: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class Responses (
    @get:JsonProperty("200", required=true)@field:JsonProperty("200", required=true)
    val the200: The200
)

data class The200 (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val schema: Schema
)

data class Schema (
    @get:JsonProperty("\$ref", required=true)@field:JsonProperty("\$ref", required=true)
    val ref: String
)
