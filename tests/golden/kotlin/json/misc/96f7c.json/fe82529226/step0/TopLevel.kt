// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class TopLevel (
    val git: List<String>,

    @Json(name = "github_services_sha")
    val githubServicesSHA: String,

    val hooks: List<String>,
    val importer: List<String>,
    val pages: List<String>,

    @Json(name = "verifiable_password_authentication")
    val verifiablePasswordAuthentication: Boolean
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}
