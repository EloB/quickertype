// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val states: List<StateElement>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class StateElement (
    val state: StateState
)

data class StateState (
    @Json(name = "state_id")
    val stateID: String,

    @Json(name = "state_name")
    val stateName: String
)
