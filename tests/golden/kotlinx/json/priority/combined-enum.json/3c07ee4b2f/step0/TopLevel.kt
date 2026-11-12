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
    val bar: List<Bar>,
    val foo: List<Bar>
)

@Serializable
data class Bar (
    val x: X
)

@Serializable
enum class X(val value: String) {
    @SerialName("three") Three("three"),
    @SerialName("one") One("one"),
    @SerialName("two") Two("two");
}
