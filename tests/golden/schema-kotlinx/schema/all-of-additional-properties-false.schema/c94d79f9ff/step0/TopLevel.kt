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
    val amount: Double,
    val frequency: Frequency,
    val description: String? = null,
    val type: Type
)

@Serializable
enum class Frequency(val value: String) {
    @SerialName("Weekly") Weekly("Weekly"),
    @SerialName("Monthly") Monthly("Monthly"),
    @SerialName("Annually") Annually("Annually");
}

@Serializable
enum class Type(val value: String) {
    @SerialName("GrossSalaryAmount") GrossSalaryAmount("GrossSalaryAmount"),
    @SerialName("Overtime") Overtime("Overtime");
}
