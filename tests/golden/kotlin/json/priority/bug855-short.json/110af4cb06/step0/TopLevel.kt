// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

class TopLevel(elements: Map<String, TopLevelValue>) : HashMap<String, TopLevelValue>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel (
            klaxon.parseJsonObject(java.io.StringReader(json)) as Map<String, TopLevelValue>
        )
    }
}

data class TopLevelValue (
    @Json(name = "channel_id")
    val channelID: String,

    @Json(name = "channel_name")
    val channelName: String,

    val code: String,

    @Json(name = "emoticon_set")
    val emoticonSet: Long,

    val id: Long
)
