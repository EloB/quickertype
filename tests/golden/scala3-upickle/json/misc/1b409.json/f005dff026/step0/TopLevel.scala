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
    val meta : Meta,
    val objects : Seq[Object]
) derives OptionPickler.ReadWriter

case class Meta (
    val limit : Long,
    val offset : Long,
    val total_count : Long
) derives OptionPickler.ReadWriter

case class Object (
    val caucus : Option[ujson.Value],
    val congress_numbers : Seq[Long],
    val current : Boolean,
    val description : String,
    val district : Long,
    val enddate : String,
    val extra : Extra,
    val id : Long,
    val leadership_title : Option[String],
    val party : Party,
    val person : Person,
    val phone : String,
    val role_type : RoleType,
    val role_type_label : RoleTypeLabel,
    val senator_class : Option[ujson.Value],
    val senator_rank : Option[ujson.Value],
    val startdate : String,
    val state : String,
    val title : Title,
    val title_long : RoleTypeLabel,
    val website : String
) derives OptionPickler.ReadWriter

case class Extra (
    val address : String,
    val contact_form : Option[String] = None,
    val fax : Option[String] = None,
    val office : String,
    val rss_url : Option[String] = None
) derives OptionPickler.ReadWriter

enum Party : 
    case Republican
    case Democrat

given OptionPickler.ReadWriter[Party] = OptionPickler.readwriter[String].bimap[Party](
    {
        case Party.Republican => "Republican"
        case Party.Democrat => "Democrat"
    },
    {
        case "Republican" => Party.Republican
        case "Democrat" => Party.Democrat
        case other => throw new upickle.core.Abort("invalid Party: " + other)
    }
)

case class Person (
    val bioguideid : String,
    val birthday : String,
    val cspanid : Long,
    val firstname : String,
    val gender : Gender,
    val gender_label : GenderLabel,
    val id : Long,
    val lastname : String,
    val link : String,
    val middlename : String,
    val name : String,
    val namemod : Namemod,
    val nickname : String,
    val osid : String,
    val pvsid : Option[String],
    val sortname : String,
    val twitterid : Option[String],
    val youtubeid : Option[String]
) derives OptionPickler.ReadWriter

enum Gender : 
    case Male
    case Female

given OptionPickler.ReadWriter[Gender] = OptionPickler.readwriter[String].bimap[Gender](
    {
        case Gender.Male => "male"
        case Gender.Female => "female"
    },
    {
        case "male" => Gender.Male
        case "female" => Gender.Female
        case other => throw new upickle.core.Abort("invalid Gender: " + other)
    }
)

enum GenderLabel : 
    case Male
    case Female

given OptionPickler.ReadWriter[GenderLabel] = OptionPickler.readwriter[String].bimap[GenderLabel](
    {
        case GenderLabel.Male => "Male"
        case GenderLabel.Female => "Female"
    },
    {
        case "Male" => GenderLabel.Male
        case "Female" => GenderLabel.Female
        case other => throw new upickle.core.Abort("invalid GenderLabel: " + other)
    }
)

enum Namemod : 
    case Empty
    case Jr
    case Ii
    case Iii
    case Iv

given OptionPickler.ReadWriter[Namemod] = OptionPickler.readwriter[String].bimap[Namemod](
    {
        case Namemod.Empty => ""
        case Namemod.Jr => "Jr."
        case Namemod.Ii => "II"
        case Namemod.Iii => "III"
        case Namemod.Iv => "IV"
    },
    {
        case "" => Namemod.Empty
        case "Jr." => Namemod.Jr
        case "II" => Namemod.Ii
        case "III" => Namemod.Iii
        case "IV" => Namemod.Iv
        case other => throw new upickle.core.Abort("invalid Namemod: " + other)
    }
)

enum RoleType : 
    case Representative

given OptionPickler.ReadWriter[RoleType] = OptionPickler.readwriter[String].bimap[RoleType](
    {
        case RoleType.Representative => "representative"
    },
    {
        case "representative" => RoleType.Representative
        case other => throw new upickle.core.Abort("invalid RoleType: " + other)
    }
)

enum RoleTypeLabel : 
    case Representative
    case Delegate
    case ResidentCommissioner

given OptionPickler.ReadWriter[RoleTypeLabel] = OptionPickler.readwriter[String].bimap[RoleTypeLabel](
    {
        case RoleTypeLabel.Representative => "Representative"
        case RoleTypeLabel.Delegate => "Delegate"
        case RoleTypeLabel.ResidentCommissioner => "Resident Commissioner"
    },
    {
        case "Representative" => RoleTypeLabel.Representative
        case "Delegate" => RoleTypeLabel.Delegate
        case "Resident Commissioner" => RoleTypeLabel.ResidentCommissioner
        case other => throw new upickle.core.Abort("invalid RoleTypeLabel: " + other)
    }
)

enum Title : 
    case Rep
    case Commish

given OptionPickler.ReadWriter[Title] = OptionPickler.readwriter[String].bimap[Title](
    {
        case Title.Rep => "Rep."
        case Title.Commish => "Commish."
    },
    {
        case "Rep." => Title.Rep
        case "Commish." => Title.Commish
        case other => throw new upickle.core.Abort("invalid Title: " + other)
    }
)
