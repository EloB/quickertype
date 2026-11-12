// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = List<TopLevelElement>

@Serializable
data class TopLevelElement (
    val designation: String,

    @SerialName("discovery_date")
    val discoveryDate: String,

    @SerialName("h_mag")
    val hMag: String? = null,

    @SerialName("i_deg")
    val iDeg: String,

    @SerialName("moid_au")
    val moidAu: String,

    @SerialName("orbit_class")
    val orbitClass: OrbitClass,

    @SerialName("period_yr")
    val periodYr: String? = null,

    val pha: Pha,

    @SerialName("q_au_1")
    val qAu1: String,

    @SerialName("q_au_2")
    val qAu2: String? = null
)

@Serializable
enum class OrbitClass(val value: String) {
    @SerialName("Apollo") Apollo("Apollo"),
    @SerialName("Amor") Amor("Amor"),
    @SerialName("Aten") Aten("Aten"),
    @SerialName("Comet") Comet("Comet"),
    @SerialName("Jupiter-family Comet") JupiterFamilyComet("Jupiter-family Comet"),
    @SerialName("Halley-type Comet*") HalleyTypeComet("Halley-type Comet*"),
    @SerialName("Parabolic Comet") ParabolicComet("Parabolic Comet"),
    @SerialName("Jupiter-family Comet*") OrbitClassJupiterFamilyComet("Jupiter-family Comet*"),
    @SerialName("Encke-type Comet") EnckeTypeComet("Encke-type Comet");
}

@Serializable
enum class Pha(val value: String) {
    @SerialName("Y") Y("Y"),
    @SerialName("N") N("N"),
    @SerialName("n/a") NA("n/a");
}
