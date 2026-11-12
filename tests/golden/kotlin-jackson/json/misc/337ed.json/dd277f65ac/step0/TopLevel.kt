// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

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
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(OffsetDateTime::class,   { OffsetDateTime.parse(it.asText()) },       { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    convert(Status::class,           { Status.fromValue(it.asText()) },           { ObjectMapper().writeValueAsString(it.value) })
    convert(CustomIncomeType::class, { CustomIncomeType.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(ResultType::class,       { ResultType.fromValue(it.asText()) },       { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val count: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val facets: Facets,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val limit: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val next: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val offset: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val previous: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val results: List<Result>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

typealias Facets = ObjectNode

data class Result (
    @get:JsonProperty("cost_absolute", required=true)@field:JsonProperty("cost_absolute", required=true)
    val costAbsolute: Long?,

    @get:JsonProperty("cost_max", required=true)@field:JsonProperty("cost_max", required=true)
    val costMax: Long?,

    @get:JsonProperty("cost_min", required=true)@field:JsonProperty("cost_min", required=true)
    val costMin: Long?,

    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val customIncomes: List<CustomIncome>,

    @get:JsonProperty("direct_rep_costs_max", required=true)@field:JsonProperty("direct_rep_costs_max", required=true)
    val directRepCostsMax: Any? = null,

    @get:JsonProperty("direct_rep_costs_min", required=true)@field:JsonProperty("direct_rep_costs_min", required=true)
    val directRepCostsMin: Any? = null,

    @get:JsonProperty("end_date", required=true)@field:JsonProperty("end_date", required=true)
    val endDate: OffsetDateTime,

    @get:JsonProperty("eur_sources_grants", required=true)@field:JsonProperty("eur_sources_grants", required=true)
    val eurSourcesGrants: Long,

    @get:JsonProperty("eur_sources_grants_src", required=true)@field:JsonProperty("eur_sources_grants_src", required=true)
    val eurSourcesGrantsSrc: String?,

    @get:JsonProperty("eur_sources_procurement", required=true)@field:JsonProperty("eur_sources_procurement", required=true)
    val eurSourcesProcurement: Long,

    @get:JsonProperty("eur_sources_procurement_src", required=true)@field:JsonProperty("eur_sources_procurement_src", required=true)
    val eurSourcesProcurementSrc: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty("new_organisation", required=true)@field:JsonProperty("new_organisation", required=true)
    val newOrganisation: Any? = null,

    @get:JsonProperty("no_clients", required=true)@field:JsonProperty("no_clients", required=true)
    val noClients: String?,

    @get:JsonProperty("other_financial_information", required=true)@field:JsonProperty("other_financial_information", required=true)
    val otherFinancialInformation: String?,

    @get:JsonProperty("other_sources_contributions", required=true)@field:JsonProperty("other_sources_contributions", required=true)
    val otherSourcesContributions: Long?,

    @get:JsonProperty("other_sources_donation", required=true)@field:JsonProperty("other_sources_donation", required=true)
    val otherSourcesDonation: Long?,

    @get:JsonProperty("other_sources_total", required=true)@field:JsonProperty("other_sources_total", required=true)
    val otherSourcesTotal: Long?,

    @get:JsonProperty("public_financing_infranational", required=true)@field:JsonProperty("public_financing_infranational", required=true)
    val publicFinancingInfranational: Long?,

    @get:JsonProperty("public_financing_national", required=true)@field:JsonProperty("public_financing_national", required=true)
    val publicFinancingNational: Long?,

    @get:JsonProperty("public_financing_total", required=true)@field:JsonProperty("public_financing_total", required=true)
    val publicFinancingTotal: Long?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val representative: String,

    @get:JsonProperty("start_date", required=true)@field:JsonProperty("start_date", required=true)
    val startDate: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Status,

    @get:JsonProperty("total_budget", required=true)@field:JsonProperty("total_budget", required=true)
    val totalBudget: Long?,

    @get:JsonProperty("turnover_absolute", required=true)@field:JsonProperty("turnover_absolute", required=true)
    val turnoverAbsolute: Long?,

    @get:JsonProperty("turnover_max", required=true)@field:JsonProperty("turnover_max", required=true)
    val turnoverMax: Long?,

    @get:JsonProperty("turnover_min", required=true)@field:JsonProperty("turnover_min", required=true)
    val turnoverMin: Long?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: ResultType,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uri: String
)

data class CustomIncome (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val amount: Long,

    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: OffsetDateTime,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Status,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: CustomIncomeType,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uri: String
)

enum class Status(val value: String) {
    Active("active"),
    Inactive("inactive");

    companion object {
        fun fromValue(value: String): Status = when (value) {
            "active"   -> Active
            "inactive" -> Inactive
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class CustomIncomeType(val value: String) {
    Public("public"),
    Other("other");

    companion object {
        fun fromValue(value: String): CustomIncomeType = when (value) {
            "public" -> Public
            "other"  -> Other
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class ResultType(val value: String) {
    FinancialDataNGO("FinancialDataNGO"),
    FinancialDataLawyer("FinancialDataLawyer"),
    FinancialDataTradeAssociation("FinancialDataTradeAssociation");

    companion object {
        fun fromValue(value: String): ResultType = when (value) {
            "FinancialDataNGO"              -> FinancialDataNGO
            "FinancialDataLawyer"           -> FinancialDataLawyer
            "FinancialDataTradeAssociation" -> FinancialDataTradeAssociation
            else                            -> throw IllegalArgumentException()
        }
    }
}
