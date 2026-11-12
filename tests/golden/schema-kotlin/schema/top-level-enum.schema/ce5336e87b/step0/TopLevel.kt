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
    .convert(TopLevel::class, { TopLevel.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

enum class TopLevel(val value: String) {
    One("one"),
    Three("three"),
    Two("two");

    public fun toJson() = klaxon.toJsonString(value)

    companion object {
        public fun fromJson(json: String) = fromValue(klaxon.parseArray<String>("[${json}]")!![0])

        public fun fromValue(value: String): TopLevel = when (value) {
            "one"   -> One
            "three" -> Three
            "two"   -> Two
            else    -> throw IllegalArgumentException()
        }
    }
}
