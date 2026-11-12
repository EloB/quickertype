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
    convert(GeometryType::class,         { GeometryType.fromValue(it.asText()) },         { ObjectMapper().writeValueAsString(it.value) })
    convert(MaintainingAuthority::class, { MaintainingAuthority.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(ClassEnum::class,            { ClassEnum.fromValue(it.asText()) },            { ObjectMapper().writeValueAsString(it.value) })
    convert(Ward::class,                 { Ward.fromValue(it.asText()) },                 { ObjectMapper().writeValueAsString(it.value) })
    convert(FeatureType::class,          { FeatureType.fromValue(it.asText()) },          { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val features: List<Feature>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

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
    @get:JsonProperty("Area", required=true)@field:JsonProperty("Area", required=true)
    val area: String,

    @get:JsonProperty("Central Asset ID", required=true)@field:JsonProperty("Central Asset ID", required=true)
    val centralAssetID: String,

    @get:JsonProperty("Feature Location", required=true)@field:JsonProperty("Feature Location", required=true)
    val featureLocation: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lat: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val long: String,

    @get:JsonProperty("Maintaining Authority", required=true)@field:JsonProperty("Maintaining Authority", required=true)
    val maintainingAuthority: MaintainingAuthority,

    @get:JsonProperty("Number", required=true)@field:JsonProperty("Number", required=true)
    val number: String,

    @get:JsonProperty("Class", required=true)@field:JsonProperty("Class", required=true)
    val propertiesClass: ClassEnum,

    @get:JsonProperty("Site Name", required=true)@field:JsonProperty("Site Name", required=true)
    val siteName: String,

    @get:JsonProperty("Ward", required=true)@field:JsonProperty("Ward", required=true)
    val ward: Ward
)

enum class MaintainingAuthority(val value: String) {
    CityOfBallarat("City of Ballarat");

    companion object {
        fun fromValue(value: String): MaintainingAuthority = when (value) {
            "City of Ballarat" -> CityOfBallarat
            else               -> throw IllegalArgumentException()
        }
    }
}

enum class ClassEnum(val value: String) {
    NoCodeAllocated("No Code Allocated"),
    OSDistrict("OS-District"),
    OSNeighbourhood("OS-Neighbourhood"),
    OSRegional("OS-Regional");

    companion object {
        fun fromValue(value: String): ClassEnum = when (value) {
            "No Code Allocated" -> NoCodeAllocated
            "OS-District"       -> OSDistrict
            "OS-Neighbourhood"  -> OSNeighbourhood
            "OS-Regional"       -> OSRegional
            else                -> throw IllegalArgumentException()
        }
    }
}

enum class Ward(val value: String) {
    South("South"),
    North("North"),
    Central("Central");

    companion object {
        fun fromValue(value: String): Ward = when (value) {
            "South"   -> South
            "North"   -> North
            "Central" -> Central
            else      -> throw IllegalArgumentException()
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
