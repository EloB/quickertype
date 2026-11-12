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
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(Status::class, { Status.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
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
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val acronym: String?,

    @get:JsonProperty("activity_consult_committees", required=true)@field:JsonProperty("activity_consult_committees", required=true)
    val activityConsultCommittees: String,

    @get:JsonProperty("activity_eu_legislative", required=true)@field:JsonProperty("activity_eu_legislative", required=true)
    val activityEuLegislative: String,

    @get:JsonProperty("activity_expert_groups", required=true)@field:JsonProperty("activity_expert_groups", required=true)
    val activityExpertGroups: String,

    @get:JsonProperty("activity_high_level_groups", required=true)@field:JsonProperty("activity_high_level_groups", required=true)
    val activityHighLevelGroups: String,

    @get:JsonProperty("activity_industry_forums", required=true)@field:JsonProperty("activity_industry_forums", required=true)
    val activityIndustryForums: String,

    @get:JsonProperty("activity_inter_groups", required=true)@field:JsonProperty("activity_inter_groups", required=true)
    val activityInterGroups: String,

    @get:JsonProperty("activity_other", required=true)@field:JsonProperty("activity_other", required=true)
    val activityOther: String?,

    @get:JsonProperty("activity_relevant_comm", required=true)@field:JsonProperty("activity_relevant_comm", required=true)
    val activityRelevantComm: String,

    @get:JsonProperty("be_office_country")@field:JsonProperty("be_office_country")
    val beOfficeCountry: String? = null,

    @get:JsonProperty("be_office_lat")@field:JsonProperty("be_office_lat")
    val beOfficeLat: Double? = null,

    @get:JsonProperty("be_office_lon")@field:JsonProperty("be_office_lon")
    val beOfficeLon: Double? = null,

    @get:JsonProperty("be_office_phone")@field:JsonProperty("be_office_phone")
    val beOfficePhone: String? = null,

    @get:JsonProperty("be_office_post_code")@field:JsonProperty("be_office_post_code")
    val beOfficePostCode: String? = null,

    @get:JsonProperty("be_office_postbox")@field:JsonProperty("be_office_postbox")
    val beOfficePostbox: String? = null,

    @get:JsonProperty("be_office_street")@field:JsonProperty("be_office_street")
    val beOfficeStreet: String? = null,

    @get:JsonProperty("be_office_town")@field:JsonProperty("be_office_town")
    val beOfficeTown: String? = null,

    @get:JsonProperty("code_of_conduct", required=true)@field:JsonProperty("code_of_conduct", required=true)
    val codeOfConduct: String,

    @get:JsonProperty("contact_country", required=true)@field:JsonProperty("contact_country", required=true)
    val contactCountry: Long,

    @get:JsonProperty("created_at", required=true)@field:JsonProperty("created_at", required=true)
    val createdAt: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val entity: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val goals: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val head: String,

    @get:JsonProperty("head_office_country", required=true)@field:JsonProperty("head_office_country", required=true)
    val headOfficeCountry: String,

    @get:JsonProperty("head_office_lat", required=true)@field:JsonProperty("head_office_lat", required=true)
    val headOfficeLat: Double?,

    @get:JsonProperty("head_office_lon", required=true)@field:JsonProperty("head_office_lon", required=true)
    val headOfficeLon: Double?,

    @get:JsonProperty("head_office_phone", required=true)@field:JsonProperty("head_office_phone", required=true)
    val headOfficePhone: String,

    @get:JsonProperty("head_office_post_code", required=true)@field:JsonProperty("head_office_post_code", required=true)
    val headOfficePostCode: String?,

    @get:JsonProperty("head_office_postbox", required=true)@field:JsonProperty("head_office_postbox", required=true)
    val headOfficePostbox: String?,

    @get:JsonProperty("head_office_street", required=true)@field:JsonProperty("head_office_street", required=true)
    val headOfficeStreet: String,

    @get:JsonProperty("head_office_town", required=true)@field:JsonProperty("head_office_town", required=true)
    val headOfficeTown: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty("identification_code", required=true)@field:JsonProperty("identification_code", required=true)
    val identificationCode: String,

    @get:JsonProperty("info_members", required=true)@field:JsonProperty("info_members", required=true)
    val infoMembers: String,

    @get:JsonProperty("last_update_date", required=true)@field:JsonProperty("last_update_date", required=true)
    val lastUpdateDate: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val legal: String,

    @get:JsonProperty("legal_status", required=true)@field:JsonProperty("legal_status", required=true)
    val legalStatus: String,

    @get:JsonProperty("main_category", required=true)@field:JsonProperty("main_category", required=true)
    val mainCategory: Long,

    @get:JsonProperty("main_category_title", required=true)@field:JsonProperty("main_category_title", required=true)
    val mainCategoryTitle: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val members: Long,

    @get:JsonProperty("members_100", required=true)@field:JsonProperty("members_100", required=true)
    val members100: Long?,

    @get:JsonProperty("members_25", required=true)@field:JsonProperty("members_25", required=true)
    val members25: Long?,

    @get:JsonProperty("members_50", required=true)@field:JsonProperty("members_50", required=true)
    val members50: Long?,

    @get:JsonProperty("members_75", required=true)@field:JsonProperty("members_75", required=true)
    val members75: Long?,

    @get:JsonProperty("members_fte", required=true)@field:JsonProperty("members_fte", required=true)
    val membersFte: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty("native_name", required=true)@field:JsonProperty("native_name", required=true)
    val nativeName: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val networking: String?,

    @get:JsonProperty("number_of_natural_persons", required=true)@field:JsonProperty("number_of_natural_persons", required=true)
    val numberOfNaturalPersons: Long?,

    @get:JsonProperty("other_code_of_conduct", required=true)@field:JsonProperty("other_code_of_conduct", required=true)
    val otherCodeOfConduct: String?,

    @get:JsonProperty("registration_date", required=true)@field:JsonProperty("registration_date", required=true)
    val registrationDate: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Status,

    @get:JsonProperty("structure_members", required=true)@field:JsonProperty("structure_members", required=true)
    val structureMembers: String,

    @get:JsonProperty("sub_category", required=true)@field:JsonProperty("sub_category", required=true)
    val subCategory: Long,

    @get:JsonProperty("sub_category_title", required=true)@field:JsonProperty("sub_category_title", required=true)
    val subCategoryTitle: String,

    @get:JsonProperty("updated_at", required=true)@field:JsonProperty("updated_at", required=true)
    val updatedAt: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val uri: String,

    @get:JsonProperty("web_site_url", required=true)@field:JsonProperty("web_site_url", required=true)
    val webSiteURL: String?
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
