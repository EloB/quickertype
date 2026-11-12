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
    val acronym: String? = null,

    @SerialName("activity_consult_committees")
    val activityConsultCommittees: String,

    @SerialName("activity_eu_legislative")
    val activityEuLegislative: String,

    @SerialName("activity_expert_groups")
    val activityExpertGroups: String,

    @SerialName("activity_high_level_groups")
    val activityHighLevelGroups: String,

    @SerialName("activity_industry_forums")
    val activityIndustryForums: String,

    @SerialName("activity_inter_groups")
    val activityInterGroups: String,

    @SerialName("activity_other")
    val activityOther: String? = null,

    @SerialName("activity_relevant_comm")
    val activityRelevantComm: String,

    @SerialName("be_office_country")
    val beOfficeCountry: String? = null,

    @SerialName("be_office_lat")
    val beOfficeLat: Double? = null,

    @SerialName("be_office_lon")
    val beOfficeLon: Double? = null,

    @SerialName("be_office_phone")
    val beOfficePhone: String? = null,

    @SerialName("be_office_post_code")
    val beOfficePostCode: String? = null,

    @SerialName("be_office_postbox")
    val beOfficePostbox: String? = null,

    @SerialName("be_office_street")
    val beOfficeStreet: String? = null,

    @SerialName("be_office_town")
    val beOfficeTown: String? = null,

    @SerialName("code_of_conduct")
    val codeOfConduct: String,

    @SerialName("contact_country")
    val contactCountry: Long,

    @SerialName("created_at")
    val createdAt: String,

    val entity: String,
    val goals: String,
    val head: String,

    @SerialName("head_office_country")
    val headOfficeCountry: String,

    @SerialName("head_office_lat")
    val headOfficeLat: Double? = null,

    @SerialName("head_office_lon")
    val headOfficeLon: Double? = null,

    @SerialName("head_office_phone")
    val headOfficePhone: String,

    @SerialName("head_office_post_code")
    val headOfficePostCode: String? = null,

    @SerialName("head_office_postbox")
    val headOfficePostbox: String? = null,

    @SerialName("head_office_street")
    val headOfficeStreet: String,

    @SerialName("head_office_town")
    val headOfficeTown: String,

    val id: String,

    @SerialName("identification_code")
    val identificationCode: String,

    @SerialName("info_members")
    val infoMembers: String,

    @SerialName("last_update_date")
    val lastUpdateDate: String,

    val legal: String,

    @SerialName("legal_status")
    val legalStatus: String,

    @SerialName("main_category")
    val mainCategory: Long,

    @SerialName("main_category_title")
    val mainCategoryTitle: String,

    val members: Long,

    @SerialName("members_100")
    val members100: Long? = null,

    @SerialName("members_25")
    val members25: Long? = null,

    @SerialName("members_50")
    val members50: Long? = null,

    @SerialName("members_75")
    val members75: Long? = null,

    @SerialName("members_fte")
    val membersFte: Double,

    val name: String,

    @SerialName("native_name")
    val nativeName: JsonElement? = null,

    val networking: String? = null,

    @SerialName("number_of_natural_persons")
    val numberOfNaturalPersons: Long? = null,

    @SerialName("other_code_of_conduct")
    val otherCodeOfConduct: String? = null,

    @SerialName("registration_date")
    val registrationDate: String,

    val status: Status,

    @SerialName("structure_members")
    val structureMembers: String,

    @SerialName("sub_category")
    val subCategory: Long,

    @SerialName("sub_category_title")
    val subCategoryTitle: String,

    @SerialName("updated_at")
    val updatedAt: String,

    val uri: String,

    @SerialName("web_site_url")
    val webSiteURL: String? = null
)

@Serializable
enum class Status(val value: String) {
    @SerialName("active") Active("active"),
    @SerialName("inactive") Inactive("inactive");
}
