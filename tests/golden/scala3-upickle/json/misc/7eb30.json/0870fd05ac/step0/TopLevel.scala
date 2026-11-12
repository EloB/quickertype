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
    val count : Long,
    val next : String,
    val previous : Option[ujson.Value],
    val results : Seq[Result]
) derives OptionPickler.ReadWriter

case class Result (
    val code : String,
    val english : String,
    val fav : Boolean,
    val group : Group,
    val location : Location,
    val min_screens : Long,
    val num_views : Long,
    val showtimes : String,
    val stars : Long,
    val tel : Tel,
    val thai : String,
    val today_screens : Long,
    val url : String,
    val website : String
) derives OptionPickler.ReadWriter

case class Group (
    val code : Code,
    val english : English,
    val thai : Thai,
    val website : String
) derives OptionPickler.ReadWriter

enum Code : 
    case Sf

given OptionPickler.ReadWriter[Code] = OptionPickler.readwriter[String].bimap[Code](
    {
        case Code.Sf => "sf"
    },
    {
        case "sf" => Code.Sf
        case other => throw new upickle.core.Abort("invalid Code: " + other)
    }
)

enum English : 
    case Sf

given OptionPickler.ReadWriter[English] = OptionPickler.readwriter[String].bimap[English](
    {
        case English.Sf => "SF"
    },
    {
        case "SF" => English.Sf
        case other => throw new upickle.core.Abort("invalid English: " + other)
    }
)

enum Thai : 
    case เอสเอฟ

given OptionPickler.ReadWriter[Thai] = OptionPickler.readwriter[String].bimap[Thai](
    {
        case Thai.เอสเอฟ => "เอสเอฟ"
    },
    {
        case "เอสเอฟ" => Thai.เอสเอฟ
        case other => throw new upickle.core.Abort("invalid Thai: " + other)
    }
)

enum Location : 
    case Empty
    case The5ThFLEmporium

given OptionPickler.ReadWriter[Location] = OptionPickler.readwriter[String].bimap[Location](
    {
        case Location.Empty => ""
        case Location.The5ThFLEmporium => "5th Fl. Emporium"
    },
    {
        case "" => Location.Empty
        case "5th Fl. Emporium" => Location.The5ThFLEmporium
        case other => throw new upickle.core.Abort("invalid Location: " + other)
    }
)

enum Tel : 
    case Empty
    case The022688899

given OptionPickler.ReadWriter[Tel] = OptionPickler.readwriter[String].bimap[Tel](
    {
        case Tel.Empty => ""
        case Tel.The022688899 => "02-268-8899"
    },
    {
        case "" => Tel.Empty
        case "02-268-8899" => Tel.The022688899
        case other => throw new upickle.core.Abort("invalid Tel: " + other)
    }
)
