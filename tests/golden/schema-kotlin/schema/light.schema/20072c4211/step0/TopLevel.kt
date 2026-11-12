// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    @Json(name = "LightParams")
    val lightParams: LightParams
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class LightParams (
    @Json(name = "app_id")
    val appID: String,

    @Json(name = "outlet_id")
    val outletID: String,

    val rgba: String
)
