// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val basePath: String,
    val definitions: Definitions,
    val host: String,
    val info: Info,
    val paths: Paths,
    val produces: List<String>,
    val schemes: List<String>,
    val swagger: String
)

@Serializable
data class Definitions (
    @SerialName("Taxonomy")
    val taxonomy: Taxonomy
)

@Serializable
data class Taxonomy (
    val properties: Properties
)

@Serializable
data class Properties (
    val annotations: Annotations,

    @SerialName("datatype_properties")
    val datatypeProperties: Annotations,

    val id: Annotations,
    val label: Annotations,

    @SerialName("sub_class_of")
    val subClassOf: Annotations,

    val type: Annotations
)

@Serializable
data class Annotations (
    val description: String,
    val type: String
)

@Serializable
data class Info (
    val description: String,
    val title: String,
    val version: String
)

@Serializable
data class Paths (
    @SerialName("/ita_taxonomies/search")
    val itaTaxonomiesSearch: ItaTaxonomiesSearch
)

@Serializable
data class ItaTaxonomiesSearch (
    val get: Get
)

@Serializable
data class Get (
    val description: String,
    val parameters: List<Parameter>,
    val responses: Responses,
    val summary: String,
    val tags: List<String>
)

@Serializable
data class Parameter (
    val description: String,
    val format: String,
    val name: String,

    @SerialName("in")
    val parameterIn: String,

    val required: Boolean,
    val type: String
)

@Serializable
data class Responses (
    @SerialName("200")
    val the200: The200
)

@Serializable
data class The200 (
    val description: String,
    val schema: Schema
)

@Serializable
data class Schema (
    @SerialName("\$ref")
    val ref: String
)
