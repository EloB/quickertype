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
 * Nested block comment openers:
 * {-
 * / *
 * This text must remain inside the generated documentation comment.
 */
@Serializable
data class TopLevel (
    /**
     * Nested property block comment openers:
     * {-
     * / *
     * This text must remain inside the generated property documentation comment.
     */
    val value: String
)
