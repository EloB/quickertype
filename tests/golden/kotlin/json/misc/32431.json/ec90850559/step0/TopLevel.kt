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
    .convert(GeometryType::class,   { GeometryType.fromValue(it.string!!) },   { Klaxon().toJsonString(it.value) })
    .convert(MagType::class,        { MagType.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })
    .convert(Status::class,         { Status.fromValue(it.string!!) },         { Klaxon().toJsonString(it.value) })
    .convert(PropertiesType::class, { PropertiesType.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(FeatureType::class,    { FeatureType.fromValue(it.string!!) },    { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val bbox: List<Double>,
    val features: List<Feature>,
    val metadata: Metadata,
    val type: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Feature (
    val geometry: Geometry,
    val id: String,
    val properties: Properties,
    val type: FeatureType
)

data class Geometry (
    val coordinates: List<Double>,
    val type: GeometryType
)

enum class GeometryType(val value: String) {
    Point("Point");

    companion object {
        public fun fromValue(value: String): GeometryType = when (value) {
            "Point" -> Point
            else    -> throw IllegalArgumentException()
        }
    }
}

data class Properties (
    val alert: Any? = null,
    val cdi: Any? = null,
    val code: String,
    val detail: String,
    val dmin: Double? = null,
    val felt: Any? = null,
    val gap: Long? = null,
    val ids: String,
    val mag: Double,
    val magType: MagType,
    val mmi: Any? = null,
    val net: String,
    val nst: Long? = null,
    val place: String,
    val rms: Double,
    val sig: Long,
    val sources: String,
    val status: Status,
    val time: Long,
    val title: String,
    val tsunami: Long,
    val type: PropertiesType,
    val types: String,
    val tz: Long,
    val updated: Long,
    val url: String
)

enum class MagType(val value: String) {
    Md("md"),
    Ml("ml"),
    MB("mb");

    companion object {
        public fun fromValue(value: String): MagType = when (value) {
            "md" -> Md
            "ml" -> Ml
            "mb" -> MB
            else -> throw IllegalArgumentException()
        }
    }
}

enum class Status(val value: String) {
    Automatic("automatic"),
    Reviewed("reviewed");

    companion object {
        public fun fromValue(value: String): Status = when (value) {
            "automatic" -> Automatic
            "reviewed"  -> Reviewed
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class PropertiesType(val value: String) {
    Earthquake("earthquake");

    companion object {
        public fun fromValue(value: String): PropertiesType = when (value) {
            "earthquake" -> Earthquake
            else         -> throw IllegalArgumentException()
        }
    }
}

enum class FeatureType(val value: String) {
    Feature("Feature");

    companion object {
        public fun fromValue(value: String): FeatureType = when (value) {
            "Feature" -> Feature
            else      -> throw IllegalArgumentException()
        }
    }
}

data class Metadata (
    val api: String,
    val count: Long,
    val generated: Long,
    val status: Long,
    val title: String,
    val url: String
)
