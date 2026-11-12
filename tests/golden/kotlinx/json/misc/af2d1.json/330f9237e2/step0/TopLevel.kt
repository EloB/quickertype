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
    val coordinates: List<List<List<List<Double>>>>,
    val type: GeometryType
)

@Serializable
enum class GeometryType(val value: String) {
    @SerialName("MultiPolygon") MultiPolygon("MultiPolygon");
}

@Serializable
enum class GeometryName(val value: String) {
    @SerialName("geom") Geom("geom");
}

@Serializable
data class FeatureProperties (
    @SerialName("add_improv")
    val addImprov: AddImprov? = null,

    @SerialName("area_")
    val area: Double,

    @SerialName("asset_numb")
    val assetNumb: String,

    val comments: String? = null,
    val condition: Long,
    val constructi: String? = null,
    val createdate: JsonElement? = null,
    val createuser: JsonElement? = null,

    @SerialName("disposal_d")
    val disposalD: JsonElement? = null,

    val documents: String,

    @SerialName("drawing_nu")
    val drawingNu: String? = null,

    @SerialName("file_numbe")
    val fileNumbe: String? = null,

    @SerialName("folder_num")
    val folderNum: String? = null,

    @SerialName("funding_ba")
    val fundingBa: FundingBa? = null,

    @SerialName("historic_c")
    val historicC: Long,

    val inspection: String,
    val inspectors: JsonElement? = null,

    @SerialName("last_updat")
    val lastUpdat: JsonElement? = null,

    @SerialName("level_accu")
    val levelAccu: LevelAccu? = null,

    val material: Material,

    @SerialName("mi_prinx")
    val miPrinx: Long,

    @SerialName("mi_symbolo")
    val miSymbolo: MiSymbolo,

    @SerialName("number_lan")
    val numberLAN: Long,

    val owner: String? = null,
    val positional: LevelAccu? = null,

    @SerialName("project_nu")
    val projectNu: String? = null,

    @SerialName("rec_id")
    val recID: Long,

    @SerialName("record_cre")
    val recordCre: String? = null,

    @SerialName("shape_area")
    val shapeArea: Double,

    @SerialName("shape_leng")
    val shapeLeng: Double,

    val status: Status,

    @SerialName("survey_num")
    val surveyNum: JsonElement? = null,

    @SerialName("toe_rl")
    val toeRl: Double,

    @SerialName("top_rl")
    val topRl: Double,

    val type: PropertiesType? = null,

    @SerialName("update_dat")
    val updateDAT: String,

    val updatedate: JsonElement? = null,
    val updateuser: JsonElement? = null
)

@Serializable
enum class AddImprov(val value: String) {
    @SerialName("f") F("f"),
    @SerialName("F") AddImprovF("F"),
    @SerialName("t") T("t");
}

@Serializable
enum class FundingBa(val value: String) {
    @SerialName("Non GCCC") NonGCCC("Non GCCC"),
    @SerialName("Capex") Capex("Capex"),
    @SerialName("Initial") Initial("Initial"),
    @SerialName("Contribute") Contribute("Contribute");
}

@Serializable
enum class LevelAccu(val value: String) {
    @SerialName("GPS Corrected 1.0M") GPSCorrected10M("GPS Corrected 1.0M"),
    @SerialName("APPROX") Approx("APPROX"),
    @SerialName("GPS COrrected 1.0M") GPSCOrrected10M("GPS COrrected 1.0M");
}

@Serializable
enum class Material(val value: String) {
    @SerialName("Gravel") Gravel("Gravel"),
    @SerialName("Concrete") Concrete("Concrete"),
    @SerialName("Bitumen") Bitumen("Bitumen"),
    @SerialName("Interlock Conc Block") InterlockConcBlock("Interlock Conc Block"),
    @SerialName("Other") Other("Other"),
    @SerialName("Earth") Earth("Earth");
}

@Serializable
enum class MiSymbolo(val value: String) {
    @SerialName("Pen (2, 2, 65535) Brush (1, 0, 16777215)") Pen2265535Brush1016777215("Pen (2, 2, 65535) Brush (1, 0, 16777215)");
}

@Serializable
enum class Status(val value: String) {
    @SerialName("CURRENT") Current("CURRENT");
}

@Serializable
enum class PropertiesType(val value: String) {
    @SerialName("Boat Ramp") BoatRamp("Boat Ramp");
}

@Serializable
enum class FeatureType(val value: String) {
    @SerialName("Feature") Feature("Feature");
}
