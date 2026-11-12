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
    val attachment: JsonArray,
    val body: String,
    val changed: String,
    val component: List<Component>,
    val created: String,
    val date: String,
    val image: JsonArray,
    val location: Location,
    val teaser: JsonElement? = null,
    val title: String,
    val topic: JsonArray,
    val url: String,
    val uuid: String,
    val vuuid: String
)

@Serializable
data class Component (
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
