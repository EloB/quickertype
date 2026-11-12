// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val pattern1: String,
    val pattern2: String,

    @Json(name = "RegExp")
    val regExp: RegExp? = null,

    val union: String
) {
    init {
        require(Regex("a[.]*").containsMatchIn(pattern1))
    }
    init {
        require(Regex("b[.]*").containsMatchIn(pattern2))
    }
    init {
        require(Regex("(b[.]*)|(c[.]*)").containsMatchIn(union))
    }
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class RegExp (
    val pattern3: String
)
