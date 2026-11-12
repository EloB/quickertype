// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val metadata: Metadata,
    val results: List<Result>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Metadata (
    val executionTime: Double,
    val responseInfo: ResponseInfo,
    val resultset: Resultset
)

data class ResponseInfo (
    val developerMessage: String,
    val status: Long
)

data class Resultset (
    val count: Long,
    val page: Long,
    val pagesize: Long
)

data class Result (
    val attachment: List<Any?>,
    val body: String,
    val changed: String,
    val component: List<Component>,
    val created: String,
    val date: String,
    val image: List<Any?>,
    val number: Any? = null,
    val teaser: Any? = null,
    val title: String,
    val topic: List<Any?>,
    val url: String,
    val uuid: String,
    val vuuid: String
)

data class Component (
    val name: String,
    val uuid: String
)
