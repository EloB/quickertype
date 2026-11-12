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
    .convert(Fall::class,     { Fall.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(Type::class,     { Type.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(Nametype::class, { Nametype.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

data class TopLevelElement (
    @Json(name = ":@computed_region_cbhk_fwbd")
    val computedRegionCbhkFwbd: String? = null,

    @Json(name = ":@computed_region_nnqa_25f4")
    val computedRegionNnqa25F4: String? = null,

    val fall: Fall,
    val geolocation: Geolocation? = null,
    val id: String,
    val mass: String? = null,
    val name: String,
    val nametype: Nametype,
    val recclass: String,
    val reclat: String? = null,
    val reclong: String? = null,
    val year: String? = null
)

enum class Fall(val value: String) {
    Fell("Fell"),
    Found("Found");

    companion object {
        public fun fromValue(value: String): Fall = when (value) {
            "Fell"  -> Fell
            "Found" -> Found
            else    -> throw IllegalArgumentException()
        }
    }
}

data class Geolocation (
    val coordinates: List<Double>,
    val type: Type
)

enum class Type(val value: String) {
    Point("Point");

    companion object {
        public fun fromValue(value: String): Type = when (value) {
            "Point" -> Point
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Nametype(val value: String) {
    Valid("Valid");

    companion object {
        public fun fromValue(value: String): Nametype = when (value) {
            "Valid" -> Valid
            else    -> throw IllegalArgumentException()
        }
    }
}
