// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val pc: PC,
    val ps3: PC,
    val ps4: PC,
    val xbox: PC,
    val xone: PC
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class PC (
    val count: Long,
    val label: String,
    val peak24: Long
)
