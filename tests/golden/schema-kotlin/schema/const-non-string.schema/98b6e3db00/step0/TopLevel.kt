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
    val amount: Long,
    val enabled: Boolean,
    val kind: Kind,
    val ratio: Double,
    val version: Double
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

enum class Kind(val value: String) {
    Widget("widget");

    companion object {
        public fun fromValue(value: String): Kind = when (value) {
            "widget" -> Widget
            else     -> throw IllegalArgumentException()
        }
    }
}
