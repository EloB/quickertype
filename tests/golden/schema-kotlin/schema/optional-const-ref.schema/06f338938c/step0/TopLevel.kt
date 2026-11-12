// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val coordinates: List<Coordinate>? = null,
    val count: Long? = null,
    val label: String? = null,
    val requiredCoordinates: List<Coordinate>,
    val requiredCount: Long,
    val requiredLabel: String,
    val weight: Double? = null
) {
    init {
        count?.let { require(it >= 1) }
    }
    init {
        count?.let { require(it <= 100) }
    }
    init {
        label?.let { require(it.codePointCount(0, it.length) >= 2) }
    }
    init {
        label?.let { require(it.codePointCount(0, it.length) <= 16) }
    }
    init {
        require(requiredCount >= 1)
    }
    init {
        require(requiredCount <= 100)
    }
    init {
        require(requiredLabel.codePointCount(0, requiredLabel.length) >= 2)
    }
    init {
        require(requiredLabel.codePointCount(0, requiredLabel.length) <= 16)
    }
    init {
        weight?.let { require(it >= 0.5) }
    }
    init {
        weight?.let { require(it <= 99.5) }
    }
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Coordinate (
    val latitude: Double,
    val longitude: Double
)
