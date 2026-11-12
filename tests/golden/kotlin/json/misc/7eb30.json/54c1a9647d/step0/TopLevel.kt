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
    .convert(Code::class,     { Code.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(English::class,  { English.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })
    .convert(Thai::class,     { Thai.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(Location::class, { Location.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Tel::class,      { Tel.fromValue(it.string!!) },      { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val count: Long,
    val next: String,
    val previous: Any? = null,
    val results: List<Result>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Result (
    val code: String,
    val english: String,
    val fav: Boolean,
    val group: Group,
    val location: Location,

    @Json(name = "min_screens")
    val minScreens: Long,

    @Json(name = "num_views")
    val numViews: Long,

    val showtimes: String,
    val stars: Long,
    val tel: Tel,
    val thai: String,

    @Json(name = "today_screens")
    val todayScreens: Long,

    val url: String,
    val website: String
)

data class Group (
    val code: Code,
    val english: English,
    val thai: Thai,
    val website: String
)

enum class Code(val value: String) {
    Sf("sf");

    companion object {
        public fun fromValue(value: String): Code = when (value) {
            "sf" -> Sf
            else -> throw IllegalArgumentException()
        }
    }
}

enum class English(val value: String) {
    Sf("SF");

    companion object {
        public fun fromValue(value: String): English = when (value) {
            "SF" -> Sf
            else -> throw IllegalArgumentException()
        }
    }
}

enum class Thai(val value: String) {
    เอสเอฟ("เอสเอฟ");

    companion object {
        public fun fromValue(value: String): Thai = when (value) {
            "เอสเอฟ" -> เอสเอฟ
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class Location(val value: String) {
    Empty(""),
    The5ThFLEmporium("5th Fl. Emporium");

    companion object {
        public fun fromValue(value: String): Location = when (value) {
            ""                 -> Empty
            "5th Fl. Emporium" -> The5ThFLEmporium
            else               -> throw IllegalArgumentException()
        }
    }
}

enum class Tel(val value: String) {
    Empty(""),
    The022688899("02-268-8899");

    companion object {
        public fun fromValue(value: String): Tel = when (value) {
            ""            -> Empty
            "02-268-8899" -> The022688899
            else          -> throw IllegalArgumentException()
        }
    }
}
