// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = List<JsonElement>

typealias TopLevelUnion = JsonElement

@Serializable
data class PurpleTopLevel (
    val country: Country,
    val date: String,
    val decimal: String,
    val indicator: Country,
    val value: String
)

@Serializable
data class Country (
    val id: ID,
    val value: Value
)

@Serializable
enum class ID(val value: String) {
    @SerialName("US") Us("US"),
    @SerialName("NY.GDP.MKTP.CD") NyGdpMktpCD("NY.GDP.MKTP.CD");
}

@Serializable
enum class Value(val value: String) {
    @SerialName("United States") UnitedStates("United States"),
    @SerialName("GDP (current US\$)") GDPCurrentUS("GDP (current US\$)");
}

@Serializable
data class FluffyTopLevel (
    val page: Long,
    val pages: Long,

    @SerialName("per_page")
    val perPage: String,

    val total: Long
)
