// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val crs: CRS,
    val features: List<Feature>,
    val totalFeatures: Long,
    val type: String
)

@Serializable
data class CRS (
    val properties: CRSProperties,
    val type: String
)

@Serializable
data class CRSProperties (
    val name: String
)

@Serializable
data class Feature (
    val geometry: Geometry,

    @SerialName("geometry_name")
    val geometryName: GeometryName,

    val id: String,
    val properties: FeatureProperties,
    val type: FeatureType
)

@Serializable
data class Geometry (
    val coordinates: List<Double>,
    val type: GeometryType
)

@Serializable
enum class GeometryType(val value: String) {
    @SerialName("Point") Point("Point");
}

@Serializable
enum class GeometryName(val value: String) {
    @SerialName("geom") Geom("geom");
}

@Serializable
data class FeatureProperties (
    val division: String,
    val fax: Double,

    @SerialName("fire_ban_r")
    val fireBanR: FireBanR? = null,

    val latitude: Double,

    @SerialName("local_govt")
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

@Serializable
enum class FireBanR(val value: String) {
    @SerialName("North Central") NorthCentral("North Central"),
    @SerialName("Central") Central("Central"),
    @SerialName("South West") SouthWest("South West"),
    @SerialName("Wimmera") Wimmera("Wimmera"),
    @SerialName("Northern Country") NorthernCountry("Northern Country"),
    @SerialName("East Gippsland") EastGippsland("East Gippsland"),
    @SerialName("North East") NorthEast("North East"),
    @SerialName("Mallee") Mallee("Mallee"),
    @SerialName("West &South Gippsland") WestSouthGippsland("West &South Gippsland"),
    @SerialName("Ballarat") Ballarat("Ballarat");
}

@Serializable
enum class Region(val value: String) {
    @SerialName("Eastern") Eastern("Eastern"),
    @SerialName("Northern Metro") NorthernMetro("Northern Metro"),
    @SerialName("Western") Western("Western"),
    @SerialName("Southern Metro") SouthernMetro("Southern Metro");
}

@Serializable
enum class PropertiesType(val value: String) {
    @SerialName("STREET") Street("STREET"),
    @SerialName("AVENUE") Avenue("AVENUE"),
    @SerialName("ROAD") Road("ROAD"),
    @SerialName("HIGHWAY") Highway("HIGHWAY"),
    @SerialName("BOULEVARD") Boulevard("BOULEVARD"),
    @SerialName("COURT") Court("COURT"),
    @SerialName("WAY") Way("WAY"),
    @SerialName("DRIVE") Drive("DRIVE"),
    @SerialName("SOUTH") South("SOUTH"),
    @SerialName("HILL") Hill("HILL"),
    @SerialName("LANE") Lane("LANE"),
    @SerialName("CLOSE") Close("CLOSE"),
    @SerialName("PARADE") Parade("PARADE"),
    @SerialName("Road") TypeRoad("Road"),
    @SerialName("PLACE") Place("PLACE"),
    @SerialName("RD") RD("RD");
}

@Serializable
enum class FeatureType(val value: String) {
    @SerialName("Feature") Feature("Feature");
}
