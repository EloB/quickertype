// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*


@Suppress("UNCHECKED_CAST")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {
    addSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {
            override fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
    })
    addDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {
            override fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree())
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(GeometryType::class,   { GeometryType.fromValue(it.asText()) },   { ObjectMapper().writeValueAsString(it.value) })
    convert(GeometryName::class,   { GeometryName.fromValue(it.asText()) },   { ObjectMapper().writeValueAsString(it.value) })
    convert(AddImprov::class,      { AddImprov.fromValue(it.asText()) },      { ObjectMapper().writeValueAsString(it.value) })
    convert(FundingBa::class,      { FundingBa.fromValue(it.asText()) },      { ObjectMapper().writeValueAsString(it.value) })
    convert(LevelAccu::class,      { LevelAccu.fromValue(it.asText()) },      { ObjectMapper().writeValueAsString(it.value) })
    convert(Material::class,       { Material.fromValue(it.asText()) },       { ObjectMapper().writeValueAsString(it.value) })
    convert(MiSymbolo::class,      { MiSymbolo.fromValue(it.asText()) },      { ObjectMapper().writeValueAsString(it.value) })
    convert(Status::class,         { Status.fromValue(it.asText()) },         { ObjectMapper().writeValueAsString(it.value) })
    convert(PropertiesType::class, { PropertiesType.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(FeatureType::class,    { FeatureType.fromValue(it.asText()) },    { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val crs: CRS,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val features: List<Feature>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val totalFeatures: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class CRS (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val properties: CRSProperties,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class CRSProperties (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String
)

data class Feature (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val geometry: Geometry,

    @get:JsonProperty("geometry_name", required=true)@field:JsonProperty("geometry_name", required=true)
    val geometryName: GeometryName,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val properties: FeatureProperties,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: FeatureType
)

data class Geometry (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val coordinates: List<List<List<List<Double>>>>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: GeometryType
)

enum class GeometryType(val value: String) {
    MultiPolygon("MultiPolygon");

    companion object {
        fun fromValue(value: String): GeometryType = when (value) {
            "MultiPolygon" -> MultiPolygon
            else           -> throw IllegalArgumentException()
        }
    }
}

enum class GeometryName(val value: String) {
    Geom("geom");

    companion object {
        fun fromValue(value: String): GeometryName = when (value) {
            "geom" -> Geom
            else   -> throw IllegalArgumentException()
        }
    }
}

data class FeatureProperties (
    @get:JsonProperty("add_improv", required=true)@field:JsonProperty("add_improv", required=true)
    val addImprov: AddImprov?,

    @get:JsonProperty("area_", required=true)@field:JsonProperty("area_", required=true)
    val area: Double,

    @get:JsonProperty("asset_numb", required=true)@field:JsonProperty("asset_numb", required=true)
    val assetNumb: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val comments: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val condition: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val constructi: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val createdate: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val createuser: Any? = null,

    @get:JsonProperty("disposal_d", required=true)@field:JsonProperty("disposal_d", required=true)
    val disposalD: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val documents: String,

    @get:JsonProperty("drawing_nu", required=true)@field:JsonProperty("drawing_nu", required=true)
    val drawingNu: String?,

    @get:JsonProperty("file_numbe", required=true)@field:JsonProperty("file_numbe", required=true)
    val fileNumbe: String?,

    @get:JsonProperty("folder_num", required=true)@field:JsonProperty("folder_num", required=true)
    val folderNum: String?,

    @get:JsonProperty("funding_ba", required=true)@field:JsonProperty("funding_ba", required=true)
    val fundingBa: FundingBa?,

    @get:JsonProperty("historic_c", required=true)@field:JsonProperty("historic_c", required=true)
    val historicC: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inspection: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inspectors: Any? = null,

    @get:JsonProperty("last_updat", required=true)@field:JsonProperty("last_updat", required=true)
    val lastUpdat: Any? = null,

    @get:JsonProperty("level_accu", required=true)@field:JsonProperty("level_accu", required=true)
    val levelAccu: LevelAccu?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val material: Material,

    @get:JsonProperty("mi_prinx", required=true)@field:JsonProperty("mi_prinx", required=true)
    val miPrinx: Long,

    @get:JsonProperty("mi_symbolo", required=true)@field:JsonProperty("mi_symbolo", required=true)
    val miSymbolo: MiSymbolo,

    @get:JsonProperty("number_lan", required=true)@field:JsonProperty("number_lan", required=true)
    val numberLAN: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val owner: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val positional: LevelAccu?,

    @get:JsonProperty("project_nu", required=true)@field:JsonProperty("project_nu", required=true)
    val projectNu: String?,

    @get:JsonProperty("rec_id", required=true)@field:JsonProperty("rec_id", required=true)
    val recID: Long,

    @get:JsonProperty("record_cre", required=true)@field:JsonProperty("record_cre", required=true)
    val recordCre: String?,

    @get:JsonProperty("shape_area", required=true)@field:JsonProperty("shape_area", required=true)
    val shapeArea: Double,

    @get:JsonProperty("shape_leng", required=true)@field:JsonProperty("shape_leng", required=true)
    val shapeLeng: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Status,

    @get:JsonProperty("survey_num", required=true)@field:JsonProperty("survey_num", required=true)
    val surveyNum: Any? = null,

    @get:JsonProperty("toe_rl", required=true)@field:JsonProperty("toe_rl", required=true)
    val toeRl: Double,

    @get:JsonProperty("top_rl", required=true)@field:JsonProperty("top_rl", required=true)
    val topRl: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: PropertiesType?,

    @get:JsonProperty("update_dat", required=true)@field:JsonProperty("update_dat", required=true)
    val updateDAT: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val updatedate: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val updateuser: Any? = null
)

enum class AddImprov(val value: String) {
    F("f"),
    AddImprovF("F"),
    T("t");

    companion object {
        fun fromValue(value: String): AddImprov = when (value) {
            "f"  -> F
            "F"  -> AddImprovF
            "t"  -> T
            else -> throw IllegalArgumentException()
        }
    }
}

enum class FundingBa(val value: String) {
    NonGCCC("Non GCCC"),
    Capex("Capex"),
    Initial("Initial"),
    Contribute("Contribute");

    companion object {
        fun fromValue(value: String): FundingBa = when (value) {
            "Non GCCC"   -> NonGCCC
            "Capex"      -> Capex
            "Initial"    -> Initial
            "Contribute" -> Contribute
            else         -> throw IllegalArgumentException()
        }
    }
}

enum class LevelAccu(val value: String) {
    GPSCorrected10M("GPS Corrected 1.0M"),
    Approx("APPROX"),
    GPSCOrrected10M("GPS COrrected 1.0M");

    companion object {
        fun fromValue(value: String): LevelAccu = when (value) {
            "GPS Corrected 1.0M" -> GPSCorrected10M
            "APPROX"             -> Approx
            "GPS COrrected 1.0M" -> GPSCOrrected10M
            else                 -> throw IllegalArgumentException()
        }
    }
}

enum class Material(val value: String) {
    Gravel("Gravel"),
    Concrete("Concrete"),
    Bitumen("Bitumen"),
    InterlockConcBlock("Interlock Conc Block"),
    Other("Other"),
    Earth("Earth");

    companion object {
        fun fromValue(value: String): Material = when (value) {
            "Gravel"               -> Gravel
            "Concrete"             -> Concrete
            "Bitumen"              -> Bitumen
            "Interlock Conc Block" -> InterlockConcBlock
            "Other"                -> Other
            "Earth"                -> Earth
            else                   -> throw IllegalArgumentException()
        }
    }
}

enum class MiSymbolo(val value: String) {
    Pen2265535Brush1016777215("Pen (2, 2, 65535) Brush (1, 0, 16777215)");

    companion object {
        fun fromValue(value: String): MiSymbolo = when (value) {
            "Pen (2, 2, 65535) Brush (1, 0, 16777215)" -> Pen2265535Brush1016777215
            else                                       -> throw IllegalArgumentException()
        }
    }
}

enum class Status(val value: String) {
    Current("CURRENT");

    companion object {
        fun fromValue(value: String): Status = when (value) {
            "CURRENT" -> Current
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class PropertiesType(val value: String) {
    BoatRamp("Boat Ramp");

    companion object {
        fun fromValue(value: String): PropertiesType = when (value) {
            "Boat Ramp" -> BoatRamp
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class FeatureType(val value: String) {
    Feature("Feature");

    companion object {
        fun fromValue(value: String): FeatureType = when (value) {
            "Feature" -> Feature
            else      -> throw IllegalArgumentException()
        }
    }
}
