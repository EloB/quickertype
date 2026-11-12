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
    val states: List<StateElement>
)

@Serializable
data class StateElement (
    val state: StateState
)

@Serializable
data class StateState (
    @SerialName("state_id")
    val stateID: String,

    @SerialName("state_name")
    val stateName: String
)
