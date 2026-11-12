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
    .convert(OtherArr::class, { OtherArr.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Gve::class,      { Gve.fromValue(it.string!!) },      { Klaxon().toJsonString(it.value) })
    .convert(Lvc::class,      { Lvc.fromValue(it.string!!) },      { Klaxon().toJsonString(it.value) })
    .convert(Arr::class,      { Arr.fromJson(it) },                { it.toJson() }, true)

data class TopLevel (
    val arr: List<Arr>? = null,

    @Json(name = "for")
    val topLevelFor: String? = null,

    val gve: Gve,
    val lvc: Lvc? = null,
    val otherArr: List<OtherArr>? = null
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

sealed class Arr {
    class EnumValue(val value: OtherArr) : Arr()
    class IntegerValue(val value: Long)  : Arr()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is EnumValue    -> this.value
        is IntegerValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): Arr = when (jv.inside) {
            is String       -> EnumValue(jv.string?.let { OtherArr.fromValue(it) }!!)
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            else            -> throw IllegalArgumentException()
        }
    }
}

enum class OtherArr(val value: String) {
    Foo("foo"),
    Bar("bar"),
    If("if");

    companion object {
        public fun fromValue(value: String): OtherArr = when (value) {
            "foo" -> Foo
            "bar" -> Bar
            "if"  -> If
            else  -> throw IllegalArgumentException()
        }
    }
}

enum class Gve(val value: String) {
    Good("good"),
    Neutral("neutral"),
    Evil("evil");

    companion object {
        public fun fromValue(value: String): Gve = when (value) {
            "good"    -> Good
            "neutral" -> Neutral
            "evil"    -> Evil
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class Lvc(val value: String) {
    Lawful("lawful"),
    Neutral("neutral"),
    Chaotic("chaotic");

    companion object {
        public fun fromValue(value: String): Lvc = when (value) {
            "lawful"  -> Lawful
            "neutral" -> Neutral
            "chaotic" -> Chaotic
            else      -> throw IllegalArgumentException()
        }
    }
}
