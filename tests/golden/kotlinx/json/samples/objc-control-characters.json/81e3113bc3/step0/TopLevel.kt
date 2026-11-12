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
    val literal: String,

    @SerialName("#{1+1}")
    val the11: Long,

    val values: List<Value>
)

@Serializable
enum class Value(val value: String) {
    @SerialName("c0\u0001\u001b\u001f") C0("c0\u0001\u001b\u001f"),
    @SerialName("c1\u007f\u0080\u0085\u009f") C1("c1\u007f\u0080\u0085\u009f");
}
