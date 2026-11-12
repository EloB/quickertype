// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

/**
 * Postman collection
 */
@Serializable
data class TopLevel (
    val item: List<TopLevel>? = null,
    val name: String? = null,
    val response: List<Response>? = null
)

@Serializable
data class Response (
    val body: String? = null
)
