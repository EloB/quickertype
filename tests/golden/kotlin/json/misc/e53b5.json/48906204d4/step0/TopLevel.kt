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
    .convert(ID::class,            { ID.fromValue(it.string!!) },    { Klaxon().toJsonString(it.value) })
    .convert(Value::class,         { Value.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(TopLevelUnion::class, { TopLevelUnion.fromJson(it) },   { it.toJson() }, true)

class TopLevel(elements: Collection<TopLevelUnion>) : ArrayList<TopLevelUnion>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelUnion>(json)!!)
    }
}

sealed class TopLevelUnion {
    class FluffyTopLevelValue(val value: FluffyTopLevel)            : TopLevelUnion()
    class PurpleTopLevelArrayValue(val value: List<PurpleTopLevel>) : TopLevelUnion()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is FluffyTopLevelValue      -> this.value
        is PurpleTopLevelArrayValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): TopLevelUnion = when (jv.inside) {
            is JsonObject   -> FluffyTopLevelValue(jv.obj?.let { klaxon.parseFromJsonObject<FluffyTopLevel>(it) }!!)
            is JsonArray<*> -> PurpleTopLevelArrayValue(jv.array?.let { klaxon.parseFromJsonArray<PurpleTopLevel>(it) }!!)
            else            -> throw IllegalArgumentException()
        }
    }
}

data class PurpleTopLevel (
    val country: Country,
    val date: String,
    val decimal: String,
    val indicator: Country,
    val value: String
)

data class Country (
    val id: ID,
    val value: Value
)

enum class ID(val value: String) {
    In("IN"),
    SPPopTotl("SP.POP.TOTL");

    companion object {
        public fun fromValue(value: String): ID = when (value) {
            "IN"          -> In
            "SP.POP.TOTL" -> SPPopTotl
            else          -> throw IllegalArgumentException()
        }
    }
}

enum class Value(val value: String) {
    India("India"),
    PopulationTotal("Population, total");

    companion object {
        public fun fromValue(value: String): Value = when (value) {
            "India"             -> India
            "Population, total" -> PopulationTotal
            else                -> throw IllegalArgumentException()
        }
    }
}

data class FluffyTopLevel (
    val page: Long,
    val pages: Long,

    @Json(name = "per_page")
    val perPage: String,

    val total: Long
)
