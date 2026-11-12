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
    @SerialName("bar")
    val barre: String,

    @SerialName("enum")
    val enumerification: EnumEnum,

    val foo: String,

    @SerialName("union")
    val unionization: JsonElement
)

@Serializable
enum class EnumEnum(val value: String) {
    @SerialName("red") Fire("red"),
    @SerialName("green") Grass("green"),
    @SerialName("blue") Blue("blue");
}

typealias Union = JsonElement
