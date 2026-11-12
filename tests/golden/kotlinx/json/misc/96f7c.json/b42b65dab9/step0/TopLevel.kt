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
    val git: List<String>,

    @SerialName("github_services_sha")
    val githubServicesSHA: String,

    val hooks: List<String>,
    val importer: List<String>,
    val pages: List<String>,

    @SerialName("verifiable_password_authentication")
    val verifiablePasswordAuthentication: Boolean
)
