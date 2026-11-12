// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

class TopLevel(elements: Collection<TextClassificationOutputElement>) : ArrayList<TextClassificationOutputElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TextClassificationOutputElement>(json)!!)
    }
}

data class TextClassificationOutputElement (
    val label: String,
    val score: Double
)
