// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

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
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
