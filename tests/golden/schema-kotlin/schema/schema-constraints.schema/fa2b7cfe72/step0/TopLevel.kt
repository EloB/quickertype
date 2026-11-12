// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val minMaxLength: String,
    val percent: Double
) {
    init {
        require(minMaxLength.codePointCount(0, minMaxLength.length) >= 5)
    }
    init {
        require(minMaxLength.codePointCount(0, minMaxLength.length) <= 5)
    }
    init {
        require(percent >= 0)
    }
    init {
        require(percent <= 1)
    }
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
