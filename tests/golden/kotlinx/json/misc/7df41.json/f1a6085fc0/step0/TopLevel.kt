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
    val pc: PC,
    val ps3: PC,
    val ps4: PC,
    val xbox: PC,
    val xone: PC
)

@Serializable
data class PC (
    val count: Long,
    val label: String,
    val peak24: Long
)
