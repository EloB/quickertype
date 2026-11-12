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
    val foo: JsonElement
)

typealias FooUnion = JsonElement

@Serializable
enum class FooEnum(val value: String) {
    @SerialName("a") A("a"),
    @SerialName("b") B("b"),
    @SerialName("c") C("c");
}
