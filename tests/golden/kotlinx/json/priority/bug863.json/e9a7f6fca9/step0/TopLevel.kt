// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = List<JsonElement>

typealias TopLevelUnion = JsonElement

@Serializable
data class PurpleTopLevel (
    @SerialName("ALIENLEVEL")
    val alienlevel: Long,

    @SerialName("BREED")
    val breed: Breed,

    @SerialName("CHAR_DIMENSION")
    val charDimension: Long,

    @SerialName("CHAR_INSTANCE")
    val charInstance: Long,

    @SerialName("DEFENDER_RANK_TITLE")
    val defenderRankTitle: String,

    @SerialName("FIRSTNAME")
    val firstname: Firstname,

    @SerialName("HEADID")
    val headid: Long,

    @SerialName("LASTNAME")
    val lastname: Lastname,

    @SerialName("LEVELX")
    val levelx: Long,

    @SerialName("NAME")
    val name: String,

    @SerialName("PROF")
    val prof: String,

    @SerialName("PROF_TITLE")
    val profTitle: String,

    @SerialName("PVPRATING")
    val pvprating: Long,

    @SerialName("PVPTITLE")
    val pvptitle: Pvptitle,

    @SerialName("RANK")
    val rank: Long,

    @SerialName("RANK_TITLE")
    val rankTitle: RankTitle,

    @SerialName("SEX")
    val sex: Sex
)

@Serializable
enum class Breed(val value: String) {
    @SerialName("Atrox") Atrox("Atrox"),
    @SerialName("Solitus") Solitus("Solitus"),
    @SerialName("Opifex") Opifex("Opifex"),
    @SerialName("Nano") Nano("Nano");
}

@Serializable
enum class Firstname(val value: String) {
    @SerialName("") Empty(""),
    @SerialName("Chi") Chi("Chi");
}

@Serializable
enum class Lastname(val value: String) {
    @SerialName("") Empty(""),
    @SerialName("Washko") Washko("Washko");
}

@Serializable
enum class Pvptitle(val value: String) {
    @SerialName("Freshman") Freshman("Freshman");
}

@Serializable
enum class RankTitle(val value: String) {
    @SerialName("President") President("President"),
    @SerialName("Advisor") Advisor("Advisor"),
    @SerialName("Veteran") Veteran("Veteran"),
    @SerialName("Applicant") Applicant("Applicant");
}

@Serializable
enum class Sex(val value: String) {
    @SerialName("Neuter") Neuter("Neuter"),
    @SerialName("Male") Male("Male"),
    @SerialName("Female") Female("Female");
}

@Serializable
data class FluffyTopLevel (
    @SerialName("ADVENTURERCOUNT")
    val adventurercount: Long,

    @SerialName("AGENTCOUNT")
    val agentcount: Long,

    @SerialName("ATROXCOUNT")
    val atroxcount: Long,

    @SerialName("AVGLVL")
    val avglvl: Double,

    @SerialName("BTCOUNT")
    val btcount: Long,

    @SerialName("DESCRIPTION")
    val description: String,

    @SerialName("DOCTORCOUNT")
    val doctorcount: Long,

    @SerialName("ENFCOUNT")
    val enfcount: Long,

    @SerialName("ENGINEEERCOUNT")
    val engineeercount: Long,

    @SerialName("FEMALECOUNT")
    val femalecount: Long,

    @SerialName("FIXERCOUNT")
    val fixercount: Long,

    @SerialName("GOVERNINGNAME")
    val governingname: String,

    @SerialName("HISTORY")
    val history: String,

    @SerialName("KEEPERCOUNT")
    val keepercount: Long,

    @SerialName("MACOUNT")
    val macount: Long,

    @SerialName("MALECOUNT")
    val malecount: Long,

    @SerialName("MAXLVL")
    val maxlvl: Long,

    @SerialName("METACOUNT")
    val metacount: Long,

    @SerialName("MINLVL")
    val minlvl: Long,

    @SerialName("MONSTERCOUNT")
    val monstercount: Long,

    @SerialName("NAME")
    val name: String,

    @SerialName("NANOCOUNT")
    val nanocount: Long,

    @SerialName("NANORACECOUNT")
    val nanoracecount: Long,

    @SerialName("NEUTERCOUNT")
    val neutercount: Long,

    @SerialName("NUMMEMBERS")
    val nummembers: Long,

    @SerialName("OBJECTIVE")
    val objective: String,

    @SerialName("OPIFEXCOUNT")
    val opifexcount: Long,

    @SerialName("ORG_DIMENSION")
    val orgDimension: Long,

    @SerialName("ORG_INSTANCE")
    val orgInstance: Long,

    @SerialName("SHADECOUNT")
    val shadecount: Long,

    @SerialName("SIDE")
    val side: Long,

    @SerialName("SIDE_NAME")
    val sideName: String,

    @SerialName("SOLIDERCOUNT")
    val solidercount: Long,

    @SerialName("SOLITUSCOUNT")
    val solituscount: Long,

    @SerialName("TRADERCOUNT")
    val tradercount: Long
)
