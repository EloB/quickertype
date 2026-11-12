// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val headers: Headers
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Headers (
    @Json(name = "Accept-Encoding")
    val acceptEncoding: String,

    @Json(name = "Connection")
    val connection: String,

    @Json(name = "Host")
    val host: String,

    @Json(name = "User-Agent")
    val userAgent: String
)
