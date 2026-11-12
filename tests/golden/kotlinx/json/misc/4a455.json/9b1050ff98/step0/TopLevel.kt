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
    val coordinates: List<List<Double>>,
    val type: GeometryType
)

@Serializable
enum class GeometryType(val value: String) {
    @SerialName("MultiPoint") MultiPoint("MultiPoint");
}

@Serializable
enum class GeometryName(val value: String) {
    @SerialName("geom") Geom("geom");
}

@Serializable
data class FeatureProperties (
    val facebookaccount: String,
    val frequencyfinderurl: String,
    val name: String,
    val siteurl: String,
    val streetaddress: String,
    val twitteraccount: String
)

@Serializable
enum class FeatureType(val value: String) {
    @SerialName("Feature") Feature("Feature");
}
