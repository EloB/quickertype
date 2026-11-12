// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val message: List<Any?>,
    val responseTime: Long,

    @Json(name = "Results")
    val results: Results,

    val status: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Results (
    val series: List<Series>
)

data class Series (
    val data: List<Datum>,
    val seriesID: String
)

data class Datum (
    val footnotes: List<Footnote>,
    val period: String,
    val periodName: String,
    val value: String,
    val year: String
)

data class Footnote (
    val code: String? = null,
    val text: String? = null
)
