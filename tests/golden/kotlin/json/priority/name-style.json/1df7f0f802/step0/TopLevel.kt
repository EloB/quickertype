// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val anEasyOne: Long,
    val isMNISTLetter: Boolean,

    @Json(name = "JSONString")
    val jsonString: String,

    @Json(name = "PrettyEasyToo")
    val prettyEasyToo: Boolean,

    @Json(name = "should_know_that_id_is_an_initialism")
    val shouldKnowThatIDIsAnInitialism: String,

    @Json(name = "   spaces are separators  too  ")
    val spacesAreSeparatorsToo: Boolean,

    @Json(name = "ZSR_HH_DEMO3_DELMATNR")
    val zsrHhDemo3Delmatnr: Boolean
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
