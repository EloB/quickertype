// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

/**
 * The top-level class.
 * Its description has two lines.
 */
@Serializable
data class TopLevel (
    /**
     * A pretty boolean
     */
    val bar: Boolean? = null,

    /**
     * An enumeration
     */
    val enum: EnumEnum,

    val foo: Double? = null,

    @SerialName("object-or-string")
    val objectOrString: JsonElement,

    /**
     * Either a number or a string
     */
    val union: JsonElement
)

/**
 * An enumeration
 */
@Serializable
enum class EnumEnum(val value: String) {
    @SerialName("foo") Foo("foo"),
    @SerialName("bar") Bar("bar");
}

typealias ObjectOrStringUnion = JsonElement

@Serializable
data class ObjectOrStringClass (
    /**
     * This must not get lost
     */
    val prop: Double
)

typealias Union = JsonElement
