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
    .convert(Weekdays::class, { Weekdays.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val weekdays: Weekdays
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

enum class Weekdays(val value: String) {
    Monday("Monday"),
    Tuesday("Tuesday"),
    Wednesday("Wednesday"),
    Thursday("Thursday"),
    Friday("Friday"),
    Saturday("Saturday"),
    Sunday("Sunday");

    companion object {
        public fun fromValue(value: String): Weekdays = when (value) {
            "Monday"    -> Monday
            "Tuesday"   -> Tuesday
            "Wednesday" -> Wednesday
            "Thursday"  -> Thursday
            "Friday"    -> Friday
            "Saturday"  -> Saturday
            "Sunday"    -> Sunday
            else        -> throw IllegalArgumentException()
        }
    }
}
