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
    val args: Args,
    val headers: Headers,
    val origin: String,
    val url: String
)

@Serializable
class Args()

@Serializable
data class Headers (
    @SerialName("Accept-Encoding")
    val acceptEncoding: String,

    @SerialName("Connection")
    val connection: String,

    @SerialName("Host")
    val host: String,

    @SerialName("User-Agent")
    val userAgent: String
)
