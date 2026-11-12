package quicktype

// Custom pickler so that missing keys and JSON nulls both read as None,
// and None is left out when writing (upickle's default for Option is a
// JSON array).
object OptionPickler extends upickle.AttributeTagged:
    import upickle.default.Writer
    import upickle.default.Reader
    override implicit def OptionWriter[T: Writer]: Writer[Option[T]] =
        implicitly[Writer[T]].comap[Option[T]] {
            case None => null.asInstanceOf[T]
            case Some(x) => x
        }

    override implicit def OptionReader[T: Reader]: Reader[Option[T]] = {
        new Reader.Delegate[Any, Option[T]](implicitly[Reader[T]].map(Some(_))){
        override def visitNull(index: Int) = None
        }
    }
end OptionPickler

// If a union has a null in, then we'll need this too...
type NullValue = None.type
given OptionPickler.ReadWriter[NullValue] = OptionPickler.readwriter[ujson.Value].bimap[NullValue](
    _ => ujson.Null,
    json => if json.isNull then None else throw new upickle.core.Abort("not null")
)
given OptionPickler.ReadWriter[java.time.Instant] = OptionPickler.readwriter[ujson.Value].bimap(
    value => ujson.Str(value.toString),
    json => json match
        case ujson.Str(value) => java.time.Instant.parse(value)
        case other => throw new upickle.core.Abort("expected date-time, got " + other)
)
given OptionPickler.ReadWriter[java.util.UUID] = OptionPickler.readwriter[String].bimap(
    _.toString,
    value =>
        val uuid = java.util.UUID.fromString(value)
        if uuid.toString.equalsIgnoreCase(value) then uuid else throw new upickle.core.Abort("invalid UUID")
)

object JsonExt:
    val valueReader = OptionPickler.readwriter[ujson.Value]

    // upickle's built-in primitive readers are lenient -- the numeric and
    // boolean readers accept strings, and the string reader accepts
    // numbers and booleans -- so untagged unions need strict readers to
    // pick the right member.
    val strictString: OptionPickler.Reader[String] = valueReader.map {
        case ujson.Str(s) => s
        case json => throw new upickle.core.Abort("expected string, got " + json)
    }
    val strictLong: OptionPickler.Reader[Long] = valueReader.map {
        case ujson.Num(n) if n.isWhole => n.toLong
        case json => throw new upickle.core.Abort("expected integer, got " + json)
    }
    val strictDouble: OptionPickler.Reader[Double] = valueReader.map {
        case ujson.Num(n) => n
        case json => throw new upickle.core.Abort("expected number, got " + json)
    }
    val strictBoolean: OptionPickler.Reader[Boolean] = valueReader.map {
        case ujson.Bool(b) => b
        case json => throw new upickle.core.Abort("expected boolean, got " + json)
    }

    def badMerge[T](r1: => OptionPickler.Reader[?], rest: OptionPickler.Reader[?]*): OptionPickler.Reader[T] = valueReader.map { json =>
        var t: T | Null = null
        val stack       = Vector.newBuilder[Throwable]
        (r1 +: rest).foreach { reader =>
            if t == null then
            try
                t = OptionPickler.read[T](json, trace = true)(using reader.asInstanceOf[OptionPickler.Reader[T]])
            catch
                case exc => stack += exc
        }
        if t != null then t.nn else throw new Exception(json.toString(), stack.result().headOption.getOrElse(null))
    }
end JsonExt
given OptionPickler.Reader[Long] = JsonExt.strictLong


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
    val timeline : Seq[Option[ujson.Value]],
    val tm : Map[String, Tm],
    val totalTimeAdded : Long,
    val totallds : Totallds
) derives OptionPickler.ReadWriter

type LeaddatumElement = LeaddatumEnum | Long
given unionReaderLeaddatumElement: OptionPickler.Reader[LeaddatumElement] = JsonExt.badMerge[LeaddatumElement](
    summon[OptionPickler.Reader[LeaddatumEnum]],
    JsonExt.strictLong,
    )

given unionWriterLeaddatumElement: OptionPickler.Writer[LeaddatumElement] = OptionPickler.writer[ujson.Value].comap[LeaddatumElement]{ _v =>
    (_v: @unchecked) match 
        case v: LeaddatumEnum => OptionPickler.writeJs[LeaddatumEnum](v)
        case v: Long => OptionPickler.writeJs[Long](v)
}

enum LeaddatumEnum : 
    case Empty
    case P1
    case P2
    case P3
    case P4

given OptionPickler.ReadWriter[LeaddatumEnum] = OptionPickler.readwriter[String].bimap[LeaddatumEnum](
    {
        case LeaddatumEnum.Empty => ""
        case LeaddatumEnum.P1 => "P1"
        case LeaddatumEnum.P2 => "P2"
        case LeaddatumEnum.P3 => "P3"
        case LeaddatumEnum.P4 => "P4"
    },
    {
        case "" => LeaddatumEnum.Empty
        case "P1" => LeaddatumEnum.P1
        case "P2" => LeaddatumEnum.P2
        case "P3" => LeaddatumEnum.P3
        case "P4" => LeaddatumEnum.P4
        case other => throw new upickle.core.Abort("invalid LeaddatumEnum: " + other)
    }
)

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
) derives OptionPickler.ReadWriter

enum PerType : 
    case Regular

given OptionPickler.ReadWriter[PerType] = OptionPickler.readwriter[String].bimap[PerType](
    {
        case PerType.Regular => "REGULAR"
    },
    {
        case "REGULAR" => PerType.Regular
        case other => throw new upickle.core.Abort("invalid PerType: " + other)
    }
)

