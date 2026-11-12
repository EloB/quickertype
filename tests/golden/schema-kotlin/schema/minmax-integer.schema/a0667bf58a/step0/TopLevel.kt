// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val free: Long,
    val intersection: Long,
    val max: Long,
    val min: Long,
    val minmax: Long,
    val minMaxIntersection: Long,
    val minMaxUnion: Long,
    val union: Long
) {
    init {
        require(intersection >= 4)
    }
    init {
        require(intersection <= 5)
    }
    init {
        require(max <= 5)
    }
    init {
        require(min >= 3)
    }
    init {
        require(minmax >= 3)
    }
    init {
        require(minmax <= 5)
    }
    init {
        require(minMaxIntersection >= 3)
    }
    init {
        require(minMaxIntersection <= 5)
    }
    init {
        require(union >= 3)
    }
    init {
        require(union <= 6)
    }
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
