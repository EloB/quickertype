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
    val data: Map<String, Datum>,
    val description: Description
)

@Serializable
data class Datum (
    val anomaly: String,
    val value: String
)

@Serializable
data class Description (
    @SerialName("base_period")
    val basePeriod: String,

    val missing: Long,
    val title: String
)
