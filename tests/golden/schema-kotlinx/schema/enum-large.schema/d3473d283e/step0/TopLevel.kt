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
    val callsign: Callsign,
    val priority: Priority
)

@Serializable
enum class Callsign(val value: String) {
    @SerialName("alpha") Alpha("alpha"),
    @SerialName("bravo") Bravo("bravo"),
    @SerialName("charlie") Charlie("charlie"),
    @SerialName("delta") Delta("delta"),
    @SerialName("echo") Echo("echo"),
    @SerialName("foxtrot") Foxtrot("foxtrot"),
    @SerialName("golf") Golf("golf"),
    @SerialName("hotel") Hotel("hotel"),
    @SerialName("india") India("india"),
    @SerialName("juliett") Juliett("juliett"),
    @SerialName("kilo") Kilo("kilo"),
    @SerialName("lima") Lima("lima"),
    @SerialName("mike") Mike("mike"),
    @SerialName("november") November("november"),
    @SerialName("oscar") Oscar("oscar"),
    @SerialName("papa") Papa("papa"),
    @SerialName("quebec") Quebec("quebec"),
    @SerialName("romeo") Romeo("romeo"),
    @SerialName("sierra") Sierra("sierra"),
    @SerialName("tango") Tango("tango");
}

@Serializable
enum class Priority(val value: String) {
    @SerialName("low") Low("low"),
    @SerialName("medium") Medium("medium"),
    @SerialName("high") High("high");
}
