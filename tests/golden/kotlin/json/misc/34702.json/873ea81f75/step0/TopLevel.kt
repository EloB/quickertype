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
    .convert(GeometryName::class,   { GeometryName.fromValue(it.string!!) },   { Klaxon().toJsonString(it.value) })
    .convert(FireBanR::class,       { FireBanR.fromValue(it.string!!) },       { Klaxon().toJsonString(it.value) })
    .convert(Region::class,         { Region.fromValue(it.string!!) },         { Klaxon().toJsonString(it.value) })
    .convert(PropertiesType::class, { PropertiesType.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(FeatureType::class,    { FeatureType.fromValue(it.string!!) },    { Klaxon().toJsonString(it.value) })

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
    val division: String,
    val fax: Double,

    @Json(name = "fire_ban_r")
    val fireBanR: FireBanR? = null,

    val latitude: Double,

    @Json(name = "local_govt")
    val localGovt: String,

    val longitude: Double,
    val no: String? = null,
    val phone: Double,
    val postcode: Long,
    val psa: String,
    val region: Region,
    val station: String,
    val street: String,
    val suburb: String,
    val type: PropertiesType? = null
)

enum class FireBanR(val value: String) {
    NorthCentral("North Central"),
    Central("Central"),
    SouthWest("South West"),
    Wimmera("Wimmera"),
    NorthernCountry("Northern Country"),
    EastGippsland("East Gippsland"),
    NorthEast("North East"),
    Mallee("Mallee"),
    WestSouthGippsland("West &South Gippsland"),
    Ballarat("Ballarat");

    companion object {
        public fun fromValue(value: String): FireBanR = when (value) {
            "North Central"         -> NorthCentral
            "Central"               -> Central
            "South West"            -> SouthWest
            "Wimmera"               -> Wimmera
            "Northern Country"      -> NorthernCountry
            "East Gippsland"        -> EastGippsland
            "North East"            -> NorthEast
            "Mallee"                -> Mallee
            "West &South Gippsland" -> WestSouthGippsland
            "Ballarat"              -> Ballarat
            else                    -> throw IllegalArgumentException()
        }
    }
}

enum class Region(val value: String) {
    Eastern("Eastern"),
    NorthernMetro("Northern Metro"),
    Western("Western"),
    SouthernMetro("Southern Metro");

    companion object {
        public fun fromValue(value: String): Region = when (value) {
            "Eastern"        -> Eastern
            "Northern Metro" -> NorthernMetro
            "Western"        -> Western
            "Southern Metro" -> SouthernMetro
            else             -> throw IllegalArgumentException()
        }
    }
}

enum class PropertiesType(val value: String) {
    Street("STREET"),
    Avenue("AVENUE"),
    Road("ROAD"),
    Highway("HIGHWAY"),
    Boulevard("BOULEVARD"),
    Court("COURT"),
    Way("WAY"),
    Drive("DRIVE"),
    South("SOUTH"),
    Hill("HILL"),
    Lane("LANE"),
    Close("CLOSE"),
    Parade("PARADE"),
    TypeRoad("Road"),
    Place("PLACE"),
    RD("RD");

    companion object {
        public fun fromValue(value: String): PropertiesType = when (value) {
            "STREET"    -> Street
            "AVENUE"    -> Avenue
            "ROAD"      -> Road
            "HIGHWAY"   -> Highway
            "BOULEVARD" -> Boulevard
            "COURT"     -> Court
            "WAY"       -> Way
            "DRIVE"     -> Drive
            "SOUTH"     -> South
            "HILL"      -> Hill
            "LANE"      -> Lane
            "CLOSE"     -> Close
            "PARADE"    -> Parade
            "Road"      -> TypeRoad
            "PLACE"     -> Place
            "RD"        -> RD
            else        -> throw IllegalArgumentException()
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
