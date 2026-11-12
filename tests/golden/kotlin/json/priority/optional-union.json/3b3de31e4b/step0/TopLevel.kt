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
    .convert(A::class, { A.fromJson(it) }, { it.toJson() }, true)

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

data class TopLevelElement (
    val a: A? = null
)

sealed class A {
    class IntegerValue(val value: Long)  : A()
    class StringValue(val value: String) : A()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is IntegerValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): A = when (jv.inside) {
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            is String       -> StringValue(jv.string!!)
            else            -> throw IllegalArgumentException()
        }
    }
}
