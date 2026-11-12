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


@Suppress("UNCHECKED_CAST")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {
    addSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {
            override fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
    })
    addDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {
            override fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree())
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    convert(FormatEnum::class, { FormatEnum.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(In::class,         { In.fromValue(it.asText()) },         { ObjectMapper().writeValueAsString(it.value) })
    convert(SchemaType::class, { SchemaType.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
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
    @get:JsonProperty("Article", required=true)@field:JsonProperty("Article", required=true)
    val article: Article,

    @get:JsonProperty("Center", required=true)@field:JsonProperty("Center", required=true)
    val center: Article,

    @get:JsonProperty("DeMinimis", required=true)@field:JsonProperty("DeMinimis", required=true)
    val deMinimis: DeMinimis,

    @get:JsonProperty("Event", required=true)@field:JsonProperty("Event", required=true)
    val event: Article,

    @get:JsonProperty("FAQ", required=true)@field:JsonProperty("FAQ", required=true)
    val faq: FAQ,

    @get:JsonProperty("Lead", required=true)@field:JsonProperty("Lead", required=true)
    val lead: Article,

    @get:JsonProperty("List", required=true)@field:JsonProperty("List", required=true)
    val list: Article,

    @get:JsonProperty("MarketIntelligence", required=true)@field:JsonProperty("MarketIntelligence", required=true)
    val marketIntelligence: Article,

    @get:JsonProperty("Office", required=true)@field:JsonProperty("Office", required=true)
    val office: Article,

    @get:JsonProperty("Provider", required=true)@field:JsonProperty("Provider", required=true)
    val provider: Article,

    @get:JsonProperty("Rate", required=true)@field:JsonProperty("Rate", required=true)
    val rate: Article,

    @get:JsonProperty("Report", required=true)@field:JsonProperty("Report", required=true)
    val report: Report,

    @get:JsonProperty("Taxonomy", required=true)@field:JsonProperty("Taxonomy", required=true)
    val taxonomy: Taxonomy
)

data class Article (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val properties: Map<String, Property>
)

data class Property (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: FormatEnum
)

enum class FormatEnum(val value: String) {
    TypeString("string");

    companion object {
        fun fromValue(value: String): FormatEnum = when (value) {
            "string" -> TypeString
            else     -> throw IllegalArgumentException()
        }
    }
}

data class DeMinimis (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val properties: DeMinimisProperties
)

data class DeMinimisProperties (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val countries: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val country: Property,

    @get:JsonProperty("de_minimis_currency", required=true)@field:JsonProperty("de_minimis_currency", required=true)
    val deMinimisCurrency: Property,

    @get:JsonProperty("de_minimis_value", required=true)@field:JsonProperty("de_minimis_value", required=true)
    val deMinimisValue: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val notes: Property,

    @get:JsonProperty("vat_amount", required=true)@field:JsonProperty("vat_amount", required=true)
    val vatAmount: Property,

    @get:JsonProperty("vat_currency", required=true)@field:JsonProperty("vat_currency", required=true)
    val vatCurrency: Property
)

data class FAQ (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val properties: FAQProperties
)

data class FAQProperties (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val answer: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val countries: Property,

    @get:JsonProperty("first_published_date", required=true)@field:JsonProperty("first_published_date", required=true)
    val firstPublishedDate: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val industries: Property,

    @get:JsonProperty("last_published_date", required=true)@field:JsonProperty("last_published_date", required=true)
    val lastPublishedDate: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val question: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val topics: Property,

    @get:JsonProperty("trade_regions", required=true)@field:JsonProperty("trade_regions", required=true)
    val tradeRegions: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: Property,

    @get:JsonProperty("world_regions", required=true)@field:JsonProperty("world_regions", required=true)
    val worldRegions: Property
)

data class Report (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val properties: ReportProperties
)

data class ReportProperties (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val countries: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: Property,

    @get:JsonProperty("expiration_date", required=true)@field:JsonProperty("expiration_date", required=true)
    val expirationDate: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val industries: Property,

    @get:JsonProperty("ita_industries", required=true)@field:JsonProperty("ita_industries", required=true)
    val itaIndustries: Property,

    @get:JsonProperty("report_type", required=true)@field:JsonProperty("report_type", required=true)
    val reportType: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: Property
)

data class Taxonomy (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val properties: TaxonomyProperties
)

data class TaxonomyProperties (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val annotations: Property,

    @get:JsonProperty("datatype_properties", required=true)@field:JsonProperty("datatype_properties", required=true)
    val datatypeProperties: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val label: Property,

    @get:JsonProperty("sub_class_of", required=true)@field:JsonProperty("sub_class_of", required=true)
    val subClassOf: Property,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: Property
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
    @get:JsonProperty("/business_service_providers/search", required=true)@field:JsonProperty("/business_service_providers/search", required=true)
    val businessServiceProvidersSearch: BusinessServiceProvidersSearchClass,

    @get:JsonProperty("/consolidated_screening_list/search", required=true)@field:JsonProperty("/consolidated_screening_list/search", required=true)
    val consolidatedScreeningListSearch: ConsolidatedScreeningListSearchClass,

    @get:JsonProperty("/de_minimis/search", required=true)@field:JsonProperty("/de_minimis/search", required=true)
    val deMinimisSearch: ConsolidatedScreeningListSearchClass,

    @get:JsonProperty("/ita_faqs/search", required=true)@field:JsonProperty("/ita_faqs/search", required=true)
    val itaFaqsSearch: ConsolidatedScreeningListSearchClass,

    @get:JsonProperty("/ita_office_locations/search", required=true)@field:JsonProperty("/ita_office_locations/search", required=true)
    val itaOfficeLocationsSearch: ConsolidatedScreeningListSearchClass,

    @get:JsonProperty("/ita_taxonomies/search", required=true)@field:JsonProperty("/ita_taxonomies/search", required=true)
    val itaTaxonomiesSearch: BusinessServiceProvidersSearchClass,

    @get:JsonProperty("/ita_zipcode_to_post/search", required=true)@field:JsonProperty("/ita_zipcode_to_post/search", required=true)
    val itaZipcodeToPostSearch: BusinessServiceProvidersSearchClass,

    @get:JsonProperty("/market_intelligence/search", required=true)@field:JsonProperty("/market_intelligence/search", required=true)
    val marketIntelligenceSearch: ConsolidatedScreeningListSearchClass,

    @get:JsonProperty("/market_research_library/search", required=true)@field:JsonProperty("/market_research_library/search", required=true)
    val marketResearchLibrarySearch: ConsolidatedScreeningListSearchClass,

    @get:JsonProperty("/tariff_rates/search", required=true)@field:JsonProperty("/tariff_rates/search", required=true)
    val tariffRatesSearch: ConsolidatedScreeningListSearchClass,

    @get:JsonProperty("/trade_articles/search", required=true)@field:JsonProperty("/trade_articles/search", required=true)
    val tradeArticlesSearch: ConsolidatedScreeningListSearchClass,

    @get:JsonProperty("/trade_events/search", required=true)@field:JsonProperty("/trade_events/search", required=true)
    val tradeEventsSearch: ConsolidatedScreeningListSearchClass,

    @get:JsonProperty("/trade_leads/search", required=true)@field:JsonProperty("/trade_leads/search", required=true)
    val tradeLeadsSearch: ConsolidatedScreeningListSearchClass
)

data class BusinessServiceProvidersSearchClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val get: BusinessServiceProvidersSearchGet
)

data class BusinessServiceProvidersSearchGet (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val parameters: List<Parameter>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val responses: PurpleResponses,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val summary: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tags: List<String>
)

data class Parameter (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val format: FormatEnum,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty("in", required=true)@field:JsonProperty("in", required=true)
    val parameterIn: In,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val required: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: FormatEnum
)

enum class In(val value: String) {
    Query("query");

    companion object {
        fun fromValue(value: String): In = when (value) {
            "query" -> Query
            else    -> throw IllegalArgumentException()
        }
    }
}

data class PurpleResponses (
    @get:JsonProperty("200", required=true)@field:JsonProperty("200", required=true)
    val the200: Purple200
)

data class Purple200 (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val schema: ItemsClass
)

data class ItemsClass (
    @get:JsonProperty("\$ref", required=true)@field:JsonProperty("\$ref", required=true)
    val ref: String
)

data class ConsolidatedScreeningListSearchClass (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val get: ConsolidatedScreeningListSearchGet
)

data class ConsolidatedScreeningListSearchGet (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val parameters: List<Parameter>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val responses: FluffyResponses,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val summary: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tags: List<String>
)

data class FluffyResponses (
    @get:JsonProperty("200", required=true)@field:JsonProperty("200", required=true)
    val the200: Fluffy200
)

data class Fluffy200 (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val schema: PurpleSchema
)

data class PurpleSchema (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val items: ItemsClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: SchemaType
)

enum class SchemaType(val value: String) {
    TypeArray("array");

    companion object {
        fun fromValue(value: String): SchemaType = when (value) {
            "array" -> TypeArray
            else    -> throw IllegalArgumentException()
        }
    }
}
