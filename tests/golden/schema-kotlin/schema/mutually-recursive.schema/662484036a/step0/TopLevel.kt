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
    .convert(Foo::class, { Foo.fromJson(it) }, { it.toJson() }, true)

sealed class Foo {
    class TopLevelArrayValue(val value: List<TopLevel>) : Foo()
    class TopLevelValue(val value: TopLevel)            : Foo()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is TopLevelArrayValue -> this.value
        is TopLevelValue      -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): Foo = when (jv.inside) {
            is JsonArray<*> -> TopLevelArrayValue(jv.array?.let { klaxon.parseFromJsonArray<TopLevel>(it) }!!)
            is JsonObject   -> TopLevelValue(jv.obj?.let { klaxon.parseFromJsonObject<TopLevel>(it) }!!)
            else            -> throw IllegalArgumentException()
        }
    }
}

data class Bar (
    val foo: Foo
)

data class TopLevel (
    val bar: Bar? = null
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
