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
    val caucus : Option[Party],
    val congress_numbers : Seq[Long],
    val current : Boolean,
    val description : String,
    val district : Option[ujson.Value],
    val enddate : String,
    val extra : Extra,
    val id : Long,
    val leadership_title : Option[String],
    val party : Party,
    val person : Person,
    val phone : String,
    val role_type : RoleType,
    val role_type_label : RoleTypeLabel,
    val senator_class : SenatorClass,
    val senator_class_label : SenatorClassLabel,
    val senator_rank : SenatorRank,
    val senator_rank_label : SenatorRankLabel,
    val startdate : String,
    val state : String,
    val title : Title,
    val title_long : RoleTypeLabel,
    val website : String
) derives OptionPickler.ReadWriter

enum Party : 
    case Republican
    case Democrat
    case Independent

given OptionPickler.ReadWriter[Party] = OptionPickler.readwriter[String].bimap[Party](
    {
        case Party.Republican => "Republican"
        case Party.Democrat => "Democrat"
        case Party.Independent => "Independent"
    },
    {
        case "Republican" => Party.Republican
        case "Democrat" => Party.Democrat
        case "Independent" => Party.Independent
        case other => throw new upickle.core.Abort("invalid Party: " + other)
    }
)

case class Extra (
    val address : String,
    val contact_form : String,
    val fax : Option[String] = None,
    val office : String,
    val rss_url : Option[String] = None
) derives OptionPickler.ReadWriter

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
    val pvsid : String,
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
    case Iii
    case Jr

given OptionPickler.ReadWriter[Namemod] = OptionPickler.readwriter[String].bimap[Namemod](
    {
        case Namemod.Empty => ""
        case Namemod.Iii => "III"
        case Namemod.Jr => "Jr."
    },
    {
        case "" => Namemod.Empty
        case "III" => Namemod.Iii
        case "Jr." => Namemod.Jr
        case other => throw new upickle.core.Abort("invalid Namemod: " + other)
    }
)

enum RoleType : 
    case Senator

given OptionPickler.ReadWriter[RoleType] = OptionPickler.readwriter[String].bimap[RoleType](
    {
        case RoleType.Senator => "senator"
    },
    {
        case "senator" => RoleType.Senator
        case other => throw new upickle.core.Abort("invalid RoleType: " + other)
    }
)

enum RoleTypeLabel : 
    case Senator

given OptionPickler.ReadWriter[RoleTypeLabel] = OptionPickler.readwriter[String].bimap[RoleTypeLabel](
    {
        case RoleTypeLabel.Senator => "Senator"
    },
    {
        case "Senator" => RoleTypeLabel.Senator
        case other => throw new upickle.core.Abort("invalid RoleTypeLabel: " + other)
    }
)

enum SenatorClass : 
    case Class2
    case Class1
    case Class3

given OptionPickler.ReadWriter[SenatorClass] = OptionPickler.readwriter[String].bimap[SenatorClass](
    {
        case SenatorClass.Class2 => "class2"
        case SenatorClass.Class1 => "class1"
        case SenatorClass.Class3 => "class3"
    },
    {
        case "class2" => SenatorClass.Class2
        case "class1" => SenatorClass.Class1
        case "class3" => SenatorClass.Class3
        case other => throw new upickle.core.Abort("invalid SenatorClass: " + other)
    }
)

enum SenatorClassLabel : 
    case Class2
    case Class1
    case Class3

given OptionPickler.ReadWriter[SenatorClassLabel] = OptionPickler.readwriter[String].bimap[SenatorClassLabel](
    {
        case SenatorClassLabel.Class2 => "Class 2"
        case SenatorClassLabel.Class1 => "Class 1"
        case SenatorClassLabel.Class3 => "Class 3"
    },
    {
        case "Class 2" => SenatorClassLabel.Class2
        case "Class 1" => SenatorClassLabel.Class1
        case "Class 3" => SenatorClassLabel.Class3
        case other => throw new upickle.core.Abort("invalid SenatorClassLabel: " + other)
    }
)

enum SenatorRank : 
    case Senior
    case Junior

given OptionPickler.ReadWriter[SenatorRank] = OptionPickler.readwriter[String].bimap[SenatorRank](
    {
        case SenatorRank.Senior => "senior"
        case SenatorRank.Junior => "junior"
    },
    {
        case "senior" => SenatorRank.Senior
        case "junior" => SenatorRank.Junior
        case other => throw new upickle.core.Abort("invalid SenatorRank: " + other)
    }
)

enum SenatorRankLabel : 
    case Senior
    case Junior

given OptionPickler.ReadWriter[SenatorRankLabel] = OptionPickler.readwriter[String].bimap[SenatorRankLabel](
    {
        case SenatorRankLabel.Senior => "Senior"
        case SenatorRankLabel.Junior => "Junior"
    },
    {
        case "Senior" => SenatorRankLabel.Senior
        case "Junior" => SenatorRankLabel.Junior
        case other => throw new upickle.core.Abort("invalid SenatorRankLabel: " + other)
    }
)

enum Title : 
    case Sen

given OptionPickler.ReadWriter[Title] = OptionPickler.readwriter[String].bimap[Title](
    {
        case Title.Sen => "Sen."
    },
    {
        case "Sen." => Title.Sen
        case other => throw new upickle.core.Abort("invalid Title: " + other)
    }
)
