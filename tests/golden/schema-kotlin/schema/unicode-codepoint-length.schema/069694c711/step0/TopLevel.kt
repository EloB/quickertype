// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val exact: String,
    val maximum: String,
    val minimum: String
) {
    init {
        require(exact.codePointCount(0, exact.length) >= 2)
    }
    init {
        require(exact.codePointCount(0, exact.length) <= 2)
    }
    init {
        require(Regex("^[^!]+\$").containsMatchIn(exact))
    }
    init {
        require(maximum.codePointCount(0, maximum.length) <= 1)
    }
    init {
        require(minimum.codePointCount(0, minimum.length) >= 2)
    }
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
