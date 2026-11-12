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
    .convert(Frequency::class, { Frequency.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Type::class,      { Type.fromValue(it.string!!) },      { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val amount: Double,
    val frequency: Frequency,
    val description: String? = null,
    val type: Type
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

enum class Frequency(val value: String) {
    Weekly("Weekly"),
    Monthly("Monthly"),
    Annually("Annually");

    companion object {
        public fun fromValue(value: String): Frequency = when (value) {
            "Weekly"   -> Weekly
            "Monthly"  -> Monthly
            "Annually" -> Annually
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class Type(val value: String) {
    GrossSalaryAmount("GrossSalaryAmount"),
    Overtime("Overtime");

    companion object {
        public fun fromValue(value: String): Type = when (value) {
            "GrossSalaryAmount" -> GrossSalaryAmount
            "Overtime"          -> Overtime
            else                -> throw IllegalArgumentException()
        }
    }
}
