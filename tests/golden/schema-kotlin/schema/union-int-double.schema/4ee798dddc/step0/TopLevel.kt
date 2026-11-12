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
    .convert(Value::class, { Value.fromJson(it) }, { it.toJson() }, true)

data class TopLevel (
    val value: Value
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

sealed class Value {
    class DoubleValue(val value: Double) : Value()
    class IntegerValue(val value: Long)  : Value()
    class StringValue(val value: String) : Value()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is DoubleValue  -> this.value
        is IntegerValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): Value = when (jv.inside) {
            is Double       -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            is String       -> StringValue(jv.string!!)
            else            -> throw IllegalArgumentException()
        }
    }
}
