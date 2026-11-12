// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = HashMap<String, TopLevelValue>

@Serializable
data class TopLevelValue (
    @SerialName("channel_id")
    val channelID: String,

    @SerialName("channel_name")
    val channelName: String,

    val code: String,

    @SerialName("emoticon_set")
    val emoticonSet: Long,

    val id: Long
)
