// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(Axis::class, { Axis.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Name::class, { Name.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val version: String? = null,
    val fruits: List<Fruit>? = null,
    val vehicles: List<Vehicle>? = null
) {
    init {
        version?.let { require(Regex("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}\$").containsMatchIn(it)) }
    }
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
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
    @Json(name = "class")
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
        public fun fromValue(value: String): Axis = when (value) {
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
        public fun fromValue(value: String): Name = when (value) {
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
