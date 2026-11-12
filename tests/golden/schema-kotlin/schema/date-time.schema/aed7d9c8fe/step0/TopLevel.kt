// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime
import java.time.LocalDate
import java.time.OffsetTime

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(OffsetDateTime::class,           { OffsetDateTime.parse(it.string!!) },            { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })
    .convert(LocalDate::class,                { LocalDate.parse(it.string!!) },                 { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    .convert(OffsetTime::class,               { OffsetTime.parse(it.string!!) },                { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_TIME.format(it)}\"" })
    .convert(JsonObject::class,               { it.obj!! },                                     { it.toJsonString() })
    .convert(ComplexUnionArrayEnum::class,    { ComplexUnionArrayEnum.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(ComplexUnionArrayElement::class, { ComplexUnionArrayElement.fromJson(it) },        { it.toJson() }, true)
    .convert(UnionArray::class,               { UnionArray.fromJson(it) },                      { it.toJson() }, true)

data class TopLevel (
    @Json(name = "complex-union-array")
    val complexUnionArray: List<ComplexUnionArrayElement>,

    val date: LocalDate,

    @Json(name = "date-time")
    val dateTime: OffsetDateTime,

    @Json(name = "local-date-class")
    val localDateClass: LocalDateClassClass? = null,

    @Json(name = "offset-date-time-class")
    val offsetDateTimeClass: OffsetDateTimeClassClass? = null,

    @Json(name = "offset-time-class")
    val offsetTimeClass: OffsetTimeClassClass? = null,

    val time: OffsetTime,

    @Json(name = "union-array")
    val unionArray: List<UnionArray>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

sealed class ComplexUnionArrayElement {
    class DateTimeValue(val value: OffsetDateTime)    : ComplexUnionArrayElement()
    class EnumValue(val value: ComplexUnionArrayEnum) : ComplexUnionArrayElement()
    class IntegerValue(val value: Long)               : ComplexUnionArrayElement()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is DateTimeValue -> this.value
        is EnumValue     -> this.value
        is IntegerValue  -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): ComplexUnionArrayElement = when (jv.inside) {
            is String       -> try { DateTimeValue(jv.string?.let { OffsetDateTime.parse(it) }!!) } catch (e: Exception) { EnumValue(jv.string?.let { ComplexUnionArrayEnum.fromValue(it) }!!) }
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            else            -> throw IllegalArgumentException()
        }
    }
}

enum class ComplexUnionArrayEnum(val value: String) {
    Foo("foo"),
    Bar("bar");

    companion object {
        public fun fromValue(value: String): ComplexUnionArrayEnum = when (value) {
            "foo" -> Foo
            "bar" -> Bar
            else  -> throw IllegalArgumentException()
        }
    }
}

typealias LocalDateClassClass = JsonObject

typealias OffsetDateTimeClassClass = JsonObject

typealias OffsetTimeClassClass = JsonObject

sealed class UnionArray {
    class DateTimeValue(val value: OffsetDateTime) : UnionArray()
    class DateValue(val value: LocalDate)          : UnionArray()
    class TimeValue(val value: OffsetTime)         : UnionArray()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is DateTimeValue -> this.value
        is DateValue     -> this.value
        is TimeValue     -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): UnionArray = when (jv.inside) {
            is String -> try { DateTimeValue(jv.string?.let { OffsetDateTime.parse(it) }!!) } catch (e: Exception) { try { DateValue(jv.string?.let { LocalDate.parse(it) }!!) } catch (e: Exception) { TimeValue(jv.string?.let { OffsetTime.parse(it) }!!) } }
            else      -> throw IllegalArgumentException()
        }
    }
}
