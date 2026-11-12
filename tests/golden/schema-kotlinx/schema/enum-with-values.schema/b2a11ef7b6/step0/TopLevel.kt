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
    val weekdays: Weekdays
)

@Serializable
enum class Weekdays(val value: String) {
    @SerialName("Monday") Monday("Monday"),
    @SerialName("Tuesday") Tuesday("Tuesday"),
    @SerialName("Wednesday") Wednesday("Wednesday"),
    @SerialName("Thursday") Thursday("Thursday"),
    @SerialName("Friday") Friday("Friday"),
    @SerialName("Saturday") Saturday("Saturday"),
    @SerialName("Sunday") Sunday("Sunday");
}
