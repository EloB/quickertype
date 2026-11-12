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
    @SerialName(":@computed_region_cbhk_fwbd")
    val computedRegionCbhkFwbd: String? = null,

    @SerialName(":@computed_region_nnqa_25f4")
    val computedRegionNnqa25F4: String? = null,

    val fall: Fall,
    val geolocation: Geolocation? = null,
    val id: String,
    val mass: String? = null,
    val name: String,
    val nametype: Nametype,
    val recclass: String,
    val reclat: String? = null,
    val reclong: String? = null,
    val year: String? = null
)

@Serializable
enum class Fall(val value: String) {
    @SerialName("Fell") Fell("Fell"),
    @SerialName("Found") Found("Found");
}

@Serializable
data class Geolocation (
    val coordinates: List<Double>,
    val type: Type
)

@Serializable
enum class Type(val value: String) {
    @SerialName("Point") Point("Point");
}

@Serializable
enum class Nametype(val value: String) {
    @SerialName("Valid") Valid("Valid");
}
