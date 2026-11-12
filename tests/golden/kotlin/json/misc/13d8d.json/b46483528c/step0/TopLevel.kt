// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

data class TopLevelElement (
    val category: String,
    val context: String,
    val id: Long,
    val location: Location,

    @Json(name = "location_subtype")
    val locationSubtype: String,

    @Json(name = "location_type")
    val locationType: String,

    val month: String,

    @Json(name = "outcome_status")
    val outcomeStatus: OutcomeStatus,

    @Json(name = "persistent_id")
    val persistentID: String
)

data class Location (
    val latitude: String,
    val longitude: String,
    val street: Street
)

data class Street (
    val id: Long,
    val name: String
)

data class OutcomeStatus (
    val category: String,
    val date: String
)
