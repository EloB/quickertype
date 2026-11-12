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
    .convert(EnumEnum::class, { EnumEnum.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Union::class,    { Union.fromJson(it) },              { it.toJson() }, true)

data class TopLevel (
    @Json(name = "bar")
    val barre: String,

    @Json(name = "enum")
    val enumerification: EnumEnum,

    val foo: String,

    @Json(name = "union")
    val unionization: Union
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

enum class EnumEnum(val value: String) {
    Fire("red"),
    Grass("green"),
    Blue("blue");

    companion object {
        public fun fromValue(value: String): EnumEnum = when (value) {
            "red"   -> Fire
            "green" -> Grass
            "blue"  -> Blue
            else    -> throw IllegalArgumentException()
        }
    }
}

sealed class Union {
    class AmountValue(val value: Double)    : Union()
    class PresenceValue(val value: Boolean) : Union()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is AmountValue   -> this.value
        is PresenceValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): Union = when (jv.inside) {
            is Double, is Int, is Long -> AmountValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is Boolean                 -> PresenceValue(jv.boolean!!)
            else                       -> throw IllegalArgumentException()
        }
    }
}
