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
    .convert(TopLevel::class,        { TopLevel.fromJson(it) },        { it.toJson() }, true)
    .convert(TopLevelElement::class, { TopLevelElement.fromJson(it) }, { it.toJson() }, true)
    .convert(XElement::class,        { XElement.fromJson(it) },        { it.toJson() }, true)
    .convert(X::class,               { X.fromJson(it) },               { it.toJson() }, true)

sealed class TopLevel {
    class AnythingMapValue(val value: Map<String, Any?>)    : TopLevel()
    class BoolValue(val value: Boolean)                     : TopLevel()
    class DoubleValue(val value: Double)                    : TopLevel()
    class IntegerValue(val value: Long)                     : TopLevel()
    class StringValue(val value: String)                    : TopLevel()
    class UnionArrayValue(val value: List<TopLevelElement>) : TopLevel()
    class NullValue()                                       : TopLevel()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is AnythingMapValue -> this.value
        is BoolValue        -> this.value
        is DoubleValue      -> this.value
        is IntegerValue     -> this.value
        is StringValue      -> this.value
        is UnionArrayValue  -> this.value
        is NullValue        -> "null"
    })

    companion object {
        public fun fromJson(json: String): TopLevel = fromJson(JsonValue(Parser().parse(StringBuilder(json)), null, null, klaxon))

        public fun fromJson(jv: JsonValue): TopLevel = when (jv.inside) {
            is JsonObject   -> AnythingMapValue(jv.obj?.let { klaxon.parseFromJsonObject<Map<String, Any?>>(it) }!!)
            is Boolean      -> BoolValue(jv.boolean!!)
            is Double       -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            is String       -> StringValue(jv.string!!)
            is JsonArray<*> -> UnionArrayValue(jv.array?.let { klaxon.parseFromJsonArray<TopLevelElement>(it) }!!)
            null            -> NullValue()
            else            -> throw IllegalArgumentException()
        }
    }
}

sealed class TopLevelElement {
    class AnythingArrayValue(val value: List<Any?>)    : TopLevelElement()
    class BoolValue(val value: Boolean)                : TopLevelElement()
    class DoubleValue(val value: Double)               : TopLevelElement()
    class IntegerValue(val value: Long)                : TopLevelElement()
    class StringValue(val value: String)               : TopLevelElement()
    class TopLevelClassValue(val value: TopLevelClass) : TopLevelElement()
    class NullValue()                                  : TopLevelElement()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is AnythingArrayValue -> this.value
        is BoolValue          -> this.value
        is DoubleValue        -> this.value
        is IntegerValue       -> this.value
        is StringValue        -> this.value
        is TopLevelClassValue -> this.value
        is NullValue          -> "null"
    })

    companion object {
        public fun fromJson(jv: JsonValue): TopLevelElement = when (jv.inside) {
            is JsonArray<*> -> AnythingArrayValue(jv.array?.let { klaxon.parseFromJsonArray<Any?>(it) }!!)
            is Boolean      -> BoolValue(jv.boolean!!)
            is Double       -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            is String       -> StringValue(jv.string!!)
            is JsonObject   -> TopLevelClassValue(jv.obj?.let { klaxon.parseFromJsonObject<TopLevelClass>(it) }!!)
            null            -> NullValue()
            else            -> throw IllegalArgumentException()
        }
    }
}

data class TopLevelClass (
    val x: X? = null
)

data class XClass (
    val x: X? = null
)

sealed class XElement {
    class AnythingArrayValue(val value: List<Any?>) : XElement()
    class BoolValue(val value: Boolean)             : XElement()
    class DoubleValue(val value: Double)            : XElement()
    class IntegerValue(val value: Long)             : XElement()
    class StringValue(val value: String)            : XElement()
    class XClassValue(val value: XClass)            : XElement()
    class NullValue()                               : XElement()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is AnythingArrayValue -> this.value
        is BoolValue          -> this.value
        is DoubleValue        -> this.value
        is IntegerValue       -> this.value
        is StringValue        -> this.value
        is XClassValue        -> this.value
        is NullValue          -> "null"
    })

    companion object {
        public fun fromJson(jv: JsonValue): XElement = when (jv.inside) {
            is JsonArray<*> -> AnythingArrayValue(jv.array?.let { klaxon.parseFromJsonArray<Any?>(it) }!!)
            is Boolean      -> BoolValue(jv.boolean!!)
            is Double       -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            is String       -> StringValue(jv.string!!)
            is JsonObject   -> XClassValue(jv.obj?.let { klaxon.parseFromJsonObject<XClass>(it) }!!)
            null            -> NullValue()
            else            -> throw IllegalArgumentException()
        }
    }
}

sealed class X {
    class AnythingMapValue(val value: Map<String, Any?>) : X()
    class BoolValue(val value: Boolean)                  : X()
    class DoubleValue(val value: Double)                 : X()
    class IntegerValue(val value: Long)                  : X()
    class StringValue(val value: String)                 : X()
    class UnionArrayValue(val value: List<XElement>)     : X()
    class NullValue()                                    : X()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is AnythingMapValue -> this.value
        is BoolValue        -> this.value
        is DoubleValue      -> this.value
        is IntegerValue     -> this.value
        is StringValue      -> this.value
        is UnionArrayValue  -> this.value
        is NullValue        -> "null"
    })

    companion object {
        public fun fromJson(jv: JsonValue): X = when (jv.inside) {
            is JsonObject   -> AnythingMapValue(jv.obj?.let { klaxon.parseFromJsonObject<Map<String, Any?>>(it) }!!)
            is Boolean      -> BoolValue(jv.boolean!!)
            is Double       -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            is String       -> StringValue(jv.string!!)
            is JsonArray<*> -> UnionArrayValue(jv.array?.let { klaxon.parseFromJsonArray<XElement>(it) }!!)
            null            -> NullValue()
            else            -> throw IllegalArgumentException()
        }
    }
}
