// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

/**
 * Postman collection
 */
data class TopLevel (
    val item: List<TopLevel>? = null,
    val name: String? = null,
    val response: List<Response>? = null
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Response (
    val body: String? = null
)
