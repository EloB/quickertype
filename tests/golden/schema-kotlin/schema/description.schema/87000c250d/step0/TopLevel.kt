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
    .convert(EnumEnum::class,            { EnumEnum.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })
    .convert(ObjectOrStringUnion::class, { ObjectOrStringUnion.fromJson(it) }, { it.toJson() }, true)
    .convert(Union::class,               { Union.fromJson(it) },               { it.toJson() }, true)

/**
 * The top-level class.
 * Its description has two lines.
 */
data class TopLevel (
    /**
     * A pretty boolean
     */
    val bar: Boolean? = null,

    /**
     * An enumeration
     */
    val enum: EnumEnum,

    val foo: Double? = null,

    @Json(name = "object-or-string")
    val objectOrString: ObjectOrStringUnion,

    /**
     * Either a number or a string
     */
    val union: Union
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

/**
 * An enumeration
 */
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

sealed class ObjectOrStringUnion {
    class ObjectOrStringClassValue(val value: ObjectOrStringClass) : ObjectOrStringUnion()
    class StringValue(val value: String)                           : ObjectOrStringUnion()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is ObjectOrStringClassValue -> this.value
        is StringValue              -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): ObjectOrStringUnion = when (jv.inside) {
            is JsonObject -> ObjectOrStringClassValue(jv.obj?.let { klaxon.parseFromJsonObject<ObjectOrStringClass>(it) }!!)
            is String     -> StringValue(jv.string!!)
            else          -> throw IllegalArgumentException()
        }
    }
}

data class ObjectOrStringClass (
    /**
     * This must not get lost
     */
    val prop: Double
)

/**
 * Either a number or a string
 */
sealed class Union {
    class DoubleValue(val value: Double) : Union()
    class StringValue(val value: String) : Union()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is DoubleValue -> this.value
        is StringValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): Union = when (jv.inside) {
            is Double, is Int, is Long -> DoubleValue(jv.double ?: jv.int?.toDouble() ?: jv.longValue?.toDouble()!!)
            is String                  -> StringValue(jv.string!!)
            else                       -> throw IllegalArgumentException()
        }
    }
}
