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


type TopLevel = List[TopLevelUnion]

type TopLevelUnion = FluffyTopLevel | Seq[PurpleTopLevel] | String
given unionReaderTopLevelUnion: OptionPickler.Reader[TopLevelUnion] = JsonExt.badMerge[TopLevelUnion](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[PurpleTopLevel]]],
    summon[OptionPickler.Reader[FluffyTopLevel]],
    )

given unionWriterTopLevelUnion: OptionPickler.Writer[TopLevelUnion] = OptionPickler.writer[ujson.Value].comap[TopLevelUnion]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[PurpleTopLevel] => OptionPickler.writeJs[Seq[PurpleTopLevel]](v)
        case v: FluffyTopLevel => OptionPickler.writeJs[FluffyTopLevel](v)
}

case class PurpleTopLevel (
    val ALIENLEVEL : Long,
    val BREED : Breed,
    val CHAR_DIMENSION : Long,
    val CHAR_INSTANCE : Long,
    val DEFENDER_RANK_TITLE : String,
    val FIRSTNAME : Firstname,
    val HEADID : Long,
    val LASTNAME : Lastname,
    val LEVELX : Long,
    val NAME : String,
    val PROF : String,
    val PROF_TITLE : String,
    val PVPRATING : Long,
    val PVPTITLE : Pvptitle,
    val RANK : Long,
    val RANK_TITLE : RankTitle,
    val SEX : Sex
) derives OptionPickler.ReadWriter

enum Breed : 
    case Atrox
    case Solitus
    case Opifex
    case Nano

given OptionPickler.ReadWriter[Breed] = OptionPickler.readwriter[String].bimap[Breed](
    {
        case Breed.Atrox => "Atrox"
        case Breed.Solitus => "Solitus"
        case Breed.Opifex => "Opifex"
        case Breed.Nano => "Nano"
    },
    {
        case "Atrox" => Breed.Atrox
        case "Solitus" => Breed.Solitus
        case "Opifex" => Breed.Opifex
        case "Nano" => Breed.Nano
        case other => throw new upickle.core.Abort("invalid Breed: " + other)
    }
)

enum Firstname : 
    case Empty
    case Chi

given OptionPickler.ReadWriter[Firstname] = OptionPickler.readwriter[String].bimap[Firstname](
    {
        case Firstname.Empty => ""
        case Firstname.Chi => "Chi"
    },
    {
        case "" => Firstname.Empty
        case "Chi" => Firstname.Chi
        case other => throw new upickle.core.Abort("invalid Firstname: " + other)
    }
)

enum Lastname : 
    case Empty
    case Washko

given OptionPickler.ReadWriter[Lastname] = OptionPickler.readwriter[String].bimap[Lastname](
    {
        case Lastname.Empty => ""
        case Lastname.Washko => "Washko"
    },
    {
        case "" => Lastname.Empty
        case "Washko" => Lastname.Washko
        case other => throw new upickle.core.Abort("invalid Lastname: " + other)
    }
)

enum Pvptitle : 
    case Freshman

given OptionPickler.ReadWriter[Pvptitle] = OptionPickler.readwriter[String].bimap[Pvptitle](
    {
        case Pvptitle.Freshman => "Freshman"
    },
    {
        case "Freshman" => Pvptitle.Freshman
        case other => throw new upickle.core.Abort("invalid Pvptitle: " + other)
    }
)

enum RankTitle : 
    case President
    case Advisor
    case Veteran
    case Applicant

given OptionPickler.ReadWriter[RankTitle] = OptionPickler.readwriter[String].bimap[RankTitle](
    {
        case RankTitle.President => "President"
        case RankTitle.Advisor => "Advisor"
        case RankTitle.Veteran => "Veteran"
        case RankTitle.Applicant => "Applicant"
    },
    {
        case "President" => RankTitle.President
        case "Advisor" => RankTitle.Advisor
        case "Veteran" => RankTitle.Veteran
        case "Applicant" => RankTitle.Applicant
        case other => throw new upickle.core.Abort("invalid RankTitle: " + other)
    }
)

enum Sex : 
    case Neuter
    case Male
    case Female

given OptionPickler.ReadWriter[Sex] = OptionPickler.readwriter[String].bimap[Sex](
    {
        case Sex.Neuter => "Neuter"
        case Sex.Male => "Male"
        case Sex.Female => "Female"
    },
    {
        case "Neuter" => Sex.Neuter
        case "Male" => Sex.Male
        case "Female" => Sex.Female
        case other => throw new upickle.core.Abort("invalid Sex: " + other)
    }
)

case class FluffyTopLevel (
    val ADVENTURERCOUNT : Long,
    val AGENTCOUNT : Long,
    val ATROXCOUNT : Long,
    val AVGLVL : Double,
    val BTCOUNT : Long,
    val DESCRIPTION : String,
    val DOCTORCOUNT : Long,
    val ENFCOUNT : Long,
    val ENGINEEERCOUNT : Long,
    val FEMALECOUNT : Long,
    val FIXERCOUNT : Long,
    val GOVERNINGNAME : String,
    val HISTORY : String,
    val KEEPERCOUNT : Long,
    val MACOUNT : Long,
    val MALECOUNT : Long,
    val MAXLVL : Long,
    val METACOUNT : Long,
    val MINLVL : Long,
    val MONSTERCOUNT : Long,
    val NAME : String,
    val NANOCOUNT : Long,
    val NANORACECOUNT : Long,
    val NEUTERCOUNT : Long,
    val NUMMEMBERS : Long,
    val OBJECTIVE : String,
    val OPIFEXCOUNT : Long,
    val ORG_DIMENSION : Long,
    val ORG_INSTANCE : Long,
    val SHADECOUNT : Long,
    val SIDE : Long,
    val SIDE_NAME : String,
    val SOLIDERCOUNT : Long,
    val SOLITUSCOUNT : Long,
    val TRADERCOUNT : Long
) derives OptionPickler.ReadWriter
