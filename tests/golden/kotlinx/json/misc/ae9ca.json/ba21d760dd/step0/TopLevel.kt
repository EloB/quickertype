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
    val features: List<Feature>,
    val name: String,
    val type: String
)

@Serializable
data class Feature (
    val geometry: Geometry,
    val properties: Properties,
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
data class Properties (
    @SerialName("Area")
    val area: String,

    @SerialName("Central Asset ID")
    val centralAssetID: String,

    @SerialName("Feature Location")
    val featureLocation: String,

    val lat: String,
    val long: String,

    @SerialName("Maintaining Authority")
    val maintainingAuthority: MaintainingAuthority,

    @SerialName("Number")
    val number: String,

    @SerialName("Class")
    val propertiesClass: ClassEnum,

    @SerialName("Site Name")
    val siteName: String,

    @SerialName("Ward")
    val ward: Ward
)

@Serializable
enum class MaintainingAuthority(val value: String) {
    @SerialName("City of Ballarat") CityOfBallarat("City of Ballarat");
}

@Serializable
enum class ClassEnum(val value: String) {
    @SerialName("No Code Allocated") NoCodeAllocated("No Code Allocated"),
    @SerialName("OS-District") OSDistrict("OS-District"),
    @SerialName("OS-Neighbourhood") OSNeighbourhood("OS-Neighbourhood"),
    @SerialName("OS-Regional") OSRegional("OS-Regional");
}

@Serializable
enum class Ward(val value: String) {
    @SerialName("South") South("South"),
    @SerialName("North") North("North"),
    @SerialName("Central") Central("Central");
}

@Serializable
enum class FeatureType(val value: String) {
    @SerialName("Feature") Feature("Feature");
}
