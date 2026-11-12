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
    @SerialName("Rate")
    val rate: Rate
)

@Serializable
data class Rate (
    val properties: Map<String, Property>
)

@Serializable
data class Property (
    val description: String,
    val type: Type
)

@Serializable
enum class Type(val value: String) {
    @SerialName("string") TypeString("string");
}

@Serializable
data class Info (
    val description: String,
    val title: String,
    val version: String
)

@Serializable
data class Paths (
    @SerialName("/tariff_rates/search")
    val tariffRatesSearch: TariffRatesSearch
)

@Serializable
data class TariffRatesSearch (
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
    val format: Type,
    val name: String,

    @SerialName("in")
    val parameterIn: String,

    val required: Boolean,
    val type: Type
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
    val items: Items,
    val type: String
)

@Serializable
data class Items (
    @SerialName("\$ref")
    val ref: String
)
