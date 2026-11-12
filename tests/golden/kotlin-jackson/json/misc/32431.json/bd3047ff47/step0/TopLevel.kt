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
    convert(MagType::class,        { MagType.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
    convert(Status::class,         { Status.fromValue(it.asText()) },         { ObjectMapper().writeValueAsString(it.value) })
    convert(PropertiesType::class, { PropertiesType.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(FeatureType::class,    { FeatureType.fromValue(it.asText()) },    { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bbox: List<Double>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val features: List<Feature>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val metadata: Metadata,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Feature (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val geometry: Geometry,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val properties: Properties,

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

data class Properties (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val alert: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cdi: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val detail: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dmin: Double?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val felt: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gap: Long?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ids: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mag: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val magType: MagType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val mmi: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val net: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nst: Long?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val place: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rms: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sig: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Status,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val time: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tsunami: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: PropertiesType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val types: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tz: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val updated: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

enum class MagType(val value: String) {
    Md("md"),
    Ml("ml"),
    MB("mb");

    companion object {
        fun fromValue(value: String): MagType = when (value) {
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
        fun fromValue(value: String): Status = when (value) {
            "automatic" -> Automatic
            "reviewed"  -> Reviewed
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class PropertiesType(val value: String) {
    Earthquake("earthquake");

    companion object {
        fun fromValue(value: String): PropertiesType = when (value) {
            "earthquake" -> Earthquake
            else         -> throw IllegalArgumentException()
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

data class Metadata (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val api: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val count: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val generated: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)
