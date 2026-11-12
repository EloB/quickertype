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
    .convert(Next::class, { Next.fromJson(it) }, { it.toJson() }, true)

data class TopLevel (
    val next: Next? = null,
    val value: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Node (
    val next: Next? = null,
    val value: String
)

sealed class Next {
    class NodeValue(val value: Node)     : Next()
    class StringValue(val value: String) : Next()
    class NullValue()                    : Next()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is NodeValue   -> this.value
        is StringValue -> this.value
        is NullValue   -> "null"
    })

    companion object {
        public fun fromJson(jv: JsonValue): Next = when (jv.inside) {
            is JsonObject -> NodeValue(jv.obj?.let { klaxon.parseFromJsonObject<Node>(it) }!!)
            is String     -> StringValue(jv.string!!)
            null          -> NullValue()
            else          -> throw IllegalArgumentException()
        }
    }
}
