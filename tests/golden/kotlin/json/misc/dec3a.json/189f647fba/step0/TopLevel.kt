// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val metadata: Metadata,
    val results: List<Result>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Metadata (
    val executionTime: Double,
    val responseInfo: ResponseInfo,
    val resultset: Resultset
)

data class ResponseInfo (
    val developerMessage: String,
    val status: Long
)

data class Resultset (
    val count: Long,
    val page: Long,
    val pagesize: Long
)

data class Result (
    @Json(name = "about_office")
    val aboutOffice: String,

    @Json(name = "application_process")
    val applicationProcess: String,

    val body: String,
    val changed: String,
    val created: String,
    val deadline: Any? = null,

    @Json(name = "hiring_office")
    val hiringOffice: Any? = null,

    @Json(name = "hiring_org")
    val hiringOrg: HiringOrg,

    @Json(name = "job_id")
    val jobID: Any? = null,

    val language: String,
    val location: Location,

    @Json(name = "num_positions")
    val numPositions: String,

    val position: String,

    @Json(name = "practice_area")
    val practiceArea: String,

    val qualifications: String,

    @Json(name = "relocation_expenses")
    val relocationExpenses: Any? = null,

    val salary: String,
    val title: String,
    val travel: String,
    val url: String,
    val uuid: String,
    val vuuid: String
)

data class HiringOrg (
    val name: String,
    val uuid: String
)

data class Location (
    @Json(name = "administrative_area")
    val administrativeArea: String,

    val country: String,

    @Json(name = "fax_number")
    val faxNumber: String,

    val locality: String,

    @Json(name = "mobile_number")
    val mobileNumber: String,

    @Json(name = "phone_number")
    val phoneNumber: String,

    @Json(name = "phone_number_extension")
    val phoneNumberExtension: String,

    @Json(name = "postal_code")
    val postalCode: String,

    @Json(name = "sub_premise")
    val subPremise: Any? = null,

    val thoroughfare: String
)