case class Team (
    val teamCode : String,
    val teamCodeInternational : String,
    val teamName : String,
    val teamNameInternational : String
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

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

given OptionPickler.ReadWriter[ActionType] = OptionPickler.readwriter[String].bimap[ActionType](
    {
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
    },
    {
        case "game" => ActionType.Game
        case "period" => ActionType.Period
        case "3pt" => ActionType.The3Pt
        case "2pt" => ActionType.The2Pt
        case "rebound" => ActionType.Rebound
        case "timeout" => ActionType.Timeout
        case "foulon" => ActionType.Foulon
        case "foul" => ActionType.Foul
        case "assist" => ActionType.Assist
        case "substitution" => ActionType.Substitution
        case "freethrow" => ActionType.Freethrow
        case "steal" => ActionType.Steal
        case "turnover" => ActionType.Turnover
        case "block" => ActionType.Block
        case "jumpball" => ActionType.Jumpball
        case other => throw new upickle.core.Abort("invalid ActionType: " + other)
    }
)

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

given OptionPickler.ReadWriter[FamilyNameInitial] = OptionPickler.readwriter[String].bimap[FamilyNameInitial](
    {
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
    },
    {
        case "R" => FamilyNameInitial.R
        case "M" => FamilyNameInitial.M
        case "s" => FamilyNameInitial.S
        case "C" => FamilyNameInitial.C
        case "O" => FamilyNameInitial.O
        case "W" => FamilyNameInitial.W
        case "A" => FamilyNameInitial.A
        case "P" => FamilyNameInitial.P
        case "V" => FamilyNameInitial.V
        case "I" => FamilyNameInitial.I
        case "J" => FamilyNameInitial.J
        case "S" => FamilyNameInitial.FamilyNameInitialS
        case "H" => FamilyNameInitial.H
        case "B" => FamilyNameInitial.B
        case other => throw new upickle.core.Abort("invalid FamilyNameInitial: " + other)
    }
)

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

given OptionPickler.ReadWriter[FirstNameInitial] = OptionPickler.readwriter[String].bimap[FirstNameInitial](
    {
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
    },
    {
        case "D" => FirstNameInitial.D
        case "J" => FirstNameInitial.J
        case "T" => FirstNameInitial.T
        case "C" => FirstNameInitial.C
        case "O" => FirstNameInitial.O
        case "H" => FirstNameInitial.H
        case "L" => FirstNameInitial.L
        case "A" => FirstNameInitial.A
        case "K" => FirstNameInitial.K
        case "R" => FirstNameInitial.R
        case "B" => FirstNameInitial.B
        case "N" => FirstNameInitial.N
        case other => throw new upickle.core.Abort("invalid FirstNameInitial: " + other)
    }
)

enum ScoreboardName : 
    case Empty
    case TS
    case RIhata
    case DJones
    case BValentine

given OptionPickler.ReadWriter[ScoreboardName] = OptionPickler.readwriter[String].bimap[ScoreboardName](
    {
        case ScoreboardName.Empty => ""
        case ScoreboardName.TS => "T. s"
        case ScoreboardName.RIhata => "R. Ihata"
        case ScoreboardName.DJones => "D. Jones"
        case ScoreboardName.BValentine => "B. Valentine"
    },
    {
        case "" => ScoreboardName.Empty
        case "T. s" => ScoreboardName.TS
        case "R. Ihata" => ScoreboardName.RIhata
        case "D. Jones" => ScoreboardName.DJones
        case "B. Valentine" => ScoreboardName.BValentine
        case other => throw new upickle.core.Abort("invalid ScoreboardName: " + other)
    }
)

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
) derives OptionPickler.ReadWriter

case class Time (
    val gt : String,
    val per : Long,
    val perType : PerType
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class Lds (
    val sAssists : Map[String, Scorer],
    val sBlocks : SBlocks,
    val sPoints : Map[String, Scorer],
    val sReboundsTotal : Map[String, Scorer],
    val sSteals : Map[String, Scorer]
) derives OptionPickler.ReadWriter

case class SBlocks (
    val `1` : Scorer
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class Comp (
    val sAssistsAverage : Double,
    val sMinutesAverage : String,
    val sPointsAverage : Double,
    val sReboundsTotalAverage : Double
) derives OptionPickler.ReadWriter

type SMinutes = Long | String
given unionReaderSMinutes: OptionPickler.Reader[SMinutes] = JsonExt.badMerge[SMinutes](
    JsonExt.strictString,
    JsonExt.strictLong,
    )

given unionWriterSMinutes: OptionPickler.Writer[SMinutes] = OptionPickler.writer[ujson.Value].comap[SMinutes]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
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
) derives OptionPickler.ReadWriter

enum SubType : 
    case Jumpshot
    case Layup
    case Dunk

given OptionPickler.ReadWriter[SubType] = OptionPickler.readwriter[String].bimap[SubType](
    {
        case SubType.Jumpshot => "jumpshot"
        case SubType.Layup => "layup"
        case SubType.Dunk => "dunk"
    },
    {
        case "jumpshot" => SubType.Jumpshot
        case "layup" => SubType.Layup
        case "dunk" => SubType.Dunk
        case other => throw new upickle.core.Abort("invalid SubType: " + other)
    }
)

case class Totallds (
    val sAssists : Map[String, Scorer],
    val sBlocks : Map[String, Scorer],
    val sPoints : Map[String, Scorer],
    val sReboundsTotal : Map[String, Scorer],
    val sSteals : Map[String, Scorer]
) derives OptionPickler.ReadWriter
