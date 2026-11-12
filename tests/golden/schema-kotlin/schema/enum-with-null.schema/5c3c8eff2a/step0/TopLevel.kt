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

data class TopLevel (
    val enum: EnumEnum? = null
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

enum class EnumEnum(val value: String) {
    Foo("foo"),
    Bar("bar");

    companion object {
        public fun fromValue(value: String): EnumEnum = when (value) {
            "foo" -> Foo
            "bar" -> Bar
            else  -> throw IllegalArgumentException()
        }
    }
}
