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
 * Comment delimiters:
 * * /
 * / *
 * {-
 * -}
 * """
 * </summary> & <br>
 * }
 * }
 * }
 * }
 * }
 */
@Serializable
data class TopLevel (
    /**
     * Ends with a backslash \
     */
    val trailingBackslash: String? = null,

    /**
     * Ends with a quote "
     */
    val trailingQuote: String? = null,

    /**
     * Ends with a triple quote """
     */
    val trailingTripleQuote: String? = null,

    /**
     * Property delimiters:
     * * /
     * / *
     * {-
     * -}
     * """
     * </summary> & <br>
     * }
     * }
     * }
     * }
     * }
     */
    val value: String
)
