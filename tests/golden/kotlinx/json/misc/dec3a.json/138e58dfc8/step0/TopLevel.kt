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
    val metadata: Metadata,
    val results: List<Result>
)

@Serializable
data class Metadata (
    val executionTime: Double,
    val responseInfo: ResponseInfo,
    val resultset: Resultset
)

@Serializable
data class ResponseInfo (
    val developerMessage: String,
    val status: Long
)

@Serializable
data class Resultset (
    val count: Long,
    val page: Long,
    val pagesize: Long
)

@Serializable
data class Result (
    @SerialName("about_office")
    val aboutOffice: String,

    @SerialName("application_process")
    val applicationProcess: String,

    val body: String,
    val changed: String,
    val created: String,
    val deadline: JsonElement? = null,

    @SerialName("hiring_office")
    val hiringOffice: JsonElement? = null,

    @SerialName("hiring_org")
    val hiringOrg: HiringOrg,

    @SerialName("job_id")
    val jobID: JsonElement? = null,

    val language: String,
    val location: Location,

    @SerialName("num_positions")
    val numPositions: String,

    val position: String,

    @SerialName("practice_area")
    val practiceArea: String,

    val qualifications: String,

    @SerialName("relocation_expenses")
    val relocationExpenses: JsonElement? = null,

    val salary: String,
    val title: String,
    val travel: String,
    val url: String,
    val uuid: String,
    val vuuid: String
)

@Serializable
data class HiringOrg (
    val name: String,
    val uuid: String
)

@Serializable
data class Location (
    @SerialName("administrative_area")
    val administrativeArea: String,

    val country: String,

    @SerialName("fax_number")
    val faxNumber: String,

    val locality: String,

    @SerialName("mobile_number")
    val mobileNumber: String,

    @SerialName("phone_number")
    val phoneNumber: String,

    @SerialName("phone_number_extension")
    val phoneNumberExtension: String,

    @SerialName("postal_code")
    val postalCode: String,

    @SerialName("sub_premise")
    val subPremise: JsonElement? = null,

    val thoroughfare: String
)
