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
    .convert(Open::class, { Open.fromJson(it) }, { it.toJson() }, true)

data class TopLevel (
    val open: List<Open>,
    val tuple: List<Open>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

sealed class Open {
    class BoolValue(val value: Boolean) : Open()
    class IntegerValue(val value: Long) : Open()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is BoolValue    -> this.value
        is IntegerValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): Open = when (jv.inside) {
            is Boolean      -> BoolValue(jv.boolean!!)
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            else            -> throw IllegalArgumentException()
        }
    }
}
