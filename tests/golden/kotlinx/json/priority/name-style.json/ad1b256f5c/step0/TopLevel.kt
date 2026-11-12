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
    val anEasyOne: Long,
    val isMNISTLetter: Boolean,

    @SerialName("JSONString")
    val jsonString: String,

    @SerialName("PrettyEasyToo")
    val prettyEasyToo: Boolean,

    @SerialName("should_know_that_id_is_an_initialism")
    val shouldKnowThatIDIsAnInitialism: String,

    @SerialName("   spaces are separators  too  ")
    val spacesAreSeparatorsToo: Boolean,

    @SerialName("ZSR_HH_DEMO3_DELMATNR")
    val zsrHhDemo3Delmatnr: Boolean
)
