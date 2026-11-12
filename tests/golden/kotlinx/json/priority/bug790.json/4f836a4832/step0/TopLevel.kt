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
    @SerialName("children_data")
    val childrenData: List<TopLevel>,

    val id: Long,

    @SerialName("is_active")
    val isActive: Boolean,

    val level: Long,
    val name: String,

    @SerialName("parent_id")
    val parentID: Long,

    val position: Long,

    @SerialName("product_count")
    val productCount: Long
)
