// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val data: Map<String, Datum>,
    val description: Description
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Datum (
    val anomaly: String,
    val value: String
)

data class Description (
    @Json(name = "base_period")
    val basePeriod: String,

    val missing: Long,
    val title: String,
    val units: String
)
