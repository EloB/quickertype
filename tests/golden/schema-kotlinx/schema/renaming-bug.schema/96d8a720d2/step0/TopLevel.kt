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
    val version: String? = null,
    val fruits: List<Fruit>? = null,
    val vehicles: List<Vehicle>? = null
)

@Serializable
data class Fruit (
    val apple: Boolean? = null,
    val berries: List<Berry>? = null,
    val orange: Boolean? = null
)

@Serializable
data class Berry (
    val color: Color? = null,
    val name: String? = null,
    val shapes: List<Shape>? = null
)

@Serializable
data class Color (
    val rgb: Double? = null
)

@Serializable
data class Shape (
    val geometry: Geometry? = null,
    val history: History? = null
)

@Serializable
data class Geometry (
    val rectShape: RectShape? = null,
    val circularShape: List<CircularShape>? = null
)

@Serializable
data class CircularShape (
    val shapeName: String? = null
)

@Serializable
data class RectShape (
    val parts: List<Part>? = null
)

@Serializable
data class Part (
    val depth: String? = null,
    val length: String? = null,
    val width: String? = null
)

@Serializable
data class History (
    @SerialName("class")
    val historyClass: String? = null
)

@Serializable
data class Vehicle (
    val brand: String? = null,
    val id: String? = null,
    val speed: Speed? = null,
    val subModule: Boolean? = null,
    val type: VehicleType? = null,
    val year: String? = null
)

@Serializable
data class Speed (
    val velocity: Limit? = null
)

@Serializable
data class Limit (
    val maximum: Double? = null,
    val minimum: Double? = null
)

@Serializable
data class VehicleType (
    val name: Name? = null,
    val width: Axis? = null,
    val length: Axis? = null
)

@Serializable
enum class Axis(val value: String) {
    @SerialName("X") X("X"),
    @SerialName("Y") Y("Y"),
    @SerialName("Z") Z("Z"),
    @SerialName("XY") Xy("XY"),
    @SerialName("YZ") Yz("YZ"),
    @SerialName("ZX") Zx("ZX");
}

@Serializable
enum class Name(val value: String) {
    @SerialName("truck") Truck("truck"),
    @SerialName("bus") Bus("bus"),
    @SerialName("car") Car("car"),
    @SerialName("van") Van("van"),
    @SerialName("train") Train("train"),
    @SerialName("Bike") Bike("Bike"),
    @SerialName("Aeroplane") Aeroplane("Aeroplane"),
    @SerialName("Jeep") Jeep("Jeep"),
    @SerialName("Trolley") Trolley("Trolley");
}
