package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val attendance : Long,
    val clock : String,
    val disableMatch : Long,
    val inOT : Long,
    val leaddata : Seq[Seq[LeaddatumElement]],
    val officials_referee1 : String,
    val officials_referee2 : String,
    val officials_referee3 : String,
    val othermatches : Seq[Othermatch],
    val pbp : Seq[Pbp],
    val period : Long,
    val periodLengthOVERTIME : Long,
    val periodLengthREGULAR : Long,
    val periodType : PerType,
    val periodsMax : Long,
    val scorers : Map[String, Seq[Scorer]],
    val timeline : Seq[Option[Json]],
    val tm : Map[String, Tm],
    val totalTimeAdded : Long,
    val totallds : Totallds
) derives Encoder.AsObject, Decoder

type LeaddatumElement = LeaddatumEnum | Long
given Decoder[LeaddatumElement] = {
    List[Decoder[LeaddatumElement]](
        Decoder[LeaddatumEnum].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[LeaddatumElement] = Encoder.instance {
    case enc0 : LeaddatumEnum => summon[Encoder[LeaddatumEnum]].apply(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}

enum LeaddatumEnum : 
    case Empty
    case P1
    case P2
    case P3
    case P4

given Decoder[LeaddatumEnum] = Decoder.decodeString.emap {
    case "" => scala.Right(LeaddatumEnum.Empty)
    case "P1" => scala.Right(LeaddatumEnum.P1)
    case "P2" => scala.Right(LeaddatumEnum.P2)
    case "P3" => scala.Right(LeaddatumEnum.P3)
    case "P4" => scala.Right(LeaddatumEnum.P4)
    case other => scala.Left("invalid LeaddatumEnum: " + other)
}
given Encoder[LeaddatumEnum] = Encoder.encodeString.contramap {
    case LeaddatumEnum.Empty => ""
    case LeaddatumEnum.P1 => "P1"
    case LeaddatumEnum.P2 => "P2"
    case LeaddatumEnum.P3 => "P3"
    case LeaddatumEnum.P4 => "P4"
}

case class Othermatch (
    val clock : String,
    val competitionName : String,
    val id : String,
    val period : Long,
    val periodType : PerType,
    val team1 : Team,
    val team1Name : String,
    val team1Score : Long,
    val team2 : Team,
    val team2Name : String,
    val team2Score : Long
) derives Encoder.AsObject, Decoder

enum PerType : 
    case Regular

given Decoder[PerType] = Decoder.decodeString.emap {
    case "REGULAR" => scala.Right(PerType.Regular)
    case other => scala.Left("invalid PerType: " + other)
}
given Encoder[PerType] = Encoder.encodeString.contramap {
    case PerType.Regular => "REGULAR"
}

case class Team (
    val teamCode : String,
    val teamCodeInternational : String,
    val teamName : String,
    val teamNameInternational : String
) derives Encoder.AsObject, Decoder

case class Pbp (
    val actionType : ActionType,
    val familyName : Option[String] = None,
    val familyNameInitial : Option[FamilyNameInitial] = None,
    val firstName : Option[String] = None,
    val firstNameInitial : Option[FirstNameInitial] = None,
    val gt : String,
    val internationalFamilyName : Option[String] = None,
    val internationalFamilyNameInitial : Option[FamilyNameInitial] = None,
    val internationalFirstName : Option[String] = None,
    val internationalFirstNameInitial : Option[FirstNameInitial] = None,
    val lead : Long,
    val period : Long,
    val periodType : PerType,
    val player : String,
    val pno : Long,
    val qualifier : String,
    val s1 : Long,
    val s2 : Long,
    val scoreboardName : Option[ScoreboardName] = None,
    val scoring : Long,
    val shirtNumber : String,
    val subType : String,
    val success : Long,
    val tno : Long
) derives Encoder.AsObject, Decoder

enum ActionType : 
    case Game
    case Period
    case The3Pt
    case The2Pt
    case Rebound
    case Timeout
    case Foulon
    case Foul
    case Assist
    case Substitution
    case Freethrow
    case Steal
    case Turnover
    case Block
    case Jumpball

given Decoder[ActionType] = Decoder.decodeString.emap {
    case "game" => scala.Right(ActionType.Game)
    case "period" => scala.Right(ActionType.Period)
    case "3pt" => scala.Right(ActionType.The3Pt)
    case "2pt" => scala.Right(ActionType.The2Pt)
    case "rebound" => scala.Right(ActionType.Rebound)
    case "timeout" => scala.Right(ActionType.Timeout)
    case "foulon" => scala.Right(ActionType.Foulon)
    case "foul" => scala.Right(ActionType.Foul)
    case "assist" => scala.Right(ActionType.Assist)
    case "substitution" => scala.Right(ActionType.Substitution)
    case "freethrow" => scala.Right(ActionType.Freethrow)
    case "steal" => scala.Right(ActionType.Steal)
    case "turnover" => scala.Right(ActionType.Turnover)
    case "block" => scala.Right(ActionType.Block)
    case "jumpball" => scala.Right(ActionType.Jumpball)
    case other => scala.Left("invalid ActionType: " + other)
}
given Encoder[ActionType] = Encoder.encodeString.contramap {
    case ActionType.Game => "game"
    case ActionType.Period => "period"
    case ActionType.The3Pt => "3pt"
    case ActionType.The2Pt => "2pt"
    case ActionType.Rebound => "rebound"
    case ActionType.Timeout => "timeout"
    case ActionType.Foulon => "foulon"
    case ActionType.Foul => "foul"
    case ActionType.Assist => "assist"
    case ActionType.Substitution => "substitution"
    case ActionType.Freethrow => "freethrow"
    case ActionType.Steal => "steal"
    case ActionType.Turnover => "turnover"
    case ActionType.Block => "block"
    case ActionType.Jumpball => "jumpball"
}

enum FamilyNameInitial : 
    case R
    case M
    case S
    case C
    case O
    case W
    case A
    case P
    case V
    case I
    case J
    case FamilyNameInitialS
    case H
    case B

given Decoder[FamilyNameInitial] = Decoder.decodeString.emap {
    case "R" => scala.Right(FamilyNameInitial.R)
    case "M" => scala.Right(FamilyNameInitial.M)
    case "s" => scala.Right(FamilyNameInitial.S)
    case "C" => scala.Right(FamilyNameInitial.C)
    case "O" => scala.Right(FamilyNameInitial.O)
    case "W" => scala.Right(FamilyNameInitial.W)
    case "A" => scala.Right(FamilyNameInitial.A)
    case "P" => scala.Right(FamilyNameInitial.P)
    case "V" => scala.Right(FamilyNameInitial.V)
    case "I" => scala.Right(FamilyNameInitial.I)
    case "J" => scala.Right(FamilyNameInitial.J)
    case "S" => scala.Right(FamilyNameInitial.FamilyNameInitialS)
    case "H" => scala.Right(FamilyNameInitial.H)
    case "B" => scala.Right(FamilyNameInitial.B)
    case other => scala.Left("invalid FamilyNameInitial: " + other)
}
given Encoder[FamilyNameInitial] = Encoder.encodeString.contramap {
    case FamilyNameInitial.R => "R"
    case FamilyNameInitial.M => "M"
    case FamilyNameInitial.S => "s"
    case FamilyNameInitial.C => "C"
    case FamilyNameInitial.O => "O"
    case FamilyNameInitial.W => "W"
    case FamilyNameInitial.A => "A"
    case FamilyNameInitial.P => "P"
    case FamilyNameInitial.V => "V"
    case FamilyNameInitial.I => "I"
    case FamilyNameInitial.J => "J"
    case FamilyNameInitial.FamilyNameInitialS => "S"
    case FamilyNameInitial.H => "H"
    case FamilyNameInitial.B => "B"
}

enum FirstNameInitial : 
    case D
    case J
    case T
    case C
    case O
    case H
    case L
    case A
    case K
    case R
    case B
    case N

given Decoder[FirstNameInitial] = Decoder.decodeString.emap {
    case "D" => scala.Right(FirstNameInitial.D)
    case "J" => scala.Right(FirstNameInitial.J)
    case "T" => scala.Right(FirstNameInitial.T)
    case "C" => scala.Right(FirstNameInitial.C)
    case "O" => scala.Right(FirstNameInitial.O)
    case "H" => scala.Right(FirstNameInitial.H)
    case "L" => scala.Right(FirstNameInitial.L)
    case "A" => scala.Right(FirstNameInitial.A)
    case "K" => scala.Right(FirstNameInitial.K)
    case "R" => scala.Right(FirstNameInitial.R)
    case "B" => scala.Right(FirstNameInitial.B)
    case "N" => scala.Right(FirstNameInitial.N)
    case other => scala.Left("invalid FirstNameInitial: " + other)
}
given Encoder[FirstNameInitial] = Encoder.encodeString.contramap {
    case FirstNameInitial.D => "D"
    case FirstNameInitial.J => "J"
    case FirstNameInitial.T => "T"
    case FirstNameInitial.C => "C"
    case FirstNameInitial.O => "O"
    case FirstNameInitial.H => "H"
    case FirstNameInitial.L => "L"
    case FirstNameInitial.A => "A"
    case FirstNameInitial.K => "K"
    case FirstNameInitial.R => "R"
    case FirstNameInitial.B => "B"
    case FirstNameInitial.N => "N"
}

enum ScoreboardName : 
    case Empty
    case TS
    case RIhata
    case DJones
    case BValentine

given Decoder[ScoreboardName] = Decoder.decodeString.emap {
    case "" => scala.Right(ScoreboardName.Empty)
    case "T. s" => scala.Right(ScoreboardName.TS)
    case "R. Ihata" => scala.Right(ScoreboardName.RIhata)
    case "D. Jones" => scala.Right(ScoreboardName.DJones)
    case "B. Valentine" => scala.Right(ScoreboardName.BValentine)
    case other => scala.Left("invalid ScoreboardName: " + other)
}
given Encoder[ScoreboardName] = Encoder.encodeString.contramap {
    case ScoreboardName.Empty => ""
    case ScoreboardName.TS => "T. s"
    case ScoreboardName.RIhata => "R. Ihata"
    case ScoreboardName.DJones => "D. Jones"
    case ScoreboardName.BValentine => "B. Valentine"
}

case class Scorer (
    val familyName : Option[String] = None,
    val familyNameInitial : Option[FamilyNameInitial] = None,
    val firstName : Option[String] = None,
    val firstNameInitial : Option[FirstNameInitial] = None,
    val gt : Option[String] = None,
    val internationalFamilyName : Option[String] = None,
    val internationalFamilyNameInitial : Option[FamilyNameInitial] = None,
    val internationalFirstName : Option[String] = None,
    val internationalFirstNameInitial : Option[FirstNameInitial] = None,
    val name : Option[String] = None,
    val per : Option[Long] = None,
    val perType : Option[PerType] = None,
    val player : Option[String] = None,
    val pno : Long,
    val scoreboardName : Option[ScoreboardName] = None,
    val shirtNumber : String,
    val summary : Option[String] = None,
    val times : Option[Seq[Time]] = None,
    val tno : Long,
    val tot : Option[Long] = None
) derives Encoder.AsObject, Decoder

case class Time (
    val gt : String,
    val per : Long,
    val perType : PerType
) derives Encoder.AsObject, Decoder

case class Tm (
    val code : String,
    val codeInternational : String,
    val fouls : Long,
    val full_score : Long,
    val lds : Lds,
    val logo : String,
    val name : String,
    val nameInternational : String,
    val p1_score : Long,
    val p2_score : Long,
    val p3_score : Long,
    val p4_score : Long,
    val pl : Map[String, Pl],
    val score : Long,
    val scoring : Seq[Scorer],
    val shortName : String,
    val shortNameInternational : String,
    val shot : Seq[Shot],
    val timeouts : Long,
    val tot_eff_1 : Long,
    val tot_eff_2 : Long,
    val tot_eff_3 : Double,
    val tot_eff_4 : Long,
    val tot_eff_5 : Long,
    val tot_eff_6 : Long,
    val tot_eff_7 : Long,
    val tot_sAssists : Long,
    val tot_sBenchPoints : Long,
    val tot_sBiggestLead : Long,
    val tot_sBiggestScoringRun : Long,
    val tot_sBlocks : Long,
    val tot_sBlocksReceived : Long,
    val tot_sFieldGoalsAttempted : Long,
    val tot_sFieldGoalsMade : Long,
    val tot_sFieldGoalsPercentage : Long,
    val tot_sFoulsOn : Long,
    val tot_sFoulsPersonal : Long,
    val tot_sFoulsTeam : Long,
    val tot_sFreeThrowsAttempted : Long,
    val tot_sFreeThrowsMade : Long,
    val tot_sFreeThrowsPercentage : Long,
    val tot_sLeadChanges : Long,
    val tot_sMinutes : Long,
    val tot_sPoints : Long,
    val tot_sPointsFastBreak : Long,
    val tot_sPointsFromTurnovers : Long,
    val tot_sPointsInThePaint : Long,
    val tot_sPointsSecondChance : Long,
    val tot_sReboundsDefensive : Long,
    val tot_sReboundsOffensive : Long,
    val tot_sReboundsTeam : Long,
    val tot_sReboundsTeamDefensive : Long,
    val tot_sReboundsTeamOffensive : Long,
    val tot_sReboundsTotal : Long,
    val tot_sSteals : Long,
    val tot_sThreePointersAttempted : Long,
    val tot_sThreePointersMade : Long,
    val tot_sThreePointersPercentage : Long,
    val tot_sTimeLeading : Double,
    val tot_sTimesScoresLevel : Long,
    val tot_sTurnovers : Long,
    val tot_sTurnoversTeam : Long,
    val tot_sTwoPointersAttempted : Long,
    val tot_sTwoPointersMade : Long,
    val tot_sTwoPointersPercentage : Long
) derives Encoder.AsObject, Decoder

case class Lds (
    val sAssists : Map[String, Scorer],
    val sBlocks : SBlocks,
    val sPoints : Map[String, Scorer],
    val sReboundsTotal : Map[String, Scorer],
    val sSteals : Map[String, Scorer]
) derives Encoder.AsObject, Decoder

case class SBlocks (
    val `1` : Scorer
) derives Encoder.AsObject, Decoder

case class Pl (
    val active : Long,
    val captain : Option[Long] = None,
    val comp : Option[Comp] = None,
    val eff_1 : Long,
    val eff_2 : Long,
    val eff_3 : Double,
    val eff_4 : Double,
    val eff_5 : Long,
    val eff_6 : Long,
    val eff_7 : Long,
    val familyName : String,
    val familyNameInitial : FamilyNameInitial,
    val firstName : String,
    val firstNameInitial : FirstNameInitial,
    val internationalFamilyName : String,
    val internationalFamilyNameInitial : FamilyNameInitial,
    val internationalFirstName : String,
    val internationalFirstNameInitial : FirstNameInitial,
    val name : String,
    val playingPosition : String,
    val sAssists : Long,
    val sBlocks : Long,
    val sBlocksReceived : Long,
    val sFieldGoalsAttempted : Long,
    val sFieldGoalsMade : Long,
    val sFieldGoalsPercentage : Long,
    val sFoulsOn : Long,
    val sFoulsPersonal : Long,
    val sFreeThrowsAttempted : Long,
    val sFreeThrowsMade : Long,
    val sFreeThrowsPercentage : Long,
    val sMinutes : SMinutes,
    val sPlusMinusPoints : Long,
    val sPoints : Long,
    val sPointsFastBreak : Long,
    val sPointsInThePaint : Long,
    val sPointsSecondChance : Long,
    val sReboundsDefensive : Long,
    val sReboundsOffensive : Long,
    val sReboundsTotal : Long,
    val sSteals : Long,
    val sThreePointersAttempted : Long,
    val sThreePointersMade : Long,
    val sThreePointersPercentage : Long,
    val sTurnovers : Long,
    val sTwoPointersAttempted : Long,
    val sTwoPointersMade : Long,
    val sTwoPointersPercentage : Long,
    val shirtNumber : String,
    val starter : Long
) derives Encoder.AsObject, Decoder

case class Comp (
    val sAssistsAverage : Double,
    val sMinutesAverage : String,
    val sPointsAverage : Double,
    val sReboundsTotalAverage : Double
) derives Encoder.AsObject, Decoder

type SMinutes = Long | String
given Decoder[SMinutes] = {
    List[Decoder[SMinutes]](
        Decoder[String].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[SMinutes] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}

case class Shot (
    val actionType : ActionType,
    val p : Long,
    val per : Long,
    val perType : PerType,
    val player : String,
    val pno : Long,
    val r : Long,
    val shirtNumber : String,
    val subType : SubType,
    val tno : Long,
    val x : Long,
    val y : Long
) derives Encoder.AsObject, Decoder

enum SubType : 
    case Jumpshot
    case Layup
    case Dunk

given Decoder[SubType] = Decoder.decodeString.emap {
    case "jumpshot" => scala.Right(SubType.Jumpshot)
    case "layup" => scala.Right(SubType.Layup)
    case "dunk" => scala.Right(SubType.Dunk)
    case other => scala.Left("invalid SubType: " + other)
}
given Encoder[SubType] = Encoder.encodeString.contramap {
    case SubType.Jumpshot => "jumpshot"
    case SubType.Layup => "layup"
    case SubType.Dunk => "dunk"
}

case class Totallds (
    val sAssists : Map[String, Scorer],
    val sBlocks : Map[String, Scorer],
    val sPoints : Map[String, Scorer],
    val sReboundsTotal : Map[String, Scorer],
    val sSteals : Map[String, Scorer]
) derives Encoder.AsObject, Decoder
