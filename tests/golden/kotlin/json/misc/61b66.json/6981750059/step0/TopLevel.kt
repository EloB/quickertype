// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val city: String,
    val delay: String,

    @Json(name = "IATA")
    val iata: String,

    @Json(name = "ICAO")
    val icao: String,

    val name: String,
    val state: String,
    val status: Status,
    val weather: Weather
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

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

data class Weather (
    val meta: Meta,
    val temp: String,
    val visibility: Double,
    val weather: String,
    val wind: String
)

data class Meta (
    val credit: String,
    val updated: String,
    val url: String
)
