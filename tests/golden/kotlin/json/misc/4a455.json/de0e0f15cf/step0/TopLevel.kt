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
    .convert(GeometryType::class, { GeometryType.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(GeometryName::class, { GeometryName.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(FeatureType::class,  { FeatureType.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val crs: CRS,
    val features: List<Feature>,
    val totalFeatures: Long,
    val type: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class CRS (
    val properties: CRSProperties,
    val type: String
)

data class CRSProperties (
    val name: String
)

data class Feature (
    val geometry: Geometry,

    @Json(name = "geometry_name")
    val geometryName: GeometryName,

    val id: String,
    val properties: FeatureProperties,
    val type: FeatureType
)

data class Geometry (
    val coordinates: List<List<Double>>,
    val type: GeometryType
)

enum class GeometryType(val value: String) {
    MultiPoint("MultiPoint");

    companion object {
        public fun fromValue(value: String): GeometryType = when (value) {
            "MultiPoint" -> MultiPoint
            else         -> throw IllegalArgumentException()
        }
    }
}

enum class GeometryName(val value: String) {
    Geom("geom");

    companion object {
        public fun fromValue(value: String): GeometryName = when (value) {
            "geom" -> Geom
            else   -> throw IllegalArgumentException()
        }
    }
}

data class FeatureProperties (
    val facebookaccount: String,
    val frequencyfinderurl: String,
    val name: String,
    val siteurl: String,
    val streetaddress: String,
    val twitteraccount: String
)

enum class FeatureType(val value: String) {
    Feature("Feature");

    companion object {
        public fun fromValue(value: String): FeatureType = when (value) {
            "Feature" -> Feature
            else      -> throw IllegalArgumentException()
        }
    }
}
