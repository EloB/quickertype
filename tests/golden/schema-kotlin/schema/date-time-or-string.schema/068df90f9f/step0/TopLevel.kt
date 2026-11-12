// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(OffsetDateTime::class, { OffsetDateTime.parse(it.string!!) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    .convert(BarEnum::class,        { BarEnum.fromValue(it.string!!) },    { Klaxon().toJsonString(it.value) })
    .convert(BarUnion::class,       { BarUnion.fromJson(it) },             { it.toJson() }, true)

data class TopLevel (
    val bar: BarUnion,
    val foo: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

sealed class BarUnion {
    class DateTimeValue(val value: OffsetDateTime) : BarUnion()
    class EnumValue(val value: BarEnum)            : BarUnion()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is DateTimeValue -> this.value
        is EnumValue     -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): BarUnion = when (jv.inside) {
            is String -> try { DateTimeValue(jv.string?.let { OffsetDateTime.parse(it) }!!) } catch (e: Exception) { EnumValue(jv.string?.let { BarEnum.fromValue(it) }!!) }
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class BarEnum(val value: String) {
    Quux("quux");

    companion object {
        public fun fromValue(value: String): BarEnum = when (value) {
            "quux" -> Quux
            else   -> throw IllegalArgumentException()
        }
    }
}
