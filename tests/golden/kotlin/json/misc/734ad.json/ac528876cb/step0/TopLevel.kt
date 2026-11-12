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
    .convert(JsonObject::class, { it.obj!! },                      { it.toJsonString() })
    .convert(Status::class,     { Status.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

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
    val acronym: String? = null,

    @Json(name = "activity_consult_committees")
    val activityConsultCommittees: String,

    @Json(name = "activity_eu_legislative")
    val activityEuLegislative: String,

    @Json(name = "activity_expert_groups")
    val activityExpertGroups: String,

    @Json(name = "activity_high_level_groups")
    val activityHighLevelGroups: String,

    @Json(name = "activity_industry_forums")
    val activityIndustryForums: String,

    @Json(name = "activity_inter_groups")
    val activityInterGroups: String,

    @Json(name = "activity_other")
    val activityOther: String? = null,

    @Json(name = "activity_relevant_comm")
    val activityRelevantComm: String,

    @Json(name = "be_office_country")
    val beOfficeCountry: String? = null,

    @Json(name = "be_office_lat")
    val beOfficeLat: Double? = null,

    @Json(name = "be_office_lon")
    val beOfficeLon: Double? = null,

    @Json(name = "be_office_phone")
    val beOfficePhone: String? = null,

    @Json(name = "be_office_post_code")
    val beOfficePostCode: String? = null,

    @Json(name = "be_office_postbox")
    val beOfficePostbox: String? = null,

    @Json(name = "be_office_street")
    val beOfficeStreet: String? = null,

    @Json(name = "be_office_town")
    val beOfficeTown: String? = null,

    @Json(name = "code_of_conduct")
    val codeOfConduct: String,

    @Json(name = "contact_country")
    val contactCountry: Long,

    @Json(name = "created_at")
    val createdAt: String,

    val entity: String,
    val goals: String,
    val head: String,

    @Json(name = "head_office_country")
    val headOfficeCountry: String,

    @Json(name = "head_office_lat")
    val headOfficeLat: Double? = null,

    @Json(name = "head_office_lon")
    val headOfficeLon: Double? = null,

    @Json(name = "head_office_phone")
    val headOfficePhone: String,

    @Json(name = "head_office_post_code")
    val headOfficePostCode: String? = null,

    @Json(name = "head_office_postbox")
    val headOfficePostbox: String? = null,

    @Json(name = "head_office_street")
    val headOfficeStreet: String,

    @Json(name = "head_office_town")
    val headOfficeTown: String,

    val id: String,

    @Json(name = "identification_code")
    val identificationCode: String,

    @Json(name = "info_members")
    val infoMembers: String,

    @Json(name = "last_update_date")
    val lastUpdateDate: String,

    val legal: String,

    @Json(name = "legal_status")
    val legalStatus: String,

    @Json(name = "main_category")
    val mainCategory: Long,

    @Json(name = "main_category_title")
    val mainCategoryTitle: String,

    val members: Long,

    @Json(name = "members_100")
    val members100: Long? = null,

    @Json(name = "members_25")
    val members25: Long? = null,

    @Json(name = "members_50")
    val members50: Long? = null,

    @Json(name = "members_75")
    val members75: Long? = null,

    @Json(name = "members_fte")
    val membersFte: Double,

    val name: String,

    @Json(name = "native_name")
    val nativeName: Any? = null,

    val networking: String? = null,

    @Json(name = "number_of_natural_persons")
    val numberOfNaturalPersons: Long? = null,

    @Json(name = "other_code_of_conduct")
    val otherCodeOfConduct: String? = null,

    @Json(name = "registration_date")
    val registrationDate: String,

    val status: Status,

    @Json(name = "structure_members")
    val structureMembers: String,

    @Json(name = "sub_category")
    val subCategory: Long,

    @Json(name = "sub_category_title")
    val subCategoryTitle: String,

    @Json(name = "updated_at")
    val updatedAt: String,

    val uri: String,

    @Json(name = "web_site_url")
    val webSiteURL: String? = null
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
