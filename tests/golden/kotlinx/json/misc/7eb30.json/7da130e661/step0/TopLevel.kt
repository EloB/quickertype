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
    val count: Long,
    val next: String,
    val previous: JsonElement? = null,
    val results: List<Result>
)

@Serializable
data class Result (
    val code: String,
    val english: String,
    val fav: Boolean,
    val group: Group,
    val location: Location,

    @SerialName("min_screens")
    val minScreens: Long,

    @SerialName("num_views")
    val numViews: Long,

    val showtimes: String,
    val stars: Long,
    val tel: Tel,
    val thai: String,

    @SerialName("today_screens")
    val todayScreens: Long,

    val url: String,
    val website: String
)

@Serializable
data class Group (
    val code: Code,
    val english: English,
    val thai: Thai,
    val website: String
)

@Serializable
enum class Code(val value: String) {
    @SerialName("sf") Sf("sf");
}

@Serializable
enum class English(val value: String) {
    @SerialName("SF") Sf("SF");
}

@Serializable
enum class Thai(val value: String) {
    @SerialName("เอสเอฟ") เอสเอฟ("เอสเอฟ");
}

@Serializable
enum class Location(val value: String) {
    @SerialName("") Empty(""),
    @SerialName("5th Fl. Emporium") The5ThFLEmporium("5th Fl. Emporium");
}

@Serializable
enum class Tel(val value: String) {
    @SerialName("") Empty(""),
    @SerialName("02-268-8899") The022688899("02-268-8899");
}
