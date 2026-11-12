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
    val next: String,
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

    val entity: String,

    @SerialName("first_name")
    val firstName: String,

    val id: String,

    @SerialName("last_name")
    val lastName: String,

    val name: String,
    val position: String? = null,
    val status: Status,
    val title: Title? = null,

    @SerialName("updated_at")
    val updatedAt: String,

    val uri: String
)

@Serializable
enum class Status(val value: String) {
    @SerialName("inactive") Inactive("inactive"),
    @SerialName("active") Active("active");
}

@Serializable
enum class Title(val value: String) {
    @SerialName("Mr") Mr("Mr"),
    @SerialName("Ms") MS("Ms");
}
