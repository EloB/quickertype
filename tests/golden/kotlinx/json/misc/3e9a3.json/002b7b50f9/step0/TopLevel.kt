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
    val message: JsonArray,
    val responseTime: Long,

    @SerialName("Results")
    val results: Results,

    val status: String
)

@Serializable
data class Results (
    val series: List<Series>
)

@Serializable
data class Series (
    val data: List<Datum>,
    val seriesID: String
)

@Serializable
data class Datum (
    val footnotes: List<Footnote>,
    val period: String,
    val periodName: String,
    val value: String,
    val year: String
)

@Serializable
data class Footnote (
    val code: String? = null,
    val text: String? = null
)
