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
    convert(FireBanR::class,       { FireBanR.fromValue(it.asText()) },       { ObjectMapper().writeValueAsString(it.value) })
    convert(Region::class,         { Region.fromValue(it.asText()) },         { ObjectMapper().writeValueAsString(it.value) })
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
    val coordinates: List<Double>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: GeometryType
)

enum class GeometryType(val value: String) {
    Point("Point");

    companion object {
        fun fromValue(value: String): GeometryType = when (value) {
            "Point" -> Point
            else    -> throw IllegalArgumentException()
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
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val division: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fax: Double,

    @get:JsonProperty("fire_ban_r", required=true)@field:JsonProperty("fire_ban_r", required=true)
    val fireBanR: FireBanR?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val latitude: Double,

    @get:JsonProperty("local_govt", required=true)@field:JsonProperty("local_govt", required=true)
    val localGovt: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val longitude: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val no: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val phone: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val postcode: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val psa: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val region: Region,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val station: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val street: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val suburb: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: PropertiesType?
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
        fun fromValue(value: String): FireBanR = when (value) {
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
        fun fromValue(value: String): Region = when (value) {
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
        fun fromValue(value: String): PropertiesType = when (value) {
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
        fun fromValue(value: String): FeatureType = when (value) {
            "Feature" -> Feature
            else      -> throw IllegalArgumentException()
        }
    }
}
