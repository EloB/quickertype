// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(OffsetDateTime::class,   { OffsetDateTime.parse(it.string!!) },       { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    .convert(JsonObject::class,       { it.obj!! },                                { it.toJsonString() })
    .convert(Status::class,           { Status.fromValue(it.string!!) },           { Klaxon().toJsonString(it.value) })
    .convert(CustomIncomeType::class, { CustomIncomeType.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(ResultType::class,       { ResultType.fromValue(it.string!!) },       { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val count: Long,
    val facets: Facets,
    val limit: Long,
    val next: String,
    val offset: Long,
    val previous: Boolean,
    val results: List<Result>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

typealias Facets = JsonObject

data class Result (
    @Json(name = "cost_absolute")
    val costAbsolute: Long? = null,

    @Json(name = "cost_max")
    val costMax: Long? = null,

    @Json(name = "cost_min")
    val costMin: Long? = null,

    @Json(name = "created_at")
    val createdAt: String,

    val customIncomes: List<CustomIncome>,

    @Json(name = "direct_rep_costs_max")
    val directRepCostsMax: Any? = null,

    @Json(name = "direct_rep_costs_min")
    val directRepCostsMin: Any? = null,

    @Json(name = "end_date")
    val endDate: OffsetDateTime,

    @Json(name = "eur_sources_grants")
    val eurSourcesGrants: Long,

    @Json(name = "eur_sources_grants_src")
    val eurSourcesGrantsSrc: String? = null,

    @Json(name = "eur_sources_procurement")
    val eurSourcesProcurement: Long,

    @Json(name = "eur_sources_procurement_src")
    val eurSourcesProcurementSrc: String? = null,

    val id: String,

    @Json(name = "new_organisation")
    val newOrganisation: Any? = null,

    @Json(name = "no_clients")
    val noClients: String? = null,

    @Json(name = "other_financial_information")
    val otherFinancialInformation: String? = null,

    @Json(name = "other_sources_contributions")
    val otherSourcesContributions: Long? = null,

    @Json(name = "other_sources_donation")
    val otherSourcesDonation: Long? = null,

    @Json(name = "other_sources_total")
    val otherSourcesTotal: Long? = null,

    @Json(name = "public_financing_infranational")
    val publicFinancingInfranational: Long? = null,

    @Json(name = "public_financing_national")
    val publicFinancingNational: Long? = null,

    @Json(name = "public_financing_total")
    val publicFinancingTotal: Long? = null,

    val representative: String,

    @Json(name = "start_date")
    val startDate: OffsetDateTime,

    val status: Status,

    @Json(name = "total_budget")
    val totalBudget: Long? = null,

    @Json(name = "turnover_absolute")
    val turnoverAbsolute: Long? = null,

    @Json(name = "turnover_max")
    val turnoverMax: Long? = null,

    @Json(name = "turnover_min")
    val turnoverMin: Long? = null,

    val type: ResultType,

    @Json(name = "updated_at")
    val updatedAt: String,

    val uri: String
)

data class CustomIncome (
    val amount: Long,

    @Json(name = "created_at")
    val createdAt: OffsetDateTime,

    val id: String,
    val name: String,
    val status: Status,
    val type: CustomIncomeType,

    @Json(name = "updated_at")
    val updatedAt: String,

    val uri: String
)

enum class Status(val value: String) {
    Active("active"),
    Inactive("inactive");

    companion object {
        public fun fromValue(value: String): Status = when (value) {
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
        public fun fromValue(value: String): CustomIncomeType = when (value) {
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
        public fun fromValue(value: String): ResultType = when (value) {
            "FinancialDataNGO"              -> FinancialDataNGO
            "FinancialDataLawyer"           -> FinancialDataLawyer
            "FinancialDataTradeAssociation" -> FinancialDataTradeAssociation
            else                            -> throw IllegalArgumentException()
        }
    }
}
