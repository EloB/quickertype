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
    @SerialName("mission_specs")
    val missionSpecs: Map<String, MissionSpec>
)

@Serializable
data class MissionSpec (
    val objectives: Map<String, Objective>
)

@Serializable
data class Objective (
    val rewards: Map<String, Reward>
)

@Serializable
class Reward()
