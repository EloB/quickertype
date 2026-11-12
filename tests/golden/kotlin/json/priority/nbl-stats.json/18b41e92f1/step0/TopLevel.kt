// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = if (isUnion && jv.inside is JsonArray<*>) (jv.inside as JsonArray<*>).map { fromJson(JsonValue(it, null, null, this@convert)) } else fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(LeaddatumEnum::class,     { LeaddatumEnum.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(PerType::class,           { PerType.fromValue(it.string!!) },           { Klaxon().toJsonString(it.value) })
    .convert(ActionType::class,        { ActionType.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })
    .convert(FamilyNameInitial::class, { FamilyNameInitial.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(FirstNameInitial::class,  { FirstNameInitial.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })
    .convert(ScoreboardName::class,    { ScoreboardName.fromValue(it.string!!) },    { Klaxon().toJsonString(it.value) })
    .convert(SubType::class,           { SubType.fromValue(it.string!!) },           { Klaxon().toJsonString(it.value) })
    .convert(LeaddatumElement::class,  { LeaddatumElement.fromJson(it) },            { it.toJson() }, true)
    .convert(SMinutes::class,          { SMinutes.fromJson(it) },                    { it.toJson() }, true)

data class TopLevel (
    val attendance: Long,
    val clock: String,
    val disableMatch: Long,
    val inOT: Long,
    val leaddata: List<List<LeaddatumElement>>,

    @Json(name = "officials_referee1")
    val officialsReferee1: String,

    @Json(name = "officials_referee2")
    val officialsReferee2: String,

    @Json(name = "officials_referee3")
    val officialsReferee3: String,

    val othermatches: List<Othermatch>,
    val pbp: List<Pbp>,
    val period: Long,
    val periodLengthOVERTIME: Long,
    val periodLengthREGULAR: Long,
    val periodType: PerType,
    val periodsMax: Long,
    val scorers: Map<String, List<Scorer>>,
    val timeline: List<Any?>,
    val tm: Map<String, Tm>,
    val totalTimeAdded: Long,
    val totallds: Totallds
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

sealed class LeaddatumElement {
    class EnumValue(val value: LeaddatumEnum) : LeaddatumElement()
    class IntegerValue(val value: Long)       : LeaddatumElement()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is EnumValue    -> this.value
        is IntegerValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): LeaddatumElement = when (jv.inside) {
            is String       -> EnumValue(jv.string?.let { LeaddatumEnum.fromValue(it) }!!)
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            else            -> throw IllegalArgumentException()
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
        public fun fromValue(value: String): LeaddatumEnum = when (value) {
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
    val clock: String,
    val competitionName: String,
    val id: String,
    val period: Long,
    val periodType: PerType,
    val team1: Team,
    val team1Name: String,
    val team1Score: Long,
    val team2: Team,
    val team2Name: String,
    val team2Score: Long
)

enum class PerType(val value: String) {
    Regular("REGULAR");

    companion object {
        public fun fromValue(value: String): PerType = when (value) {
            "REGULAR" -> Regular
            else      -> throw IllegalArgumentException()
        }
    }
}

data class Team (
    val teamCode: String,
    val teamCodeInternational: String,
    val teamName: String,
    val teamNameInternational: String
)

data class Pbp (
    val actionType: ActionType,
    val familyName: String? = null,
    val familyNameInitial: FamilyNameInitial? = null,
    val firstName: String? = null,
    val firstNameInitial: FirstNameInitial? = null,
    val gt: String,
    val internationalFamilyName: String? = null,
    val internationalFamilyNameInitial: FamilyNameInitial? = null,
    val internationalFirstName: String? = null,
    val internationalFirstNameInitial: FirstNameInitial? = null,
    val lead: Long,
    val period: Long,
    val periodType: PerType,
    val player: String,
    val pno: Long,
    val qualifier: String,
    val s1: Long,
    val s2: Long,
    val scoreboardName: ScoreboardName? = null,
    val scoring: Long,
    val shirtNumber: String,
    val subType: String,
    val success: Long,
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
        public fun fromValue(value: String): ActionType = when (value) {
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
        public fun fromValue(value: String): FamilyNameInitial = when (value) {
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
        public fun fromValue(value: String): FirstNameInitial = when (value) {
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
        public fun fromValue(value: String): ScoreboardName = when (value) {
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
    val pno: Long,
    val scoreboardName: ScoreboardName? = null,
    val shirtNumber: String,
    val summary: String? = null,
    val times: List<Time>? = null,
    val tno: Long,
    val tot: Long? = null
)

data class Time (
    val gt: String,
    val per: Long,
    val perType: PerType
)

data class Tm (
    val code: String,
    val codeInternational: String,
    val fouls: Long,

    @Json(name = "full_score")
    val fullScore: Long,

    val lds: Lds,
    val logo: String,
    val name: String,
    val nameInternational: String,

    @Json(name = "p1_score")
    val p1Score: Long,

    @Json(name = "p2_score")
    val p2Score: Long,

    @Json(name = "p3_score")
    val p3Score: Long,

    @Json(name = "p4_score")
    val p4Score: Long,

    val pl: Map<String, Pl>,
    val score: Long,
    val scoring: List<Scorer>,
    val shortName: String,
    val shortNameInternational: String,
    val shot: List<Shot>,
    val timeouts: Long,

    @Json(name = "tot_eff_1")
    val totEFF1: Long,

    @Json(name = "tot_eff_2")
    val totEFF2: Long,

    @Json(name = "tot_eff_3")
    val totEFF3: Double,

    @Json(name = "tot_eff_4")
    val totEFF4: Long,

    @Json(name = "tot_eff_5")
    val totEFF5: Long,

    @Json(name = "tot_eff_6")
    val totEFF6: Long,

    @Json(name = "tot_eff_7")
    val totEFF7: Long,

    @Json(name = "tot_sAssists")
    val totSAssists: Long,

    @Json(name = "tot_sBenchPoints")
    val totSBenchPoints: Long,

    @Json(name = "tot_sBiggestLead")
    val totSBiggestLead: Long,

    @Json(name = "tot_sBiggestScoringRun")
    val totSBiggestScoringRun: Long,

    @Json(name = "tot_sBlocks")
    val totSBlocks: Long,

    @Json(name = "tot_sBlocksReceived")
    val totSBlocksReceived: Long,

    @Json(name = "tot_sFieldGoalsAttempted")
    val totSFieldGoalsAttempted: Long,

    @Json(name = "tot_sFieldGoalsMade")
    val totSFieldGoalsMade: Long,

    @Json(name = "tot_sFieldGoalsPercentage")
    val totSFieldGoalsPercentage: Long,

    @Json(name = "tot_sFoulsOn")
    val totSFoulsOn: Long,

    @Json(name = "tot_sFoulsPersonal")
    val totSFoulsPersonal: Long,

    @Json(name = "tot_sFoulsTeam")
    val totSFoulsTeam: Long,

    @Json(name = "tot_sFreeThrowsAttempted")
    val totSFreeThrowsAttempted: Long,

    @Json(name = "tot_sFreeThrowsMade")
    val totSFreeThrowsMade: Long,

    @Json(name = "tot_sFreeThrowsPercentage")
    val totSFreeThrowsPercentage: Long,

    @Json(name = "tot_sLeadChanges")
    val totSLeadChanges: Long,

    @Json(name = "tot_sMinutes")
    val totSMinutes: Long,

    @Json(name = "tot_sPoints")
    val totSPoints: Long,

    @Json(name = "tot_sPointsFastBreak")
    val totSPointsFastBreak: Long,

    @Json(name = "tot_sPointsFromTurnovers")
    val totSPointsFromTurnovers: Long,

    @Json(name = "tot_sPointsInThePaint")
    val totSPointsInThePaint: Long,

    @Json(name = "tot_sPointsSecondChance")
    val totSPointsSecondChance: Long,

    @Json(name = "tot_sReboundsDefensive")
    val totSReboundsDefensive: Long,

    @Json(name = "tot_sReboundsOffensive")
    val totSReboundsOffensive: Long,

    @Json(name = "tot_sReboundsTeam")
    val totSReboundsTeam: Long,

    @Json(name = "tot_sReboundsTeamDefensive")
    val totSReboundsTeamDefensive: Long,

    @Json(name = "tot_sReboundsTeamOffensive")
    val totSReboundsTeamOffensive: Long,

    @Json(name = "tot_sReboundsTotal")
    val totSReboundsTotal: Long,

    @Json(name = "tot_sSteals")
    val totSSteals: Long,

    @Json(name = "tot_sThreePointersAttempted")
    val totSThreePointersAttempted: Long,

    @Json(name = "tot_sThreePointersMade")
    val totSThreePointersMade: Long,

    @Json(name = "tot_sThreePointersPercentage")
    val totSThreePointersPercentage: Long,

    @Json(name = "tot_sTimeLeading")
    val totSTimeLeading: Double,

    @Json(name = "tot_sTimesScoresLevel")
    val totSTimesScoresLevel: Long,

    @Json(name = "tot_sTurnovers")
    val totSTurnovers: Long,

    @Json(name = "tot_sTurnoversTeam")
    val totSTurnoversTeam: Long,

    @Json(name = "tot_sTwoPointersAttempted")
    val totSTwoPointersAttempted: Long,

    @Json(name = "tot_sTwoPointersMade")
    val totSTwoPointersMade: Long,

    @Json(name = "tot_sTwoPointersPercentage")
    val totSTwoPointersPercentage: Long
)

data class Lds (
    val sAssists: Map<String, Scorer>,
    val sBlocks: SBlocks,
    val sPoints: Map<String, Scorer>,
    val sReboundsTotal: Map<String, Scorer>,
    val sSteals: Map<String, Scorer>
)

data class SBlocks (
    @Json(name = "1")
    val the1: Scorer
)

data class Pl (
    val active: Long,
    val captain: Long? = null,
    val comp: Comp? = null,

    @Json(name = "eff_1")
    val eff1: Long,

    @Json(name = "eff_2")
    val eff2: Long,

    @Json(name = "eff_3")
    val eff3: Double,

    @Json(name = "eff_4")
    val eff4: Double,

    @Json(name = "eff_5")
    val eff5: Long,

    @Json(name = "eff_6")
    val eff6: Long,

    @Json(name = "eff_7")
    val eff7: Long,

    val familyName: String,
    val familyNameInitial: FamilyNameInitial,
    val firstName: String,
    val firstNameInitial: FirstNameInitial,
    val internationalFamilyName: String,
    val internationalFamilyNameInitial: FamilyNameInitial,
    val internationalFirstName: String,
    val internationalFirstNameInitial: FirstNameInitial,
    val name: String,
    val playingPosition: String,
    val sAssists: Long,
    val sBlocks: Long,
    val sBlocksReceived: Long,
    val sFieldGoalsAttempted: Long,
    val sFieldGoalsMade: Long,
    val sFieldGoalsPercentage: Long,
    val sFoulsOn: Long,
    val sFoulsPersonal: Long,
    val sFreeThrowsAttempted: Long,
    val sFreeThrowsMade: Long,
    val sFreeThrowsPercentage: Long,
    val sMinutes: SMinutes,
    val sPlusMinusPoints: Long,
    val sPoints: Long,
    val sPointsFastBreak: Long,
    val sPointsInThePaint: Long,
    val sPointsSecondChance: Long,
    val sReboundsDefensive: Long,
    val sReboundsOffensive: Long,
    val sReboundsTotal: Long,
    val sSteals: Long,
    val sThreePointersAttempted: Long,
    val sThreePointersMade: Long,
    val sThreePointersPercentage: Long,
    val sTurnovers: Long,
    val sTwoPointersAttempted: Long,
    val sTwoPointersMade: Long,
    val sTwoPointersPercentage: Long,
    val shirtNumber: String,
    val starter: Long
)

data class Comp (
    val sAssistsAverage: Double,
    val sMinutesAverage: String,
    val sPointsAverage: Double,
    val sReboundsTotalAverage: Double
)

sealed class SMinutes {
    class IntegerValue(val value: Long)  : SMinutes()
    class StringValue(val value: String) : SMinutes()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is IntegerValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): SMinutes = when (jv.inside) {
            is Int, is Long -> IntegerValue((jv.int?.toLong() ?: jv.longValue)!!)
            is String       -> StringValue(jv.string!!)
            else            -> throw IllegalArgumentException()
        }
    }
}

data class Shot (
    val actionType: ActionType,
    val p: Long,
    val per: Long,
    val perType: PerType,
    val player: String,
    val pno: Long,
    val r: Long,
    val shirtNumber: String,
    val subType: SubType,
    val tno: Long,
    val x: Long,
    val y: Long
)

enum class SubType(val value: String) {
    Jumpshot("jumpshot"),
    Layup("layup"),
    Dunk("dunk");

    companion object {
        public fun fromValue(value: String): SubType = when (value) {
            "jumpshot" -> Jumpshot
            "layup"    -> Layup
            "dunk"     -> Dunk
            else       -> throw IllegalArgumentException()
        }
    }
}

data class Totallds (
    val sAssists: Map<String, Scorer>,
    val sBlocks: Map<String, Scorer>,
    val sPoints: Map<String, Scorer>,
    val sReboundsTotal: Map<String, Scorer>,
    val sSteals: Map<String, Scorer>
)
