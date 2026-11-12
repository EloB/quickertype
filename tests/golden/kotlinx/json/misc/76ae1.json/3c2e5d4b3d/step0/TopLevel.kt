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
    @SerialName("Article")
    val article: Article,

    @SerialName("Center")
    val center: Article,

    @SerialName("DeMinimis")
    val deMinimis: DeMinimis,

    @SerialName("Event")
    val event: Article,

    @SerialName("FAQ")
    val faq: FAQ,

    @SerialName("Lead")
    val lead: Article,

    @SerialName("List")
    val list: Article,

    @SerialName("MarketIntelligence")
    val marketIntelligence: Article,

    @SerialName("Office")
    val office: Article,

    @SerialName("Provider")
    val provider: Article,

    @SerialName("Rate")
    val rate: Article,

    @SerialName("Report")
    val report: Report,

    @SerialName("Taxonomy")
    val taxonomy: Taxonomy
)

@Serializable
data class Article (
    val properties: Map<String, Property>
)

@Serializable
data class Property (
    val description: String,
    val type: FormatEnum
)

@Serializable
enum class FormatEnum(val value: String) {
    @SerialName("string") TypeString("string");
}

@Serializable
data class DeMinimis (
    val properties: DeMinimisProperties
)

@Serializable
data class DeMinimisProperties (
    val countries: Property,
    val country: Property,

    @SerialName("de_minimis_currency")
    val deMinimisCurrency: Property,

    @SerialName("de_minimis_value")
    val deMinimisValue: Property,

    val notes: Property,

    @SerialName("vat_amount")
    val vatAmount: Property,

    @SerialName("vat_currency")
    val vatCurrency: Property
)

@Serializable
data class FAQ (
    val properties: FAQProperties
)

@Serializable
data class FAQProperties (
    val answer: Property,
    val countries: Property,

    @SerialName("first_published_date")
    val firstPublishedDate: Property,

    val id: Property,
    val industries: Property,

    @SerialName("last_published_date")
    val lastPublishedDate: Property,

    val question: Property,
    val topics: Property,

    @SerialName("trade_regions")
    val tradeRegions: Property,

    val url: Property,

    @SerialName("world_regions")
    val worldRegions: Property
)

@Serializable
data class Report (
    val properties: ReportProperties
)

@Serializable
data class ReportProperties (
    val countries: Property,
    val description: Property,

    @SerialName("expiration_date")
    val expirationDate: Property,

    val id: Property,
    val industries: Property,

    @SerialName("ita_industries")
    val itaIndustries: Property,

    @SerialName("report_type")
    val reportType: Property,

    val title: Property,
    val url: Property
)

@Serializable
data class Taxonomy (
    val properties: TaxonomyProperties
)

@Serializable
data class TaxonomyProperties (
    val annotations: Property,

    @SerialName("datatype_properties")
    val datatypeProperties: Property,

    val id: Property,
    val label: Property,

    @SerialName("sub_class_of")
    val subClassOf: Property,

    val type: Property
)

@Serializable
data class Info (
    val description: String,
    val title: String,
    val version: String
)

@Serializable
data class Paths (
    @SerialName("/business_service_providers/search")
    val businessServiceProvidersSearch: BusinessServiceProvidersSearchClass,

    @SerialName("/consolidated_screening_list/search")
    val consolidatedScreeningListSearch: ConsolidatedScreeningListSearchClass,

    @SerialName("/de_minimis/search")
    val deMinimisSearch: ConsolidatedScreeningListSearchClass,

    @SerialName("/ita_faqs/search")
    val itaFaqsSearch: ConsolidatedScreeningListSearchClass,

    @SerialName("/ita_office_locations/search")
    val itaOfficeLocationsSearch: ConsolidatedScreeningListSearchClass,

    @SerialName("/ita_taxonomies/search")
    val itaTaxonomiesSearch: BusinessServiceProvidersSearchClass,

    @SerialName("/ita_zipcode_to_post/search")
    val itaZipcodeToPostSearch: BusinessServiceProvidersSearchClass,

    @SerialName("/market_intelligence/search")
    val marketIntelligenceSearch: ConsolidatedScreeningListSearchClass,

    @SerialName("/market_research_library/search")
    val marketResearchLibrarySearch: ConsolidatedScreeningListSearchClass,

    @SerialName("/tariff_rates/search")
    val tariffRatesSearch: ConsolidatedScreeningListSearchClass,

    @SerialName("/trade_articles/search")
    val tradeArticlesSearch: ConsolidatedScreeningListSearchClass,

    @SerialName("/trade_events/search")
    val tradeEventsSearch: ConsolidatedScreeningListSearchClass,

    @SerialName("/trade_leads/search")
    val tradeLeadsSearch: ConsolidatedScreeningListSearchClass
)

@Serializable
data class BusinessServiceProvidersSearchClass (
    val get: BusinessServiceProvidersSearchGet
)

@Serializable
data class BusinessServiceProvidersSearchGet (
    val description: String,
    val parameters: List<Parameter>,
    val responses: PurpleResponses,
    val summary: String,
    val tags: List<String>
)

@Serializable
data class Parameter (
    val description: String,
    val format: FormatEnum,
    val name: String,

    @SerialName("in")
    val parameterIn: In,

    val required: Boolean,
    val type: FormatEnum
)

@Serializable
enum class In(val value: String) {
    @SerialName("query") Query("query");
}

@Serializable
data class PurpleResponses (
    @SerialName("200")
    val the200: Purple200
)

@Serializable
data class Purple200 (
    val description: String,
    val schema: ItemsClass
)

@Serializable
data class ItemsClass (
    @SerialName("\$ref")
    val ref: String
)

@Serializable
data class ConsolidatedScreeningListSearchClass (
    val get: ConsolidatedScreeningListSearchGet
)

@Serializable
data class ConsolidatedScreeningListSearchGet (
    val description: String,
    val parameters: List<Parameter>,
    val responses: FluffyResponses,
    val summary: String,
    val tags: List<String>
)

@Serializable
data class FluffyResponses (
    @SerialName("200")
    val the200: Fluffy200
)

@Serializable
data class Fluffy200 (
    val description: String,
    val schema: PurpleSchema
)

@Serializable
data class PurpleSchema (
    val items: ItemsClass,
    val type: SchemaType
)

@Serializable
enum class SchemaType(val value: String) {
    @SerialName("array") TypeArray("array");
}
