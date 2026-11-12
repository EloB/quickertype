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
    .convert(FooEnum::class,  { FooEnum.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(FooUnion::class, { FooUnion.fromJson(it) },          { it.toJson() }, true)

data class TopLevel (
    val foo: FooUnion
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

sealed class FooUnion {
    class BoolValue(val value: Boolean)  : FooUnion()
    class DoubleValue(val value: Double) : FooUnion()
    class EnumValue(val value: FooEnum)  : FooUnion()
    class IntegerValue(val value: Long)  : FooUnion()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is BoolValue    -> this.value
        is DoubleValue  -> this.value
        is EnumValue    -> this.value
        is IntegerValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): FooUnion = when (jv.inside) {
            is Boolean      -> BoolValue(jv.boolean!!)
            is Double       -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is String       -> EnumValue(jv.string?.let { FooEnum.fromValue(it) }!!)
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            else            -> throw IllegalArgumentException()
        }
    }
}

enum class FooEnum(val value: String) {
    A("a"),
    B("b"),
    C("c");

    companion object {
        public fun fromValue(value: String): FooEnum = when (value) {
            "a"  -> A
            "b"  -> B
            "c"  -> C
            else -> throw IllegalArgumentException()
        }
    }
}
