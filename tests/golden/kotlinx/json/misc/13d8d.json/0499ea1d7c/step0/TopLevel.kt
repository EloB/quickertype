// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = List<TopLevelElement>

@Serializable
data class TopLevelElement (
    val category: String,
    val context: String,
    val id: Long,
    val location: Location,

    @SerialName("location_subtype")
    val locationSubtype: String,

    @SerialName("location_type")
    val locationType: String,

    val month: String,

    @SerialName("outcome_status")
    val outcomeStatus: OutcomeStatus,

    @SerialName("persistent_id")
    val persistentID: String
)

@Serializable
data class Location (
    val latitude: String,
    val longitude: String,
    val street: Street
)

@Serializable
data class Street (
    val id: Long,
    val name: String
)

@Serializable
data class OutcomeStatus (
    val category: String,
    val date: String
)
