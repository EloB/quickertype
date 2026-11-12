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
    @SerialName("IN") In("IN"),
    @SerialName("SP.POP.TOTL") SPPopTotl("SP.POP.TOTL");
}

@Serializable
enum class Value(val value: String) {
    @SerialName("India") India("India"),
    @SerialName("Population, total") PopulationTotal("Population, total");
}

@Serializable
data class FluffyTopLevel (
    val page: Long,
    val pages: Long,

    @SerialName("per_page")
    val perPage: String,

    val total: Long
)
