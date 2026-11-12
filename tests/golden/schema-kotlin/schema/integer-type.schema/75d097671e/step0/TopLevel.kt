// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    @Json(name = "above_i32_max")
    val aboveI32Max: Long,

    @Json(name = "below_i32_min")
    val belowI32Min: Long,

    @Json(name = "i32_range")
    val i32Range: Long,

    @Json(name = "large_bounds")
    val largeBounds: Long,

    @Json(name = "only_maximum")
    val onlyMaximum: Long,

    @Json(name = "only_minimum")
    val onlyMinimum: Long,

    @Json(name = "small_negative")
    val smallNegative: Long,

    @Json(name = "small_positive")
    val smallPositive: Long,

    val unbounded: Long
) {
    init {
        require(aboveI32Max >= 0)
    }
    init {
        require(aboveI32Max <= 2147483648)
    }
    init {
        require(belowI32Min >= -2147483649)
    }
    init {
        require(belowI32Min <= 0)
    }
    init {
        require(i32Range >= -2147483648)
    }
    init {
        require(i32Range <= 2147483647)
    }
    init {
        require(largeBounds >= -9007199254740991)
    }
    init {
        require(largeBounds <= 9007199254740991)
    }
    init {
        require(onlyMaximum <= 0)
    }
    init {
        require(onlyMinimum >= 0)
    }
    init {
        require(smallNegative >= -100)
    }
    init {
        require(smallNegative <= 0)
    }
    init {
        require(smallPositive >= 0)
    }
    init {
        require(smallPositive <= 100)
    }
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
