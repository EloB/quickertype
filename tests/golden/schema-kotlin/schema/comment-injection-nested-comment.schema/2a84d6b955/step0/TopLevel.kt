// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

/**
 * Nested block comment openers:
 * {-
 * / *
 * This text must remain inside the generated documentation comment.
 */
data class TopLevel (
    /**
     * Nested property block comment openers:
     * {-
     * / *
     * This text must remain inside the generated property documentation comment.
     */
    val value: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
