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
    .convert(UnionItem::class, { UnionItem.fromJson(it) }, { it.toJson() }, true)

data class TopLevel (
    val maxOnly: List<Long>,
    val minAndMax: List<Double>,
    val minOnly: List<String>,
    val plain: List<String>,
    val unionItems: List<UnionItem>
) {
    init {
        require(maxOnly.size <= 3)
    }
    init {
        require(minAndMax.size >= 1)
    }
    init {
        require(minAndMax.size <= 4)
    }
    init {
        require(minOnly.size >= 2)
    }
    init {
        require(unionItems.size >= 2)
    }
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

sealed class UnionItem {
    class IntegerValue(val value: Long)  : UnionItem()
    class StringValue(val value: String) : UnionItem()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is IntegerValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): UnionItem = when (jv.inside) {
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            is String       -> StringValue(jv.string!!)
            else            -> throw IllegalArgumentException()
        }
    }
}
