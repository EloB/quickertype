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
    val data: Map<String, String>,
    val description: Description
)

@Serializable
data class Description (
    @SerialName("base_period")
    val basePeriod: String,

    val missing: String,
    val title: String,
    val units: String
)
