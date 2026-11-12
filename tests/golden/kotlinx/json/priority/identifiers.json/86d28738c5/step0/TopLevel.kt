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
    val bla: TopLevelBla,

    @SerialName("")
    val empty: Empty,

    val foo: Foo,

    @SerialName("ThisIsA\ud83d\ude1cTough\"\n\nOne")
    val thisIsAToughOne: ThisIsAToughOne,

    @SerialName("!")
    val topLevel: Long,

    @SerialName("Empty")
    val topLevelEmpty: EmptyClass
)

@Serializable
data class TopLevelBla (
    val bar: Long
)

@Serializable
data class Empty (
    val x: Long
)

@Serializable
data class Foo (
    val bla: FooBla,

    @SerialName("_")
    val empty: Long,

    @SerialName("__")
    val foo: Long
)

@Serializable
class FooBla()

@Serializable
data class ThisIsAToughOne (
    @SerialName("\n\n\n")
    val empty: Long,

    @SerialName("\"")
    val thisIsAToughOne: Long
)

@Serializable
data class EmptyClass (
    val y: Long
)
