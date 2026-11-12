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
    .convert(UnionList::class, { UnionList.fromJson(it) }, { it.toJson() }, true)

data class TopLevel (
    val list: UnionList
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class UnionListClass (
    val next: UnionList
)

sealed class UnionList {
    class DoubleValue(val value: Double)                 : UnionList()
    class UnionListClassValue(val value: UnionListClass) : UnionList()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is DoubleValue         -> this.value
        is UnionListClassValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): UnionList = when (jv.inside) {
            is Double, is Int, is Long -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is JsonObject              -> UnionListClassValue(jv.obj?.let { klaxon.parseFromJsonObject<UnionListClass>(it) }!!)
            else                       -> throw IllegalArgumentException()
        }
    }
}
