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
    val bbox: List<Double>,
    val features: List<Feature>,
    val metadata: Metadata,
    val type: String
)

@Serializable
data class Feature (
    val geometry: Geometry,
    val id: String,
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
    val alert: JsonElement? = null,
    val cdi: JsonElement? = null,
    val code: String,
    val detail: String,
    val dmin: Double? = null,
    val felt: JsonElement? = null,
    val gap: Long? = null,
    val ids: String,
    val mag: Double,
    val magType: MagType,
    val mmi: JsonElement? = null,
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

@Serializable
enum class MagType(val value: String) {
    @SerialName("md") Md("md"),
    @SerialName("ml") Ml("ml"),
    @SerialName("mb") MB("mb");
}

@Serializable
enum class Status(val value: String) {
    @SerialName("automatic") Automatic("automatic"),
    @SerialName("reviewed") Reviewed("reviewed");
}

@Serializable
enum class PropertiesType(val value: String) {
    @SerialName("earthquake") Earthquake("earthquake");
}

@Serializable
enum class FeatureType(val value: String) {
    @SerialName("Feature") Feature("Feature");
}

@Serializable
data class Metadata (
    val api: String,
    val count: Long,
    val generated: Long,
    val status: Long,
    val title: String,
    val url: String
)
