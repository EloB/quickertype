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
    .convert(Callsign::class, { Callsign.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Priority::class, { Priority.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val callsign: Callsign,
    val priority: Priority
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

enum class Callsign(val value: String) {
    Alpha("alpha"),
    Bravo("bravo"),
    Charlie("charlie"),
    Delta("delta"),
    Echo("echo"),
    Foxtrot("foxtrot"),
    Golf("golf"),
    Hotel("hotel"),
    India("india"),
    Juliett("juliett"),
    Kilo("kilo"),
    Lima("lima"),
    Mike("mike"),
    November("november"),
    Oscar("oscar"),
    Papa("papa"),
    Quebec("quebec"),
    Romeo("romeo"),
    Sierra("sierra"),
    Tango("tango");

    companion object {
        public fun fromValue(value: String): Callsign = when (value) {
            "alpha"    -> Alpha
            "bravo"    -> Bravo
            "charlie"  -> Charlie
            "delta"    -> Delta
            "echo"     -> Echo
            "foxtrot"  -> Foxtrot
            "golf"     -> Golf
            "hotel"    -> Hotel
            "india"    -> India
            "juliett"  -> Juliett
            "kilo"     -> Kilo
            "lima"     -> Lima
            "mike"     -> Mike
            "november" -> November
            "oscar"    -> Oscar
            "papa"     -> Papa
            "quebec"   -> Quebec
            "romeo"    -> Romeo
            "sierra"   -> Sierra
            "tango"    -> Tango
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class Priority(val value: String) {
    Low("low"),
    Medium("medium"),
    High("high");

    companion object {
        public fun fromValue(value: String): Priority = when (value) {
            "low"    -> Low
            "medium" -> Medium
            "high"   -> High
            else     -> throw IllegalArgumentException()
        }
    }
}
