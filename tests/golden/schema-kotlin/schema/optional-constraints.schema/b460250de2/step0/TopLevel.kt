// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val optDouble: Double? = null,
    val optInt: Long? = null,
    val optPattern: String? = null,
    val optString: String? = null,
    val reqZeroMin: Long
) {
    init {
        optDouble?.let { require(it >= 0.5) }
    }
    init {
        optDouble?.let { require(it <= 99.5) }
    }
    init {
        optInt?.let { require(it >= 0) }
    }
    init {
        optInt?.let { require(it <= 100) }
    }
    init {
        optPattern?.let { require(Regex("^[a-z]+\$").containsMatchIn(it)) }
    }
    init {
        optString?.let { require(it.codePointCount(0, it.length) >= 3) }
    }
    init {
        optString?.let { require(it.codePointCount(0, it.length) <= 10) }
    }
    init {
        require(reqZeroMin >= 0)
    }
    init {
        require(reqZeroMin <= 100)
    }
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
