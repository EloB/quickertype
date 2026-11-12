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
    .convert(JsonObject::class,       { it.obj!! },                      { it.toJsonString() })
    .convert(UnionConstructor::class, { UnionConstructor.fromJson(it) }, { it.toJson() }, true)

data class TopLevel (
    val constructor: UnionConstructor? = null
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

sealed class UnionConstructor {
    class ConstructorValue(val value: Constructor) : UnionConstructor()
    class DoubleValue(val value: Double)           : UnionConstructor()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is ConstructorValue -> this.value
        is DoubleValue      -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): UnionConstructor = when (jv.inside) {
            is JsonObject              -> ConstructorValue(jv.obj?.let { klaxon.parseFromJsonObject<Constructor>(it) }!!)
            is Double, is Int, is Long -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            else                       -> throw IllegalArgumentException()
        }
    }
}

typealias Constructor = JsonObject
