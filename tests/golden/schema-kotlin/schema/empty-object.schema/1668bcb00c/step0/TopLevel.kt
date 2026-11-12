// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

class TopLevel(elements: Map<String, Any?>) : HashMap<String, Any?>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel (
            klaxon.parseJsonObject(java.io.StringReader(json)) as Map<String, Any?>
        )
    }
}
