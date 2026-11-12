// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.LocalDate

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(LocalDate::class,          { LocalDate.parse(it.string!!) },             { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    .convert(EffectiveFromEnum::class,  { EffectiveFromEnum.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(EffectiveFromUnion::class, { EffectiveFromUnion.fromJson(it) },          { it.toJson() }, true)

data class TopLevel (
    val details: String,
    val rates: List<Rate>,
    val version: Any? = null
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Rate (
    val code: String,

    @Json(name = "country_code")
    val countryCode: String,

    val name: String,
    val periods: List<Period>
)

data class Period (
    @Json(name = "effective_from")
    val effectiveFrom: EffectiveFromUnion,

    val rates: Rates
)

sealed class EffectiveFromUnion {
    class DateValue(val value: LocalDate)         : EffectiveFromUnion()
    class EnumValue(val value: EffectiveFromEnum) : EffectiveFromUnion()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is DateValue -> this.value
        is EnumValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): EffectiveFromUnion = when (jv.inside) {
            is String -> try { DateValue(jv.string?.let { LocalDate.parse(it) }!!) } catch (e: Exception) { EnumValue(jv.string?.let { EffectiveFromEnum.fromValue(it) }!!) }
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class EffectiveFromEnum(val value: String) {
    The00000101("0000-01-01");

    companion object {
        public fun fromValue(value: String): EffectiveFromEnum = when (value) {
            "0000-01-01" -> The00000101
            else         -> throw IllegalArgumentException()
        }
    }
}

data class Rates (
    val parking: Double? = null,
    val reduced: Double? = null,
    val reduced1: Double? = null,
    val reduced2: Double? = null,
    val standard: Double,

    @Json(name = "super_reduced")
    val superReduced: Double? = null
)
