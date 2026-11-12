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

// Klaxon cannot deserialize map values typed as JsonObject, so fields
// holding such maps are converted at the field level instead.
@Target(AnnotationTarget.FIELD)
private annotation class KlaxonJsonObjectMap

private val jsonObjectMapConverter: Converter = object : Converter {
    override fun canConvert(cls: Class<*>) = true
    override fun fromJson(jv: JsonValue)   = jv.obj!!
    override fun toJson(value: Any)        = klaxon.toJsonString(value)
}

private val klaxon = Klaxon()
    .convert(JsonObject::class, { it.obj!! }, { it.toJsonString() })
    .fieldConverter(KlaxonJsonObjectMap::class, jsonObjectMapConverter)

data class TopLevel (
    @Json(name = "mission_specs")
    val missionSpecs: Map<String, MissionSpec>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class MissionSpec (
    val objectives: Map<String, Objective>
)

data class Objective (
    @KlaxonJsonObjectMap
    val rewards: Map<String, Reward>
)

typealias Reward = JsonObject
