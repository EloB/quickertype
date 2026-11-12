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
    @SerialName("Report")
    val report: Report
)

@Serializable
data class Report (
    val properties: Properties
)

@Serializable
data class Properties (
    @SerialName("click_url")
    val clickURL: ClickURL,

    val country: ClickURL,
    val description: ClickURL,

    @SerialName("expiration_date")
    val expirationDate: ClickURL,

    val id: ClickURL,
    val industry: ClickURL,

    @SerialName("report_type")
    val reportType: ClickURL,

    @SerialName("source_industry")
    val sourceIndustry: ClickURL,

    val title: ClickURL,
    val url: ClickURL
)

@Serializable
data class ClickURL (
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
    @SerialName("/market_research_library/search")
    val marketResearchLibrarySearch: MarketResearchLibrarySearch
)

@Serializable
data class MarketResearchLibrarySearch (
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
