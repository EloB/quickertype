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
    .convert(Kind::class, { Kind.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val b: String? = null,
    val kind: Kind
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

enum class Kind(val value: String) {
    One("one"),
    Two("two");

    companion object {
        public fun fromValue(value: String): Kind = when (value) {
            "one" -> One
            "two" -> Two
            else  -> throw IllegalArgumentException()
        }
    }
}
