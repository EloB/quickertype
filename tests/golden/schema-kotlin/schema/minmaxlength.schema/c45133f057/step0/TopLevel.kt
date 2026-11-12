// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(InUnion::class, { InUnion.fromJson(it) }, { it.toJson() }, true)

data class TopLevel (
    val intersection: String,
    val inUnion: InUnion,
    val maxlength: String,
    val minlength: String,
    val minMaxIntersection: String,
    val minmaxlength: String,
    val minMaxUnion: String,
    val union: String
) {
    init {
        require(intersection.codePointCount(0, intersection.length) >= 4)
    }
    init {
        require(intersection.codePointCount(0, intersection.length) <= 5)
    }
    init {
        require(maxlength.codePointCount(0, maxlength.length) <= 5)
    }
    init {
        require(minlength.codePointCount(0, minlength.length) >= 3)
    }
    init {
        require(minMaxIntersection.codePointCount(0, minMaxIntersection.length) >= 3)
    }
    init {
        require(minMaxIntersection.codePointCount(0, minMaxIntersection.length) <= 5)
    }
    init {
        require(minmaxlength.codePointCount(0, minmaxlength.length) >= 3)
    }
    init {
        require(minmaxlength.codePointCount(0, minmaxlength.length) <= 5)
    }
    init {
        require(union.codePointCount(0, union.length) >= 3)
    }
    init {
        require(union.codePointCount(0, union.length) <= 6)
    }
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

sealed class InUnion {
    class DoubleValue(val value: Double) : InUnion()
    class StringValue(val value: String) : InUnion()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is DoubleValue -> this.value
        is StringValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): InUnion = when (jv.inside) {
            is Double, is Int, is Long -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is String                  -> StringValue(jv.string!!)
            else                       -> throw IllegalArgumentException()
        }
    }
}
