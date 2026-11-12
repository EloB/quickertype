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
    val prizes: List<Prize>
)

@Serializable
data class Prize (
    val category: Category,
    val laureates: List<Laureate>,
    val overallMotivation: String? = null,
    val year: String
)

@Serializable
enum class Category(val value: String) {
    @SerialName("physics") Physics("physics"),
    @SerialName("chemistry") Chemistry("chemistry"),
    @SerialName("medicine") Medicine("medicine"),
    @SerialName("literature") Literature("literature"),
    @SerialName("peace") Peace("peace"),
    @SerialName("economics") Economics("economics");
}

@Serializable
data class Laureate (
    val firstname: String,
    val id: String,
    val motivation: String? = null,
    val share: String,
    val surname: String
)
