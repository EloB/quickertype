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
    convert(Axis::class, { Axis.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Name::class, { Name.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    val version: String? = null,
    val fruits: List<Fruit>? = null,
    val vehicles: List<Vehicle>? = null
) {
    init {
        version?.let { require(Regex("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}\$").containsMatchIn(it)) }
    }
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Fruit (
    val apple: Boolean? = null,
    val berries: List<Berry>? = null,
    val orange: Boolean? = null
)

data class Berry (
    val color: Color? = null,
    val name: String? = null,
    val shapes: List<Shape>? = null
)

data class Color (
    val rgb: Double? = null
)

data class Shape (
    val geometry: Geometry? = null,
    val history: History? = null
)

data class Geometry (
    val rectShape: RectShape? = null,
    val circularShape: List<CircularShape>? = null
)

data class CircularShape (
    val shapeName: String? = null
)

data class RectShape (
    val parts: List<Part>? = null
)

data class Part (
    val depth: String? = null,
    val length: String? = null,
    val width: String? = null
)

data class History (
    @get:JsonProperty("class")@field:JsonProperty("class")
    val historyClass: String? = null
)

data class Vehicle (
    val brand: String? = null,
    val id: String? = null,
    val speed: Speed? = null,
    val subModule: Boolean? = null,
    val type: VehicleType? = null,
    val year: String? = null
)

data class Speed (
    val velocity: Limit? = null
)

data class Limit (
    val maximum: Double? = null,
    val minimum: Double? = null
)

data class VehicleType (
    val name: Name? = null,
    val width: Axis? = null,
    val length: Axis? = null
)

enum class Axis(val value: String) {
    X("X"),
    Y("Y"),
    Z("Z"),
    Xy("XY"),
    Yz("YZ"),
    Zx("ZX");

    companion object {
        fun fromValue(value: String): Axis = when (value) {
            "X"  -> X
            "Y"  -> Y
            "Z"  -> Z
            "XY" -> Xy
            "YZ" -> Yz
            "ZX" -> Zx
            else -> throw IllegalArgumentException()
        }
    }
}

enum class Name(val value: String) {
    Truck("truck"),
    Bus("bus"),
    Car("car"),
    Van("van"),
    Train("train"),
    Bike("Bike"),
    Aeroplane("Aeroplane"),
    Jeep("Jeep"),
    Trolley("Trolley");

    companion object {
        fun fromValue(value: String): Name = when (value) {
            "truck"     -> Truck
            "bus"       -> Bus
            "car"       -> Car
            "van"       -> Van
            "train"     -> Train
            "Bike"      -> Bike
            "Aeroplane" -> Aeroplane
            "Jeep"      -> Jeep
            "Trolley"   -> Trolley
            else        -> throw IllegalArgumentException()
        }
    }
}
