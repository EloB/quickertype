// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*


@Suppress("UNCHECKED_CAST")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {
    addSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {
            override fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
    })
    addDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {
            override fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree())
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(LeaddatumEnum::class,     { LeaddatumEnum.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(PerType::class,           { PerType.fromValue(it.asText()) },           { ObjectMapper().writeValueAsString(it.value) })
    convert(ActionType::class,        { ActionType.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
    convert(FamilyNameInitial::class, { FamilyNameInitial.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(FirstNameInitial::class,  { FirstNameInitial.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
    convert(ScoreboardName::class,    { ScoreboardName.fromValue(it.asText()) },    { ObjectMapper().writeValueAsString(it.value) })
    convert(SubType::class,           { SubType.fromValue(it.asText()) },           { ObjectMapper().writeValueAsString(it.value) })
    convert(LeaddatumElement::class,  { LeaddatumElement.fromJson(it) },            { it.toJson() }, true)
    convert(SMinutes::class,          { SMinutes.fromJson(it) },                    { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val attendance: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val clock: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val disableMatch: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inOT: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val leaddata: List<List<LeaddatumElement>>,

    @get:JsonProperty("officials_referee1", required=true)@field:JsonProperty("officials_referee1", required=true)
    val officialsReferee1: String,

    @get:JsonProperty("officials_referee2", required=true)@field:JsonProperty("officials_referee2", required=true)
    val officialsReferee2: String,

    @get:JsonProperty("officials_referee3", required=true)@field:JsonProperty("officials_referee3", required=true)
    val officialsReferee3: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val othermatches: List<Othermatch>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pbp: List<Pbp>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val period: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val periodLengthOVERTIME: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val periodLengthREGULAR: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val periodType: PerType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val periodsMax: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scorers: Map<String, List<Scorer>>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val timeline: List<Any?>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tm: Map<String, Tm>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val totalTimeAdded: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val totallds: Totallds
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class LeaddatumElement {
    class EnumValue(val value: LeaddatumEnum) : LeaddatumElement()
    class IntegerValue(val value: Long)       : LeaddatumElement()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is EnumValue    -> this.value
        is IntegerValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): LeaddatumElement = when (jn) {
            is TextNode             -> EnumValue(mapper.convertValue(jn))
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

enum class LeaddatumEnum(val value: String) {
    Empty(""),
    P1("P1"),
    P2("P2"),
    P3("P3"),
    P4("P4");

    companion object {
        fun fromValue(value: String): LeaddatumEnum = when (value) {
            ""   -> Empty
            "P1" -> P1
            "P2" -> P2
            "P3" -> P3
            "P4" -> P4
            else -> throw IllegalArgumentException()
        }
    }
}

data class Othermatch (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val clock: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val competitionName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val period: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val periodType: PerType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val team1: Team,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val team1Name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val team1Score: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val team2: Team,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val team2Name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val team2Score: Long
)

enum class PerType(val value: String) {
    Regular("REGULAR");

    companion object {
        fun fromValue(value: String): PerType = when (value) {
            "REGULAR" -> Regular
            else      -> throw IllegalArgumentException()
        }
    }
}

data class Team (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val teamCode: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val teamCodeInternational: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val teamName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val teamNameInternational: String
)

data class Pbp (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val actionType: ActionType,

    val familyName: String? = null,
    val familyNameInitial: FamilyNameInitial? = null,
    val firstName: String? = null,
    val firstNameInitial: FirstNameInitial? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gt: String,

    val internationalFamilyName: String? = null,
    val internationalFamilyNameInitial: FamilyNameInitial? = null,
    val internationalFirstName: String? = null,
    val internationalFirstNameInitial: FirstNameInitial? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lead: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val period: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val periodType: PerType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val player: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pno: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val qualifier: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val s1: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val s2: Long,

    val scoreboardName: ScoreboardName? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scoring: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shirtNumber: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subType: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val success: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tno: Long
)

enum class ActionType(val value: String) {
    Game("game"),
    Period("period"),
    The3Pt("3pt"),
    The2Pt("2pt"),
    Rebound("rebound"),
    Timeout("timeout"),
    Foulon("foulon"),
    Foul("foul"),
    Assist("assist"),
    Substitution("substitution"),
    Freethrow("freethrow"),
    Steal("steal"),
    Turnover("turnover"),
    Block("block"),
    Jumpball("jumpball");

    companion object {
        fun fromValue(value: String): ActionType = when (value) {
            "game"         -> Game
            "period"       -> Period
            "3pt"          -> The3Pt
            "2pt"          -> The2Pt
            "rebound"      -> Rebound
            "timeout"      -> Timeout
            "foulon"       -> Foulon
            "foul"         -> Foul
            "assist"       -> Assist
            "substitution" -> Substitution
            "freethrow"    -> Freethrow
            "steal"        -> Steal
            "turnover"     -> Turnover
            "block"        -> Block
            "jumpball"     -> Jumpball
            else           -> throw IllegalArgumentException()
        }
    }
}

enum class FamilyNameInitial(val value: String) {
    R("R"),
    M("M"),
    S("s"),
    C("C"),
    O("O"),
    W("W"),
    A("A"),
    P("P"),
    V("V"),
    I("I"),
    J("J"),
    FamilyNameInitialS("S"),
    H("H"),
    B("B");

    companion object {
        fun fromValue(value: String): FamilyNameInitial = when (value) {
            "R"  -> R
            "M"  -> M
            "s"  -> S
            "C"  -> C
            "O"  -> O
            "W"  -> W
            "A"  -> A
            "P"  -> P
            "V"  -> V
            "I"  -> I
            "J"  -> J
            "S"  -> FamilyNameInitialS
            "H"  -> H
            "B"  -> B
            else -> throw IllegalArgumentException()
        }
    }
}

enum class FirstNameInitial(val value: String) {
    D("D"),
    J("J"),
    T("T"),
    C("C"),
    O("O"),
    H("H"),
    L("L"),
    A("A"),
    K("K"),
    R("R"),
    B("B"),
    N("N");

    companion object {
        fun fromValue(value: String): FirstNameInitial = when (value) {
            "D"  -> D
            "J"  -> J
            "T"  -> T
            "C"  -> C
            "O"  -> O
            "H"  -> H
            "L"  -> L
            "A"  -> A
            "K"  -> K
            "R"  -> R
            "B"  -> B
            "N"  -> N
            else -> throw IllegalArgumentException()
        }
    }
}

enum class ScoreboardName(val value: String) {
    Empty(""),
    TS("T. s"),
    RIhata("R. Ihata"),
    DJones("D. Jones"),
    BValentine("B. Valentine");

    companion object {
        fun fromValue(value: String): ScoreboardName = when (value) {
            ""             -> Empty
            "T. s"         -> TS
            "R. Ihata"     -> RIhata
            "D. Jones"     -> DJones
            "B. Valentine" -> BValentine
            else           -> throw IllegalArgumentException()
        }
    }
}

data class Scorer (
    val familyName: String? = null,
    val familyNameInitial: FamilyNameInitial? = null,
    val firstName: String? = null,
    val firstNameInitial: FirstNameInitial? = null,
    val gt: String? = null,
    val internationalFamilyName: String? = null,
    val internationalFamilyNameInitial: FamilyNameInitial? = null,
    val internationalFirstName: String? = null,
    val internationalFirstNameInitial: FirstNameInitial? = null,
    val name: String? = null,
    val per: Long? = null,
    val perType: PerType? = null,
    val player: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pno: Long,

    val scoreboardName: ScoreboardName? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shirtNumber: String,

    val summary: String? = null,
    val times: List<Time>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tno: Long,

    val tot: Long? = null
)

data class Time (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gt: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val per: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val perType: PerType
)

data class Tm (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val codeInternational: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fouls: Long,

    @get:JsonProperty("full_score", required=true)@field:JsonProperty("full_score", required=true)
    val fullScore: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lds: Lds,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val logo: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nameInternational: String,

    @get:JsonProperty("p1_score", required=true)@field:JsonProperty("p1_score", required=true)
    val p1Score: Long,

    @get:JsonProperty("p2_score", required=true)@field:JsonProperty("p2_score", required=true)
    val p2Score: Long,

    @get:JsonProperty("p3_score", required=true)@field:JsonProperty("p3_score", required=true)
    val p3Score: Long,

    @get:JsonProperty("p4_score", required=true)@field:JsonProperty("p4_score", required=true)
    val p4Score: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pl: Map<String, Pl>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val score: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val scoring: List<Scorer>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shortName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shortNameInternational: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shot: List<Shot>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val timeouts: Long,

    @get:JsonProperty("tot_eff_1", required=true)@field:JsonProperty("tot_eff_1", required=true)
    val totEFF1: Long,

    @get:JsonProperty("tot_eff_2", required=true)@field:JsonProperty("tot_eff_2", required=true)
    val totEFF2: Long,

    @get:JsonProperty("tot_eff_3", required=true)@field:JsonProperty("tot_eff_3", required=true)
    val totEFF3: Double,

    @get:JsonProperty("tot_eff_4", required=true)@field:JsonProperty("tot_eff_4", required=true)
    val totEFF4: Long,

    @get:JsonProperty("tot_eff_5", required=true)@field:JsonProperty("tot_eff_5", required=true)
    val totEFF5: Long,

    @get:JsonProperty("tot_eff_6", required=true)@field:JsonProperty("tot_eff_6", required=true)
    val totEFF6: Long,

    @get:JsonProperty("tot_eff_7", required=true)@field:JsonProperty("tot_eff_7", required=true)
    val totEFF7: Long,

    @get:JsonProperty("tot_sAssists", required=true)@field:JsonProperty("tot_sAssists", required=true)
    val totSAssists: Long,

    @get:JsonProperty("tot_sBenchPoints", required=true)@field:JsonProperty("tot_sBenchPoints", required=true)
    val totSBenchPoints: Long,

    @get:JsonProperty("tot_sBiggestLead", required=true)@field:JsonProperty("tot_sBiggestLead", required=true)
    val totSBiggestLead: Long,

    @get:JsonProperty("tot_sBiggestScoringRun", required=true)@field:JsonProperty("tot_sBiggestScoringRun", required=true)
    val totSBiggestScoringRun: Long,

    @get:JsonProperty("tot_sBlocks", required=true)@field:JsonProperty("tot_sBlocks", required=true)
    val totSBlocks: Long,

    @get:JsonProperty("tot_sBlocksReceived", required=true)@field:JsonProperty("tot_sBlocksReceived", required=true)
    val totSBlocksReceived: Long,

    @get:JsonProperty("tot_sFieldGoalsAttempted", required=true)@field:JsonProperty("tot_sFieldGoalsAttempted", required=true)
    val totSFieldGoalsAttempted: Long,

    @get:JsonProperty("tot_sFieldGoalsMade", required=true)@field:JsonProperty("tot_sFieldGoalsMade", required=true)
    val totSFieldGoalsMade: Long,

    @get:JsonProperty("tot_sFieldGoalsPercentage", required=true)@field:JsonProperty("tot_sFieldGoalsPercentage", required=true)
    val totSFieldGoalsPercentage: Long,

    @get:JsonProperty("tot_sFoulsOn", required=true)@field:JsonProperty("tot_sFoulsOn", required=true)
    val totSFoulsOn: Long,

    @get:JsonProperty("tot_sFoulsPersonal", required=true)@field:JsonProperty("tot_sFoulsPersonal", required=true)
    val totSFoulsPersonal: Long,

    @get:JsonProperty("tot_sFoulsTeam", required=true)@field:JsonProperty("tot_sFoulsTeam", required=true)
    val totSFoulsTeam: Long,

    @get:JsonProperty("tot_sFreeThrowsAttempted", required=true)@field:JsonProperty("tot_sFreeThrowsAttempted", required=true)
    val totSFreeThrowsAttempted: Long,

    @get:JsonProperty("tot_sFreeThrowsMade", required=true)@field:JsonProperty("tot_sFreeThrowsMade", required=true)
    val totSFreeThrowsMade: Long,

    @get:JsonProperty("tot_sFreeThrowsPercentage", required=true)@field:JsonProperty("tot_sFreeThrowsPercentage", required=true)
    val totSFreeThrowsPercentage: Long,

    @get:JsonProperty("tot_sLeadChanges", required=true)@field:JsonProperty("tot_sLeadChanges", required=true)
    val totSLeadChanges: Long,

    @get:JsonProperty("tot_sMinutes", required=true)@field:JsonProperty("tot_sMinutes", required=true)
    val totSMinutes: Long,

    @get:JsonProperty("tot_sPoints", required=true)@field:JsonProperty("tot_sPoints", required=true)
    val totSPoints: Long,

    @get:JsonProperty("tot_sPointsFastBreak", required=true)@field:JsonProperty("tot_sPointsFastBreak", required=true)
    val totSPointsFastBreak: Long,

    @get:JsonProperty("tot_sPointsFromTurnovers", required=true)@field:JsonProperty("tot_sPointsFromTurnovers", required=true)
    val totSPointsFromTurnovers: Long,

    @get:JsonProperty("tot_sPointsInThePaint", required=true)@field:JsonProperty("tot_sPointsInThePaint", required=true)
    val totSPointsInThePaint: Long,

    @get:JsonProperty("tot_sPointsSecondChance", required=true)@field:JsonProperty("tot_sPointsSecondChance", required=true)
    val totSPointsSecondChance: Long,

    @get:JsonProperty("tot_sReboundsDefensive", required=true)@field:JsonProperty("tot_sReboundsDefensive", required=true)
    val totSReboundsDefensive: Long,

    @get:JsonProperty("tot_sReboundsOffensive", required=true)@field:JsonProperty("tot_sReboundsOffensive", required=true)
    val totSReboundsOffensive: Long,

    @get:JsonProperty("tot_sReboundsTeam", required=true)@field:JsonProperty("tot_sReboundsTeam", required=true)
    val totSReboundsTeam: Long,

    @get:JsonProperty("tot_sReboundsTeamDefensive", required=true)@field:JsonProperty("tot_sReboundsTeamDefensive", required=true)
    val totSReboundsTeamDefensive: Long,

    @get:JsonProperty("tot_sReboundsTeamOffensive", required=true)@field:JsonProperty("tot_sReboundsTeamOffensive", required=true)
    val totSReboundsTeamOffensive: Long,

    @get:JsonProperty("tot_sReboundsTotal", required=true)@field:JsonProperty("tot_sReboundsTotal", required=true)
    val totSReboundsTotal: Long,

    @get:JsonProperty("tot_sSteals", required=true)@field:JsonProperty("tot_sSteals", required=true)
    val totSSteals: Long,

    @get:JsonProperty("tot_sThreePointersAttempted", required=true)@field:JsonProperty("tot_sThreePointersAttempted", required=true)
    val totSThreePointersAttempted: Long,

    @get:JsonProperty("tot_sThreePointersMade", required=true)@field:JsonProperty("tot_sThreePointersMade", required=true)
    val totSThreePointersMade: Long,

    @get:JsonProperty("tot_sThreePointersPercentage", required=true)@field:JsonProperty("tot_sThreePointersPercentage", required=true)
    val totSThreePointersPercentage: Long,

    @get:JsonProperty("tot_sTimeLeading", required=true)@field:JsonProperty("tot_sTimeLeading", required=true)
    val totSTimeLeading: Double,

    @get:JsonProperty("tot_sTimesScoresLevel", required=true)@field:JsonProperty("tot_sTimesScoresLevel", required=true)
    val totSTimesScoresLevel: Long,

    @get:JsonProperty("tot_sTurnovers", required=true)@field:JsonProperty("tot_sTurnovers", required=true)
    val totSTurnovers: Long,

    @get:JsonProperty("tot_sTurnoversTeam", required=true)@field:JsonProperty("tot_sTurnoversTeam", required=true)
    val totSTurnoversTeam: Long,

    @get:JsonProperty("tot_sTwoPointersAttempted", required=true)@field:JsonProperty("tot_sTwoPointersAttempted", required=true)
    val totSTwoPointersAttempted: Long,

    @get:JsonProperty("tot_sTwoPointersMade", required=true)@field:JsonProperty("tot_sTwoPointersMade", required=true)
    val totSTwoPointersMade: Long,

    @get:JsonProperty("tot_sTwoPointersPercentage", required=true)@field:JsonProperty("tot_sTwoPointersPercentage", required=true)
    val totSTwoPointersPercentage: Long
)

data class Lds (
    @get:JsonProperty("sAssists", required=true)@field:JsonProperty("sAssists", required=true)
    val sAssists: Map<String, Scorer>,

    @get:JsonProperty("sBlocks", required=true)@field:JsonProperty("sBlocks", required=true)
    val sBlocks: SBlocks,

    @get:JsonProperty("sPoints", required=true)@field:JsonProperty("sPoints", required=true)
    val sPoints: Map<String, Scorer>,

    @get:JsonProperty("sReboundsTotal", required=true)@field:JsonProperty("sReboundsTotal", required=true)
    val sReboundsTotal: Map<String, Scorer>,

    @get:JsonProperty("sSteals", required=true)@field:JsonProperty("sSteals", required=true)
    val sSteals: Map<String, Scorer>
)

data class SBlocks (
    @get:JsonProperty("1", required=true)@field:JsonProperty("1", required=true)
    val the1: Scorer
)

data class Pl (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val active: Long,

    val captain: Long? = null,
    val comp: Comp? = null,

    @get:JsonProperty("eff_1", required=true)@field:JsonProperty("eff_1", required=true)
    val eff1: Long,

    @get:JsonProperty("eff_2", required=true)@field:JsonProperty("eff_2", required=true)
    val eff2: Long,

    @get:JsonProperty("eff_3", required=true)@field:JsonProperty("eff_3", required=true)
    val eff3: Double,

    @get:JsonProperty("eff_4", required=true)@field:JsonProperty("eff_4", required=true)
    val eff4: Double,

    @get:JsonProperty("eff_5", required=true)@field:JsonProperty("eff_5", required=true)
    val eff5: Long,

    @get:JsonProperty("eff_6", required=true)@field:JsonProperty("eff_6", required=true)
    val eff6: Long,

    @get:JsonProperty("eff_7", required=true)@field:JsonProperty("eff_7", required=true)
    val eff7: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val familyName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val familyNameInitial: FamilyNameInitial,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val firstName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val firstNameInitial: FirstNameInitial,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val internationalFamilyName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val internationalFamilyNameInitial: FamilyNameInitial,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val internationalFirstName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val internationalFirstNameInitial: FirstNameInitial,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val playingPosition: String,

    @get:JsonProperty("sAssists", required=true)@field:JsonProperty("sAssists", required=true)
    val sAssists: Long,

    @get:JsonProperty("sBlocks", required=true)@field:JsonProperty("sBlocks", required=true)
    val sBlocks: Long,

    @get:JsonProperty("sBlocksReceived", required=true)@field:JsonProperty("sBlocksReceived", required=true)
    val sBlocksReceived: Long,

    @get:JsonProperty("sFieldGoalsAttempted", required=true)@field:JsonProperty("sFieldGoalsAttempted", required=true)
    val sFieldGoalsAttempted: Long,

    @get:JsonProperty("sFieldGoalsMade", required=true)@field:JsonProperty("sFieldGoalsMade", required=true)
    val sFieldGoalsMade: Long,

    @get:JsonProperty("sFieldGoalsPercentage", required=true)@field:JsonProperty("sFieldGoalsPercentage", required=true)
    val sFieldGoalsPercentage: Long,

    @get:JsonProperty("sFoulsOn", required=true)@field:JsonProperty("sFoulsOn", required=true)
    val sFoulsOn: Long,

    @get:JsonProperty("sFoulsPersonal", required=true)@field:JsonProperty("sFoulsPersonal", required=true)
    val sFoulsPersonal: Long,

    @get:JsonProperty("sFreeThrowsAttempted", required=true)@field:JsonProperty("sFreeThrowsAttempted", required=true)
    val sFreeThrowsAttempted: Long,

    @get:JsonProperty("sFreeThrowsMade", required=true)@field:JsonProperty("sFreeThrowsMade", required=true)
    val sFreeThrowsMade: Long,

    @get:JsonProperty("sFreeThrowsPercentage", required=true)@field:JsonProperty("sFreeThrowsPercentage", required=true)
    val sFreeThrowsPercentage: Long,

    @get:JsonProperty("sMinutes", required=true)@field:JsonProperty("sMinutes", required=true)
    val sMinutes: SMinutes,

    @get:JsonProperty("sPlusMinusPoints", required=true)@field:JsonProperty("sPlusMinusPoints", required=true)
    val sPlusMinusPoints: Long,

    @get:JsonProperty("sPoints", required=true)@field:JsonProperty("sPoints", required=true)
    val sPoints: Long,

    @get:JsonProperty("sPointsFastBreak", required=true)@field:JsonProperty("sPointsFastBreak", required=true)
    val sPointsFastBreak: Long,

    @get:JsonProperty("sPointsInThePaint", required=true)@field:JsonProperty("sPointsInThePaint", required=true)
    val sPointsInThePaint: Long,

    @get:JsonProperty("sPointsSecondChance", required=true)@field:JsonProperty("sPointsSecondChance", required=true)
    val sPointsSecondChance: Long,

    @get:JsonProperty("sReboundsDefensive", required=true)@field:JsonProperty("sReboundsDefensive", required=true)
    val sReboundsDefensive: Long,

    @get:JsonProperty("sReboundsOffensive", required=true)@field:JsonProperty("sReboundsOffensive", required=true)
    val sReboundsOffensive: Long,

    @get:JsonProperty("sReboundsTotal", required=true)@field:JsonProperty("sReboundsTotal", required=true)
    val sReboundsTotal: Long,

    @get:JsonProperty("sSteals", required=true)@field:JsonProperty("sSteals", required=true)
    val sSteals: Long,

    @get:JsonProperty("sThreePointersAttempted", required=true)@field:JsonProperty("sThreePointersAttempted", required=true)
    val sThreePointersAttempted: Long,

    @get:JsonProperty("sThreePointersMade", required=true)@field:JsonProperty("sThreePointersMade", required=true)
    val sThreePointersMade: Long,

    @get:JsonProperty("sThreePointersPercentage", required=true)@field:JsonProperty("sThreePointersPercentage", required=true)
    val sThreePointersPercentage: Long,

    @get:JsonProperty("sTurnovers", required=true)@field:JsonProperty("sTurnovers", required=true)
    val sTurnovers: Long,

    @get:JsonProperty("sTwoPointersAttempted", required=true)@field:JsonProperty("sTwoPointersAttempted", required=true)
    val sTwoPointersAttempted: Long,

    @get:JsonProperty("sTwoPointersMade", required=true)@field:JsonProperty("sTwoPointersMade", required=true)
    val sTwoPointersMade: Long,

    @get:JsonProperty("sTwoPointersPercentage", required=true)@field:JsonProperty("sTwoPointersPercentage", required=true)
    val sTwoPointersPercentage: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shirtNumber: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val starter: Long
)

data class Comp (
    @get:JsonProperty("sAssistsAverage", required=true)@field:JsonProperty("sAssistsAverage", required=true)
    val sAssistsAverage: Double,

    @get:JsonProperty("sMinutesAverage", required=true)@field:JsonProperty("sMinutesAverage", required=true)
    val sMinutesAverage: String,

    @get:JsonProperty("sPointsAverage", required=true)@field:JsonProperty("sPointsAverage", required=true)
    val sPointsAverage: Double,

    @get:JsonProperty("sReboundsTotalAverage", required=true)@field:JsonProperty("sReboundsTotalAverage", required=true)
    val sReboundsTotalAverage: Double
)

sealed class SMinutes {
    class IntegerValue(val value: Long)  : SMinutes()
    class StringValue(val value: String) : SMinutes()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): SMinutes = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class Shot (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val actionType: ActionType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val p: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val per: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val perType: PerType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val player: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pno: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val r: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shirtNumber: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val subType: SubType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tno: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val x: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val y: Long
)

enum class SubType(val value: String) {
    Jumpshot("jumpshot"),
    Layup("layup"),
    Dunk("dunk");

    companion object {
        fun fromValue(value: String): SubType = when (value) {
            "jumpshot" -> Jumpshot
            "layup"    -> Layup
            "dunk"     -> Dunk
            else       -> throw IllegalArgumentException()
        }
    }
}

data class Totallds (
    @get:JsonProperty("sAssists", required=true)@field:JsonProperty("sAssists", required=true)
    val sAssists: Map<String, Scorer>,

    @get:JsonProperty("sBlocks", required=true)@field:JsonProperty("sBlocks", required=true)
    val sBlocks: Map<String, Scorer>,

    @get:JsonProperty("sPoints", required=true)@field:JsonProperty("sPoints", required=true)
    val sPoints: Map<String, Scorer>,

    @get:JsonProperty("sReboundsTotal", required=true)@field:JsonProperty("sReboundsTotal", required=true)
    val sReboundsTotal: Map<String, Scorer>,

    @get:JsonProperty("sSteals", required=true)@field:JsonProperty("sSteals", required=true)
    val sSteals: Map<String, Scorer>
)
