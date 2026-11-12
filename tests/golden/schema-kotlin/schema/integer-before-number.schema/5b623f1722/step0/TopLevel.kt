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
    .convert(TopLevel::class, { TopLevel.fromJson(it) }, { it.toJson() }, true)

/**
 * An integer or non-integer number
 */
sealed class TopLevel {
    class DoubleValue(val value: Double) : TopLevel()
    class IntegerValue(val value: Long)  : TopLevel()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is DoubleValue  -> this.value
        is IntegerValue -> this.value
    })

    companion object {
        public fun fromJson(json: String): TopLevel = fromJson(JsonValue(Parser().parse(StringBuilder(json)), null, null, klaxon))

        public fun fromJson(jv: JsonValue): TopLevel = when (jv.inside) {
            is Double       -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            else            -> throw IllegalArgumentException()
        }
    }
}
