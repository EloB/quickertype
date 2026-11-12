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
    val city: String,
    val delay: String,

    @SerialName("IATA")
    val iata: String,

    @SerialName("ICAO")
    val icao: String,

    val name: String,
    val state: String,
    val status: Status,
    val weather: Weather
)

@Serializable
data class Status (
    val avgDelay: String,
    val closureBegin: String,
    val closureEnd: String,
    val endTime: String,
    val maxDelay: String,
    val minDelay: String,
    val reason: String,
    val trend: String,
    val type: String
)

@Serializable
data class Weather (
    val meta: Meta,
    val temp: String,
    val visibility: Double,
    val weather: String,
    val wind: String
)

@Serializable
data class Meta (
    val credit: String,
    val updated: String,
    val url: String
)
