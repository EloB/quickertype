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
    @SerialName("LightParams")
    val lightParams: LightParams
)

@Serializable
data class LightParams (
    @SerialName("app_id")
    val appID: String,

    @SerialName("outlet_id")
    val outletID: String,

    val rgba: String
)
