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
    val callsign : Callsign,
    val priority : Priority
) derives OptionPickler.ReadWriter

enum Callsign : 
    case Alpha
    case Bravo
    case Charlie
    case Delta
    case Echo
    case Foxtrot
    case Golf
    case Hotel
    case India
    case Juliett
    case Kilo
    case Lima
    case Mike
    case November
    case Oscar
    case Papa
    case Quebec
    case Romeo
    case Sierra
    case Tango

given OptionPickler.ReadWriter[Callsign] = OptionPickler.readwriter[String].bimap[Callsign](
    {
        case Callsign.Alpha => "alpha"
        case Callsign.Bravo => "bravo"
        case Callsign.Charlie => "charlie"
        case Callsign.Delta => "delta"
        case Callsign.Echo => "echo"
        case Callsign.Foxtrot => "foxtrot"
        case Callsign.Golf => "golf"
        case Callsign.Hotel => "hotel"
        case Callsign.India => "india"
        case Callsign.Juliett => "juliett"
        case Callsign.Kilo => "kilo"
        case Callsign.Lima => "lima"
        case Callsign.Mike => "mike"
        case Callsign.November => "november"
        case Callsign.Oscar => "oscar"
        case Callsign.Papa => "papa"
        case Callsign.Quebec => "quebec"
        case Callsign.Romeo => "romeo"
        case Callsign.Sierra => "sierra"
        case Callsign.Tango => "tango"
    },
    {
        case "alpha" => Callsign.Alpha
        case "bravo" => Callsign.Bravo
        case "charlie" => Callsign.Charlie
        case "delta" => Callsign.Delta
        case "echo" => Callsign.Echo
        case "foxtrot" => Callsign.Foxtrot
        case "golf" => Callsign.Golf
        case "hotel" => Callsign.Hotel
        case "india" => Callsign.India
        case "juliett" => Callsign.Juliett
        case "kilo" => Callsign.Kilo
        case "lima" => Callsign.Lima
        case "mike" => Callsign.Mike
        case "november" => Callsign.November
        case "oscar" => Callsign.Oscar
        case "papa" => Callsign.Papa
        case "quebec" => Callsign.Quebec
        case "romeo" => Callsign.Romeo
        case "sierra" => Callsign.Sierra
        case "tango" => Callsign.Tango
        case other => throw new upickle.core.Abort("invalid Callsign: " + other)
    }
)

enum Priority : 
    case Low
    case Medium
    case High

given OptionPickler.ReadWriter[Priority] = OptionPickler.readwriter[String].bimap[Priority](
    {
        case Priority.Low => "low"
        case Priority.Medium => "medium"
        case Priority.High => "high"
    },
    {
        case "low" => Priority.Low
        case "medium" => Priority.Medium
        case "high" => Priority.High
        case other => throw new upickle.core.Abort("invalid Priority: " + other)
    }
)
