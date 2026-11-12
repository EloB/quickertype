// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

class TopLevel(elements: Collection<Long>) : ArrayList<Long>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<Any>(json)!!.map { when (it) { is Int -> it.toLong(); is Long -> it; else -> throw IllegalArgumentException() } })
    }
}
