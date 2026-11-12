// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

data class TopLevelElement (
    val id: String,
    val identifiers: List<Identifier>,
    val keywords: List<String>,
    val links: List<Link>,
    val name: String,

    @Json(name = "other_names")
    val otherNames: List<Any?>,

    @Json(name = "superseded_by")
    val supersededBy: Any? = null,

    val text: List<Text>
)

data class Identifier (
    val identifier: String,
    val scheme: String
)

data class Link (
    val note: String,
    val url: String
)

data class Text (
    @Json(name = "media_type")
    val mediaType: String,

    val title: String,
    val url: String
)
