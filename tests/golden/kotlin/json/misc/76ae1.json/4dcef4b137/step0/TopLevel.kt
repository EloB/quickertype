// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(FormatEnum::class, { FormatEnum.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(In::class,         { In.fromValue(it.string!!) },         { Klaxon().toJsonString(it.value) })
    .convert(SchemaType::class, { SchemaType.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

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
    @Json(name = "Article")
    val article: Article,

    @Json(name = "Center")
    val center: Article,

    @Json(name = "DeMinimis")
    val deMinimis: DeMinimis,

    @Json(name = "Event")
    val event: Article,

    @Json(name = "FAQ")
    val faq: FAQ,

    @Json(name = "Lead")
    val lead: Article,

    @Json(name = "List")
    val list: Article,

    @Json(name = "MarketIntelligence")
    val marketIntelligence: Article,

    @Json(name = "Office")
    val office: Article,

    @Json(name = "Provider")
    val provider: Article,

    @Json(name = "Rate")
    val rate: Article,

    @Json(name = "Report")
    val report: Report,

    @Json(name = "Taxonomy")
    val taxonomy: Taxonomy
)

data class Article (
    val properties: Map<String, Property>
)

data class Property (
    val description: String,
    val type: FormatEnum
)

enum class FormatEnum(val value: String) {
    TypeString("string");

    companion object {
        public fun fromValue(value: String): FormatEnum = when (value) {
            "string" -> TypeString
            else     -> throw IllegalArgumentException()
        }
    }
}

data class DeMinimis (
    val properties: DeMinimisProperties
)

data class DeMinimisProperties (
    val countries: Property,
    val country: Property,

    @Json(name = "de_minimis_currency")
    val deMinimisCurrency: Property,

    @Json(name = "de_minimis_value")
    val deMinimisValue: Property,

    val notes: Property,

    @Json(name = "vat_amount")
    val vatAmount: Property,

    @Json(name = "vat_currency")
    val vatCurrency: Property
)

data class FAQ (
    val properties: FAQProperties
)

data class FAQProperties (
    val answer: Property,
    val countries: Property,

    @Json(name = "first_published_date")
    val firstPublishedDate: Property,

    val id: Property,
    val industries: Property,

    @Json(name = "last_published_date")
    val lastPublishedDate: Property,

    val question: Property,
    val topics: Property,

    @Json(name = "trade_regions")
    val tradeRegions: Property,

    val url: Property,

    @Json(name = "world_regions")
    val worldRegions: Property
)

data class Report (
    val properties: ReportProperties
)

data class ReportProperties (
    val countries: Property,
    val description: Property,

    @Json(name = "expiration_date")
    val expirationDate: Property,

    val id: Property,
    val industries: Property,

    @Json(name = "ita_industries")
    val itaIndustries: Property,

    @Json(name = "report_type")
    val reportType: Property,

    val title: Property,
    val url: Property
)

data class Taxonomy (
    val properties: TaxonomyProperties
)

data class TaxonomyProperties (
    val annotations: Property,

    @Json(name = "datatype_properties")
    val datatypeProperties: Property,

    val id: Property,
    val label: Property,

    @Json(name = "sub_class_of")
    val subClassOf: Property,

    val type: Property
)

data class Info (
    val description: String,
    val title: String,
    val version: String
)

data class Paths (
    @Json(name = "/business_service_providers/search")
    val businessServiceProvidersSearch: BusinessServiceProvidersSearchClass,

    @Json(name = "/consolidated_screening_list/search")
    val consolidatedScreeningListSearch: ConsolidatedScreeningListSearchClass,

    @Json(name = "/de_minimis/search")
    val deMinimisSearch: ConsolidatedScreeningListSearchClass,

    @Json(name = "/ita_faqs/search")
    val itaFaqsSearch: ConsolidatedScreeningListSearchClass,

    @Json(name = "/ita_office_locations/search")
    val itaOfficeLocationsSearch: ConsolidatedScreeningListSearchClass,

    @Json(name = "/ita_taxonomies/search")
    val itaTaxonomiesSearch: BusinessServiceProvidersSearchClass,

    @Json(name = "/ita_zipcode_to_post/search")
    val itaZipcodeToPostSearch: BusinessServiceProvidersSearchClass,

    @Json(name = "/market_intelligence/search")
    val marketIntelligenceSearch: ConsolidatedScreeningListSearchClass,

    @Json(name = "/market_research_library/search")
    val marketResearchLibrarySearch: ConsolidatedScreeningListSearchClass,

    @Json(name = "/tariff_rates/search")
    val tariffRatesSearch: ConsolidatedScreeningListSearchClass,

    @Json(name = "/trade_articles/search")
    val tradeArticlesSearch: ConsolidatedScreeningListSearchClass,

    @Json(name = "/trade_events/search")
    val tradeEventsSearch: ConsolidatedScreeningListSearchClass,

    @Json(name = "/trade_leads/search")
    val tradeLeadsSearch: ConsolidatedScreeningListSearchClass
)

data class BusinessServiceProvidersSearchClass (
    val get: BusinessServiceProvidersSearchGet
)

data class BusinessServiceProvidersSearchGet (
    val description: String,
    val parameters: List<Parameter>,
    val responses: PurpleResponses,
    val summary: String,
    val tags: List<String>
)

data class Parameter (
    val description: String,
    val format: FormatEnum,
    val name: String,

    @Json(name = "in")
    val parameterIn: In,

    val required: Boolean,
    val type: FormatEnum
)

enum class In(val value: String) {
    Query("query");

    companion object {
        public fun fromValue(value: String): In = when (value) {
            "query" -> Query
            else    -> throw IllegalArgumentException()
        }
    }
}

data class PurpleResponses (
    @Json(name = "200")
    val the200: Purple200
)

data class Purple200 (
    val description: String,
    val schema: ItemsClass
)

data class ItemsClass (
    @Json(name = "\$ref")
    val ref: String
)

data class ConsolidatedScreeningListSearchClass (
    val get: ConsolidatedScreeningListSearchGet
)

data class ConsolidatedScreeningListSearchGet (
    val description: String,
    val parameters: List<Parameter>,
    val responses: FluffyResponses,
    val summary: String,
    val tags: List<String>
)

data class FluffyResponses (
    @Json(name = "200")
    val the200: Fluffy200
)

data class Fluffy200 (
    val description: String,
    val schema: PurpleSchema
)

data class PurpleSchema (
    val items: ItemsClass,
    val type: SchemaType
)

enum class SchemaType(val value: String) {
    TypeArray("array");

    companion object {
        public fun fromValue(value: String): SchemaType = when (value) {
            "array" -> TypeArray
            else    -> throw IllegalArgumentException()
        }
    }
}
