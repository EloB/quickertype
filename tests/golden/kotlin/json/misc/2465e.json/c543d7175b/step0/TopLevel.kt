// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val basePath: String,
    val definitions: Definitions,
    val host: String,
    val info: Info,
    val paths: Paths,
    val produces: List<String>,
    val schemes: List<String>,
    val swagger: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Definitions (
    @Json(name = "Taxonomy")
    val taxonomy: Taxonomy
)

data class Taxonomy (
    val properties: Properties
)

data class Properties (
    val annotations: Annotations,

    @Json(name = "datatype_properties")
    val datatypeProperties: Annotations,

    val id: Annotations,
    val label: Annotations,

    @Json(name = "sub_class_of")
    val subClassOf: Annotations,

    val type: Annotations
)

data class Annotations (
    val description: String,
    val type: String
)

data class Info (
    val description: String,
    val title: String,
    val version: String
)

data class Paths (
    @Json(name = "/ita_taxonomies/search")
    val itaTaxonomiesSearch: ItaTaxonomiesSearch
)

data class ItaTaxonomiesSearch (
    val get: Get
)

data class Get (
    val description: String,
    val parameters: List<Parameter>,
    val responses: Responses,
    val summary: String,
    val tags: List<String>
)

data class Parameter (
    val description: String,
    val format: String,
    val name: String,

    @Json(name = "in")
    val parameterIn: String,

    val required: Boolean,
    val type: String
)

data class Responses (
    @Json(name = "200")
    val the200: The200
)

data class The200 (
    val description: String,
    val schema: Schema
)

data class Schema (
    @Json(name = "\$ref")
    val ref: String
)
