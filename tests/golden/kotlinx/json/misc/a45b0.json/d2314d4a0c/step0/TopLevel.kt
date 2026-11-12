// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = List<TopLevelElement>

@Serializable
data class TopLevelElement (
    val age: Long,
    val country: Country,
    val females: Long,
    val males: Long,
    val total: Long,
    val year: Long
)

@Serializable
enum class Country(val value: String) {
    @SerialName("United States") UnitedStates("United States");
}
