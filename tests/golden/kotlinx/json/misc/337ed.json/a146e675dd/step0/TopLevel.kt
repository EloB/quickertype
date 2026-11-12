// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

@file:UseSerializers(OffsetDateTimeSerializer::class)

package quicktype

import java.time.OffsetDateTime

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val count: Long,
    val facets: Facets,
    val limit: Long,
    val next: String,
    val offset: Long,
    val previous: Boolean,
    val results: List<Result>
)

@Serializable
class Facets()

@Serializable
data class Result (
    @SerialName("cost_absolute")
    val costAbsolute: Long? = null,

    @SerialName("cost_max")
    val costMax: Long? = null,

    @SerialName("cost_min")
    val costMin: Long? = null,

    @SerialName("created_at")
    val createdAt: String,

    val customIncomes: List<CustomIncome>,

    @SerialName("direct_rep_costs_max")
    val directRepCostsMax: JsonElement? = null,

    @SerialName("direct_rep_costs_min")
    val directRepCostsMin: JsonElement? = null,

    @SerialName("end_date")
    val endDate: OffsetDateTime,

    @SerialName("eur_sources_grants")
    val eurSourcesGrants: Long,

    @SerialName("eur_sources_grants_src")
    val eurSourcesGrantsSrc: String? = null,

    @SerialName("eur_sources_procurement")
    val eurSourcesProcurement: Long,

    @SerialName("eur_sources_procurement_src")
    val eurSourcesProcurementSrc: String? = null,

    val id: String,

    @SerialName("new_organisation")
    val newOrganisation: JsonElement? = null,

    @SerialName("no_clients")
    val noClients: String? = null,

    @SerialName("other_financial_information")
    val otherFinancialInformation: String? = null,

    @SerialName("other_sources_contributions")
    val otherSourcesContributions: Long? = null,

    @SerialName("other_sources_donation")
    val otherSourcesDonation: Long? = null,

    @SerialName("other_sources_total")
    val otherSourcesTotal: Long? = null,

    @SerialName("public_financing_infranational")
    val publicFinancingInfranational: Long? = null,

    @SerialName("public_financing_national")
    val publicFinancingNational: Long? = null,

    @SerialName("public_financing_total")
    val publicFinancingTotal: Long? = null,

    val representative: String,

    @SerialName("start_date")
    val startDate: OffsetDateTime,

    val status: Status,

    @SerialName("total_budget")
    val totalBudget: Long? = null,

    @SerialName("turnover_absolute")
    val turnoverAbsolute: Long? = null,

    @SerialName("turnover_max")
    val turnoverMax: Long? = null,

    @SerialName("turnover_min")
    val turnoverMin: Long? = null,

    val type: ResultType,

    @SerialName("updated_at")
    val updatedAt: String,

    val uri: String
)

@Serializable
data class CustomIncome (
    val amount: Long,

    @SerialName("created_at")
    val createdAt: OffsetDateTime,

    val id: String,
    val name: String,
    val status: Status,
    val type: CustomIncomeType,

    @SerialName("updated_at")
    val updatedAt: String,

    val uri: String
)

@Serializable
enum class Status(val value: String) {
    @SerialName("active") Active("active"),
    @SerialName("inactive") Inactive("inactive");
}

@Serializable
enum class CustomIncomeType(val value: String) {
    @SerialName("public") Public("public"),
    @SerialName("other") Other("other");
}

@Serializable
enum class ResultType(val value: String) {
    @SerialName("FinancialDataNGO") FinancialDataNGO("FinancialDataNGO"),
    @SerialName("FinancialDataLawyer") FinancialDataLawyer("FinancialDataLawyer"),
    @SerialName("FinancialDataTradeAssociation") FinancialDataTradeAssociation("FinancialDataTradeAssociation");
}

object OffsetDateTimeSerializer : KSerializer<OffsetDateTime> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("OffsetDateTime", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): OffsetDateTime = OffsetDateTime.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: OffsetDateTime) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(value))
    }
}
