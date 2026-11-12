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
    convert(GeometryType::class, { GeometryType.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(GeometryName::class, { GeometryName.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(FeatureType::class,  { FeatureType.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
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
    val coordinates: List<List<Double>>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: GeometryType
)

enum class GeometryType(val value: String) {
    MultiPoint("MultiPoint");

    companion object {
        fun fromValue(value: String): GeometryType = when (value) {
            "MultiPoint" -> MultiPoint
            else         -> throw IllegalArgumentException()
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
    val facebookaccount: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val frequencyfinderurl: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val siteurl: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val streetaddress: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val twitteraccount: String
)

enum class FeatureType(val value: String) {
    Feature("Feature");

    companion object {
        fun fromValue(value: String): FeatureType = when (value) {
            "Feature" -> Feature
            else      -> throw IllegalArgumentException()
        }
    }
}
