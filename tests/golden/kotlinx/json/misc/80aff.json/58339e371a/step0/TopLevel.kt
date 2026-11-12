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
    val count: Long,
    val facets: Facets,
    val limit: Long,
    val next: Boolean,
    val offset: Long,
    val previous: Boolean,
    val results: List<Result>
)

@Serializable
class Facets()

@Serializable
data class Result (
    @SerialName("created_at")
    val createdAt: String,

    val id: Long,
    val items: Long,
    val name: String,
    val parent: Long? = null,

    @SerialName("updated_at")
    val updatedAt: String,

    val uri: String
)
